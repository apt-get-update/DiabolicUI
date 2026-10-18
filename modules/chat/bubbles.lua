-- Chat bubbles in DiabolicUI's style: Blizzard's bubbles (nameless
-- children of the WorldFrame) are emptied, and a bubble of ours with the
-- same text, in a bigger font on a dark backdrop, follows each of them.
local _, Engine = ...
local Module = Engine:NewModule("ChatBubbles")

-- Allow the user to use the stand-alone instead
Module:SetIncompatible("NiceBubbles")

-- Lua API
local _G = _G

local math_abs = math.abs
local math_floor = math.floor
local pairs = pairs
local select = select

-- WoW API
local CreateFrame = _G.CreateFrame
local SetCVar = _G.SetCVar
local WorldFrame = _G.WorldFrame

-- Bubble Data
local bubbles = {} -- local bubble registry
local numChildren, numBubbles = -1, 0 -- bubble counters

local fontsize = 14 -- bubble font size
local offsetX, offsetY = 0, -100 -- bubble offset from its original position

-- Textures
local BLANK_TEXTURE = [[Interface\ChatFrame\ChatFrameBackground]]
local BUBBLE_TEXTURE = [[Interface\Tooltips\ChatBubble-Background]]
local TOOLTIP_BORDER = [[Interface\Tooltips\UI-Tooltip-Border]]

local getPadding = function()
	return fontsize / 1.2
end

-- let the bubble size scale from 400 to 660ish (font size 22)
local getMaxWidth = function()
	return 400 + math_floor((fontsize - 14)/22 * 260)
end

local getBackdrop = function(scale)
	return {
		bgFile = BLANK_TEXTURE,
		edgeFile = TOOLTIP_BORDER,
		edgeSize = 16 * scale,
		insets = {
			left = 2.5 * scale,
			right = 2.5 * scale,
			top = 2.5 * scale,
			bottom = 2.5 * scale
		}
	}
end


------------------------------------------------------------------------------
-- 	Namebubble Detection & Update Cycle
------------------------------------------------------------------------------
-- this needs to run even when the UI is hidden
local Updater = Engine:CreateFrame("Frame", nil, WorldFrame)
Module.Updater = Updater -- (named in /dui cpu)
Updater:SetFrameStrata("TOOLTIP")

-- check whether the given frame is a bubble or not
Updater.IsBubble = function(self, bubble)
	local name = bubble.GetName and bubble:GetName()
	local region = bubble.GetRegions and bubble:GetRegions()
	if name or not region then
		return
	end
	local texture = region.GetTexture and region:GetTexture()
	return texture and texture == BUBBLE_TEXTURE
end

Updater.OnUpdate = function(self, elapsed)
	local children = WorldFrame:GetNumChildren()
	if numChildren ~= children then
		local frames = { WorldFrame:GetChildren() }
		for i = 1, children do
			local frame = frames[i]
			if not(bubbles[frame]) and self:IsBubble(frame) then
				self:InitBubble(frame)
			end
		end
		numChildren = children
	end

	-- bubble, bubble.text = original bubble and message
	-- bubbles[bubble], bubbles[bubble].text = our custom bubble and message
	local scale = WorldFrame:GetHeight()/UIParent:GetHeight()
	for bubble in pairs(bubbles) do
		local msg = bubble.text:GetText()
		if bubble:IsShown() and msg and (msg ~= "") then
			-- continuing the fight against overlaps blending into each other!
			bubbles[bubble]:SetFrameLevel(bubble:GetFrameLevel()) -- this works?

			local blizzTextWidth = math_floor(bubble.text:GetWidth())
			local blizzTextHeight = math_floor(bubble.text:GetHeight())
			local point, _, rpoint, blizzX, blizzY = bubble.text:GetPoint()
			local r, g, b = bubble.text:GetTextColor()
			if blizzTextWidth and blizzTextHeight and point and rpoint and blizzX and blizzY then
				if (not bubbles[bubble]:IsShown()) then
					bubbles[bubble]:Show()
				end
				if (bubbles[bubble].last ~= msg) then
					bubbles[bubble].text:SetText(msg)
					bubbles[bubble].text:SetTextColor(r, g, b)
					bubbles[bubble].last = msg
					local sWidth = bubbles[bubble].text:GetStringWidth()
					local maxWidth = getMaxWidth()
					if sWidth > maxWidth then
						bubbles[bubble].text:SetWidth(maxWidth)
					else
						bubbles[bubble].text:SetWidth(sWidth)
					end
				end
				local space = getPadding()
				local ourTextWidth = bubbles[bubble].text:GetWidth()
				local ourTextHeight = bubbles[bubble].text:GetHeight()
				local ourX = math_floor(offsetX + (blizzX - blizzTextWidth/2)/scale - (ourTextWidth-blizzTextWidth)/2) -- chatbubbles are rendered at BOTTOM, WorldFrame, BOTTOMLEFT, x, y
				local ourY = math_floor(offsetY + blizzY/scale - (ourTextHeight-blizzTextHeight)/2) -- get correct bottom coordinate
				local ourWidth = math_floor(ourTextWidth + space*2)
				local ourHeight = math_floor(ourTextHeight + space*2)
				-- only resize and move when it changed: this runs every frame
				if (ourWidth ~= bubbles[bubble].width) or (ourHeight ~= bubbles[bubble].height) then
					bubbles[bubble]:SetSize(ourWidth, ourHeight)
					bubbles[bubble].width, bubbles[bubble].height = ourWidth, ourHeight
				end
				local oldX, oldY = select(4, bubbles[bubble]:GetPoint())
				if not(oldX and oldY) or ((math_abs(oldX - ourX) > .5) or (math_abs(oldY - ourY) > .5)) then
					bubbles[bubble]:ClearAllPoints()
					bubbles[bubble]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", ourX, ourY)
				end
			end
			bubble.text:SetTextColor(r, g, b, 0)
		else
			if bubbles[bubble]:IsShown() then
				bubbles[bubble]:Hide()
			else
				bubbles[bubble].last = nil -- to avoid repeated messages not being shown
			end
		end
	end
end

Updater.InitBubble = function(self, bubble)
	numBubbles = numBubbles + 1

	local space = getPadding()
	bubbles[bubble] = CreateFrame("Frame", nil, self.BubbleBox)
	bubbles[bubble]:Hide()
	bubbles[bubble]:SetFrameStrata("BACKGROUND")
	bubbles[bubble]:SetFrameLevel(numBubbles%128 + 1) -- try to avoid overlapping bubbles blending into each other
	bubbles[bubble]:SetBackdrop(getBackdrop(1))
	bubbles[bubble]:SetBackdropColor(0, 0, 0, .5)
	bubbles[bubble]:SetBackdropBorderColor(0, 0, 0, .25)

	bubbles[bubble].text = bubbles[bubble]:CreateFontString()
	bubbles[bubble].text:SetPoint("BOTTOMLEFT", space, space)
	bubbles[bubble].text:SetFontObject(MailFont_Large)
	bubbles[bubble].text:SetFont(MailFont_Large:GetFont(), fontsize + 1, "")
	bubbles[bubble].text:SetShadowOffset(-.75, -.75)
	bubbles[bubble].text:SetShadowColor(0, 0, 0, 1)

	-- empty the blizzard bubble: no artwork, invisible text
	for i = 1, bubble:GetNumRegions() do
		local region = select(i, bubble:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		elseif region:GetObjectType() == "FontString" then
			bubble.text = region
		end
	end
	local r, g, b = bubble.text:GetTextColor()
	bubble.text:SetTextColor(r, g, b, 0)
end

Module.OnInit = function(self)
	-- this will be our bubble parent
	Updater.BubbleBox = Engine:CreateFrame("Frame", nil, "UIParent")
	Updater.BubbleBox:SetAllPoints()
end

Module.OnEnable = function(self)
	SetCVar("chatBubbles", 1)
	Updater:SetScript("OnUpdate", Updater.OnUpdate)
end
