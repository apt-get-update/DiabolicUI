local _, Engine = ...
local Module = Engine:GetModule("ActionBars")
local BarWidget = Module:SetWidget("Bar: Vehicle")

-- Lua API
local select = select
local setmetatable = setmetatable
local tinsert, tconcat, twipe = table.insert, table.concat, table.wipe

-- WoW API
local CreateFrame = CreateFrame
local GetNumShapeshiftForms = GetNumShapeshiftForms
local RegisterStateDriver = RegisterStateDriver
local UnitClass = UnitClass

local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local NUM_BUTTONS = VEHICLE_MAX_ACTIONBUTTONS or 6

BarWidget.OnEnable = function (self)
  local config = Module.config
  local db = Module.db

  local Artwork = Module:GetWidget("Artwork")
  local Bar = Module:GetHandler("ActionBar"):New("vehicle", Module:GetWidget("Controller: Main"):GetFrame(), Artwork:GetBarTemplate())

  --------------------------------------------------------------------
  -- Buttons
  --------------------------------------------------------------------

  -- Spawn the action buttons
  for i = 1, NUM_BUTTONS do
    -- Make sure the standard bars
    -- get button IDs that reflect their actual actions
    -- local button_id = (Bar.id - 1) * NUM_ACTIONBAR_BUTTONS + i

    local button = Bar:NewButton("action", i, Artwork:GetButtonTemplate())
    button:SetStateAction(0, "action", i)
    for state = 1, 14 do
      button:SetStateAction(state, "action", (state - 1) * NUM_ACTIONBAR_BUTTONS + i)
    end
    -- button:SetStateAction(0, "action", button_id)
    -- tinsert(Bar.buttons, button)
  end
  --------------------------------------------------------------------
  -- Page Driver
  --------------------------------------------------------------------

  -- This driver updates the bar state attribute to follow its current page,
  -- and also moves the vehicle, override, possess and temp shapeshift
  -- bars into the main bar as state/page changes.
  --
  -- After a state change the state-page childupdate is called
  -- on all the bar's children, which in turn updates button actions
  -- and initiate a texture update!
  Bar:SetAttribute("_onstate-page", [[
    self:SetAttribute("state", newstate);

    for i = 1, self:GetAttribute("num_buttons") do
      local Button = self:GetFrameRef("Button"..i);
      Button:SetAttribute("actionpage", tonumber(newstate));
    end

    control:CallMethod("UpdateAction");
  ]])

  -- reset the page before applying a new page driver
  Bar:SetAttribute("state-page", "0")

  -- Main actionbar paging based on class/stance
  -- also supports user changed paging
  local driver = {}
  local _, player_class = UnitClass("player")

  tinsert(driver, "[bonusbar:5]11")

  tinsert(driver, "11")
  local page_driver = tconcat(driver, "; ")

  -- enable the new page driver
  RegisterStateDriver(Bar, "page", page_driver)

  --------------------------------------------------------------------
  -- Visibility Drivers
  --------------------------------------------------------------------
  Bar:SetAttribute("_onstate-vis", [[
    if newstate == "hide" then
      self:Hide();
    elseif newstate == "show" then
      self:Show();
    end
  ]])

  twipe(driver)
  tinsert(driver, "[bonusbar:5]show")
  tinsert(driver, "[vehicleui]show")
  tinsert(driver, "hide")

  -- Register a proxy visibility driver
  local visibility_driver = tconcat(driver, "; ")
  RegisterStateDriver(Bar, "vis", visibility_driver)

  -- store bar settings
  local bar_config = config.structure.bars.vehicle
  Bar:SetAttribute("flyout_direction", bar_config.flyout_direction)
  Bar:SetAttribute("growth_x", bar_config.growthX)
  Bar:SetAttribute("growth_y", bar_config.growthY)
  Bar:SetAttribute("padding", bar_config.padding)
  Bar:SetAttribute("bar_width", bar_config.bar_size[1])
  Bar:SetAttribute("bar_height", bar_config.bar_size[2])
  Bar:SetAttribute("button_size", bar_config.buttonsize)

  -- The vehicle bar always has the same size,
  -- so a one time setup execution will do.
  -- Note: We could easily do this from Lua...
  Bar:Execute([[
    -- update bar size
    local bar_width = self:GetAttribute("bar_width");
    local bar_height = self:GetAttribute("bar_height");

    self:SetWidth(bar_width);
    self:SetHeight(bar_height);

    -- update button size
    local old_button_size = self:GetAttribute("old_button_size");
    local button_size = self:GetAttribute("button_size");
    local padding = self:GetAttribute("padding");

    if button_size ~= old_button_size then
      for i = 1, self:GetAttribute("num_buttons") do
        local Button = self:GetFrameRef("Button"..i);
        Button:SetWidth(button_size);
        Button:SetHeight(button_size);
        Button:ClearAllPoints();
        Button:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", (i-1)*(button_size + padding), 0);
      end
      self:SetAttribute("old_button_size", button_size); -- need to set this for the artwork updates
    end
  ]])

  Bar:SetPoint("BOTTOM")
  Bar:PostUpdate()

  self.Bar = Bar
end
BarWidget.GetFrame = function (self)
  return self.Bar
end
