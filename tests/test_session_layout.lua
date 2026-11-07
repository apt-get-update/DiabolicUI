-- Run from the addon root: lua5.1 tests/test_session_layout.lua
--
-- /dui layout (modules/blizzard/layout-scan.lua) in the fake client: what it
-- saves, parts placed by settings/positions.lua (adjust.lua), and /dui layout
-- all opening each window in turn.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean = Session.assertClean

local client, kit

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
	kit = client:GetModule("Blizzard: Windows")
end

-- Whether the layout check is on (for this session only).
local function checking()
	return client:GetModule("Blizzard: Layout Scan").Ticker:IsShown() and true or false
end

local function slash(text)
	_G.SlashCmdList.DIABOLICUISLASHHANDLER(text)
end

-- What the Layout chat window (the first free one, ChatFrame3) was told, without our prefix.
local function said()
	local lines = {}
	for _, message in ipairs(client.widgetState[_G.ChatFrame3].messages) do
		lines[#lines + 1] = (message.text:gsub("^|cffff8000DiabolicUI|r ", ""))
	end
	return lines
end

-- A window of ours over a frame of `name`, 400x300 at a whole place on
-- screen, its band, title and close button.
local function window(name)
	local frame = CreateFrame("Frame", name, _G.UIParent)
	frame:SetSize(400, 300)
	frame:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 100, -100)
	local win = kit:CreateWindow(frame, { 0, 0, 0, 0 })
	local header = kit:CreateHeader(win, 40, { 24, 24 })
	local title = frame:CreateFontString(name .. "Title")
	title:SetText("Audit")
	kit:SetTitle(header, title)
	local close = CreateFrame("Button", name .. "CloseButton", frame)
	close:SetSize(32, 32)
	kit:StyleClose(close, win, header)
	frame:Hide()
	return frame, win, header
end

-- One of our buttons, its bottom left at `x`, `y` in `frame`.
local function button(frame, name, x, y, width, text)
	local b = CreateFrame("Button", name, frame, "UIPanelButtonTemplate")
	b:SetSize(width, 22)
	b:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", x, y)
	b:SetText(text)
	b.DiabolicStyled = true
	return b
end

-- A zone of `material` (slate by default) around a frame of `name`, its
-- top left at `x`, `y` in `frame`.
local function zone(frame, name, x, y, width, height, material)
	local f = CreateFrame("Frame", name, frame)
	f:SetSize(width, height)
	f:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
	return kit:AddZone(f, material or "slate", { 0, 0, 0, 0 }), f
end

local function text(frame, name, x, y, value)
	local t = frame:CreateFontString(name)
	t:SetText(value)
	t:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
	return t
end

TestLayoutAudit = {}

function TestLayoutAudit:tearDown()
	client, kit = nil, nil
end

function TestLayoutAudit:test_a_bag_keeps_only_what_it_shows()
	boot()
	local frame = window("AuditBag")
	local one, two = button(frame, "AdiBagsItemButton1", 40, 100, 30, "1"), button(frame, "AdiBagsItemButton2", 80, 100, 30, "2")
	local other = button(frame, "AuditBagOther", 120, 100, 30, "3")
	slash("layout")
	frame:Show()
	client:Tick(1.1)
	local seen = _G.DiabolicUI_Layout.windows.AuditBag
	lu.assertNotNil(seen.parts.AdiBagsItemButton1)
	lu.assertNotNil(seen.parts.AdiBagsItemButton2)
	-- (an older version's art: gone with the next look)
	seen.art = {}
	one:Hide()
	other:Hide()
	client:Tick(1.1)
	lu.assertNil(seen.parts.AdiBagsItemButton1)
	lu.assertNotNil(seen.parts.AdiBagsItemButton2)
	lu.assertNotNil(seen.parts.AuditBagOther) -- (not a bag's: kept as ever)
	lu.assertNil(seen.art)
	assertClean(client)
end

function TestLayoutAudit:test_a_window_keeping_them()
	boot()
	local frame = window("AuditFine")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	text(frame, "AuditInk", 40, -90, "In ink"):SetTextColor(0, 0, 0)
	-- (art: a white line colored, a glow under the cursor only, Blizzard's)
	local line = frame:CreateTexture(nil, "BACKGROUND")
	line:SetTexture([[Interface\Buttons\WHITE8X8]])
	line:SetVertexColor(1, .5, 0)
	kit.Gradient(line, "HORIZONTAL", 1, .5, 0, 1, .5, .25, 0, .5)
	line:SetPoint("TOPLEFT", 10, -10)
	line:SetSize(100, 1)
	local glow = frame:CreateTexture("AuditGlow", "HIGHLIGHT")
	glow:SetTexture([[Interface\AddOns\DiabolicUI\media\textures\DiabolicUI_D3_GemRing]])
	glow:SetAllPoints()
	local blizzard = frame:CreateTexture(nil, "ARTWORK")
	blizzard:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])
	blizzard:SetAllPoints()
	frame:Show()
	slash("layout")
	lu.assertNotNil(_G.DiabolicUI_Layout.windows.AuditFine.checked)
	-- its named parts saved, where they are (from its top left, y down)
	-- and how they're placed, to move them by name
	local parts = _G.DiabolicUI_Layout.windows.AuditFine.parts
	-- (as settings/positions.lua takes them; a text keeps its own size)
	local page, ink = parts.AuditPage, parts.AuditInk
	lu.assertEquals({ unpack(page, 1, 7) }, { "TOPLEFT", "AuditFine", "TOPLEFT", 30, -80, 340, 150 })
	lu.assertEquals(page.kind, "Frame")
	lu.assertEquals({ unpack(ink) }, { "TOPLEFT", "AuditFine", "TOPLEFT", 40, -90 })
	lu.assertEquals(ink.text, "In ink")
	-- (for an editor: all its points, its parent, where it is on screen, its layer)
	lu.assertEquals(page.points, { { "TOPLEFT", "AuditFine", "TOPLEFT", 30, -80 } })
	lu.assertEquals(page.parent, "AuditFine")
	lu.assertEquals(page.rect, { frame:GetLeft() + 30, frame:GetTop() - 230, 340, 150 })
	lu.assertEquals({ page.strata, page.level }, { frame:GetFrameStrata(), _G.AuditPage:GetFrameLevel() })
	lu.assertEquals({ ink.layer, ink.level }, { "ARTWORK", frame:GetFrameLevel() })
	lu.assertEquals(_G.DiabolicUI_Layout.windows.AuditFine.rect, { frame:GetLeft(), frame:GetBottom(), 400, 300 })
	-- what's styled says as what (windows/components/): the window's close
	lu.assertEquals(parts.AuditFineCloseButton.style, "CloseButton")
	lu.assertNil(page.style)
	-- the art (for the editor to draw it): the textures, the backdrops (its
	-- border), in the order they're drawn
	local art, lines, backdrops = _G.DiabolicUI_Layout.windows.AuditFine.views[""].art, {}, {}
	for _, packed in ipairs(art) do
		lu.assertEquals(type(packed), "string")
		local item = assert(loadstring("return " .. packed))()
		lu.assertNil(item.order)
		lu.assertNotEquals(item.owner, "AuditGlow")
		if (item.file == [[Interface\Buttons\WHITE8X8]]) then
			lines[#lines + 1] = item
		elseif item.backdrop then
			backdrops[#backdrops + 1] = item
		end
	end
	lu.assertEquals(#lines, 1)
	lu.assertEquals(lines[1].color, { 1, .5, 0, 1 })
	lu.assertEquals(lines[1].coords, { 0, 0, 0, 1, 1, 0, 1, 1 })
	lu.assertEquals(lines[1].rect, { frame:GetLeft() + 10, frame:GetTop() - 11, 100, 1 })
	lu.assertEquals({ lines[1].owner, lines[1].alpha, lines[1].blend }, { "AuditFine", 1, "BLEND" })
	lu.assertEquals(lines[1].gradient, { "HORIZONTAL", 1, .5, 0, 1, .5, .25, 0, .5 })
	lu.assertTrue(#backdrops > 0)
	lu.assertEquals(#backdrops[1].backdrop.insets, 4)
	-- our own parts named after it, listed too (its window, its band, the
	-- page's zone), placed on unnamed ones "?"
	local zone = parts.AuditPageDiabolicZone
	lu.assertEquals(zone.points[2], { "BOTTOMRIGHT", "AuditPage", "BOTTOMRIGHT", 0, 0 })
	lu.assertNotNil(parts.AuditFineDiabolic)
	lu.assertEquals(parts.AuditFineDiabolicBand.parent, "AuditFineDiabolic")
	-- its parts counted, once
	local total = tonumber(said()[2]:match("^AuditFine: (%d+) parts saved %(%1 new%)%.$"))
	lu.assertTrue(total > 3)
	local before = #said()
	client:Tick(1.1)
	lu.assertEquals(#said(), before)
	-- again when new ones show (a page, a tab)
	text(frame, "AuditMore", 40, -120, "More"):SetTextColor(0, 0, 0)
	local nameless = CreateFrame("Frame", nil, frame)
	nameless:SetSize(10, 10)
	nameless:SetPoint("TOPLEFT")
	local hanging = CreateFrame("Frame", "AuditHanging", frame)
	hanging:SetSize(10, 10)
	hanging:SetPoint("TOP", nameless, "BOTTOM")
	client:Tick(1.1)
	lu.assertEquals(said()[before + 1], string.format("AuditFine: %d parts saved (2 new).", total + 2))
	lu.assertEquals(parts.AuditHanging.points, { { "TOP", "?", "BOTTOM", 0, 0 } })
	client:Tick(1.1)
	lu.assertEquals(#said(), before + 1)
	-- off again
	slash("layout")
	lu.assertEquals(said()[before + 2], "Layout scan off: /reload to write it.")
	lu.assertFalse(checking())
	assertClean(client)
end

-- A window's art and where it is by the tabs chosen, each part with the tabs
-- it showed in (the editor shows one tab at a time).
function TestLayoutAudit:test_a_window_by_its_tabs()
	boot()
	local frame = window("AuditTabbed")
	local Tab = function(name, label)
		local tab = CreateFrame("Button", name, frame)
		tab:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 40, 40)
		tab:SetSize(60, 20)
		tab:SetText(label)
		return tab
	end
	local first, second = Tab("AuditTabbedTab1", "First"), Tab("AuditTabbedTab2", "")
	local icon = first:CreateTexture("AuditTabbedIcon", "ARTWORK")
	icon:SetTexture([[Interface\Icons\INV_Misc_QuestionMark]])
	icon:SetAllPoints()
	zone(frame, "AuditPageOne", 30, -80, 340, 150, "parchment")
	first:Disable()
	frame:Show()
	slash("layout")
	local seen = _G.DiabolicUI_Layout.windows.AuditTabbed
	lu.assertEquals(seen.views.AuditTabbedTab1.label, "First")
	-- (the game's art too)
	local files = {}
	for _, packed in ipairs(seen.views.AuditTabbedTab1.art) do
		local item = assert(loadstring("return " .. packed))()
		files[item.file or ""] = item.owner
	end
	lu.assertEquals(files[ [[Interface\Icons\INV_Misc_QuestionMark]] ], "AuditTabbedIcon")
	lu.assertEquals(seen.views.AuditTabbedTab1.rect, { frame:GetLeft(), frame:GetBottom(), 400, 300 })
	lu.assertEquals(seen.parts.AuditPageOne.tabs, { AuditTabbedTab1 = true })
	-- the other tab (no text: by its name), a part in both, one only there
	first:Enable()
	second:Disable()
	_G.AuditPageOne:Hide()
	zone(frame, "AuditPageTwo", 30, -80, 340, 150, "parchment")
	client:Tick(1.1)
	lu.assertEquals(seen.views.AuditTabbedTab2.label, "AuditTabbedTab2")
	-- (an icon's reads as its tooltip)
	second.tooltip = "Second"
	client:Tick(1.1)
	lu.assertEquals(seen.views.AuditTabbedTab2.label, "Second")
	lu.assertEquals(seen.tabButtons.AuditTabbedTab2, "Second")
	lu.assertEquals(seen.parts.AuditPageOne.tabs, { AuditTabbedTab1 = true })
	lu.assertEquals(seen.parts.AuditPageTwo.tabs, { AuditTabbedTab2 = true })
	lu.assertEquals(seen.parts.AuditTabbedDiabolic.tabs, { AuditTabbedTab1 = true, AuditTabbedTab2 = true })
	slash("layout")
	assertClean(client)
end

-- What the editor draws a text by: as the game shows it, by the tabs chosen, its
-- font and colour; and what a scroll frame cuts off isn't told, the scroll bar
-- beside it still is.
function TestLayoutAudit:test_what_the_editor_draws()
	boot()
	local frame = window("AuditWords")
	local coded = "|cffff0000Red|r\nline"
	text(frame, "AuditWordsText", 40, -80, coded):SetTextColor(.5, .25, 0)
	local Art = function(parent, name, y)
		local art = parent:CreateTexture(name, "ARTWORK")
		art:SetTexture([[Interface\Icons\INV_Misc_QuestionMark]])
		art:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
		art:SetSize(100, 20)
	end
	local scroll = CreateFrame("ScrollFrame", "AuditWordsScroll", frame)
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, -120)
	scroll:SetSize(100, 40)
	local child = CreateFrame("Frame", "AuditWordsChild", scroll)
	child:SetPoint("TOPLEFT", scroll, "TOPLEFT", 0, 0)
	child:SetSize(100, 200)
	scroll:SetScrollChild(child)
	Art(child, "AuditWordsArtIn", 0)
	Art(child, "AuditWordsArtOut", -100)
	local Row = function(name, y)
		local row = child:CreateFontString(name)
		row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, y)
		row:SetSize(100, 20)
		row:SetText(name)
	end
	Row("AuditWordsIn", 0)
	Row("AuditWordsOut", -100)
	local bar = CreateFrame("Frame", "AuditWordsBar", scroll)
	bar:SetPoint("TOPLEFT", scroll, "TOPRIGHT", 4, 0)
	bar:SetSize(16, 40)
	Art(bar, "AuditWordsArtBar", 0)
	frame:Show()
	slash("layout")
	local seen = _G.DiabolicUI_Layout.windows.AuditWords
	local parts, view = seen.parts, seen.views[""]
	lu.assertTrue(view.worded)
	lu.assertNil(parts.AuditWordsText.text) -- (not a file's text)
	lu.assertEquals(parts.AuditWordsText.words[""], coded)
	lu.assertEquals(parts.AuditWordsText.color, { .5, .25, 0, 1 })
	lu.assertEquals(parts.AuditWordsText.justifyV, "MIDDLE")
	lu.assertNotNil(parts.AuditWordsText.font)
	lu.assertNotNil(parts.AuditWordsText.fontSize)
	lu.assertEquals(parts.AuditWordsIn.words[""], "AuditWordsIn")
	lu.assertNotNil(parts.AuditWordsOut) -- (still there to pick)
	lu.assertNil(parts.AuditWordsOut.words[""])
	local owners = {}
	for _, packed in ipairs(view.art) do
		owners[assert(loadstring("return " .. packed))().owner or ""] = true
	end
	lu.assertTrue(owners.AuditWordsArtIn)
	lu.assertTrue(owners.AuditWordsArtBar)
	lu.assertNil(owners.AuditWordsArtOut)
	slash("layout")
	assertClean(client)
end

-- Our own parts named after what they're for (/dui layout lists them,
-- settings/positions.lua places them), a number after a name taken; none
-- for a part with no name.
function TestLayoutAudit:test_our_parts_named_after_their_owner()
	boot()
	local frame = window("AuditNames")
	lu.assertEquals(_G.AuditNamesDiabolic:GetParent(), frame)
	local list = CreateFrame("Frame", "AuditNamesList", frame)
	lu.assertEquals(kit:AddZone(list, "slate", { 0, 0, 0, 0 }):GetName(), "AuditNamesListDiabolicZone")
	lu.assertEquals(kit:AddZone(list, "slate", { 0, 0, 0, 0 }):GetName(), "AuditNamesListDiabolicZone2")
	lu.assertNil(kit:AddZone(CreateFrame("Frame", nil, frame), "slate", { 0, 0, 0, 0 }):GetName())
	assertClean(client)
end

-- One stretched: on both its points, again when something moves it.
function TestLayoutAudit:test_a_part_stretched_on_two_points()
	boot()
	local adjust = client:GetModule("Blizzard: Adjust")
	local frame = CreateFrame("Frame", "StretchFrame", _G.UIParent)
	local part = CreateFrame("Frame", "StretchPart", frame)
	adjust.config.StretchPart = { "TOPLEFT", "StretchFrame", "TOPLEFT", 5, -5, second = { "BOTTOMRIGHT", "BOTTOMRIGHT", -6, 7 } }
	adjust:Apply()
	local Points = function()
		lu.assertEquals(part:GetNumPoints(), 2)
		lu.assertEquals({ part:GetPoint(1) }, { "TOPLEFT", frame, "TOPLEFT", 5, -5 })
		lu.assertEquals({ part:GetPoint(2) }, { "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 7 })
	end
	Points()
	part:ClearAllPoints()
	part:SetPoint("CENTER")
	Points()
	assertClean(client)
end

-- One placed on a window not made yet: where it was until it is, then placed.
function TestLayoutAudit:test_a_part_waits_for_the_window_its_placed_on()
	boot()
	local adjust = client:GetModule("Blizzard: Adjust")
	local frame = CreateFrame("Frame", "WaitFrame", _G.UIParent)
	local part = CreateFrame("Frame", "WaitPart", frame)
	part:SetPoint("CENTER")
	adjust.config.WaitPart = { "TOPLEFT", "WaitFrameDiabolic", "TOPLEFT", 5, -5 }
	adjust:Apply()
	lu.assertEquals((part:GetPoint()), "CENTER")
	local win = kit:CreateWindow(frame, { 0, 0, 0, 0 })
	lu.assertEquals({ part:GetPoint() }, { "TOPLEFT", win, "TOPLEFT", 5, -5 })
	assertClean(client)
end

-- settings/positions.lua (modules/blizzard/adjust.lua): a part moved
-- and resized by its name, kept so whatever moves it again; one made later
-- once an addon loads; a protected one after combat.
function TestLayoutAudit:test_parts_moved_and_resized_by_name()
	boot()
	local adjust = client:GetModule("Blizzard: Adjust")
	local frame = window("AdjustFrame")
	local part = button(frame, "AdjustButton", 10, 10, 80, "Okay")
	local secure = CreateFrame("Button", "AdjustSecure", frame, "SecureActionButtonTemplate")
	secure:SetPoint("CENTER")
	local positions = adjust.config
	positions.AdjustButton = { "BOTTOMRIGHT", "AdjustFrame", "BOTTOMRIGHT", -10, 12, 90, 24 }
	positions.AdjustLater = { "TOP", "AdjustFrame", "TOP", 0, -50 }
	positions.AdjustSecure = { "TOPLEFT", "AdjustFrame", "TOPLEFT", 5, -5 }
	client:EnterCombat()
	adjust:Apply()
	lu.assertEquals({ part:GetPoint() }, { "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 12 })
	lu.assertEquals({ part:GetWidth(), part:GetHeight() }, { 90, 24 })
	lu.assertEquals((secure:GetPoint()), "CENTER")
	-- moved or resized again by its own code: put back
	part:ClearAllPoints()
	part:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
	lu.assertEquals({ part:GetPoint() }, { "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 12 })
	part:SetSize(80, 22)
	lu.assertEquals({ part:GetWidth(), part:GetHeight() }, { 90, 24 })
	-- the protected one once combat ends
	client:LeaveCombat()
	lu.assertEquals({ secure:GetPoint() }, { "TOPLEFT", frame, "TOPLEFT", 5, -5 })
	-- one made later (an addon's) once an addon loads
	local later = CreateFrame("Frame", "AdjustLater", frame)
	later:SetPoint("CENTER")
	client:FireEvent("ADDON_LOADED", "Something")
	lu.assertEquals({ later:GetPoint() }, { "TOP", frame, "TOP", 0, -50 })
	assertClean(client)
end

-- settings/positions.lua: { width, height } alone resizes a part where it
-- is; two parts chained the other way round by Blizzard swapped (each let
-- go first: no loop).
function TestLayoutAudit:test_parts_sized_only_and_chains_swapped()
	boot()
	local adjust = client:GetModule("Blizzard: Adjust")
	local frame = window("ChainFrame")
	local first = button(frame, "ChainFirst", 10, 10, 80, "Join")
	local second = CreateFrame("Button", "ChainSecond", frame)
	second:SetSize(80, 22)
	second:SetPoint("LEFT", first, "RIGHT", 8, 0)
	first:ClearAllPoints()
	first:SetPoint("RIGHT", second, "LEFT", -8, 0) -- (Blizzard's: the first hangs off the second)
	second:ClearAllPoints()
	second:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
	local positions = adjust.config
	positions.ChainSecond = { "LEFT", "ChainFirst", "RIGHT", 8, 0 }
	positions.ChainFirst = { "BOTTOM", "ChainFrame", "BOTTOM", 0, 10, 100, 24 }
	positions.ChainSized = { 120, 30 }
	local sized = CreateFrame("Frame", "ChainSized", frame)
	sized:SetPoint("TOP", frame, "TOP", 0, -40)
	sized:SetSize(10, 10)
	adjust:Apply()
	lu.assertEquals({ first:GetPoint() }, { "BOTTOM", frame, "BOTTOM", 0, 10 })
	lu.assertEquals({ second:GetPoint() }, { "LEFT", first, "RIGHT", 8, 0 })
	lu.assertEquals({ sized:GetPoint() }, { "TOP", frame, "TOP", 0, -40 })
	lu.assertEquals({ sized:GetWidth(), sized:GetHeight() }, { 120, 30 })
	sized:SetWidth(10)
	lu.assertEquals(sized:GetWidth(), 120)
	assertClean(client)
end

function TestLayoutAudit:test_off_after_a_reload_what_is_old_forgotten()
	boot({ savedVariables = { DiabolicUI_Layout = { on = true, moved = { Old = { 1, 2 } }, adjust = true, windows = {
		AuditFine = { checked = "2026-10-27 20:00", problems = { "an old one" } },
		Elsewhere = { checked = "2026-10-27 20:00", parts = { Kept = { "TOP", "Elsewhere", "TOP", 0, 0, kind = "Frame" } } },
	} } } })
	-- (an older version's: the scan is on for a session only)
	lu.assertNil(_G.DiabolicUI_Layout.on)
	lu.assertNil(_G.DiabolicUI_Layout.moved)
	lu.assertNil(_G.DiabolicUI_Layout.adjust)
	lu.assertFalse(checking())
	local frame = window("AuditFine")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	frame:Show()
	slash("layout")
	client:Tick(1.1)
	lu.assertNil(_G.DiabolicUI_Layout.windows.AuditFine.problems)
	lu.assertNotNil(_G.DiabolicUI_Layout.windows.Elsewhere.parts.Kept)
	assertClean(client)
end

-- What's left to scan: our windows not scanned, by an older version, their
-- tabs not visited, what we don't style; less of it said as it goes.
function TestLayoutAudit:test_what_is_left_to_scan()
	boot({ savedVariables = { DiabolicUI_Layout = { windows = {
		DressUpFrame = { parts = { Old = { "TOP", "DressUpFrame", "TOP", 0, 0, kind = "Frame" } } },
	} } } })
	local function lineWith(start)
		for _, line in ipairs(said()) do
			if (line:sub(1, #start) == start) then
				return line
			end
		end
	end
	local frame = window("AuditLeft")
	local Tab = function(name, label)
		local tab = CreateFrame("Button", name, frame)
		tab:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 40, 40)
		tab:SetSize(60, 20)
		tab:SetText(label)
		return tab
	end
	local first, second, third = Tab("AuditLeftTab1", "First"), Tab("AuditLeftTab2", "Second"), Tab("AuditLeftTab3", "")
	first:Disable()
	frame:Show()
	-- what's not ours: shown, in the game's lists (not what's said not to be
	-- a window, what's in one of ours, what's hidden, what's not a frame)
	local Other = function(name, parent)
		local other = CreateFrame("Frame", name, parent or _G.UIParent)
		other:SetSize(10, 10)
		other:SetPoint("CENTER")
		return other
	end
	Other("AuditPlain")
	Other("GameMenuFrame")
	Other("AuditInside", frame)
	Other("AuditHidden"):Hide()
	_G.AuditString = "not a frame"
	for _, name in ipairs({ "AuditPlain", "GameMenuFrame", "AuditInside", "AuditHidden", "AuditString", "AuditNothing" }) do
		table.insert(_G.UISpecialFrames, name)
	end
	Other("AuditPanelWindow")
	_G.UIPanelWindows.AuditPanelWindow = { area = "left" }
	slash("layout")
	lu.assertTrue(lineWith("Still to open: "):find("BankFrame", 1, true) ~= nil)
	-- (a window for an addon: only if it's there)
	lu.assertNil(lineWith("Still to open: "):find("AtrFake", 1, true))
	lu.assertEquals(lineWith("Scanned by an older version, open again: "), "Scanned by an older version, open again: DressUpFrame.")
	lu.assertEquals(lineWith("Tabs not visited: "), "Tabs not visited: AuditLeft (AuditLeftTab3, Second).")
	lu.assertNotNil(lineWith("Not styled: "))
	local left = _G.DiabolicUI_Layout.left
	lu.assertEquals(left.unstyled, { "AuditPanelWindow", "AuditPlain" })
	lu.assertEquals(left.old, { "DressUpFrame" })
	-- a tab visited: one less, said
	local count = left.count
	first:Enable()
	second:Disable()
	client:Tick(1.1)
	lu.assertEquals(_G.DiabolicUI_Layout.left.count, count - 1)
	lu.assertEquals(lineWith(string.format("%d left", count - 1)), string.format("%d left to scan (/dui layout left).", count - 1))
	lu.assertEquals(_G.DiabolicUI_Layout.left.tabs, { "AuditLeft (AuditLeftTab3)" })
	-- styled since: not said any more
	_G.DiabolicUI_Layout.unstyled.BankFrame = true
	slash("layout left")
	lu.assertNil(_G.DiabolicUI_Layout.unstyled.BankFrame)
	-- all of it done
	second:Enable()
	third:Disable()
	client:Tick(1.1)
	wipe(kit.Windows)
	client:GetModule("Blizzard: Panels").config.frames = {}
	kit.config.layout.on_demand = {}
	_G.DiabolicUI_Layout.unstyled = {}
	slash("layout left")
	lu.assertEquals(said()[#said()], "Every window scanned, every tab visited.")
	assertClean(client)
end

-- A foot's height is its own, what's on it follows it and not the other way
-- round: a button placed on it, a page without one, a taller one.
function TestLayoutAudit:test_a_foot_holds_its_buttons()
	boot()
	local frame, win = window("AuditFoot")
	local foot = kit:AddFooter(win, true)
	lu.assertEquals(foot:GetName(), "AuditFootDiabolicFoot")
	lu.assertEquals(foot:GetHeight(), 35)
	lu.assertEquals(foot:GetNumPoints(), 2)
	local go = button(frame, "AuditFootGo", 0, 0, 80, "Go")
	go:ClearAllPoints()
	go:SetPoint("BOTTOMLEFT", foot, "BOTTOMLEFT", 14, 7)
	frame:Show()
	lu.assertEquals(foot:GetHeight(), 35)
	lu.assertEquals(go:GetBottom(), foot:GetBottom() + 7)
	lu.assertEquals(foot:GetBottom(), win:GetBottom() + 23)
	-- a page without one: nothing drawn, still there to be placed on
	kit:SetFooter(foot, nil)
	lu.assertNil(foot.DiabolicShown)
	lu.assertFalse(foot.Rail:IsShown() and true or false)
	lu.assertEquals(go:GetBottom(), foot:GetBottom() + 7)
	-- taller, its buttons where they are
	local at = go:GetBottom()
	kit:SetFooter(foot, 65)
	lu.assertTrue(foot.DiabolicShown)
	lu.assertTrue(foot.Rail:IsShown() and true or false)
	lu.assertEquals(foot:GetHeight(), 65)
	lu.assertEquals(go:GetBottom(), at)
	assertClean(client)
end

-- A part not placed has no sides yet.
function TestLayoutAudit:test_a_part_not_placed_has_no_edges()
	boot()
	lu.assertNil((kit.Edges(CreateFrame("Frame", nil, _G.UIParent))))
	assertClean(client)
end

-- A list over a foot goes by its iron bar, not by its buttons.
function TestLayoutAudit:test_a_list_goes_by_the_foot()
	boot()
	lu.assertEquals({ _G.FriendsFrameFriendsScrollFrameDiabolicZone:GetPoint(3) },
		{ "BOTTOM", _G.FriendsFrameDiabolicFoot, "TOP", 0, kit:FootBar() + 6 })
	assertClean(client)
end

function TestLayoutAudit:test_a_check_that_breaks_said_once()
	boot()
	local frame = window("AuditBroken")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	_G.AuditPage.GetLeft = function() error("broken") end
	frame:Show()
	slash("layout")
	client:Tick(2)
	local broken = 0
	for _, line in ipairs(said()) do
		if line:find("^AuditBroken couldn't be scanned: ") then
			broken = broken + 1
		end
	end
	lu.assertEquals(broken, 1)
	assertClean(client)
end

function TestLayoutAudit:test_the_sweep_opens_each_window()
	-- (the currencies' popup there, a player targeted in reach)
	boot({ world = function(world, c)
		c.api.LoadAddOn("Blizzard_TokenUI")
		world.units.target = Client.newUnit({ name = "Friend", class = "WARRIOR", isPlayer = true, inRange = true })
		world.inspectReady = true
	end })
	-- not in a fight
	client:EnterCombat()
	slash("layout all")
	lu.assertEquals(said()[1], "Not in combat.")
	client:LeaveCombat()
	-- each window in turn, page by page (one that breaks: the others still), then closed
	local opened = {}
	local toggle = _G.ToggleFriendsFrame
	_G.ToggleFriendsFrame = function(tab)
		if (tab == 3) then
			error("no such tab")
		end
		opened[#opened + 1] = tab
		return toggle(tab)
	end
	-- (the Bulletin Board's, when it's there)
	local board = false
	_G.GroupBulletinBoard_Addon = { ShowWindow = function() board = true end }
	slash("layout all")
	lu.assertTrue(checking())
	client:Tick(60, 0.1)
	lu.assertEquals(opened, { 1, 2, 4, 5 })
	lu.assertTrue(board)
	_G.GroupBulletinBoard_Addon = nil
	lu.assertEquals(_G.InspectFrame.unit, "target")
	-- (how many times it's said it's done, what's left after it)
	local function done()
		local count = 0
		for _, line in ipairs(said()) do
			count = count + (line:find("^Layout scan done") and 1 or 0)
		end
		return count
	end
	lu.assertEquals(done(), 1)
	lu.assertNotNil(_G.DiabolicUI_Layout.left)
	lu.assertFalse(_G.CharacterFrame:IsShown() == 1)
	-- stopped by a fight (the check left on: not started again)
	slash("layout all")
	client:Tick(1, 0.1)
	client:EnterCombat()
	client:Tick(2, 0.1)
	lu.assertEquals(done(), 2)
	client:LeaveCombat()
	assertClean(client)
end

-- A checked tab (a spellbook school's, a talent spec's) is a view of its own.
function TestLayoutAudit:test_a_checked_tab_is_a_view()
	boot()
	local frame = window("AuditChecked")
	local one = CreateFrame("CheckButton", "AuditCheckedTab1", frame)
	local two = CreateFrame("CheckButton", "AuditCheckedTab2", frame)
	one:SetChecked(1)
	frame:Show()
	slash("layout")
	client:Tick(1.5, 0.1)
	one:SetChecked(nil)
	two:SetChecked(1)
	client:Tick(1.5, 0.1)
	local views = _G.DiabolicUI_Layout.windows.AuditChecked.views
	lu.assertNotNil(views.AuditCheckedTab1)
	lu.assertNotNil(views.AuditCheckedTab2)
	lu.assertNil(views[""])
	assertClean(client)
end

-- Our own page's tab (the spellbook's companions'), chosen: a view of its own.
function TestLayoutAudit:test_a_page_tab_is_a_view()
	boot()
	local frame = window("AuditPages")
	local page = CreateFrame("Button", "AuditPagesTabMOUNT", frame)
	page.DiabolicPageTab = true
	frame:Show()
	slash("layout")
	client:Tick(1.5, 0.1)
	page:Disable()
	client:Tick(1.5, 0.1)
	local views = _G.DiabolicUI_Layout.windows.AuditPages.views
	lu.assertNotNil(views[""])
	lu.assertNotNil(views.AuditPagesTabMOUNT)
	assertClean(client)
end

-- Those views from before that are dropped once, for the next scan to see them.
function TestLayoutAudit:test_views_from_before_checked_tabs_are_dropped()
	local parts = function()
		return { Part = { "TOP", "X", "TOP", 0, 0, tabs = { Old = true }, last = { Old = 1 }, words = { Old = "a" } }, Older = "x" }
	end
	local old = function()
		return { parts = parts(), views = { Old = { stamp = 1 } } }
	end
	boot({ savedVariables = { DiabolicUI_Layout = { windows = {
		SpellBookFrame = old(), PlayerTalentFrame = old(), MailFrame = old(),
	} } } })
	local windows = _G.DiabolicUI_Layout.windows
	lu.assertNil(windows.SpellBookFrame.views)
	lu.assertNil(windows.PlayerTalentFrame.parts.Part.last)
	lu.assertEquals(windows.PlayerTalentFrame.parts.Older, "x")
	lu.assertNotNil(windows.MailFrame.views.Old)
	-- (not again: what the new scan saved stays)
	boot({ savedVariables = { DiabolicUI_Layout = { checkedTabs = true, pageTabs = true, windows = { SpellBookFrame = old() } } } })
	lu.assertNotNil(_G.DiabolicUI_Layout.windows.SpellBookFrame.views.Old)
	-- (the spellbook's once more, from before its pages' tabs counted)
	boot({ savedVariables = { DiabolicUI_Layout = { checkedTabs = true, windows = { SpellBookFrame = old(), PlayerTalentFrame = old() } } } })
	lu.assertNil(_G.DiabolicUI_Layout.windows.SpellBookFrame.views)
	lu.assertNotNil(_G.DiabolicUI_Layout.windows.PlayerTalentFrame.views.Old)
	assertClean(client)
end

-- An NPC's window: its tabs looked at in turn when it shows, once a scan, then
-- back on the first.
function TestLayoutAudit:test_an_npc_window_walks_its_tabs()
	boot()
	local frame = window("MailFrame")
	local clicks = {}
	local tabs = {}
	for i = 1, 3 do
		local tab = CreateFrame("Button", "MailFrameTab" .. i, frame)
		tab:SetScript("OnClick", function(self)
			clicks[#clicks + 1] = i
			for _, other in ipairs(tabs) do
				other:Enable()
			end
			self:Disable()
		end)
		tabs[i] = tab
	end
	tabs[1]:Disable()
	tabs[3]:Hide()
	slash("layout")
	frame:Show()
	client:Tick(5, 0.1)
	lu.assertEquals(clicks, { 2, 1 })
	local views = _G.DiabolicUI_Layout.windows.MailFrame.views
	lu.assertNotNil(views.MailFrameTab1)
	lu.assertNotNil(views.MailFrameTab2)
	-- opened again: left alone
	frame:Hide()
	client:Tick(1.5, 0.1)
	frame:Show()
	client:Tick(3, 0.1)
	lu.assertEquals(clicks, { 2, 1 })
	-- a new scan looks again, not in a fight
	slash("layout")
	client:EnterCombat()
	slash("layout")
	client:Tick(3, 0.1)
	lu.assertEquals(clicks, { 2, 1 })
	client:LeaveCombat()
	client:Tick(5, 0.1)
	lu.assertEquals(clicks, { 2, 1, 2, 1 })
	assertClean(client)
end

function TestLayoutAudit:test_it_talks_in_a_chat_window_named_layout()
	boot()
	local count = function(frame)
		return #(client.widgetState[frame].messages or {})
	end
	-- opened the first time, then the same one
	local general = count(_G.ChatFrame1)
	slash("layout left")
	lu.assertEquals((_G.GetChatWindowInfo(3)), "Layout")
	lu.assertEquals(count(_G.ChatFrame3), 1)
	slash("layout left")
	lu.assertEquals(count(_G.ChatFrame3), 2)
	lu.assertEquals(count(_G.ChatFrame1), general)
	lu.assertEquals((_G.GetChatWindowInfo(4)), "")
	-- closed by the player: a new one, its old name not it
	client.chatWindows[3] = { name = "Layout" }
	_G.ChatFrame3.isDocked = nil
	slash("layout left")
	lu.assertEquals(client.chatWindows[3].shown, 1)
	lu.assertEquals(count(_G.ChatFrame3), 3)
	-- all windows taken: none written over, the default one told
	for i = 1, 10 do
		client.chatWindows[i] = { name = "Mine", shown = 1 }
	end
	slash("layout left")
	lu.assertEquals((_G.GetChatWindowInfo(10)), "Mine")
	lu.assertEquals(count(_G.ChatFrame1), general + 1)
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
