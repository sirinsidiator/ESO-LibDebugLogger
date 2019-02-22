local LuaUnit = require('luaunit')
local lu = LuaUnit.LuaUnit

local function getAddonName()
	local name
	for line in io.lines(".project") do
		name = line:match("^\t<name>(.+)</name>")
		if(name) then
			return name
		end
	end
	print("Could not find addon name.")
	return nil
end

local function importAddonFiles()
	for line in io.lines("src/" .. getAddonName() .. ".txt") do
		if(not line:find("^%s*##") and line:find("\.lua")) then
			require(line:match("^%s*(.+)\.lua"))
		end
	end
end

local function mockGlobals()
	zo_strsplit = function(...)
		return unpack(LuaUnit.private.strsplit(...))
	end
	df = function(...)
		print(string.format(...))
	end
end

mockGlobals()
importAddonFiles()

require('LibDebugLoggerTest')

---- Control test output:
-- lu:setOutputType( "NIL" )
-- lu:setOutputType( "TAP" )
-- lu:setVerbosity( LuaUnit.VERBOSITY_LOW )
os.exit( lu:run() )
