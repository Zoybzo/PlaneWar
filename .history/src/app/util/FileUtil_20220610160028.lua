FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()

local json = require("dkjson")
--

function FileUtil.fileRead(filename)
    local absoluateFilename = writablePath .. filename
    local file = io.open(writablePath .. filename, "w+")
    local str = fileUtil:getStringFromFile(filename)
    print(str)
    return str
end

function FileUtil.fileWrite()
end

function FileUtil.loadGame()
end

function FileUtil.saveGame()
    -- body
end

function FileUtil.saveRank()
    -- body
end

function FileUtil.loadRank()
    -- body
end

return FileUtil