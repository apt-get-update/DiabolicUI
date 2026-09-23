---
title: "Module Tour: Chat"
weight: 10
---

# Module Tour: Chat

`modules/chat/` is three small, independent modules, each with a single
job and each willing to step aside for a dedicated standalone addon doing
the same thing — see [`SetIncompatible`]({{< relref
"modules-and-widgets#opting-out-setincompatible" >}}):

| File | Module | Yields to |
|---|---|---|
| `windows.lua` | `ChatWindows` | `Prat-3.0` |
| `bubbles.lua` | `ChatBubbles` | `NiceBubbles` |
| `filters.lua` | `ChatFilters` | `gUI4_Chat` |

## `ChatWindows`

Styling and behavior for the chat frames themselves — tab fading, window
alpha/color.

## `ChatBubbles`

Restyles the little floating speech-bubble frames above characters' heads
in the 3D world (distinct from the chat window itself). Maintains its own
bubble registry (`bubbles`, `numChildren`/`numBubbles` counters) since these
are anonymous frames Blizzard creates and destroys as people talk nearby,
not named globals this addon can just grab once.

## `ChatFilters`

Message filters registered via overriding `frame.AddMessage`
(`Module.SetUpFrame`, applied to every `CHAT_FRAMES` entry plus any later
temporary window via a `FCF_OpenTemporaryWindow` hook) — normalizing player-
name/channel-name link formatting, coloring AFK/DND tags and raid warnings,
and (optionally, `Module.db.copyWebLinks`) the **copy web links** feature:

Any `http://`/`https://` URL found in a message gets wrapped in a custom
`|HDiabolicCopyText:<id>|h` hyperlink (keeping the URL itself as the visible
text, everything else in the message untouched) via `WrapWebLinks`. The
actual popup — an editable, pre-selected text box the player can copy from —
opens on left-click through a **real override of `_G.SetItemRef`**, not
`hooksecurefunc`: Blizzard's own `SetItemRef` falls through to
`ItemRefTooltip:SetHyperlink()` for any link type it doesn't recognize,
which *errors* outright rather than no-op'ing, so a secure hook running
*alongside* the original isn't enough — this custom link type has to be
caught and handled *instead of* calling through to the original at all.

The URL-to-popup-text mapping (`copyTextByIndex`) is a small ring buffer
(`COPY_TEXT_HISTORY_LIMIT = 200`) so it can't grow unboundedly over a long
play session.
