-- Run from the addon root: lua5.1 tests/test_session_handlers.lua
--
-- The shared handlers in the fake client, through their own API, for what
-- the addon's screens don't reach on their own: popups with one to three
-- buttons, with or without a title or text, their buttons under the mouse,
-- several at once; status bars filling in all four directions, smoothing
-- and the spark's pulse; the orb's layer colors, textures, crops and spark;
-- the action buttons' flashing, usability, cooldowns, stacks, grid, pet
-- actions and tooltips; the unit frames' right-click menus and tooltips;
-- the engine's own chat commands.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local Client = require("mocks.client")
local Session = require("mocks.session")

local assertClean, tooltipLines = Session.assertClean, Session.tooltipLines

local client

local function boot(options)
	client = Client.boot(options)
	client:Tick(0.2)
end

local function shown(widget)
	return widget:IsShown() == 1
end

-- left, right, top, bottom of a texture's crop
local function crop(texture)
	local left, top, _, bottom, right = texture:GetTexCoord()
	return { left, right, top, bottom }
end

local function assertColor(actual, expected)
	for i = 1, #expected do
		lu.assertAlmostEquals(actual[i], expected[i], 1e-9)
	end
end

-- Popups -----------------------------------------------------------------------

TestPopups = {}

function TestPopups:setUp()
	boot()
	self.popups = client:GetHandler("PopUpMessage")
	self.style = client.Engine:GetDB("UI").popup
	-- a first login asks about setting up the chat: out of the way
	self:frame("ENGINE_AUTO_SETUP_CHAT"):Hide()
end

function TestPopups:tearDown()
	client = nil
end

-- The frame showing popup `id`, if it's up.
function TestPopups:frame(id)
	for _, child in ipairs({ client.Engine:GetFrame():GetChildren() }) do
		if child.id == id and child:IsShown() then
			return child
		end
	end
end

function TestPopups:show(id, info)
	self.popups:RegisterPopUp(id, info)
	self.popups:ShowPopUp(id, self.style)
	return self:frame(id)
end

function TestPopups:test_three_buttons_and_every_callback()
	local calls = {}
	local function record(name)
		return function(frame)
			calls[#calls + 1] = name
			lu.assertEquals(frame.id, "TEST_THREE")
		end
	end
	local frame = self:show("TEST_THREE", {
		title = "Three ways", text = "Pick one.",
		button1 = "Yes", button2 = "No", button3 = "Later",
		OnAccept = record("accept"), OnCancel = record("cancel"), OnAlt = record("alt"),
		OnShow = record("show"), OnHide = record("hide"),
	})
	lu.assertEquals(calls, { "show" })
	lu.assertEquals(frame.title:GetText(), "Three ways")
	lu.assertEquals(frame.message:GetText(), "Pick one.")
	lu.assertEquals(frame.button1:GetPoint(), "BOTTOMLEFT")
	lu.assertEquals(frame.button2:GetPoint(), "BOTTOMRIGHT")
	lu.assertEquals(frame.button3:GetPoint(), "BOTTOM")
	lu.assertEquals(frame.button3.text:GetText(), "Later")
	-- three buttons would be wider than the widest popup
	lu.assertEquals(frame:GetWidth(), self.style.maxwidth)

	client:Click(frame.button3)
	lu.assertEquals(calls, { "show", "alt", "hide" })
	lu.assertNil(self:frame("TEST_THREE"))

	self.popups:ShowPopUp("TEST_THREE", self.style)
	client:Click(self:frame("TEST_THREE").button1)
	self.popups:ShowPopUp("TEST_THREE", self.style)
	client:Click(self:frame("TEST_THREE").button2)
	lu.assertEquals(calls, { "show", "alt", "hide", "show", "accept", "hide", "show", "cancel", "hide" })
	assertClean(client)
end

function TestPopups:test_one_button_without_a_title_or_text()
	local frame = self:show("TEST_ONE", { button2 = "Okay" })
	lu.assertFalse(shown(frame.button1))
	lu.assertTrue(shown(frame.button2))
	lu.assertFalse(shown(frame.button3))
	lu.assertEquals(frame.button2:GetPoint(), "BOTTOM")
	lu.assertFalse(shown(frame.title))
	lu.assertFalse(shown(frame.message))
	lu.assertAlmostEquals(frame.header:GetHeight(), 0, 0.001)
	lu.assertEquals(frame:GetWidth(), self.style.minwidth)
	-- nothing registered for the button: it just closes
	client:Click(frame.button2)
	lu.assertNil(self:frame("TEST_ONE"))
	assertClean(client)
end

function TestPopups:test_two_buttons_in_any_pair()
	local footer, button = self.style.footer, self.style.footer.button
	local frame = self:show("TEST_ACCEPT_ALT", { text = "Two.", button1 = "Yes", button3 = "Later" })
	lu.assertEquals(frame.button1:GetPoint(), "BOTTOMLEFT")
	lu.assertEquals(frame.button3:GetPoint(), "BOTTOMRIGHT")
	lu.assertEquals(frame:GetWidth(), footer.insets[1] + button.insets[1] + button.size[1] * 2 + footer.button_spacing + button.insets[2] + footer.insets[2])
	client:Click(frame.button1)

	frame = self:show("TEST_CANCEL_ALT", { text = "Two.", button2 = "No", button3 = "Later" })
	lu.assertEquals(frame.button2:GetPoint(), "BOTTOMRIGHT")
	lu.assertEquals(frame.button3:GetPoint(), "BOTTOMLEFT")
	client:Click(frame.button3)
	lu.assertNil(self:frame("TEST_CANCEL_ALT"))
	assertClean(client)
end

function TestPopups:test_text_only_has_no_footer()
	local frame = self:show("TEST_NOTE", { title = "Note", text = "Just so you know." })
	lu.assertFalse(shown(frame.footer))
	local body = self.style.body
	lu.assertAlmostEquals(frame:GetHeight(), frame.header:GetHeight() + self.style.padding + frame.body:GetHeight(), 0.001)
	lu.assertAlmostEquals(frame.body:GetHeight(), body.insets[3] + body.insets[4] + frame.message:GetStringHeight(), 0.001)
	frame:Hide()
	assertClean(client)
end

function TestPopups:test_showing_it_again_updates_the_same_frame()
	local info = { title = "Again", text = "First", button1 = "Okay" }
	local frame = self:show("TEST_AGAIN", info)
	info.text = "Second"
	-- no style this time: the one it was shown with is kept
	self.popups:ShowPopUp("TEST_AGAIN")
	lu.assertIs(self:frame("TEST_AGAIN"), frame)
	lu.assertEquals(frame.message:GetText(), "Second")
	lu.assertEquals(frame:GetWidth(), self.style.minwidth)
	lu.assertIs(self.popups:GetPopUp("TEST_AGAIN"), info)
	assertClean(client)
end

function TestPopups:test_several_at_once_stack_and_frames_are_reused()
	local a = self:show("TEST_A", { text = "A", button1 = "Okay" })
	local b = self:show("TEST_B", { text = "B", button1 = "Okay" })
	lu.assertNotIs(a, b)
	local point, relativeTo, relativePoint = b:GetPoint()
	lu.assertEquals({ point, relativePoint }, { "TOP", "BOTTOM" })
	lu.assertIs(relativeTo, a)
	lu.assertIs(select(2, a:GetPoint()), client.Engine:GetFrame())

	a:Hide()
	lu.assertIs(select(2, b:GetPoint()), client.Engine:GetFrame())
	-- the free frame takes the next popup
	lu.assertIs(self:show("TEST_C", { text = "C", button1 = "Okay" }), a)
	assertClean(client)
end

function TestPopups:test_a_frame_reused_without_a_title_or_text_hides_them()
	local frame = self:show("TEST_FULL", { title = "Full", text = "Everything.", button1 = "Okay" })
	client:Click(frame.button1)
	lu.assertIs(self:show("TEST_BARE", { button1 = "Okay" }), frame)
	lu.assertFalse(shown(frame.title))
	lu.assertFalse(shown(frame.message))
	assertClean(client)
end

function TestPopups:test_the_buttons_light_up_and_press()
	local frame = self:show("TEST_LOOKS", { text = "Looks.", button1 = "Okay" })
	local button = frame.button1
	local colors = self.style.footer.button.fontColor
	local function look()
		return (shown(button.normal) and "normal") or (shown(button.pushed) and "pushed") or (shown(button.highlight) and "highlight")
	end
	local function textColor()
		return { button.text:GetTextColor() }
	end
	lu.assertEquals(look(), "normal")
	assertColor(textColor(), colors.normal)

	client:Hover(button)
	lu.assertEquals(look(), "highlight")
	assertColor(textColor(), colors.highlight)
	client:RunScript(button, "OnMouseDown", "LeftButton")
	lu.assertEquals(look(), "pushed")
	assertColor(textColor(), colors.pushed)
	lu.assertEquals(select(5, button.text:GetPoint()), -4)

	-- moved off while held down: lit, not pressed
	client:Leave()
	lu.assertEquals(look(), "highlight")
	lu.assertEquals(select(5, button.text:GetPoint()), 0)
	client:RunScript(button, "OnMouseUp", "LeftButton")
	lu.assertEquals(look(), "normal")

	-- held down when the popup closes: back to normal when it shows again
	client:Hover(button)
	client:RunScript(button, "OnMouseDown", "LeftButton")
	client:Leave()
	frame:Hide()
	self.popups:ShowPopUp("TEST_LOOKS", self.style)
	lu.assertEquals(look(), "normal")
	assertClean(client)
end

-- Status bars ------------------------------------------------------------------

TestStatusBars = {}

function TestStatusBars:setUp()
	boot()
	local bar = client:GetHandler("StatusBar"):New(_G.UIParent)
	bar:SetPoint("CENTER")
	bar:SetSize(200, 20)
	bar:SetMinMaxValues(0, 100)
	self.bar = bar
end

function TestStatusBars:tearDown()
	client = nil
end

function TestStatusBars:test_it_fills_in_every_direction()
	local bar = self.bar
	bar:DisableSmoothing(true)
	bar:SetValue(25)
	lu.assertEquals(crop(bar.bar), { 0, .25, 0, 1 })
	lu.assertAlmostEquals(bar.bar:GetWidth(), 50, 1e-9)
	lu.assertEquals(select(3, bar.spark:GetPoint()), "RIGHT")

	bar:SetOrientation("LEFT")
	bar:Update()
	lu.assertEquals(crop(bar.bar), { .75, 1, 0, 1 })
	lu.assertEquals(bar.bar:GetPoint(3), "RIGHT")
	lu.assertEquals(select(3, bar.spark:GetPoint()), "LEFT")

	bar:SetOrientation("UP")
	bar:Update()
	lu.assertEquals(crop(bar.bar), { 0, 1, .75, 1 })
	lu.assertAlmostEquals(bar.bar:GetHeight(), 5, 1e-9)
	lu.assertEquals(select(3, bar.spark:GetPoint()), "TOP")

	bar:SetOrientation("DOWN")
	bar:Update()
	lu.assertEquals(crop(bar.bar), { 0, 1, 0, .25 })
	lu.assertEquals(select(3, bar.spark:GetPoint()), "BOTTOM")
	assertClean(client)
end

function TestStatusBars:test_values_stay_in_range()
	local bar = self.bar
	bar:DisableSmoothing(true)
	bar:SetValue(150)
	lu.assertEquals(bar:GetValue(), 100)
	bar:SetValue(60)
	lu.assertTrue(shown(bar.spark))
	bar:SetValue(-5)
	lu.assertEquals(bar:GetValue(), 0)
	lu.assertFalse(shown(bar.bar))
	lu.assertFalse(shown(bar.spark))

	bar:SetValue(80)
	bar:SetMinMaxValues(0, 50)
	lu.assertEquals(bar:GetValue(), 50)
	bar:SetMinMaxValues(60, 100)
	lu.assertEquals(bar:GetValue(), 60)
	lu.assertEquals({ bar:GetMinMaxValues() }, { 60, 100 })
	lu.assertFalse(shown(bar.bar))
	bar:SetValue(90)
	bar:Clear()
	lu.assertEquals(bar:GetValue(), 60)
	assertClean(client)
end

function TestStatusBars:test_smoothing_moves_towards_the_value()
	local bar = self.bar
	-- from (next to) nothing it jumps straight there
	bar:SetValue(10)
	client:Tick(0.02)
	lu.assertEquals(bar._displayvalue, 10)

	bar:SetValue(80)
	client:Tick(0.02)
	lu.assertTrue(bar._displayvalue > 10 and bar._displayvalue < 80)
	client:Tick(1)
	lu.assertEquals(bar._displayvalue, 80)

	bar:SetValue(20)
	client:Tick(0.02)
	lu.assertTrue(bar._displayvalue > 20 and bar._displayvalue < 80)
	client:Tick(1)
	lu.assertEquals(bar._displayvalue, 20)

	-- sent off and straight back before a frame went by
	bar:SetValue(50)
	bar:SetValue(20)
	client:Tick(0.02)
	lu.assertEquals(bar._displayvalue, 20)
	lu.assertNil(bar.smoothing)

	-- frames closer together than 1/120s are skipped
	bar:SetValue(70)
	client:Tick(0.005, 0.005)
	lu.assertEquals(bar._displayvalue, 20)

	-- full: the updates stop once it's there
	bar:SetValue(100)
	client:Tick(1.5)
	lu.assertEquals(bar._displayvalue, 100)
	lu.assertNil(bar:GetScript("OnUpdate"))

	-- a smaller range pulls the shown value in too
	bar:SetMinMaxValues(0, 50)
	lu.assertEquals(bar._displayvalue, 50)
	assertClean(client)
end

function TestStatusBars:test_without_smoothing_updates_stop_when_full()
	local bar = self.bar
	bar:DisableSmoothing(true)
	bar:SetValue(100)
	lu.assertNotNil(bar:GetScript("OnUpdate"))
	client:Tick(0.1)
	lu.assertNil(bar:GetScript("OnUpdate"))
	assertClean(client)
end

function TestStatusBars:test_the_spark_pulses()
	local bar = self.bar
	bar:DisableSmoothing(true)
	bar:SetSparkFlash(0.1, 0.1, 0.2, 0.8)
	bar:SetValue(50)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.2, 1e-9)
	client:Tick(0.1)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.8, 1e-9)
	client:Tick(0.1)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.2, 1e-9)
	client:Tick(0.05)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.5, 1e-9)
	client:Tick(0.1)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.8, 1e-9)
	client:Tick(0.05)
	lu.assertAlmostEquals(bar.spark:GetAlpha(), 0.5, 1e-9)

	bar:SetSparkSize(4, 30)
	bar:Update()
	lu.assertEquals({ bar.spark:GetSize() }, { 4, 20 })
	assertClean(client)
end

function TestStatusBars:test_it_behaves_like_a_frame()
	local bar = self.bar
	local parent = _G.CreateFrame("Frame", nil, _G.UIParent)
	parent:SetPoint("CENTER")
	parent:SetSize(300, 30)

	bar:SetParent(parent)
	lu.assertIs(bar:GetParent(), parent)
	lu.assertIs(bar:CreateTexture():GetParent(), bar.scaffold)
	lu.assertIs(bar:CreateFontString():GetParent(), bar.scaffold)
	lu.assertIs(bar:CreateFrame():GetParent(), bar.scaffold)

	bar:ClearAllPoints()
	bar:SetAllPoints(parent)
	lu.assertIs(select(2, bar:GetPoint()), parent)
	lu.assertEquals({ bar:GetSize() }, { 300, 30 })
	lu.assertEquals(bar:GetWidth(), 300)
	lu.assertEquals(bar:GetHeight(), 30)
	bar:ClearAllPoints()
	bar:SetPoint("TOP")
	bar:SetWidth(120)
	bar:SetHeight(12)
	lu.assertEquals({ bar:GetSize() }, { 120, 12 })

	bar:SetFrameStrata("HIGH")
	lu.assertEquals(bar:GetFrameStrata(), "HIGH")
	bar:SetFrameLevel(7)
	lu.assertEquals(bar:GetFrameLevel(), 7)
	bar:SetAlpha(0.5)
	lu.assertEquals(bar:GetAlpha(), 0.5)
	bar:SetStatusBarColor(1, 0, 0)
	lu.assertEquals({ bar:GetStatusBarColor() }, { 1, 0, 0, 1 })
	bar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
	lu.assertEquals(bar.bar:GetTexture(), [[Interface\TargetingFrame\UI-StatusBar]])
	bar:SetSparkTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
	lu.assertEquals(bar.spark:GetTexture(), [[Interface\CastingBar\UI-CastingBar-Spark]])

	local onShow = function() end
	bar:SetScript("OnShow", onShow)
	lu.assertIs(bar:GetScript("OnShow"), onShow)
	bar:Hide()
	lu.assertFalse(shown(bar))
	bar:Show()
	lu.assertTrue(shown(bar))
	lu.assertEquals(bar:GetObjectType(), "StatusBar")
	lu.assertTrue(bar:IsObjectType("StatusBar"))
	lu.assertFalse(bar:IsObjectType("Frame"))
	assertClean(client)
end

function TestStatusBars:test_an_unplaced_bar_has_its_set_size()
	local bar = client:GetHandler("StatusBar"):New(_G.UIParent)
	bar:SetSize(80, 8)
	lu.assertEquals({ bar:GetSize() }, { 80, 8 })
	lu.assertEquals(bar:GetWidth(), 80)
	lu.assertEquals(bar:GetHeight(), 8)
	assertClean(client)
end

-- Orbs ---------------------------------------------------------------------------

TestOrbs = {}

function TestOrbs:setUp()
	boot()
	local orb = client:GetHandler("Orb"):New(_G.UIParent)
	orb:SetPoint("CENTER")
	orb:SetSize(100, 100)
	orb:SetMinMaxValues(0, 100)
	self.orb = orb
end

function TestOrbs:tearDown()
	client = nil
end

function TestOrbs:test_layer_colors()
	local orb = self.orb
	orb:SetStatusBarColor(.2, .3, .4)
	assertColor({ orb:GetStatusBarColor("bar") }, { .2, .3, .4, 1 })
	orb:SetStatusBarColor(.2, .3, .4, .6)
	assertColor({ orb:GetStatusBarColor("bar") }, { .2, .3, .4, .6 })
	assertColor({ orb.scaffold.bar:GetVertexColor() }, { .2, .3, .4, .6 })
	orb:SetStatusBarColor(.5, .5, .5, "moon")
	assertColor({ orb:GetStatusBarColor("moon") }, { .5, .5, .5, .5 })
	orb:SetStatusBarColor(.1, .2, .3, .7, "shade")
	assertColor({ orb:GetStatusBarColor("shade") }, { .1, .2, .3, .7 })

	-- the smoke is the main color, and the spark a bright shade of it
	-- (less green when blue leads)
	orb:SetStatusBarColor(0, 0, 1, "smoke")
	assertColor({ orb:GetStatusBarColor() }, { 0, 0, 1, .9 })
	assertColor({ orb.overlay.spark:GetVertexColor() }, { .375, .5625, 1 })
	assertColor({ orb.overlay.spark.glow:GetVertexColor() }, { .375, .5625, 1 })
	assertClean(client)
end

function TestOrbs:test_one_color_for_all_layers()
	local orb = self.orb
	orb:SetStatusBarColor(1, .5, 0, "ALL")
	assertColor({ orb:GetStatusBarColor("bar") }, { .25, .125, 0, 1 })
	assertColor({ orb:GetStatusBarColor("moon") }, { .5, .25, 0, .5 })
	assertColor({ orb:GetStatusBarColor("smoke") }, { 1, .5, 0, .9 })
	assertColor({ orb:GetStatusBarColor("shade") }, { .1, .05, 0, 1 })
	assertColor({ orb.scaffold.moon:GetVertexColor() }, { .5, .25, 0, .5 })
	-- less green when red leads
	assertColor({ orb.overlay.spark:GetVertexColor() }, { 1, .7, .75 })

	orb:SetStatusBarColor(1, 1, 1, .4, "ALL")
	assertColor({ orb:GetStatusBarColor("shade") }, { .1, .1, .1, .4 })
	assertClean(client)
end

function TestOrbs:test_layer_textures()
	local orb = self.orb
	local scaffold = orb.scaffold
	orb:SetStatusBarTexture("bar.tga")
	lu.assertEquals(scaffold.bar:GetTexture(), "bar.tga")
	orb:SetStatusBarTexture("moon.tga", "moon")
	lu.assertEquals(scaffold.moon:GetTexture(), "moon.tga")
	orb:SetStatusBarTexture("smoke.tga", "smoke")
	orb:SetStatusBarTexture("shade.tga", "shade")

	-- plain colors in place of a file
	orb:SetStatusBarTexture(1, 0, 0)
	lu.assertNil(scaffold.bar:GetTexture())
	orb:SetStatusBarTexture(1, 0, 0, "moon")
	lu.assertNil(scaffold.moon:GetTexture())
	orb:SetStatusBarTexture(1, 0, 0, .5, "smoke")
	lu.assertNil(scaffold.smoke:GetTexture())
	orb:SetStatusBarTexture("bar.tga")
	orb:SetStatusBarTexture(1, 0, 0, .5)
	lu.assertNil(scaffold.bar:GetTexture())
	lu.assertEquals(scaffold.shade:GetTexture(), "shade.tga")
	assertClean(client)
end

function TestOrbs:test_the_fluid_and_the_spark_on_its_surface()
	local orb = self.orb
	orb:DisableSmoothing(true)
	orb:SetSparkSize(10, 8)
	orb:SetValue(25)
	lu.assertTrue(shown(orb.scrollframe))
	lu.assertAlmostEquals(orb.scrollframe:GetHeight(), 25, 1e-9)
	lu.assertAlmostEquals(orb.scrollframe:GetVerticalScroll(), 75, 1e-9)
	-- the spark spans the circle at that height: 2 * sqrt(50^2 - 25^2)
	local spark = orb.overlay.spark
	lu.assertTrue(shown(spark))
	lu.assertAlmostEquals(spark:GetWidth(), 2 * math.sqrt(50 ^ 2 - 25 ^ 2), 1e-9)
	lu.assertEquals(crop(spark), { 0, 1, 0, 1 })
	lu.assertEquals({ spark:GetPoint() }, { "CENTER", orb.scrollframe, "TOP", 0, -1 })

	-- full or empty: no spark
	orb:SetValue(100)
	lu.assertFalse(shown(spark))
	orb:SetValue(0)
	lu.assertFalse(shown(orb.scrollframe))
	assertClean(client)
end

function TestOrbs:test_a_cropped_orb_crops_its_spark()
	local orb = self.orb
	orb:DisableSmoothing(true)
	orb:SetValue(50) -- the spark is as wide as the orb
	local spark = orb.overlay.spark
	orb:SetCrop(30, 0)
	lu.assertEquals(orb.scrollframe:GetWidth(), 70)
	lu.assertEquals(orb.scrollframe:GetHorizontalScroll(), 30)
	lu.assertEquals(crop(spark), { .3, 1, 0, 1 })
	lu.assertEquals({ spark:GetPoint() }, { "LEFT", orb.scrollframe, "TOPLEFT", 0, -1 })
	lu.assertAlmostEquals(spark:GetWidth(), 70, 1e-9)

	orb:SetCrop(0, 20)
	lu.assertEquals(crop(spark), { 0, .8, 0, 1 })
	lu.assertEquals({ spark:GetPoint() }, { "RIGHT", orb.scrollframe, "TOPRIGHT", 0, -1 })

	orb:SetWidth(120)
	lu.assertEquals(orb.scrollframe:GetWidth(), 100)
	orb:SetHeight(120)
	lu.assertEquals({ orb.scrollchild:GetSize() }, { 120, 120 })
	assertClean(client)
end

function TestOrbs:test_the_spark_pulses_with_its_glow()
	local orb = self.orb
	orb:DisableSmoothing(true)
	orb:SetSparkFlash(0.1, 0.1, 0.2, 0.8)
	orb:SetSparkFlashSize(20, 16)
	orb:SetSparkFlashTexture("glow.tga")
	orb:SetSparkTexture("spark.tga")
	orb:SetValue(50)
	local spark = orb.overlay.spark
	lu.assertEquals(spark.glow:GetTexture(), "glow.tga")
	lu.assertEquals(spark:GetTexture(), "spark.tga")
	client:Tick(0.1)
	lu.assertAlmostEquals(spark.glow:GetAlpha(), 0.8, 1e-9)
	lu.assertAlmostEquals(spark:GetAlpha(), 0.8, 1e-9)
	client:Tick(0.1)
	lu.assertAlmostEquals(spark.glow:GetAlpha(), 0.2, 1e-9)
	client:Tick(0.05)
	lu.assertAlmostEquals(spark.glow:GetAlpha(), 0.5, 1e-9)
	assertClean(client)
end

function TestOrbs:test_smoothing_moves_towards_the_value()
	local orb = self.orb
	orb:SetValue(10)
	client:Tick(0.02)
	lu.assertEquals(orb.displayValue, 10)

	orb:SetValue(80)
	client:Tick(0.02)
	lu.assertTrue(orb.displayValue > 10 and orb.displayValue < 80)
	client:Tick(1)
	lu.assertEquals(orb.displayValue, 80)

	orb:SetValue(20)
	client:Tick(0.02)
	lu.assertTrue(orb.displayValue > 20 and orb.displayValue < 80)
	client:Tick(1)
	lu.assertEquals(orb.displayValue, 20)

	orb:SetValue(50)
	orb:SetValue(20)
	client:Tick(0.02)
	lu.assertNil(orb.smoothing)

	orb:SetValue(70)
	client:Tick(0.005, 0.005)
	lu.assertEquals(orb.displayValue, 20)

	orb:SetValue(100)
	client:Tick(1.5)
	lu.assertEquals(orb.displayValue, 100)
	lu.assertNil(orb:GetScript("OnUpdate"))

	-- a smaller range pulls both values in, a larger one leaves them
	orb:SetMinMaxValues(0, 50)
	lu.assertEquals(orb:GetValue(), 50)
	orb:SetMinMaxValues(60, 200)
	lu.assertEquals(orb:GetValue(), 60)
	lu.assertEquals({ orb:GetMinMaxValues() }, { 60, 200 })
	orb:SetValue(500)
	lu.assertEquals(orb:GetValue(), 200)
	orb:SetValue(10)
	lu.assertEquals(orb:GetValue(), 60)
	orb:SetValue(100)
	orb:Clear()
	lu.assertEquals(orb.displayValue, 60)
	assertClean(client)
end

function TestOrbs:test_it_behaves_like_a_frame()
	local orb = self.orb
	local parent = _G.CreateFrame("Frame", nil, _G.UIParent)
	orb:SetParent(parent)
	lu.assertIs(orb:GetParent(), parent)
	-- made on the orb's own frame, above the scaffold
	lu.assertIs(orb:CreateTexture():GetParent(), orb)
	lu.assertIs(orb:CreateFontString():GetParent(), orb)
	lu.assertIs(orb:GetOverlay(), orb.overlay)
	orb:ClearAllPoints()
	orb:SetAllPoints(parent)
	lu.assertIs(select(2, orb:GetPoint()), parent)

	local onShow = function() end
	orb:SetScript("OnShow", onShow)
	lu.assertIs(orb:GetScript("OnShow"), onShow)
	orb:Hide()
	lu.assertFalse(shown(orb))
	orb:Show()
	lu.assertTrue(shown(orb))
	lu.assertEquals(orb:GetObjectType(), "Orb")
	lu.assertTrue(orb:IsObjectType("Orb"))
	lu.assertFalse(orb:IsObjectType("StatusBar"))
	assertClean(client)
end

-- Action buttons -----------------------------------------------------------------

TestActionButtons = {}

function TestActionButtons:setUp()
	boot()
	client:Tick(1) -- the range and flash checks start a second after logging in
	self.button = _G.EngineBar1Button1
	self.action = client.world.actions[1]
end

function TestActionButtons:tearDown()
	client = nil
end

function TestActionButtons:test_auto_attack_flashes_while_on()
	local button, action = self.button, self.action
	action.attack, action.current = true, true
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	lu.assertEquals(button.flashing, 1)
	local seen = {}
	for _ = 1, 4 do
		client:Tick(0.4)
		seen[shown(button.flash)] = true
	end
	lu.assertTrue(seen[true] and seen[false])

	action.current = false
	client:FireEvent("PLAYER_LEAVE_COMBAT")
	lu.assertEquals(button.flashing, 0)
	lu.assertFalse(shown(button.flash))
	action.current = true
	client:FireEvent("PLAYER_ENTER_COMBAT")
	lu.assertEquals(button.flashing, 1)
	assertClean(client)
end

function TestActionButtons:test_shooting_flashes_until_it_stops()
	local button, action = _G.EngineBar1Button2, client.world.actions[2]
	action.autoRepeat = true
	client:FireEvent("START_AUTOREPEAT_SPELL")
	lu.assertEquals(button.flashing, 1)
	action.autoRepeat = false
	client:FireEvent("STOP_AUTOREPEAT_SPELL")
	lu.assertEquals(button.flashing, 0)
	assertClean(client)
end

function TestActionButtons:test_usable_out_of_mana_unusable_out_of_range_and_dead()
	local button, action = self.button, self.action
	action.noMana = true
	client:FireEvent("ACTIONBAR_UPDATE_USABLE")
	lu.assertEquals(button.usableState, "mana")
	action.noMana, action.usable = false, false
	client:FireEvent("ACTIONBAR_UPDATE_STATE")
	lu.assertEquals(button.usableState, "unusable")
	action.usable = true
	client:FireEvent("COMPANION_UPDATE", "MOUNT")
	lu.assertEquals(button.usableState, "usable")

	action.inRange = 0
	client:Tick(0.25)
	lu.assertEquals(button.usableState, "range")
	action.inRange = 1
	client:Tick(0.25)
	lu.assertEquals(button.usableState, "usable")

	-- dead: grayed out, or darkened without shaders to gray it with
	client.world.units.player.dead = true
	client:FireEvent("UNIT_ENTERED_VEHICLE", "player")
	lu.assertEquals(button.usableState, "taxi")
	lu.assertEquals(button.icon:IsDesaturated(), 1)
	client.world.noShaders = true
	button:UpdateUsable("forced")
	lu.assertNil(button.icon:IsDesaturated())
	assertColor({ button.icon:GetVertexColor() }, { .3, .3, .3 })
	assertClean(client)
end

function TestActionButtons:test_cooldowns_and_stacks()
	local button, action = self.button, self.action
	action.cooldown = { client.world.time, 30, 1 }
	client:FireEvent("ACTIONBAR_UPDATE_COOLDOWN")
	lu.assertTrue(shown(button.cooldown))
	action.cooldown = { 0, 0, 1 }
	client:FireEvent("UPDATE_SHAPESHIFT_COOLDOWN")
	lu.assertFalse(shown(button.cooldown))

	action.consumable, action.count = true, 5
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 0)
	lu.assertEquals(tostring(button.stack:GetText()), "5")
	action.count = 12000
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	lu.assertEquals(button.stack:GetText(), "*")
	action.consumable = false
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	lu.assertEquals(button.stack:GetText(), "")
	assertClean(client)
end

function TestActionButtons:test_new_icons_and_bindings()
	local button, action = self.button, self.action
	action.texture = [[Interface\Icons\Spell_Nature_Thorns]]
	client:FireEvent("UPDATE_SHAPESHIFT_FORM")
	lu.assertEquals(button.icon:GetTexture(), action.texture)
	action.texture = [[Interface\Icons\Spell_Nature_Regeneration]]
	client:FireEvent("CURRENT_SPELL_CAST_CHANGED")
	lu.assertEquals(button.icon:GetTexture(), action.texture)

	-- emptied: no icon, a dimmed binding
	client.world.actions[1] = nil
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	lu.assertFalse(shown(button.icon))
	lu.assertFalse(shown(button.cooldown))

	client.world.bindings.ACTIONBUTTON1 = { "SHIFT-Q" }
	client:FireEvent("UPDATE_BINDINGS")
	lu.assertNotEquals(button.keybind:GetText(), "")
	assertClean(client)
end

function TestActionButtons:test_all_three_modifiers_show_the_empty_slots()
	local modifiers = client.world.modifiers
	local button = self.button
	lu.assertEquals(button.showgrid, 0)
	modifiers.shift, modifiers.ctrl, modifiers.alt = true, true, true
	client:FireEvent("MODIFIER_STATE_CHANGED", "LSHIFT", 1)
	lu.assertEquals(button.showgrid, 1)
	client:FireEvent("MODIFIER_STATE_CHANGED", "LALT", 1) -- still all down: once only
	lu.assertEquals(button.showgrid, 1)
	modifiers.alt = false
	client:FireEvent("MODIFIER_STATE_CHANGED", "LALT", 0)
	lu.assertEquals(button.showgrid, 0)
	client:FireEvent("MODIFIER_STATE_CHANGED", "LCTRL", 0)
	lu.assertEquals(button.showgrid, 0)
	assertClean(client)
end

function TestActionButtons:test_tooltips_follow_the_button()
	local button = self.button
	client.world.cvars.UberTooltips = "1"
	client:Hover(button)
	lu.assertEquals(_G.GameTooltip.default, 1) -- the default tooltip spot
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], "Spell 1")
	lu.assertNotNil(button.UpdateTooltip)
	self.action.name = "Spell One"
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	lu.assertEquals(tooltipLines(_G.GameTooltip)[1], "Spell One")
	client:Leave()

	client.world.cvars.UberTooltips = "0"
	client.world.actions[1] = nil
	client:FireEvent("ACTIONBAR_SLOT_CHANGED", 1)
	client:Hover(button)
	lu.assertEquals(_G.GameTooltip:GetOwner(), button)
	lu.assertNil(button.UpdateTooltip)
	client:Leave()
	assertClean(client)
end

function TestActionButtons:test_trade_skills_update_the_checked_look()
	local button = self.button
	button:SetChecked(1)
	client:FireEvent("TRADE_SKILL_SHOW")
	lu.assertTrue(button._checked)
	button:SetChecked(nil)
	client:FireEvent("TRADE_SKILL_CLOSE")
	lu.assertFalse(button._checked)
	assertClean(client)
end

function TestActionButtons:test_pet_actions()
	boot({ class = "HUNTER", world = function(world)
		_G.PET_ACTION_ATTACK = "Attack"
		_G.PET_ATTACK_TEXTURE = [[Interface\Icons\Ability_GhoulFrenzy]]
		world.units.pet = Client.newUnit({ name = "Wolf" })
		world.petActionsUsable = true
		world.petActions[1] = { name = "PET_ACTION_ATTACK", texture = "PET_ATTACK_TEXTURE", isToken = true, isActive = true }
		world.petActions[2] = { name = "Bite", subtext = "Rank 3", texture = [[Interface\Icons\Ability_Racial_Cannibalize]], autoCastAllowed = true, autoCastEnabled = true }
		world.petActions[3] = { name = "Growl", texture = [[Interface\Icons\Ability_Physical_Taunt]], autoCastAllowed = true }
	end })
	client:FireEvent("PET_BAR_UPDATE")
	local attack, bite, growl = _G.EnginePetBarButton1, _G.EnginePetBarButton2, _G.EnginePetBarButton3
	lu.assertEquals(attack.icon:GetTexture(), [[Interface\Icons\Ability_GhoulFrenzy]])
	lu.assertTrue(attack._checked) -- attacking right now
	lu.assertFalse(shown(attack.autocastable))
	lu.assertTrue(bite.autocast.autocasting)
	lu.assertFalse(shown(bite.autocastable))
	lu.assertFalse(growl.autocast.autocasting)
	lu.assertTrue(shown(growl.autocastable))

	client:Hover(bite)
	lu.assertEquals(tooltipLines(_G.GameTooltip), { "Bite", "Rank 3" })
	client:Hover(attack)
	lu.assertEquals(tooltipLines(_G.GameTooltip), { "Attack" })
	client:Leave()

	-- the pet forgets Bite
	client.world.petActions[2] = nil
	client:FireEvent("UNIT_PET", "player")
	lu.assertFalse(shown(bite.icon))
	lu.assertFalse(shown(bite.autocastable))
	lu.assertFalse(bite.autocast.autocasting)

	client.world.petActionsUsable = false
	client:FireEvent("PET_BAR_UPDATE_USABLE")
	lu.assertEquals(growl.usableState, "unusable")

	-- dragging a pet spell shows every slot, like the action bars do
	local showgrid = growl.showgrid
	client:FireEvent("PET_BAR_SHOWGRID")
	lu.assertEquals(growl.showgrid, showgrid + 1)
	client:FireEvent("PET_BAR_HIDEGRID")
	lu.assertEquals(growl.showgrid, showgrid)

	for _, event in ipairs({ "PET_STABLE_UPDATE", "PET_STABLE_SHOW", "PLAYER_CONTROL_LOST", "PLAYER_CONTROL_GAINED",
		"PET_BAR_UPDATE_COOLDOWN", "SPELLS_CHANGED", "PLAYER_FARSIGHT_FOCUS_CHANGED" }) do
		client:FireEvent(event)
	end
	client:FireEvent("UNIT_FLAGS", "pet")
	client:FireEvent("UNIT_AURA", "pet")
	lu.assertTrue(shown(growl.icon))
	assertClean(client)
end

-- Unit frames ----------------------------------------------------------------------

TestUnitFrames = {}

function TestUnitFrames:setUp()
	boot()
	self.module = client:GetModule("UnitFrames")
end

function TestUnitFrames:tearDown()
	client = nil
end

function TestUnitFrames:test_focus_entries_are_taken_out_of_the_menus()
	-- they taint when used from our frames
	lu.assertEquals(_G.UnitPopupMenus.TARGET, { "RAID_TARGET_ICON", "CANCEL" })
	lu.assertEquals(_G.UnitPopupMenus.FOCUS, { "RAID_TARGET_ICON", "CANCEL" })
	assertClean(client)
end

function TestUnitFrames:test_the_right_click_menu_of_each_kind_of_frame()
	local player = self.module:GetWidget("Unit: Player"):GetFrame()
	player:menu()
	lu.assertIs(client.openDropDown, _G.PlayerFrameDropDown)

	-- raid members get the raid menu
	client.world.units.raid1 = Client.newUnit()
	client:FireEvent("RAID_ROSTER_UPDATE")
	client.openDropDown = nil
	local raid = self.module:GetWidget("Unit: Raid"):GetFrame(1)
	raid:menu()
	lu.assertIs(client.openDropDown, _G.FriendsDropDown)
	lu.assertEquals(_G.FriendsDropDown.unit, raid.unit)

	-- none for the target of target, nor a frame between units
	client.openDropDown = nil
	self.module:GetWidget("Unit: ToT"):GetFrame():menu()
	raid.unit = nil
	raid:menu()
	lu.assertNil(client.openDropDown)
	assertClean(client)
end

function TestUnitFrames:test_your_own_title_in_your_tooltip()
	client.world.titles[1] = { name = "Champion of the Frozen Wastes ", playerTitle = 1 }
	client.world.currentTitle = 1
	local player = self.module:GetWidget("Unit: Player"):GetFrame()
	client:Hover(player)
	local lines = tooltipLines(_G.GameTooltip)
	lu.assertEquals(lines[#lines], "Champion of the Frozen Wastes ")
	client:Leave()
	lu.assertFalse(shown(_G.GameTooltip))
	assertClean(client)
end

function TestUnitFrames:test_an_event_registered_twice_runs_once()
	local frame = self.module:GetWidget("Unit: Player"):GetFrame()
	local runs = 0
	local count = function() runs = runs + 1 end
	frame:RegisterEvent("PLAYER_FLAGS_CHANGED", count)
	frame:RegisterEvent("PLAYER_FLAGS_CHANGED", count)
	client:FireEvent("PLAYER_FLAGS_CHANGED", "player")
	lu.assertEquals(runs, 1)
	assertClean(client)
end

-- The engine's chat commands -----------------------------------------------------

TestEngineCommands = {}

function TestEngineCommands:setUp()
	boot()
end

function TestEngineCommands:tearDown()
	client = nil
end

function TestEngineCommands:test_setscale_saves_and_scales_out_of_combat()
	local UICenter = client.Engine:GetFrame()
	local db = client.Engine:GetConfig("ScreenScaling")
	local base = UICenter:GetScale() / db.scale
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("setscale 1.25")
	lu.assertEquals(db.scale, 1.25)
	lu.assertAlmostEquals(UICenter:GetScale(), base * 1.25, 1e-9)

	_G.SlashCmdList.DIABOLICUISLASHHANDLER("setscale big") -- not a number: ignored
	lu.assertEquals(db.scale, 1.25)

	-- the frame everything hangs from is secure: it waits for combat to end
	client:EnterCombat()
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("setscale 0.8")
	lu.assertEquals(db.scale, 0.8)
	lu.assertAlmostEquals(UICenter:GetScale(), base * 1.25, 1e-9)
	client:LeaveCombat()
	lu.assertAlmostEquals(UICenter:GetScale(), base * 0.8, 1e-9)
	assertClean(client)
end

function TestEngineCommands:test_resetsetup_puts_the_chat_back()
	local db = client.Engine:GetConfig("ChatWindows")
	db.hasbeenqueried, db.autoposition = true, false
	_G.ChatFrame1:ClearAllPoints()
	_G.SlashCmdList.DIABOLICUISLASHHANDLER("resetsetup")
	lu.assertFalse(db.hasbeenqueried)
	lu.assertTrue(db.autoposition)
	lu.assertNotNil(_G.ChatFrame1:GetPoint())
	assertClean(client)
end

os.exit(lu.LuaUnit.run())
