---
title: "Module Tour: Blizzard Reskins"
weight: 12
---

# Module Tour: Blizzard Reskins

`modules/blizzard/` is a collection of small, mostly independent modules
that each reskin or patch one specific piece of Blizzard's own UI. Most
follow the same shape:

```lua
Module.OnInit = function(self)
    local content = _G.SomeBlizzardFrame
    if (not content) then
        return  -- frame doesn't exist on this client/state, nothing to do
    end
    local config = self:GetDB("Blizzard").something
    ...
end
```

The loot window (`lootframe.lua`) is the one substantial rebuild in this
folder and has its own [case study]({{< relref "case-study-loot-window" >}}).
The rest:

| File | Reskins |
|---|---|
| `anchors.lua` | Moves `DurabilityFrame` and `VehicleSeatIndicator`, and keeps them there |
| `containers.lua` | Bags and bank (quality borders, item levels on gear), unless `Backpacker`/`BlizzardBagsPlus` is loaded |
| `fonts.lua` | Wires the addon's own font objects (see [Settings & Locale]({{< relref "settings-and-locale" >}})), including a Latin-vs-non-Latin locale check |
| `gamemenu.lua` | The Escape-menu button list |
| `mirrortimers.lua` | Mirror timers (breath, feign death, etc.) |
| `popups.lua` | `StaticPopup` dialogs |
| `styling.lua` | Tints the character, spell book, dungeon finder, world map and merchant frames; see below |
| `totembar.lua` | `MultiCastActionBarFrame` (totem bar) |
| `tooltips.lua` | `GameTooltip` skin + inspected-player gear info |

Several modules that only ever targeted later clients (an alternate power
bar, a character-sheet item-level display that permanently disabled itself,
and a few empty stubs) were removed in the WotLK-only cleanup.

## `styling.lua`

The catch-all for Blizzard frames that get tinted but don't warrant their
own file: an `elements` list of frame names (the character, spell book,
dungeon finder, world map and merchant frames, and the bags unless a bag
addon replaces them), whose textures get the backdrop color and whose text
gets the title color, minus a small `whiteList` of regions left alone.
Every name in the list exists in the 3.3.5 FrameXML; trimmed during the
[WotLK-only dead-code sweep]({{< relref "conventions#wotlk-335a-only" >}}):
roughly 130 entries tied to `Blizzard_PVPUI`/`Blizzard_TalentUI`/
`Blizzard_TradeSkillUI`/`Blizzard_GarrisonUI` (none of which exist as
load-on-demand addons on this client), a dead objective-tracker
positioning subsystem, the machinery for frames from addons loaded later
(nothing used it), and the character slot cleanup aimed at textures 3.3.5
doesn't have.

## `gamemenu.lua`

`Module.UpdateButtonLayout` is wrapped in `Module:Wrap(...)` rather than
called directly — the file's own comment explains why: *"to avoid potential
taint, we safewrap the layout method"*. `Engine:Wrap` (`engine-core.lua`'s
`safeCall`) is the concrete mechanism: if called while `InCombatLockdown()`,
it queues the function instead of running it immediately, and drains the
queue once combat lockdown actually ends — since repositioning secure/
protected Blizzard buttons *during* combat lockdown is exactly what causes
taint errors, not just doing it "when Blizzard doesn't expect it." Worth
following this precedent for any new method that rearranges secure/
protected Blizzard UI elements, rather than calling straight through.
