-- User settings for the unit frames (saved per profile in DiabolicUI_DB).
local ADDON, Engine = ...

Engine:NewConfig("UnitFrames", {
	showClassColors = true, -- color unit frame health bars by class
	testPartyMode = false, -- preview a mock party with fake members
	testRaidMode = false, -- preview a mock raid with fake members
	showPortrait = false, -- show an animated 3D model portrait on party and focus frames
	player = {
	},
	target = {
	}
})
