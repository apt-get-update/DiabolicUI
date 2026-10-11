local _, Engine = ...

-- chat windows and frames
Engine:NewConfig("ChatWindows", {
	autoposition = true, -- whether or not to autoposition the default chat frame
	hasbeenqueried = false, -- whether the user has been asked about the previous
	fadeChat = true, -- whether chat text fades out after being visible for a while
	timeFading = 3, -- seconds it takes for chat text to fade out, 1-5
	timeVisible = 20, -- seconds chat text stays fully visible before it starts fading, 5-120
	backgroundOpacity = 25, -- opacity (%) of the chat window background while typing, 0-100.
	slideMessages = true, -- new chat lines slide in instead of jumping (modules/chat/slide.lua)

	-- the user's own manually dragged/resized main chat window layout,
	-- applied instead of the styled default position/size while
	-- autoposition is off. nil until the user actually moves or resizes it.
	positionX = nil,
	positionY = nil,
	width = nil,
	height = nil
})

-- chat filters and emoticons
Engine:NewConfig("ChatFilters", {
	copyWebLinks = true, -- left-click a web link in chat to copy it

	-- shorter system lines (modules/chat/cleaner.lua)
	cleanLoot = true, -- loot, money, quest rewards: "+ [Item] (3)"
	cleanProgress = true, -- experience, reputation, honor, skills, level ups
	cleanQuests = true, -- quests accepted and completed
	cleanStatus = true, -- away, busy, rested
	cleanOnline = true, -- friends and guild members coming online / going offline
	cleanAuctions = true, -- auctions created, sold, won, outbid, expired
	cleanAchievements = true, -- "Name: [Achievement]"
	hideChatNoise = true -- channel join/leave/change notices, empty lines
})

