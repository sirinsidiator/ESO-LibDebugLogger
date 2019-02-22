local LuaUnit = require('luaunit')
local assertEquals = LuaUnit.assertEquals
local assertTrue = LuaUnit.assertTrue

local lib = LibStub("LibDebugLogger")
TestLibDebugLogger = {}

function TestLibDebugLogger:CreateTestCases(prefix, testCases, testFunction)
	for i = 1, #testCases do
		local test = testCases[i]
		self[string.format("test%s%s%d", prefix, i < 10 and "0" or "", i)] = function()
			testFunction(test.input, test.output)
		end
	end
end

function TestLibDebugLogger:setUp()
	-- set up tests
end

function TestLibDebugLogger:testExample()
	-- TODO: add testCode
	assertTrue(false)
end

do -- create identical tests with different inputs
	local testCases = {
		{input = 1, output = 0},
	}

TestLibDebugLogger:CreateTestCases("Example2", testCases, function(input, expected)
	assertEquals(input, expected)
end)
end