local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)

function MyRoleNode:create()
    local myRoleNode = MyRoleNode.new()
    myRoleNode.addChild(myRoleNode:init())
    return myRoleNode
end

function MyRoleNode:ctor()
    self.x = 0
    self.y = 0
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
end

function MyRoleNode:init()
    -- body
end

return MyRoleNode
