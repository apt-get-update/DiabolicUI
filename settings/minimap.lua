local Addon, Engine = ...
local C = Engine:GetDB("Data: Colors")
local path = ([[Interface\AddOns\%s\media\]]):format(Addon)

-- WoW Client Constants
local ENGINE_BFA = Engine:IsBuild("8.0.1")
local ENGINE_LEGION_735 = Engine:IsBuild("7.3.5")
local ENGINE_LEGION_730 = Engine:IsBuild("7.3.0")
local ENGINE_LEGION_725 = Engine:IsBuild("7.2.5")
local ENGINE_LEGION_715 = Engine:IsBuild("7.1.5")
local ENGINE_WOD = Engine:IsBuild("WoD")
local ENGINE_MOP = Engine:IsBuild("MoP")
local ENGINE_CATA = Engine:IsBuild("Cata")

-- Just me trying out stuff
local targetSize = 260 -- 230 should be min, 290 max
local origSize = 290
local mapScale = targetSize/origSize
local mapSize = targetSize
local mapTexSize = 512 * (mapSize / origSize)
local mapOffset = math.floor((origSize - mapSize)/2)

-- Show Blizzard's Blip Textures
--local blips = UIParent:CreateTexture(nil, "ARTWORK")
--blips:SetSize(512,512)
--blips:SetTexture([[Interface\Minimap\ObjectIconsAtlas]])
--blips:SetPoint("CENTER")
--local blipBackdrop = UIParent:CreateTexture(nil, "BORDER")
--blipBackdrop:SetAllPoints(blips)
--blipBackdrop:SetColorTexture(.15,.15,.15,1)

Engine:NewStaticConfig("Minimap", {
	size = { mapSize, mapSize }, 
	point = { "TOPRIGHT", "UICenter", "TOPRIGHT", -(20 + mapOffset), -84 }, 
	map = {
		size = { mapSize, mapSize }, 
		point = { "CENTER", 0, 0 },
		mask = path..[[textures\DiabolicUI_MinimapCircularMaskSemiTransparent.tga]],
		blips = ENGINE_BFA and [[Interface\Minimap\ObjectIconsAtlas]] -- BfA 8.0.1  -- path..[[textures\Blip-Nandini-New-801.tga]] 
			or ENGINE_LEGION_735 and path..[[textures\Blip-Nandini-New-735.tga]] -- [[Interface\Minimap\ObjectIconsAtlas]] -- Legion 7.3.5  
			or ENGINE_LEGION_730 and path..[[textures\Blip-Nandini-New-730.tga]] -- Legion 7.3.0
			or ENGINE_LEGION_725 and path..[[textures\Blip-Nandini-New-725.tga]] -- Legion 7.2.5 
			or ENGINE_LEGION_715 and path..[[textures\Blip-Nandini-New-715.tga]] -- Legion 7.1.5 (WoW-Freakz)
			or ENGINE_WOD and path..[[textures\Blip-Nandini-New-622.tga]] -- late WoD
			or ENGINE_MOP and path..[[textures\Blip-Nandini-New-548.tga]] -- late MoP (Warmane)
			or (not ENGINE_CATA) and path..[[textures\Blip-Nandini-New-335.tga]] -- WotLK (Warmane)
			or [[Interface\Minimap\ObjectIcons]] -- Fallback. Default blizzard location. (ObjectIconsAtlas for Legion)
	},
	border = {
		size = { mapTexSize, mapTexSize },
		point = { "CENTER", 0, 0 },
		path = path..[[textures\DiabolicUI_Minimap_CircularBorder.tga]]
	},
	widgets = {
		buttonBag = {
			size = { 32, 32 },
			point = { "TOPRIGHT", mapOffset/2, mapOffset/2 },
			texture = path .. [[textures\DiabolicUI_Texture_32x32_WhitePlusRounded_Warcraft.tga]]
		},
		group = {
			size = { 54, 54 },
			point = { "BOTTOMLEFT", 10, -16 },

			border_size = { 128, 128 },
			border_point = { "CENTER", 0, 0 },
			border_texture = path .. [[textures\DiabolicUI_MinimapIcon_Circular.tga]],
			border_texcoord = { 0/64, 64/64, 0/64, 64/64 },

			icon_size = { 40, 40 },
			icon_point = { "CENTER", 0, 0 },
			icon_texture = path .. [[textures\DiabolicUI_40x40_MenuIconGrid.tga]],
			icon_texcoord = { 120/255, 159/255, 40/255, 79/255 },

		},
		mail = {
			size = { 40, 40 },
			point = { "BOTTOMRIGHT", -12, 10 }, 
			texture = path .. [[textures\DiabolicUI_40x40_MenuIconGrid.tga]],
			texture_size = { 256, 256 },
			texcoord = { 0/255, 39/255, 120/255, 159/255 }
		},
		worldmap = {
			size = { 40, 40 },
			point = { "TOPRIGHT", -12, -10 }, 
			texture = path .. [[textures\DiabolicUI_40x40_MenuIconGrid.tga]],
			texture_size = { 256, 256 },
			texcoord = { 200/255, 239/255, 0/255, 39/255 }
		}
	},
	text = {
		zone = {
			point = { "TOPRIGHT", "UICenter", "TOPRIGHT", -23.5, -(10.5 + 12) },
			normalFont = DiabolicFont_HeaderRegular16
		},
		time = {
			point = { "TOPRIGHT", "UICenter", "TOPRIGHT", -23.5, -(30.5 + 10) },
			normalFont = DiabolicFont_SansRegular14
		},
		coordinates = {
			point = { "BOTTOM", "Minimap", "BOTTOM", 0, 12.5 + 10 },
			normalFont = DiabolicFont_SansRegular12
		}
	}
})
