-- Every named part of the windows /dui layout saw (Blizzard's, and the
-- addons' styled), where it was: { point, the frame it's placed on, that
-- frame's point, x, y, width, height } (x right, y up; a text keeps its own
-- size). To move one: remove its "--", change its numbers, /reload. Without
-- a width and height it keeps its size. A line without "--" keeps its part
-- there for good, whatever else moves it (modules/blizzard/adjust.lua).
-- Written by tools/positions.lua (docs: Common Tasks): it keeps the lines
-- without "--" and adds what /dui adjust moved in game.
local _, Engine = ...

Engine:NewStaticConfig("Positions", {
})
