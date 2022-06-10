local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)

function MyRoleNode:create(painting, action)
    local myRoleNode = MyRoleNode.new()
    myRoleNode:addChild(myRoleNode:init(painting, action))
    return myRoleNode
end

function MyRoleNode:ctor()
    self.x = 0
    self.y = 0
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
    -- plane
    self.tailFlame = nil
    self.myRole = nil
    -- default
    self.defaultHeight = 0
end

function MyRoleNode:init(painting, action)
    -- body
    local layer = ccui.Layout:create()
    self.myRole = cc.Sprite:create(ConstantsUtil.PATH_ROLE[painting]):addTo(layer)
    self.tailFlame = cc.ParticleSystemQuad:create(ConstantsUtil.PATH_TAIL_FLAME_PLIST):addTo(layer)
    self.deltaHeight = self.myRole:getContentSize().height / 2 + self.tailFlame:getContentSize().height / 2
    self.myRole:setTag(ConstantsUtil.TAG_MY_ROLE)
    self.myRole:setAnchorPoint(0.5, 0.5)
    self.myRole:setPosition(WinSize.width / 2, WinSize.height * -0.3)
    self.tailFlame:setAnchorPoint(0.5, 0.5)
    self.tailFlame:setPosition(WinSize.width / 2, WinSize.height * -0.3 - self.deltaHeight)

    self.myRole:runAction(action)
    action:setTarget(action:getTarget():getPositionX(), action:getTarget():getPositionY() - self.defaultHeight)
    self.tailFlame:runAction(action)

    --- 单点触摸移动
    local function onTouchBegan(touch, event)
        Log.i("touch begin")
        return true
    end
    local function onTouchEnded(touch, event)
        Log.i("touch end")
    end
    local function onTouchMoved(touch, event)
        local target = event:getCurrentTarget() --获取当前的控件
        local posX, posY = target:getPosition() --获取当前的位置
        local delta = touch:getDelta() --获取滑动的距离
        target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --给精灵重新设置位置
    end

    --- 事件分发器
    local eventDispatcher = self:getEventDispatcher()
    local listener1 = cc.EventListenerTouchOneByOne:create() --创建一个单点事件监听
    listener1:setSwallowTouches(false) --是否向下传递
    listener1:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener1:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener1:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, self.myRole) --分发监听事件
    local listener2 = cc.EventListenerTouchOneByOne:create() --创建一个单点事件监听
    listener2:setSwallowTouches(false) --是否向下传递
    listener2:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener2:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener2:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener2, self.tailFlame)

    return layer
end

function MyRoleNode:runAction(action)
end

return MyRoleNode
