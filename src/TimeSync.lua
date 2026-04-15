-- SPDX-FileCopyrightText: 2026 sirinsidiator
--
-- SPDX-License-Identifier: Artistic-2.0

local lib = LibDebugLogger
local internal = lib.internal

local LDL_LOGGER_CONFIG = {
    tag = lib.id
}

-- small hack to allow the logviewer website to sync time stamps between game logs and our log
-- which has inaccurate timestamps due to the lack of a GetTimeStampMilliseconds api
internal.TIME_SYNC_ERROR_CODE = 0x32BBA739
ZO_ERROR_FRAME.suppressedErrors[internal.TIME_SYNC_ERROR_CODE] = true
internal.Log(internal.LOG_LEVEL_INFO, LDL_LOGGER_CONFIG, "Time Sync A")
error("Time Sync B")
