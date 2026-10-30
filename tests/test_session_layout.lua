-- Run from the addon root: lua5.1 tests/test_session_layout.lua
--
-- /dui layout (modules/blizzard/layout-audit.lua) in the fake client: a
-- window built to break each of the layout's rules, the problems said
-- once in the chat and saved by window, the check kept on after a reload,
-- the edges between screen pixels at a pixel-perfect scale, and
-- /dui layout all opening each window in turn.

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
	return client:GetModule("Blizzard: Layout Audit").Ticker:IsShown() and true or false
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

-- `frame`'s problems saved, as a set.
local function problems(name)
	local entry = _G.DiabolicUI_Layout.windows[name]
	local set = {}
	for _, problem in ipairs(entry and entry.problems or {}) do
		set[problem] = true
	end
	return set
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
		"AuditTop is 2 under the band (the rule: at least 6).",
		"2 of room over the content, 30 under it: uneven.",
		"30 of room left of the content, 50 right of it: uneven.", -- (its zones': not "Out")
		"AuditTop and AuditBeside are 2 apart (the rule: at least 6).",
		"AuditUnder and AuditOverlap overlap by 10.",
		"\"Name\" is off its list's panel.",
		"AuditTop and AuditAlmost are 2 off lining up (their bottoms).",
		"AuditDropDown isn't Diablo III's.",
		"\"Pale\" and 1 more are light on parchment: hard to read.",
	}) do
		lu.assertTrue(found[problem], problem .. "\n" .. table.concat(_G.DiabolicUI_Layout.windows.AuditFrame.problems, "\n"))
	end
	-- said once each, however often it's checked
	local count = #said()
	client:Tick(2)
	lu.assertEquals(#said(), count)
	lu.assertEquals(said()[2], "AuditFrame: \"Okay\" and \"A very long cancel\" are 1 off their row.")
	assertClean(client)
end

function TestLayoutAudit:test_a_window_keeping_them()
	boot()
	local frame = window("AuditFine")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	text(frame, "AuditInk", 40, -90, "In ink"):SetTextColor(0, 0, 0)
	frame:Show()
	slash("layout")
	lu.assertEquals(said()[2], "AuditFine: nothing breaks the rules.")
	lu.assertNotNil(_G.DiabolicUI_Layout.windows.AuditFine.checked)
	-- said once
	client:Tick(1.1)
	lu.assertEquals(#said(), 2)
	-- off again
	slash("layout")
	lu.assertEquals(said()[3], "Layout check off.")
	lu.assertFalse(checking())
	assertClean(client)
end

function TestLayoutAudit:test_off_after_a_reload_its_last_sessions_problems_replaced()
	boot({ savedVariables = { DiabolicUI_Layout = { on = true, windows = {
		AuditFine = { checked = "2026-10-27 20:00", problems = { "an old one" } },
		Elsewhere = { checked = "2026-10-27 20:00", problems = { "kept" } },
	} } } })
	-- (an older version's "on" forgotten: the check is on for a session only)
	lu.assertNil(_G.DiabolicUI_Layout.on)
	lu.assertFalse(checking())
	local frame = window("AuditFine")
	zone(frame, "AuditPage", 30, -80, 340, 150, "parchment")
	frame:Show()
	slash("layout")
	client:Tick(1.1)
	lu.assertNil(problems("AuditFine")["an old one"])
	lu.assertTrue(problems("Elsewhere").kept)
	-- the screen as it was checked
	lu.assertEquals(_G.DiabolicUI_Layout.resolution, "1920x1080")
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
	text(frame, "AuditPartsLabel", 40, -68, "Label"):SetTextColor(0, 0, 0)
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

function TestLayoutAudit:test_said_in_a_chat_window_of_its_own()
	boot()
	client.chatWindows = { [3] = { name = "Layout" } }
	slash("layout")
	lu.assertEquals(#said(), 0)
	lu.assertEquals(said(_G.ChatFrame3)[1], "Layout check on: each window is checked as it shows, its problems saved. /dui layout again to stop.")
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
		if line:find("^AuditBroken couldn't be checked: ") then
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
	-- each window in turn, page by page (one that breaks said), then closed
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
	local lines = said()
	lu.assertEquals(lines[#lines]:match("^Layout sweep done"), "Layout sweep done")
	lu.assertFalse(_G.CharacterFrame:IsShown() == 1)
	-- stopped by a fight (the check left on: not started again)
	slash("layout all")
	client:Tick(1, 0.1)
	client:EnterCombat()
	client:Tick(2, 0.1)
	lines = said()
	lu.assertEquals(lines[#lines]:match("^Layout sweep done"), "Layout sweep done")
	client:LeaveCombat()
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
