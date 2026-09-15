-- Run from the addon root: lua5.1 tests/test_chat_commands.lua
--
-- Loads the *real* handlers/commands.lua under a minimal Engine/WoW mock and
-- exercises the "/diabolic", "/diabolicui" and "/dui" slash command plumbing
-- shared by every module that registers its own subcommand:
--  - ParseCommand: trims and collapses whitespace, then splits into
--    (command, ...args) when there's more than one token, or returns the
--    single token unchanged otherwise.
--  - PerformCommand: defaults an empty/nil command to "config" (so bare
--    "/dui" opens the options panel, same as "/dui config"), looks up the
--    command in the registry populated by Register, and calls it with the
--    remaining arguments - or does nothing for an unknown command.
--  - Register: first-write-wins, silently ignores a second registration of
--    the same command name.

package.path = "./tests/?.lua;" .. package.path

local lu = require("luaunit")
local EngineMock = require("mocks.engine_mock")

local Handler

local function loadCommandsHandler()
	-- string.split is a WoW-custom extension (delimiter, str) -> multiple
	-- values, not part of standard Lua 5.1 - commands.lua captures it as a
	-- local upvalue at file scope (`local string_split = string.split`), so
	-- it must be installed for real *before* loadfile, same gotcha as
	-- test_tooltip_positioning.lua's `cursor` table.
	_G.string.split = function(delimiter, str)
		local parts = {}
		for part in (str .. delimiter):gmatch("(.-)" .. delimiter) do
			table.insert(parts, part)
		end
		return unpack(parts)
	end

	_G.SlashCmdList = {}

	local Engine = EngineMock.new()
	local chunk = assert(loadfile("handlers/commands.lua"))
	chunk("DiabolicUI", Engine)
	return Engine:GetHandler("ChatCommand")
end

TestChatCommands = {}

function TestChatCommands:setUp()
	Handler = loadCommandsHandler()
end

-- ParseCommand
---------------------------------------------------------

function TestChatCommands:test_single_word_is_returned_unchanged()
	lu.assertEquals(Handler:ParseCommand("config"), "config")
end

function TestChatCommands:test_multiple_words_are_split_into_separate_values()
	lu.assertEquals({ Handler:ParseCommand("num_bars 2") }, { "num_bars", "2" })
end

function TestChatCommands:test_leading_trailing_and_repeated_whitespace_is_normalized()
	lu.assertEquals({ Handler:ParseCommand("  num_bars   2  ") }, { "num_bars", "2" })
end

function TestChatCommands:test_empty_string_is_returned_unchanged()
	lu.assertEquals(Handler:ParseCommand(""), "")
end

-- PerformCommand
---------------------------------------------------------

function TestChatCommands:test_calls_the_registered_command_with_its_arguments()
	local received
	Handler:Register("num_bars", function(...) received = { ... } end)

	Handler:PerformCommand("num_bars", "2")

	lu.assertEquals(received, { "2" })
end

function TestChatCommands:test_unknown_command_does_nothing()
	-- Must not error even though nothing is registered for this command.
	Handler:PerformCommand("does_not_exist")
end

function TestChatCommands:test_empty_or_nil_command_defaults_to_config()
	local calledConfig = false
	Handler:Register("config", function() calledConfig = true end)

	Handler:PerformCommand("")
	lu.assertTrue(calledConfig)

	calledConfig = false
	Handler:PerformCommand(nil)
	lu.assertTrue(calledConfig)
end

-- Register
---------------------------------------------------------

function TestChatCommands:test_register_first_write_wins()
	local firstCalled, secondCalled = false, false
	Handler:Register("autoposition", function() firstCalled = true end)
	Handler:Register("autoposition", function() secondCalled = true end) -- silently ignored

	Handler:PerformCommand("autoposition")

	lu.assertTrue(firstCalled)
	lu.assertFalse(secondCalled)
end

-- End-to-end: exactly what a bare "/dui" does via SlashCmdList
---------------------------------------------------------

function TestChatCommands:test_slash_handler_parses_and_dispatches_in_one_call()
	local received
	Handler:Register("num_side_bars", function(...) received = { ... } end)
	Handler:OnEnable()

	_G.SlashCmdList["DIABOLICUISLASHHANDLER"]("num_side_bars 1")

	lu.assertEquals(received, { "1" })
end

os.exit(lu.LuaUnit.run())
