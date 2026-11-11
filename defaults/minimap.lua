-- User settings for the minimap: its size and where it was moved (saved in
-- DiabolicUI_DB).
local _, Engine = ...

Engine:NewConfig("Minimap", {
	size = 1, -- of its 100%, within the static config's minSize and maxSize
	position = nil, -- { point = , x = , y = } once moved, relative to UIParent
})
