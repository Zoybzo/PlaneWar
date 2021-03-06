local OverNode =
    class(
    "OverNode",
    function()
        return cc.Node:create()
    end
)

function OverNode:create(itsColor)
    -- body
    local overNode = OverNode.new()
    overNode:addChild(overNode:init(itsColor))
    return overNode
end

function OverNode:ctor()
    -- body
end

function OverNode:init(itsColor)
    GameHandler.updateRank(ConstantsUtil.username, GameHandler.myRole:getMyScore())
    -- body
    local layer = ccui.Layout:create()
    local overLayer = cc.LayerColor:create(itsColor):addTo(layer)
    local list = tolua.cast(CSLoader:createNodeWithFlatBuffersFile("overLayer.csb"), "ccui.Layout"):addTo(overLayer)

    local listView = tolua.cast(ccui.Helper:seekWidgetByName(list, "infoList"), "ccui.ListView")
    local nameField = tolua.cast(ccui.Helper:seekWidgetByName(list, "nameField"), "ccui.Layout")
    local scoreField = tolua.cast(ccui.Helper:seekWidgetByName(list, "scoreField"), "ccui.Layout")
    --
    local nickname = ccui.Text:create(ConstantsUtil.username, ConstantsUtil.PATH_NORMAL_FONT_TTF, 30)
    nickname:addTo(nameField)
    nickname:setAnchorPoint(0.5, 0.5)
    nickname:setPosition(nameField:getPositionX(), nameField:getPositionY())
    --
    local score =
        ccui.Text:create(
        TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3),
        ConstantsUtil.PATH_NORMAL_FONT_TTF,
        30
    )
    score:addTo(scoreField)
    score:setAnchorPoint(0.5, 0.5)
    score:setPosition(scoreField:getPositionX(), scoreField:getPositionY())
    -- Log.i("Score: " .. TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3))
    -- local score =
    --     ccui.TextBMFont:create(
    --     TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3),
    --     ConstantsUtil.PATH_BIG_NUM_FNT
    -- ):addTo(scoreField)
    -- score:setScale(0.1)
    -- score:setAnchorPoint(0.5, 0.5)
    -- score:pos(scoreField:getPositionX(), scoreField:getPositionY())
    -- score:setContentSize(scoreField:getContentSize().width, scoreField:getContentSize().height)

    -- local listView = ccui.ListView:create():addTo(layer)
    -- listView:setAnchorPoint(0.5, 0.5)
    -- local viewWidth = WinSize.width * 0.8
    -- local viewHeight = WinSize.height * 0.8
    -- listView:setPosition(WinSize.width / 2, WinSize.height / 2)
    -- listView:setContentSize(viewWidth, viewHeight)

    -- local infoLayer = ccui.ListView:create():addTo(listView)
    -- infoLayer:setAnchorPoint(0.5, 0.5)
    -- local infoWidth = viewWidth
    -- local infoHeight = viewHeight * 0.5
    -- infoLayer:setContentSize(infoWidth, infoHeight)
    -- infoLayer:setDirection(0)
    -- --
    -- --
    -- local scoreLayer = ccui.Layout:create():addTo(infoLayer, ConstantsUtil.LEVEL_VISIABLE_HIGH)
    -- scoreLayer:setContentSize(infoWidth / 2, infoHeight)

    local restartButton = tolua.cast(ccui.Helper:seekWidgetByName(list, "restartButton"), "ccui.Button")
    restartButton:addTouchEventListener(
        function(ref, event)
            -- body
            Log.i("restartButton")
            if cc.EventCode.BEGAN == event then
                --- ??????
            elseif cc.EventCode.ENDED == event then
                --- ??????
                Director:resume()
                layer:removeFromParent()
                --
                display:getRunningScene():destroy()
                GameHandler.cleanupData()
                --
                local nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local backButton = tolua.cast(ccui.Helper:seekWidgetByName(list, "backButton"), "ccui.Button")
    backButton:addTouchEventListener(
        function(ref, event)
            Log.i("backButton")
            if cc.EventCode.BEGAN == event then
                --- ??????
            elseif cc.EventCode.ENDED == event then
                --- ??????
                --
                GameHandler.cleanupData()
                --
                Director:resume()
                local nowScene = import("app.scenes.MenuScene").new()
                display.replaceScene(nowScene)
            end
        end
    )
    return layer
end

return OverNode
