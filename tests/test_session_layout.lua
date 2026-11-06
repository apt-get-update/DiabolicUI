-- Run from the addon root: lua5.1 tests/test_session_layout.lua
--
-- /dui layout (modules/blizzard/layout-scan.lua) in the fake client: what it
-- saves, the editor's rules (tools/rules.js) on it for a window built to break
-- each of them, parts placed by settings/positions.lua (adjust.lua), and
-- /dui layout all opening each window in turn.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")
local Rules = require("mocks.rules")

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

-- What the chat frame (ChatFrame1 unless given) was told, without our prefix.
local function said(frame)
	local lines = {}
	for _, message in ipairs(client.widgetState[frame or _G.DEFAULT_CHAT_FRAME].messages) do
		lines[#lines + 1] = (message.text:gsub("^|cffff8000DiabolicUI|r ", ""))
	end
	return lines
end

-- `name`'s problems, as a set: the rules run on what's saved.
local function problems(name)
	if (not Rules.available) then
		lu.skip("needs node")
	end
	return Rules.Problems(name)
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

function TestLayoutAudit:test_a_window_breaking_the_rules()
	boot()
	local frame, win, header = window("AuditFrame")
	-- the band: a dropdown not Diablo III's, a text over it
	local dropdown = CreateFrame("Frame", "AuditDropDown", frame, "UIDropDownMenuTemplate")
	dropdown:SetSize(120, 32)
	dropdown:SetPoint("LEFT", header, "LEFT", 40, 0)
	local over = frame:CreateFontString("AuditBandText")
	over:SetText("Over the dropdown")
	over:SetPoint("LEFT", header, "LEFT", 60, 0)
	-- buttons on a row 2 apart and 1 off it, one's text wider than it; one
	-- out of the window
	button(frame, "AuditOkay", 30, 30, 60, "Okay")
	button(frame, "AuditCancel", 92, 31, 60, "A very long cancel")
	button(frame, "AuditOut", 380, 100, 60, "Out")
	-- zones: one 2 under the band, two 2 apart, two over each other, two
	-- almost lined up
	zone(frame, "AuditTop", 30, -66, 100, 50, "parchment")
	zone(frame, "AuditBeside", 132, -66, 100, 50)
	zone(frame, "AuditUnder", 30, -118, 100, 50)
	zone(frame, "AuditOverlap", 120, -150, 100, 50)
	zone(frame, "AuditAlmost", 250, -68, 100, 50)
	-- a list's column name over the painting, off its zone
	local sort = CreateFrame("Button", "AuditNameSort", frame)
	sort:SetText("Name")
	sort:SetSize(80, 19)
	sort:SetPoint("TOPLEFT", frame, "TOPLEFT", 250, -230)
	-- light text on the parchment: its color, or a color in it
	text(frame, "AuditLight", 40, -80, "Pale"):SetTextColor(1, 1, 1)
	text(frame, "AuditCoded", 40, -95, "|cffffffffWhite|r"):SetTextColor(0, 0, 0)
	kit:AddFooter(win, "AuditOkay")

	slash("layout")
	lu.assertTrue(checking())
	-- (nothing shown: nothing checked)
	lu.assertNil(_G.DiabolicUI_Layout.windows.AuditFrame)
	frame:Show()
	client:Tick(1.1)
	local found = problems("AuditFrame")
	for _, problem in ipairs({
		"\"Okay\" and \"A very long cancel\" are 1 off their row.",
		"\"Okay\" and \"A very long cancel\" are 2 apart on their row (the rule: 6).",
		"\"A very long cancel\"'s text is wider than it.",
		"AuditDropDown and \"Over the dropdown\" overlap in the band.",
		"\"Out\" is out of the window.",
		"AuditBeside is 2 under the band (the rule: at least 6).",
		"2 of room over the content, 30 under it: uneven.",
		"30 of room left of the content, 50 right of it: uneven.", -- (its zones': not "Out")
		"AuditBeside and AuditTop are 2 apart (the rule: at least 6).",
		"AuditOverlap and AuditUnder overlap by 10.",
		"\"Name\" is off its list's panel.",
		"AuditAlmost and AuditTop are 2 off lining up (their bottoms).",
		"AuditDropDown isn't Diablo III's.",
		"AuditCoded and 1 more are light on parchment: hard to read.",
	}) do
		lu.assertTrue(found[problem], problem)
	end
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
	lu.assertEquals(next(problems("AuditFine")), nil)
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
	-- our own art (for the editor to draw it): the textures from our media
	-- or white, our backdrops (its border), in the order they're drawn
	local art, lines, backdrops = _G.DiabolicUI_Layout.windows.AuditFine.views[""].art, {}, {}
	for _, item in ipairs(art) do
		lu.assertNil(item.order)
		lu.assertNotEquals(item.owner, "AuditGlow")
		local file = item.file or item.backdrop.edgeFile or item.backdrop.bgFile
		lu.assertTrue((file:find("[Dd]iabolic[Uu][Ii]") ~= nil) or (file == [[Interface\Buttons\WHITE8X8]]), file)
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
	zone(frame, "AuditPageOne", 30, -80, 340, 150, "parchment")
	first:Disable()
	frame:Show()
	slash("layout")
	local seen = _G.DiabolicUI_Layout.windows.AuditTabbed
	lu.assertEquals(seen.views.AuditTabbedTab1.label, "First")
	lu.assertNotNil(seen.views.AuditTabbedTab1.art)
	lu.assertEquals(seen.views.AuditTabbedTab1.rect, { frame:GetLeft(), frame:GetBottom(), 400, 300 })
	lu.assertEquals(seen.parts.AuditPageOne.tabs, { AuditTabbedTab1 = true })
	-- the other tab (no text: by its name), a part in both, one only there
	first:Enable()
	second:Disable()
	_G.AuditPageOne:Hide()
	zone(frame, "AuditPageTwo", 30, -80, 340, 150, "parchment")
	client:Tick(1.1)
	lu.assertEquals(seen.views.AuditTabbedTab2.label, "AuditTabbedTab2")
	lu.assertEquals(seen.parts.AuditPageOne.tabs, { AuditTabbedTab1 = true })
	lu.assertEquals(seen.parts.AuditPageTwo.tabs, { AuditTabbedTab2 = true })
	lu.assertEquals(seen.parts.AuditTabbedDiabolic.tabs, { AuditTabbedTab1 = true, AuditTabbedTab2 = true })
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
	-- the screen as it was, the rules' numbers
	lu.assertEquals(_G.DiabolicUI_Layout.resolution, "1920x1080")
	lu.assertEquals(_G.DiabolicUI_Layout.rules, { button_gap = 6, content_gap = 6, uneven = 8 })
	assertClean(client)
end

function TestLayoutAudit:test_what_is_left_out_and_what_counts()
	boot()
	local frame, win, header = window("AuditParts")
	-- the band: a dropdown with its own text (in it, not over it), the
	-- band's own text, a text right-justified
	local dropdown = CreateFrame("Frame", "AuditPartsDropDown", frame, "UIDropDownMenuTemplate")
	dropdown:SetSize(120, 32)
	dropdown:SetPoint("LEFT", header, "LEFT", 40, 0)
	dropdown.DiabolicDropDown = true
	local inside = _G.AuditPartsDropDownText
	inside:SetText("All")
	inside:SetPoint("LEFT", dropdown, "LEFT", 20, 0)
	local own = header:CreateFontString("AuditPartsBandText")
	own:SetText("Band")
	own:SetPoint("RIGHT", header, "RIGHT", -60, 0)
	local right = frame:CreateFontString("AuditPartsRight")
	right:SetText("Right")
	right:SetJustifyH("RIGHT")
	right:SetWidth(100)
	right:SetPoint("LEFT", header, "LEFT", 140, 0)
	-- a slate panel with a parchment in it (only the parchment's edges
	-- count), a label between the band and them
	local panel = zone(frame, "AuditPanel", 30, -80, 340, 150)
	local page = zone(frame, "AuditPartsPage", 40, -90, 300, 130, "parchment")
	local label = text(frame, "AuditPartsLabel", 40, -68, "Label")
	label:SetTextColor(0, 0, 0)
	label:SetJustifyH("LEFT")
	-- a part counted in the sides though not content (a slot column's)
	local edge = CreateFrame("Frame", "AuditPartsEdge", frame)
	edge:SetSize(20, 20)
	edge:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, -200)
	edge.DiabolicEdge = true
	-- on the page: a lit row (white on it is fine), an icon's count (on its
	-- art), a button's text (ours)
	local row = frame:CreateTexture()
	row:SetPoint("TOPLEFT", frame, "TOPLEFT", 40, -100)
	row:SetSize(300, 16)
	kit:LightRow(row)
	text(frame, "AuditPartsChosen", 45, -101, "Chosen"):SetTextColor(1, 1, 1)
	local icon = CreateFrame("Frame", "AuditPartsIcon", frame)
	icon:SetSize(30, 30)
	icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 50, -130)
	local art = icon:CreateTexture()
	art:SetTexture([[Interface\Icons\INV_Misc_QuestionMark]])
	art:SetAllPoints()
	local lit = icon:CreateTexture(nil, "HIGHLIGHT")
	lit:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	lit:SetAllPoints()
	local count = icon:CreateFontString("AuditPartsCount")
	count:SetText("20")
	count:SetTextColor(1, 1, 1)
	count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", -2, 2)
	local face = button(frame, "AuditPartsButton", 100, 120, 80, "Go")
	face:GetFontString():SetTextColor(1, 1, 1)
	face:GetFontString():SetPoint("CENTER", face, "CENTER", 0, 0)
	-- a scroll bar by the page, its arrows in it
	local bar = CreateFrame("Slider", "AuditPartsBar", frame)
	bar:SetSize(16, 100)
	bar:SetPoint("TOPLEFT", page, "TOPRIGHT", 4, 0)
	local arrow = CreateFrame("Button", nil, bar)
	arrow:SetSize(16, 16)
	arrow:SetPoint("BOTTOM", bar, "TOP")
	-- hung from the window: a banner tab, a scroll frame's text, a
	-- tooltip's, a popup beside it
	local banner = CreateFrame("Button", "AuditPartsTab", frame)
	banner:SetSize(60, 80)
	banner:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 20, 0)
	banner.DiabolicBanner = {}
	banner:SetText("Tab")
	local scroll = CreateFrame("ScrollFrame", nil, frame)
	scroll:SetSize(100, 20)
	scroll:SetPoint("TOPLEFT", frame, "TOPRIGHT", -50, -250)
	text(scroll, nil, 0, 0, "A long line past the scroll frame's side")
	local tip = CreateFrame("Frame", nil, frame)
	tip:SetFrameStrata("TOOLTIP")
	tip:SetSize(100, 20)
	tip:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 0)
	text(tip, nil, 0, 0, "A tooltip's")
	local popup = CreateFrame("Frame", nil, frame)
	popup:SetSize(100, 100)
	popup:SetPoint("TOPLEFT", frame, "TOPRIGHT", 10, -50)
	text(popup, nil, 5, -5, "A popup's")
	-- a zone named after what it's on: none of three
	local a, b, c = CreateFrame("Frame", nil, frame), CreateFrame("Frame", nil, frame), CreateFrame("Frame", nil, frame)
	c:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	b:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	a:SetPoint("TOPLEFT", b, "TOPLEFT", 30, -235)
	a:SetSize(150, 20)
	kit:AddZone(a, "slate", { 0, 0, 0, 0 })
	-- (and one on a frame placed on the screen itself)
	local free = CreateFrame("Frame", nil, frame)
	free:SetSize(100, 20)
	free:SetPoint("TOPLEFT", frame, "TOPLEFT", 200, -233)
	free.GetPoint = function() return "TOPLEFT", nil, "TOPLEFT", 300, -333 end
	kit:AddZone(free, "slate", { 0, 0, 0, 0 })
	frame:Show()
	slash("layout")
	local found = problems("AuditParts")
	-- none of these said
	for problem in pairs(found) do
		lu.assertNil(problem:find("overlap in the band"), problem)
		lu.assertNil(problem:find("out of the window"), problem)
		lu.assertNil(problem:find("light on parchment"), problem)
		lu.assertNil(problem:find("AuditPanel and"), problem)
	end
	-- the room over the content from the label's bottom, not the band's;
	-- the scroll bar on the content's right
	lu.assertTrue(found["AuditPanel is 0 under \"Label\" (the rule: at least 6)."])
	assertClean(client)
end

function TestLayoutAudit:test_the_foot_and_one_light_text()
	boot()
	local frame, win = window("AuditFoot")
	-- a page down to 2 over the foot's rail
	zone(frame, "AuditPage", 30, -80, 340, 158, "parchment")
	button(frame, "AuditOkay", 30, 20, 60, "Okay")
	kit:AddFooter(win, "AuditOkay")
	text(frame, "AuditLight", 40, -90, "Pale"):SetTextColor(1, 1, 1)
	frame:Show()
	slash("layout")
	local found = problems("AuditFoot")
	lu.assertTrue(found["\"Pale\" is light on parchment: hard to read."])
	lu.assertTrue(found["AuditPage is 2 over the foot (the rule: at least 6)."])
	assertClean(client)
end

function TestLayoutAudit:test_a_part_between_the_page_and_the_foot()
	boot()
	local frame, win = window("AuditBetween")
	-- the page's foot 100 over the window's, a text 4 under it (the
	-- letter's money, its attachments), the foot's rail lower
	zone(frame, "AuditPage", 30, -80, 340, 120, "parchment")
	text(frame, "AuditMoney", 40, -204, "12g")
	button(frame, "AuditOkay", 30, 20, 60, "Okay")
	kit:AddFooter(win, "AuditOkay")
	frame:Show()
	slash("layout")
	-- the room under the page measured to the text, not the rail
	lu.assertTrue(problems("AuditBetween")["AuditPage is 4 over the foot (the rule: at least 6)."])
	assertClean(client)
end

function TestLayoutAudit:test_edges_between_screen_pixels_at_a_pixel_perfect_scale()
	-- 1024x768: one UI unit a screen pixel
	boot({ world = function(world) world.resolution = 2 end })
	local frame, win = window("AuditPixels")
	zone(frame, "AuditPage", 30.5, -80, 340, 150, "parchment")
	button(frame, "AuditOkay", 30, 20, 60, "Okay")
	kit:AddFooter(win, "AuditOkay")
	frame:Show()
	slash("layout")
	-- (the foot and its button among them)
	lu.assertTrue(problems("AuditPixels")["1 of 6 parts are between screen pixels (AuditPage by 0.5): blurry edges."])
	lu.assertEquals(_G.DiabolicUI_Layout.unit, "1.000")
	assertClean(client)
	-- the window itself
	boot({ world = function(world) world.resolution = 2 end })
	frame = window("AuditPixels")
	frame:SetPoint("TOPLEFT", _G.UIParent, "TOPLEFT", 100.5, -100)
	frame:Show()
	slash("layout")
	local found
	for problem in pairs(problems("AuditPixels")) do
		found = found or problem:find("(the window by 0.5)", 1, true)
	end
	lu.assertNotNil(found)
	assertClean(client)
	-- no resolution known: not checked
	boot({ world = function(world) world.resolution = 0 end })
	frame = window("AuditPixels")
	zone(frame, "AuditPage", 30.5, -80, 340, 150, "parchment")
	frame:Show()
	slash("layout")
	lu.assertFalse(_G.DiabolicUI_Layout.resolution)
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

function TestLayoutAudit:test_a_check_that_breaks_said_once()
	boot()
	local frame, win = window("AuditBroken")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	win.DiabolicHeaders = nil -- (no list of bands: the checks reading it break)
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
	slash("layout all")
	lu.assertTrue(checking())
	client:Tick(60, 0.1)
	lu.assertEquals(opened, { 1, 2, 4, 5 })
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

os.exit(lu.LuaUnit.run())
