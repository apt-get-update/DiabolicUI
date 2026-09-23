---
title: "Case Study: The Loot Window"
weight: 8
---

# Case Study: The Loot Window

`modules/blizzard/lootframe.lua` replaces Blizzard's loot window entirely.
It's a good worked example of the "own the frame" principle mentioned in
[Conventions]({{< relref "conventions" >}}), and of the
[texture canvas ratio]({{< relref "conventions#texture-canvas-vs-visible-art" >}})
pitfall, both in one real file.

## Why not just reskin Blizzard's `LootFrame`?

An earlier version of this feature patched Blizzard's live `LootFrame`
directly — recoloring it, resizing its rows, adding a custom backdrop. That
approach kept hitting the same handful of problems, all inherent to not
fully controlling the frame being patched:

- The backdrop and row backgrounds needed a sibling frame at a carefully
  guessed frame level, because the actual clipping ancestor of Blizzard's
  own row buttons wasn't obvious from the outside.
- Deciding whether a row *genuinely* had an item in it (as opposed to being
  an unused row Blizzard just hadn't hidden yet) meant reading back widget
  state (`button:IsShown()`, whether its icon texture had already been set)
  that turned out to be unreliable and racy — a freshly opened window could
  show a correctly-styled first row and a not-yet-styled second one, purely
  because Blizzard hadn't populated it yet at the moment this code ran.
- A hard Lua crash (`LootFrame.lua:225: attempt to perform arithmetic on
  field 'page' (a nil value)`) came from an inherited `OnUpdate` script
  (`LootItem_OnEnter`) that assumes it's running on a real descendant of the
  actual `LootFrame`.

None of these are bugs in *this* addon's logic so much as the fundamental
cost of patching something you don't fully own. Studying
[xLoot](https://warperia.com/addon-wotlk/xloot/)'s real, shipped source (a
long-established, working loot replacement addon for this same client)
confirmed the standard fix: **stop reskinning Blizzard's window and build
your own instead.**

## The technique

1. **Take over the events, don't fight the frame.** `LootFrame:UnregisterEvent(...)`
   for `LOOT_OPENED`/`LOOT_SLOT_CLEARED`/`LOOT_CLOSED`, and register those
   same three events on your own module instead. Blizzard's window then
   simply never opens — nothing to hide, clip around, or guess the layout
   of.
2. **Build fresh buttons from the template, not from Blizzard's live
   instances.** `CreateFrame("Button", name, ownFrame, "LootButtonTemplate")`
   reuses the *template* (icon/text layout XML) without inheriting any of
   Blizzard's own `LootButton1`..`N` frames or their existing parent chain.
3. **Populate straight from the API, not from widget state.**
   `GetLootSlotInfo(slot)` is called fresh on every `Update()`, and its
   `texture` return value is the one and only source of truth for "does
   this row have an item" — no `IsShown()` guessing, no race.
4. **Lay out rows yourself.** Since the buttons are 100% owned, position
   is a plain deterministic vertical chain (`Module.Update`, below) instead
   of pitch-measuring an unfamiliar scrollframe.

## Template gotchas that had to be worked around

`LootButtonTemplate` comes with baggage that isn't obvious until you hit it:

- Its native `NormalTexture`/`HighlightTexture`/`PushedTexture` are shown
  automatically by the Button widget engine on hover/click, *regardless of
  any script you write* — they have to be explicitly cleared
  (`button:SetNormalTexture("")`, etc.), and a generic sweep over
  `button:GetRegions()` hides any other texture region that isn't one this
  module explicitly created (see the `ours` table in `CreateRow`).
- Its XML wires an `OnUpdate` script that calls Blizzard's own
  `LootItem_OnEnter`, which indexes `LootFrame.page` — `nil` for a button
  that isn't really a child of the real `LootFrame`. Fixed with
  `button:SetScript("OnUpdate", nil)`.
- The icon texture and item-name `FontString` are accessible as
  `_G[buttonName.."IconTexture"]` / `_G[buttonName.."Text"]` — global names
  derived from the button's own name, not fields on the button object
  itself.

## The row-background scaling ratio

The wide ornate row background (`DiabolicUI_UIButton_300x51_*.tga`) has a
300×51 *visible* design (`row.size`) sitting inside a much larger 512×128
*canvas* (`row.texture_size`), padded transparently on all sides. A loot
item name can be arbitrarily long, so the row itself — and this background —
needs to stretch to fit. Sizing the texture frame to just the target row
size would only shrink the *whole canvas* to that size, making the visible
art render far smaller than intended. The fix scales canvas and row by the
identical ratio:

```lua
local scaleX, scaleY = rowWidth / rowConfig.size[1], rowHeight / rowConfig.size[2]
local canvasWidth, canvasHeight = rowConfig.texture_size[1] * scaleX, rowConfig.texture_size[2] * scaleY
texture:SetSize(canvasWidth, canvasHeight)
texture:SetPoint("CENTER", button, "CENTER")
```

This same pattern shows up anywhere else in the addon a background/border
texture has to stretch to fit dynamic content — see
[Conventions]({{< relref "conventions#texture-canvas-vs-visible-art" >}}).
