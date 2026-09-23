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
| `containers.lua` | Bags (quality borders, item levels on gear), unless `Backpacker`/`BlizzardBagsPlus` is loaded |
| `durability.lua` | `DurabilityFrame` |
| `fonts.lua` | Wires the addon's own font objects (see [Settings & Locale]({{< relref "settings-and-locale" >}})), including a Latin-vs-non-Latin locale check |
| `gamemenu.lua` | The Escape-menu button list |
| `ghostframe.lua` | `GhostFrame` (release-spirit prompt) |
| `mirrortimers.lua` | Mirror timers (breath, feign death, etc.) |
| `popups.lua` | `StaticPopup` dialogs |
| `styling.lua` | A grab-bag of remaining Blizzard frames (character/quest/talent-adjacent chrome); see below |
| `totembar.lua` | `MultiCastActionBarFrame` (totem bar) |
| `vehicleseat.lua` | `VehicleSeatIndicator` |
| `tooltips.lua` | `GameTooltip` skin + inspected-player gear info |

Several modules that only ever targeted later clients (an alternate power
bar, a character-sheet item-level display that permanently disabled itself,
and a few empty stubs) were removed in the WotLK-only cleanup.

## `styling.lua`

The catch-all for Blizzard frames that get styled but don't warrant their
own file — a big `elements`/`whiteList`/`blackList` table plus
`iterateNameless` for anonymous regions, driving a generic "walk this
frame's regions/children and restyle anything matching" pass. Already
trimmed once during the
[WotLK-only dead-code sweep]({{< relref "conventions#wotlk-335a-only" >}}):
roughly 130 entries tied to `Blizzard_PVPUI`/`Blizzard_TalentUI`/
`Blizzard_TradeSkillUI`/`Blizzard_GarrisonUI` (none of which exist as
load-on-demand addons on this client) were removed, along with an entire
dead objective-tracker positioning subsystem.

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
