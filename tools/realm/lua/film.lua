-- The test realm's film wardrobe (tools/realm): what you wear, as others and
-- the camera see it, without the items themselves (any class's look).
-- Game masters only.
--   .angel       Tyrael's white and gold (Sanctified Lightsworn, no helm)
--   .angel off   your own items' look again
local LOOK = {
	[2] = 51279, -- shoulders
	[4] = 51275, -- chest
	[6] = 51278, -- legs
	[9] = 51276, -- hands
}
local VISIBLE = 283 -- PLAYER_VISIBLE_ITEM_1_ENTRYID (3.3.5a); a slot's 2 fields on

RegisterPlayerEvent(42, function(_, player, command) -- PLAYER_EVENT_ON_COMMAND
	local what = command:match("^angel%s*(%a*)$")
	if (not what) or not player or (player:GetGMRank() < 1) then
		return
	end
	for slot, entry in pairs(LOOK) do
		local own = player:GetEquippedItemBySlot(slot)
		local shown = (what == "off") and (own and own:GetEntry() or 0) or entry
		player:SetUInt32Value(VISIBLE + slot * 2, shown)
	end
	player:SendBroadcastMessage(what == "off" and "Your own look." or "The angel's look.")
	return false
end)
