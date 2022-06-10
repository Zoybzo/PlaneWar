FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()

local json = require("dkjson")
--

function FileUtil.fileRead(filename)
    local absoluateFilename = writablePath .. filename
    local file = io.open(absoluateFilename, "r")
    Log.i(file:read())
    file:close()
end

function FileUtil.fileWrite(filename, str)
    local absoluateFilename = writablePath .. filename
    local file = io.open(absoluateFilename, "w+")
    file:write(str)
    file:close()
end

function FileUtil.loadGame()
end

function FileUtil.saveGame()
end

function FileUtil.saveRank()
    -- body
end

function FileUtil.loadRank()
    -- body
end

return FileUtil