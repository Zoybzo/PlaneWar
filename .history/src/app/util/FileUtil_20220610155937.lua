FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()
local path = cc.FileUtils:getInstance():getWritablePath()
local file = io.open(path .. filename, "w+")

local json = require("dkjson")
--

function FileUtil.fileRead(filename)
    local str = cc.FileUtils:getInstance():getStringFromFile(filename)
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