local lib = LibDebugLogger
local internal = lib.internal

-- these changes are used during UI load and get discarded when the real settings are loaded,
-- or if no settings have been created yet, they will be kept instead of the defaults.
--internal.settings.logTraces = true
--internal.settings.minLogLevel = internal.LOG_LEVEL_VERBOSE

-- enable adding the stacktrace of the call to zo_callLater to the actual stacktrace
--internal.logOriginStacktrace = true

-- add tags to the verbose whitelist below so they are logged during UI load.
local whitelist = internal.verboseWhitelist
--whitelist["myTag"] = true
--whitelist["myTag/SubLogger"] = true
