FileUtil = FileUtil or {}
-- local
local fileUtil = cc.FileUtils:getInstance()
local writablePath = fileUtil:getWritablePath()

local json = require("dkjson")
--

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