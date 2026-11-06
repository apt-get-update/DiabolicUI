-- The sample window the editor's Components shows: every control, in its states,
-- built by the game's own styling (modules/blizzard/windows.lua) in the tests' fake
-- client, with the changes not saved yet. So what's drawn can't differ from what
-- the styling does, and nothing here says how a control looks.
--
--   lua5.1 tools/sample.lua [edits.lua]    (from the addon's folder; JSON on stdout)
--
-- { rect, art (as tools/layout.json's), texts, controls (what's clicked: the
-- component it's styled by, where), problems }
package.path = "./tests/?.lua;" .. package.path

local Shared = dofile((arg[0]:match("^(.*)/[^/]*$") or ".") .. "/shared.lua")
local Client = require("mocks.client")

local changes = (arg[1] and assert(loadfile(arg[1]))() or {})["@components"] or {}
local components = {}
local pipe = io.popen("ls windows/components/*.qml")
for path in pipe:lines() do
	local component = Shared.ReadComponent(path)
	if changes[component.name] then
		Shared.ChangeComponent(component, changes[component.name])
	end
	components[#components + 1] = component
end
pipe:close()
local generated = assert(loadstring(Shared.ComponentsLua(components), "settings/components.lua"))

local fonts = {}
pipe = io.popen("find media -type f -iname '*.ttf'")
for path in pipe:lines() do
	fonts[path:lower()] = path
end
pipe:close()

-- as in game, settings read as the modules start: then the changes are theirs
local client = Client.boot({ login = false })
generated("DiabolicUI", client.Engine)
client:Login()
client:ClearProblems()

local kit = client:GetModule("Blizzard: Windows")
local scan = client:GetModule("Blizzard: Layout Scan")
local CreateFrame, UIParent = _G.CreateFrame, _G.UIParent
local WIDTH, HEIGHT = 720, 516

local frame = CreateFrame("Frame", "Sample", UIParent)
frame:SetSize(WIDTH, HEIGHT)
frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 200, -100)

local controls = {}
local Mark = function(component, part)
	controls[#controls + 1] = { component = component, part = part }
	return part
end

local At = function(part, x, y, width, height)
	part:SetPoint("TOPLEFT", frame, "TOPLEFT", x, -y)
	if width then
		part:SetSize(width, height)
	end
	return part
end

local Button = function(name, x, y, width, text)
	local button = CreateFrame("Button", name, frame, "UIPanelButtonTemplate")
	At(button, x, y, width, 22)
	button:SetText(text)
	kit:StyleButton(button, 22)
	return Mark("Button", button)
end

-- each in its own protected call: a value that makes one fail leaves the others
local Build = {}

local window, header
Build[#Build + 1] = function()
	window = kit:CreateWindow(frame, { 0, 0, 0, 0 })
	Mark("Window", window)
	header = kit:CreateHeader(window, 40, { 24, 24 })
	local title = frame:CreateFontString("SampleTitle")
	title:SetText("Sample window")
	kit:SetTitle(header, title)
	kit:AddTitleGem(header).icon:SetTexture([[Interface\Icons\INV_Misc_QuestionMark]])
end

Build[#Build + 1] = function()
	local close = CreateFrame("Button", "SampleCloseButton", frame)
	close:SetSize(32, 32)
	kit:StyleClose(close, window, header)
	Mark("CloseButton", close)
end

-- the tabs that hang: one chosen
Build[#Build + 1] = function()
	local tabs = {}
	for i = 1, 4 do
		local tab = CreateFrame("Button", "SampleBanner" .. i, frame)
		tab:SetSize(60, 24)
		tab:SetText("Banner " .. i)
		tabs[i] = tab
		Mark("Banner", tab)
	end
	tabs[2]:Disable()
	kit:HangTabs(window, tabs, { nil, nil, nil, [[Interface\Icons\Spell_Fire_FlameBolt]] })
	tabs[3]:LockHighlight() -- (under the mouse)
	kit:DropTop(window)
end

-- in the band: a dropdown, an edit box, a checkbox
Build[#Build + 1] = function()
	local drop = CreateFrame("Frame", "SampleBandDropDown", frame, "UIDropDownMenuTemplate")
	drop:SetWidth(170)
	_G.SampleBandDropDownText:SetText("In the band")
	kit:StyleDropDown(drop)
	Mark("DropDown", drop)
	local box = CreateFrame("EditBox", "SampleBandBox", frame, "InputBoxTemplate")
	box:SetSize(120, 20)
	kit:StyleEditBox(box)
	kit:AddHint(box, "Search")
	Mark("EditBox", box)
	local label = frame:CreateFontString("SampleBandLabel")
	label:SetText("Label")
	kit:StyleBandText(label)
	kit:LineBand(header, { label, drop, box })
	_G.SampleBandDropDownButton.SamplePressed = true
	-- from its right end: a button read as a label
	local all = CreateFrame("Button", "SampleBandAll", frame)
	all:SetSize(50, 20)
	all:SetText("All")
	kit:StyleLabelButton(all)
	kit:LineBand(header, { all }, true)
end

-- a section over a panel: a list, its row chosen, its + and -, its scroll bar
local LEFT, TOP = 34, 124
Build[#Build + 1] = function()
	local section = At(CreateFrame("Frame", "SampleSection", frame), LEFT, TOP, 310, window and kit.config.section.height)
	local title = section:CreateFontString("SampleSectionTitle")
	title:SetText("Section")
	kit:StyleSection(section, title)
	Mark("Section", section)
end

Build[#Build + 1] = function()
	local list = At(CreateFrame("Frame", "SampleList", frame), LEFT, TOP + 30, 288, 132)
	local panel = kit:AddPanel(list, { 0, 0, 0, 0 }, list)
	Mark("Panel", panel)
	for i, row in ipairs({ "Expanded", "A row", "The row chosen", "A row", "Collapsed" }) do
		local y = 6 + (i - 1) * 24
		local words = list:CreateFontString(nil, "OVERLAY")
		words:SetFontObject("DiabolicFont_Narrow14")
		words:SetText(row)
		words:SetPoint("TOPLEFT", list, "TOPLEFT", 30, -y - 3)
		if (i == 1) or (i == 5) then
			local expander = CreateFrame("Button", "SampleExpander" .. i, list)
			expander:SetSize(18, 18)
			expander:SetPoint("TOPLEFT", list, "TOPLEFT", 8, -y - 1)
			expander:SetNormalTexture((i == 1) and [[Interface\Buttons\UI-MinusButton-Up]] or [[Interface\Buttons\UI-PlusButton-Up]])
			kit:StyleExpanders(expander)
			Mark("ListRow", expander)
		elseif (i == 3) then
			local chosen = list:CreateTexture(nil, "ARTWORK")
			chosen:SetPoint("TOPLEFT", list, "TOPLEFT", 4, -y)
			chosen:SetPoint("BOTTOMRIGHT", list, "TOPRIGHT", -4, -y - 22)
			kit:LightRow(chosen)
			Mark("ListRow", chosen)
		end
	end
	local bar = CreateFrame("Slider", "SampleScrollBar", frame)
	At(bar, LEFT + 292, TOP + 46, 16, 100)
	bar:SetFrameLevel(frame:GetFrameLevel() + 5) -- (its track a level under it, over the stone)
	local up = CreateFrame("Button", "SampleScrollBarScrollUpButton", bar)
	up:SetPoint("BOTTOM", bar, "TOP")
	local down = CreateFrame("Button", "SampleScrollBarScrollDownButton", bar)
	down:SetPoint("TOP", bar, "BOTTOM")
	bar:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]])
	bar:GetThumbTexture():SetPoint("TOP", bar, "TOP", 0, -20)
	kit:StyleScrollBar(bar)
	Mark("ScrollBar", bar)
	Mark("ScrollBar", up)
	Mark("ScrollBar", down)
end

-- a table's column names, one as under the mouse
Build[#Build + 1] = function()
	local zone = kit:AddZone(At(CreateFrame("Frame", "SampleTable", frame), LEFT, TOP + 208, 310, 60), "slate", { 0, 0, 0, 0 })
	kit:AddHeaderBar(zone)
	local names = { "Name", "Level", "Zone" }
	for i, name in ipairs(names) do
		local column = CreateFrame("Button", "SampleColumn" .. i, frame)
		At(column, LEFT + 4 + (i - 1) * 100, TOP + 186, 102, 22)
		column:SetHighlightTexture([[Interface\Buttons\WHITE8X8]])
		column:SetText(name)
		column:SetNormalFontObject("DiabolicFont_Narrow14")
		Mark("Columns", column)
	end
	kit:StyleColumnHeaders("SampleColumn", #names)
	-- (the mouse's highlight, which a scan leaves out, drawn)
	_G.SampleColumn2:GetHighlightTexture():SetDrawLayer("BACKGROUND")
end

-- the buttons: as they are, under the mouse, disabled
local RIGHT = 372
Build[#Build + 1] = function()
	Button("SampleButton", RIGHT, TOP, 96, "Button")
	Button("SampleButtonLit", RIGHT + 102, TOP, 96, "Lit"):LockHighlight()
	Button("SampleButtonOff", RIGHT + 204, TOP, 96, "Disabled"):Disable()
end

Build[#Build + 1] = function()
	local bordered = CreateFrame("Button", "SampleBordered", frame)
	At(bordered, RIGHT, TOP + 36, 44, 44)
	bordered:SetNormalTexture([[Interface\Icons\INV_Misc_QuestionMark]])
	kit:AddBorder(bordered, 44)
	Mark("Button", bordered)
end

-- the page buttons
Build[#Build + 1] = function()
	local back = At(CreateFrame("Button", "SamplePagerBack", frame), RIGHT + 60, TOP + 45)
	local on = At(CreateFrame("Button", "SamplePagerOn", frame), RIGHT + 92, TOP + 45)
	kit:StylePager(back, on)
	Mark("Pager", back)
	Mark("Pager", on)
end

-- the tabs in a row: one chosen
Build[#Build + 1] = function()
	for i, name in ipairs({ "Tab", "Chosen", "Tab" }) do
		local tab = CreateFrame("Button", "SampleTab" .. i, frame)
		At(tab, RIGHT + (i - 1) * 100, TOP + 92, 96, 32)
		tab:SetText(name)
		if (i == 2) then
			tab:Disable()
		end
		kit:StyleTab(tab, {})
		Mark("Tab", tab)
	end
end

Build[#Build + 1] = function()
	local drop = CreateFrame("Frame", "SampleDropDown", frame, "UIDropDownMenuTemplate")
	At(drop, RIGHT - 16, TOP + 136, 172, 32)
	_G.SampleDropDownText:SetText("A dropdown")
	kit:StyleDropDown(drop)
	Mark("DropDown", drop)
	_G.SampleDropDownButton.SampleLit = true
end

Build[#Build + 1] = function()
	local box = CreateFrame("EditBox", "SampleEditBox", frame, "InputBoxTemplate")
	At(box, RIGHT + 8, TOP + 178, 124, 20)
	kit:StyleEditBox(box)
	box:SetText("An edit box")
	Mark("EditBox", box)
	local hinted = CreateFrame("EditBox", "SampleHinted", frame, "InputBoxTemplate")
	At(hinted, RIGHT + 160, TOP + 178, 124, 20)
	kit:StyleEditBox(hinted)
	kit:AddHint(hinted, "Its hint")
	Mark("EditBox", hinted)
end

-- the checkboxes: empty, checked, as two in a band
Build[#Build + 1] = function()
	local Box = function(name, x, y, text, checked, look)
		local box = CreateFrame("CheckButton", name, frame, "OptionsCheckButtonTemplate")
		At(box, x, y)
		_G[name .. "Text"]:SetText(text)
		kit:StyleCheckBox(box, look)
		box:SetChecked(checked)
		Mark("CheckBox", box)
	end
	Box("SampleCheck", RIGHT, TOP + 212, "Empty", false)
	Box("SampleChecked", RIGHT + 100, TOP + 212, "Checked", true)
	Box("SampleStacked", RIGHT + 200, TOP + 212, "In a band", true, kit.config.check_box.stacked)
end

Build[#Build + 1] = function()
	local bar = CreateFrame("StatusBar", "SampleBar", frame)
	At(bar, RIGHT + 8, TOP + 248, 280, 18)
	bar:SetMinMaxValues(0, 100)
	bar:SetValue(60)
	kit:StyleBar(bar)
	Mark("Bar", bar)
	-- (its fill, which the fake client keeps apart from its regions, as one)
	local fill = bar:CreateTexture(nil, "ARTWORK")
	fill:SetTexture(bar:GetStatusBarTexture():GetTexture())
	fill:SetVertexColor(bar:GetStatusBarColor())
	fill:SetTexCoord(0, .6, 0, 1)
	fill:SetPoint("TOPLEFT", bar, "TOPLEFT")
	fill:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT")
	fill:SetWidth(bar:GetWidth() * .6)
end

-- what the controls above show only under the mouse, pressed or disabled:
-- arrows pressed, arrows disabled, the X lit and pressed, a checkbox lit and pressed
Build[#Build + 1] = function()
	local Pager = function(name, x, y)
		local back = At(CreateFrame("Button", name .. "Back", frame), x, y)
		local on = At(CreateFrame("Button", name .. "On", frame), x + 28, y)
		kit:StylePager(back, on)
		Mark("Pager", back)
		Mark("Pager", on)
		return back, on
	end
	local y = TOP + 280
	local back, on = Pager("SamplePressed", RIGHT, y)
	back.SamplePressed, on.SamplePressed = true, true
	back, on = Pager("SampleOff", RIGHT + 62, y)
	back:Disable()
	on:Disable()
	for i, state in ipairs({ "SampleLit", "SamplePressed" }) do
		local close = CreateFrame("Button", "SampleClose" .. i, frame)
		At(close, RIGHT + 96 + i * 30, y + 2, 22, 22)
		kit:SkinClose(close)
		close[state] = true
		Mark("CloseButton", close)
		local box = CreateFrame("CheckButton", "SampleCheck" .. i, frame, "OptionsCheckButtonTemplate")
		At(box, RIGHT + 180 + i * 30, y + 3)
		kit:StyleCheckBox(box)
		box[state] = true
		Mark("CheckBox", box)
	end
end

-- the foot, up to its buttons, set apart as a window's are
Build[#Build + 1] = function()
	for i, name in ipairs({ "Another", "In the foot" }) do
		local button = CreateFrame("Button", "SampleFootButton" .. i, frame, "UIPanelButtonTemplate")
		button:SetNormalTexture([[Interface\Buttons\UI-Panel-Button-Up]])
		button:SetSize(120, 22)
		button:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -28 - (2 - i) * 120, 30)
		button:SetText(name)
		Mark("Button", button)
	end
	kit:StyleButtons(frame)
	kit:AddFooter(window, true)
end

local problems = {}
for _, build in ipairs(Build) do
	local ok, problem = pcall(build)
	if (not ok) then
		problems[#problems + 1] = tostring(problem)
	end
end
frame:Show()
client:Tick(.05)
if (client:Problems() ~= "") then
	problems[#problems + 1] = client:Problems()
end

-- what the client shows of a button by its state, the fake one showing it all
local Show = function(texture, shown)
	if texture then
		if shown then
			texture:Show()
		else
			texture:Hide()
		end
	end
end

local States
States = function(from)
	if from:IsObjectType("Button") then
		local enabled = from:IsEnabled() == 1
		local disabled = from:GetDisabledTexture()
		local pressed = from.SamplePressed and from:GetPushedTexture()
		Show(from:GetNormalTexture(), (not pressed) and (enabled or (not disabled)))
		Show(from:GetPushedTexture(), pressed)
		Show(disabled, not enabled)
		if from.SampleLit and from:GetHighlightTexture() then
			from:GetHighlightTexture():SetDrawLayer("OVERLAY") -- (a scan leaves out what's only under the mouse)
		end
		if from:IsObjectType("CheckButton") then
			local checked = from:GetChecked()
			Show(from:GetCheckedTexture(), checked and enabled)
			Show(from:GetDisabledCheckedTexture(), checked and (not enabled))
		end
	end
	for i = 1, select("#", from:GetChildren()) do
		States((select(i, from:GetChildren())))
	end
end
States(frame)

-- the art of a plain color, which a scan leaves out (it has no file): as white, dyed
local Colors
Colors = function(from)
	for i = 1, select("#", from:GetRegions()) do
		local region = select(i, from:GetRegions())
		local color = region:IsObjectType("Texture") and client.widgetState[region].color
		if color then
			region:SetTexture([[Interface\Buttons\WHITE8X8]])
			-- (in its state: a chosen row's keeps its color white, and it's only drawn)
			client.widgetState[region].vertexColor = { color[1], color[2], color[3], color[4] or 1 }
		end
	end
	for i = 1, select("#", from:GetChildren()) do
		Colors((select(i, from:GetChildren())))
	end
end
Colors(frame)

-- the texts, which a scan leaves to the windows' parts
local Rect = function(part)
	local left, bottom, width, height = part:GetRect()
	return left and { left, bottom, width, height }
end

local texts = {}
local Add = function(region, text)
	if (not text) or (text == "") or (not region:GetLeft()) then
		return
	end
	local file, size, flags = region:GetFont()
	local object = region:GetFontObject()
	-- (its font's color, if none set on it)
	local color = client.widgetState[region].textColor or (object and { object:GetTextColor() }) or { 1, 1, 1 }
	local path = file:gsub("\\", "/"):lower()
	-- (held by one point its width is its text's: from that point; the fake
	-- client only guesses that width)
	local point = (region:GetNumPoints() == 1) and region:GetPoint(1) or region:GetJustifyH()
	texts[#texts + 1] = { text = text, rect = Rect(region), size = size, outline = (flags or ""):find("OUTLINE") and true or nil,
		font = fonts[path:match("(media/.*)$") or ""] or ("game/" .. path), color = color, alpha = region:GetAlpha(),
		align = (point:find("LEFT") and "left") or (point:find("RIGHT") and "right") or "center" }
end

local Texts
Texts = function(from)
	for i = 1, select("#", from:GetRegions()) do
		local region = select(i, from:GetRegions())
		if region:IsObjectType("FontString") and region:IsVisible() then
			Add(region, region:GetText())
		end
	end
	if from:IsObjectType("EditBox") then
		Add(from, from:GetText())
	elseif from:IsObjectType("Button") and from:GetFontString() and from:GetFontString():IsVisible() then
		local text = from:GetFontString()
		-- (in its button's middle in its font: the client's own doing)
		if (not text:GetLeft()) then
			text:SetPoint("CENTER", from, "CENTER")
		end
		if (not text:GetFontObject()) and from:GetNormalFontObject() then
			text:SetFontObject(from:GetNormalFontObject())
		end
		Add(text, text:GetText())
	end
	for i = 1, select("#", from:GetChildren()) do
		local child = select(i, from:GetChildren())
		if child:IsVisible() then
			Texts(child)
		end
	end
end
Texts(frame)

local art = Shared.Pictures(scan.ArtOf(frame)) or {}

-- what it all covers, for the editor to fit
local left, bottom, right, top = math.huge, math.huge, -math.huge, -math.huge
for _, list in ipairs({ art, texts }) do
	for _, item in ipairs(list) do
		local r = item.rect
		left, bottom = math.min(left, r[1]), math.min(bottom, r[2])
		right, top = math.max(right, r[1] + r[3]), math.max(top, r[2] + r[4])
	end
end

local out = {}
for _, control in ipairs(controls) do
	local rect = Rect(control.part)
	if rect then
		out[#out + 1] = { component = control.component, rect = rect }
	end
end

io.write(Shared.Encode({ rect = { left, bottom, right - left, top - bottom }, art = art, texts = texts, controls = out, problems = problems }), "\n")
