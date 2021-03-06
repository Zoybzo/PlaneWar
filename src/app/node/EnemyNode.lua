local EnemyNode =
    class(
    "EnemyNode",
    function()
        return cc.Node:create()
    end
)
-- local
local EnemyModel = require("app.model.EnemyModel")
--

function EnemyNode:create(x, y, enemyData)
    local enemyNode = EnemyNode.new(x, y, enemyData)
    enemyNode:addChild(enemyNode:init())
    return enemyNode
end

--构造
function EnemyNode:ctor(x, y, enemyData)
    if enemyData == nil then
        self.dataModel = EnemyModel.new(x)
    else
        self.dataModel = enemyData
    end
    self.enemy = nil
end

function EnemyNode:getPosition()
    return self.dataModel.x, self.dataModel.y
end

function EnemyNode:getPositionX()
    return self.dataModel.x
end

function EnemyNode:getPositionY()
    return self.dataModel.y
end

function EnemyNode:getWidth()
    return self.enemy:getBoundingBox().width
end

function EnemyNode:getHeight()
    return self.enemy:getBoundingBox().height
end

function EnemyNode:init()
    local layer = ccui.Layout:create()
    self.enemy = cc.Sprite:create(ConstantsUtil.PATH_SMALL_ENEMY_PNG):addTo(layer)
    self.enemy:setPosition(self.dataModel.x, self.dataModel.y)
    self.enemy:setAnchorPoint(0.5, 0.5)
    local function enemyMove()
        self.dataModel.y = self.dataModel.y - ConstantsUtil.SPEED_ENEMY_MOVE
        self.enemy:setPositionY(self.dataModel.y)
        if self.dataModel.y <= ConstantsUtil.DIE_PLACE_ENEMY then
            self:removeFromParent() -- 这个函数会把子节点也全部cleanup
            table.removebyvalue(GameHandler.EnemyArray, self, false)
        end
    end
    self.enemy:scheduleUpdateWithPriorityLua(enemyMove, 0)
    table.insert(GameHandler.EnemyArray, self)
    return layer
end

function EnemyNode:isCollision(target)
    if
        math.abs(target:getPositionX() - self:getPositionX()) * 2 <= (target:getWidth() + self:getWidth()) and
            math.abs(target:getPositionY() - self:getPositionY()) * 2 <= (target:getHeight() + self:getHeight())
     then
        return true
    else
        return false
    end
end

return EnemyNode
