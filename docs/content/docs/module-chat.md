---
title: "Module Tour: Chat"
weight: 10
---

# Module Tour: Chat

`modules/chat/` is four small, independent modules, each with a single
job and each willing to step aside for a dedicated standalone addon doing
the same thing — see [`SetIncompatible`]({{< relref
"modules-and-widgets#opting-out-setincompatible" >}}):

| File | Module | Yields to |
|---|---|---|
| `windows.lua` | `ChatWindows` | `Prat-3.0` |
| `bubbles.lua` | `ChatBubbles` | `NiceBubbles` |
| `filters.lua` | `ChatFilters` | `gUI4_Chat` |
| `cleaner.lua` | `ChatCleaner` | `ChatCleaner`, `CleanerChat` |

## `ChatWindows`

Styling and behavior for the chat frames themselves — tab fading, window
alpha/color.

## `ChatBubbles`

Restyles the little floating speech-bubble frames above characters' heads
in the 3D world (distinct from the chat window itself). Blizzard's bubble is
emptied (no artwork, invisible text) and a bubble of ours, with the same
text in a bigger font on a dark backdrop, follows it every frame. Maintains
its own bubble registry (`bubbles`, `numChildren`/`numBubbles` counters)
since these are anonymous frames Blizzard creates and reuses as people talk
nearby, not named globals this addon can just grab once.

## `ChatFilters`

Message filters registered via overriding `frame.AddMessage`
(`Module.SetUpFrame`, applied to every `CHAT_FRAMES` entry plus any later
temporary window via a `FCF_OpenTemporaryWindow` hook) — normalizing player-
name/channel-name link formatting, coloring AFK/DND tags and raid warnings,
and the **copy web links** feature:

Web addresses found in a message become light blue
`|Hurl:<address>|h<address>|h` links, through `WrapWebLinks` (the same rules
as CleanerChat's Glass backport): anything with a scheme (`https://`,
`ftp://`, ...), `www.` domains, `mailto:` and e-mail addresses, IPv4
addresses, domains with a port or a path, and bare domains with a common top
level domain, so "etc." or "v3.3.5a" stay text. Brackets and quotes around an
address and the punctuation ending a sentence after it stay out of the link;
links, textures and colors already in the message are copied over as they
are. Hovering one shows "Click to copy the link." (an `OnHyperlinkEnter`
hook on each chat frame). The popup (the address selected, read only) opens
on left-click through a **real override of `_G.SetItemRef`**, not
`hooksecurefunc`: Blizzard's own `SetItemRef` falls through to
`ItemRefTooltip:SetHyperlink()` for any link type it doesn't recognize,
which *errors* outright rather than no-op'ing, so a secure hook running
*alongside* the original isn't enough — this custom link type has to be
caught and handled *instead of* calling through to the original at all.

## `ChatCleaner`

Shorter system lines, in the spirit of Goldpaw's ChatCleaner: "You receive
loot: [Item]x3." becomes `+ [Item] (3)`, looted money shows as coins
(`F.Money`), and experience, reputation, honor, skills, level ups, quests,
away/busy/rested, online/offline, auctions and achievements get short
colored lines. Each group has its own option (`ChatFilters` settings,
"Shorter Messages" in the chat options); one more hides channel
join/leave/change notices and empty chat lines.

It works with chat message event filters, so a line is rewritten before
any window shows it. Each rule names the global string Blizzard printed the
line from; `ToPattern` turns that into a Lua pattern, keeping track of
translations that reorder their arguments (`%2$s`), so any client language
works. Rules are tried in order (a line with a count before the same line
without one, since "%sx%d." also reads as "%s."), and a rule that can't use
a line it matched passes it on. Achievement lines keep their `%s`:
Blizzard puts the player's name there after the filters.

Hiding a "Left Channel" notice skips Blizzard's own bookkeeping (a chat
window forgets a channel it left only while showing that notice), so the
filter forgets it in its place.
