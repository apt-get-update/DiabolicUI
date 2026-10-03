-- Small helpers the test_session_*.lua files share, on top of the fake
-- client (mocks/client.lua).

local lu = require("luaunit")

local Session = {}

-- Fails the test with every Lua error and blocked action the client
-- recorded, if any.
function Session.assertClean(client, context)
	local problems = client:Problems()
	if problems ~= "" then
		lu.fail((context and (context .. ":\n") or "") .. problems)
	end
end

-- Adds an item to the fake item cache and returns its link.
-- fields: name, quality, iLevel, equipSlot, class, subclass, stats = { ITEM_MOD_... = n }, ...
function Session.item(client, id, fields)
	fields = fields or {}
	fields.name = fields.name or ("Item " .. id)
	client.world.itemInfo[id] = fields
	return select(2, client.api.GetItemInfo(id))
end

-- Text of every left line of a tooltip, in order.
function Session.tooltipLines(tooltip)
	local lines = {}
	local name = tooltip:GetName()
	for i = 1, tooltip:NumLines() do
		local left, right = _G[name .. "TextLeft" .. i], _G[name .. "TextRight" .. i]
		lines[i] = (left:GetText() or "") .. ((right:IsShown() and right:GetText()) and ("|" .. right:GetText()) or "")
	end
	return lines
end

function Session.stripColors(text)
	return ((text or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""))
end

return Session
