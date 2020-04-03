local lib = LibDebugLogger
local internal = lib.internal
local callback = lib.callback
local Logger = internal.class.Logger

--- Returns the current LibDebugLogger API version. It will be incremented in case there are any breaking changes.
--- You can check this before accessing any functions to gracefully handle future incompatibilities.
lib.GetAPIVersion = function() return 2 end

lib.DEFAULT_SETTINGS = internal.defaultSettings
lib.TAG_INGAME = internal.TAG_INGAME

lib.LOG_LEVEL_DEBUG = internal.LOG_LEVEL_DEBUG
lib.LOG_LEVEL_INFO = internal.LOG_LEVEL_INFO
lib.LOG_LEVEL_WARNING = internal.LOG_LEVEL_WARNING
lib.LOG_LEVEL_ERROR = internal.LOG_LEVEL_ERROR
lib.LOG_LEVELS = internal.LOG_LEVELS
lib.LOG_LEVEL_TO_STRING = internal.LOG_LEVEL_TO_STRING
lib.STR_TO_LOG_LEVEL = internal.STR_TO_LOG_LEVEL

lib.ENTRY_TIME_INDEX = internal.ENTRY_TIME_INDEX
lib.ENTRY_FORMATTED_TIME_INDEX = internal.ENTRY_FORMATTED_TIME_INDEX
lib.ENTRY_OCCURENCES_INDEX = internal.ENTRY_OCCURENCES_INDEX
lib.ENTRY_LEVEL_INDEX = internal.ENTRY_LEVEL_INDEX
lib.ENTRY_TAG_INDEX = internal.ENTRY_TAG_INDEX
lib.ENTRY_MESSAGE_INDEX = internal.ENTRY_MESSAGE_INDEX
lib.ENTRY_STACK_INDEX = internal.ENTRY_STACK_INDEX

--- The time when the client was started in milliseconds.
lib.SESSION_START_TIME = internal.SESSION_START_TIME

--- The approximate time when the UI was loaded in milliseconds.
--- We don't actually know the exact time for the UI load, so instead we just use the time when LibDebugLogger.lua was loaded.
--- Since all log messages will have a timestamp after that, it's good enough for our purpose.
lib.UI_LOAD_START_TIME = internal.UI_LOAD_START_TIME

--- @param tag - a string identifier that is used to identify entries made via this logger
--- @return a new logger instance with the passed tag
function lib.Create(tag)
    return Logger:New(tag)
end
setmetatable(lib, { __call = function(_, ...) return lib.Create(...) end })

--- @return true, if logs capture a stack trace.
function lib:IsTraceLoggingEnabled()
    return internal.settings.logTraces
end

--- @param enabled - controls if logs should capture a stack trace.
function lib:SetTraceLoggingEnabled(enabled)
    internal.settings.logTraces = enabled
end

--- @return the minimum log level.
function lib:GetMinLogLevel()
    return internal.settings.minLogLevel
end

--- @param level - sets the minimum log level.
function lib:SetMinLogLevel(level)
    internal.settings.minLogLevel = level
end

--- @return returns the log table.
function lib:GetLog()
    return internal.log
end

--- removes all entries from the log and returns the log table.
--- @return returns the log table.
function lib:ClearLog()
    internal.log = {}
    LibDebugLoggerLog = internal.log
    internal:FireCallbacks(callback.LOG_CLEARED, internal.log)
    return internal.log
end

--- @param enabled - controls if logs created via d(), df() or CHAT_ROUTER:AddDebugMessage should be hidden from the chat window
function lib:SetBlockChatOutputEnabled(enabled)
    internal.blockChatOutput = enabled
end

--- @return true, if logs created via d(), df() or CHAT_ROUTER:AddDebugMessage are hidden from the chat window
function lib:IsBlockChatOutputEnabled()
    return internal.blockChatOutput
end

--- This method rebuilds the input string in case it has been split up to circumvent the saved variables string length limit.
--- @return the resulting string
function lib.CombineSplitStringIfNeeded(input)
    if(type(input) == "table") then
        return table.concat(input, "")
    else
        return input
    end
end

--- Register to a callback fired by the library. Usage is the same as with CALLBACK_MANAGER:RegisterCallback.
--- The available callback names are located in Callbacks.lua
--- Callback functions should be as lightweight as possible. If you plan to use expensive calls, 
--- defer the execution with zo_callLater!
function lib:RegisterCallback(...)
    return internal.callbackObject:RegisterCallback(...)
end
