local MenuScene =
    class(
    "MenuScene",
    function()
        return display.newScene("MenuScene")
    end
)
---local

---

function MenuScene:ctor()
end

function MenuScene:onEnter()
    local menuScene = CSLoader:createNodeWithFlatBuffersFile("MenuScene.csb"):addTo(self)
    local bg = ccui.Helper:seekWidgetByName(menuScene, "background")
    bg:setContentSize(WinSize.width, WinSize.height)
    ccui.Helper:doLayout(bg)

    local rankButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "rank"), "ccui.Button")
    rankButton:addTouchEventListener(
        function(ref, event)
            ConstantsUtil.playButtonEffect()
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                local nowScene = import("app.scenes.RankScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local settingButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "setting"), "ccui.Button")
    settingButton:addTouchEventListener(
        function(ref, event)
            ConstantsUtil.playButtonEffect()
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                local nowScene = import("app.scenes.SettingScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local newGameButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "new_game"), "ccui.Button")
    newGameButton:addTouchEventListener(
        function(ref, event)
            ConstantsUtil.playButtonEffect()
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                --
                GameHandler:cleanupData()
                GameHandler.isContinue = false
                --
                local nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local continueButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "continue"), "ccui.Button")
    continueButton:addTouchEventListener(
        function(ref, event)
            ConstantsUtil.playButtonEffect()
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                if GameHandler.isContinue == true then
                    local nowScene = import("app.scenes.GameScene").new()
                    display.replaceScene(nowScene)
                end
            end
        end
    )
end

function MenuScene:onExit()
end

return MenuScene
