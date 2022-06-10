---require
-- require("AudioEngine")
---
local GameScene =
    class(
    "GameScene",
    function()
        return display.newScene("GameScene")
    end
)
---local
local MyRoleNode = require("app.node.MyRoleNode")
local PauseNode = require("app.node.PauseNode")
local OverNode = require("app.node.OverNode")
local BulletNode = require("app.node.BulletNode")
local EnemyNode = require("app.node.EnemyNode")
---
function GameScene:ctor()
    self.myRoleWithTail = nil -- 飞机
    self.gameScene = nil -- scene
    GameHandler.pause = false
    display.addSpriteFrames(ConstantsUtil.PATH_EXPLOSION_PLIST, ConstantsUtil.PATH_EXPLOSION_PNG)
end

function GameScene:onEnter()
    self.gameScene =
        CSLoader:createNodeWithFlatBuffersFile("GameScene.csb"):addTo(self, ConstantsUtil.LEVEL_VISIABLE_LOW)

    --- 暂停
    local pauseButton = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "pause"), "ccui.Button")
    pauseButton:addTouchEventListener(
        function(ref, event)
            Log.i("pauseButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                if GameHandler.pause == false then
                    --- 当前关闭 点击后开启
                    GameHandler.pause = true
                    local pause = PauseNode:create(ConstantsUtil.COLOR_GREW_TRANSLUCENT, self.myRoleWithTail)
                    pause:addTo(self)
                    Director:pause()
                end
            end
        end
    )

    --- 我方飞机
    self.myRoleWithTail = MyRoleNode:create(ConstantsUtil.ROLE_PURPLE_PLANE):addTo(self)
    if GameHandler.isContinue == false then
        self.myRoleWithTail:initMove(2, WinSize.width * 0.5, WinSize.height * 0.17)
    end
    local myRole = tolua.cast(self.myRoleWithTail.myRole, "cc.Sprite")

    --- 生命与分数
    local hp = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "life"), "ccui.Layout")

    local hp_item =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(self.myRoleWithTail:getMyHp(), 3),
        ConstantsUtil.PATH_BIG_NUM
    )
    hp:addChild(hp_item)
    hp_item:setScale(0.4)
    hp_item:setAnchorPoint(1, 1)
    hp_item:pos(hp:getContentSize().width * 0, hp:getContentSize().height * 0.5)
    hp_item:setContentSize(0, hp:getContentSize().height)

    local score = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "score"), "ccui.Layout")
    local score_item =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(self.myRoleWithTail:getMyScore(), 3),
        ConstantsUtil.PATH_BIG_NUM
    )
    score:addChild(score_item)
    score_item:setScale(0.4)
    score_item:setAnchorPoint(1, 1)
    score_item:pos(score:getContentSize().width * 0, score:getContentSize().height * 0.5)
    score_item:setContentSize(0, score:getContentSize().height)

    -- 子弹初始化
    if GameHandler.isContinue == true then
        for i = 1, #(GameHandler.BulletArray) do
            local node = cc.Node:create():addTo(self)
            GameHandler.BulletArray[i]:addTo(node)
        end
    end

    -- 子弹发射
    local function addBullet()
        if effectKey then
            Audio.playEffectSync(ConstantsUtil.PATH_FIRE_EFFECT, false)
        end

        local x, y = myRole:getPosition()
        local bullet = BulletNode:create(x, y + myRole:getContentSize().height / 2):addTo(self)
    end
    addBulletEntry = Scheduler:scheduleScriptFunc(addBullet, ConstantsUtil.INTERVAL_BULLET, false)

    -- 敌军初始化
    if GameHandler.isContinue == true then
    end

    -- 敌军 Test
    local function newEnemy()
        -- body
        local enemy = EnemyNode:create(math.random() * WinSize.width):addTo(self)
    end
    addEnemyEntry = Scheduler:scheduleScriptFunc(newEnemy, ConstantsUtil.INTERVAL_ENEMY, false)

    --- 爆炸动画
    local explosionSprite = display.newSprite("#explosion_01.png")
    self:addChild(explosionSprite, 6)
    local function getExplosion(x, y)
        -- body
        explosionSprite:setPosition(x, y)
        local frames = display.newFrames("explosion_%02d.png", 1, 35)
        local animation = display.newAnimation(frames, ConstantsUtil.SPEED_EXPLOSION)
        local animate = cc.Animate:create(animation)
        explosionSprite:runAction(animate)
    end

    --TODO 要么是子弹与敌人碰撞 要么是自己与敌人碰撞 所以可以给敌人写个碰撞函数
    -- 子弹与敌人碰撞 Test
    local function collisionBetweenBUlletAndEnemy()
        local bulletArraySize = #(GameHandler.BulletArray)
        local enemyArraySize = #(GameHandler.EnemyArray)
        for i = 1, bulletArraySize do
            if #(GameHandler.BulletArray) < i then
                break
            end
            for j = 1, enemyArraySize do
                if #(GameHandler.EnemyArray) < j then
                    break
                end
                if
                    math.abs(GameHandler.BulletArray[i]:getPositionX() - GameHandler.EnemyArray[j]:getPositionX()) * 2 <=
                        (GameHandler.BulletArray[i]:getWidth() + GameHandler.EnemyArray[j]:getWidth()) and
                        (math.abs(GameHandler.BulletArray[i]:getPositionY() - GameHandler.EnemyArray[j]:getPositionY()) *
                            2) <=
                            (GameHandler.BulletArray[i]:getHeight() + GameHandler.EnemyArray[j]:getHeight())
                 then
                    -- sound
                    if effectKey then
                        Audio.playEffectSync(ConstantsUtil.PATH_EXPLOSION_EFFECT, false)
                    end
                    -- score
                    if self.myRoleWithTail:getMyScore() < 999 then
                        self.myRoleWithTail:setMyScore(
                            self.myRoleWithTail:getMyScore() + ConstantsUtil.PLUS_ENEMY_SCORE
                        )
                        score_item:setString(TypeConvert.Integer2StringLeadingZero(self.myRoleWithTail:getMyScore(), 3))
                    end
                    -- 爆炸动画
                    getExplosion(GameHandler.EnemyArray[j]:getPositionX(), GameHandler.EnemyArray[j]:getPositionY())
                    -- body
                    GameHandler.BulletArray[i]:removeFromParent()
                    GameHandler.EnemyArray[j]:removeFromParent()
                    table.remove(GameHandler.BulletArray, i)
                    table.remove(GameHandler.EnemyArray, j)
                    i = i - 1
                    j = j - 1
                    bulletArraySize = bulletArraySize - 1
                    enemyArraySize = enemyArraySize - 1
                end
            end
        end
    end
    collisionBetweenBUlletAndEnemyEntry =
        Scheduler:scheduleScriptFunc(collisionBetweenBUlletAndEnemy, ConstantsUtil.INTERVAL_COLLISION, false)

    -- -- 敌人与自己碰撞
    -- local function collisionBetweenMyRoleAndEnemy()
    --     local enemyArraySize = #(GameHandler.EnemyArray)
    --     local rectMyRole = myRole:getBoundingBox()
    --     for i = 1, enemyArraySize do
    --         if #(GameHandler.EnemyArray) < i then
    --             break
    --         end
    --         local rect = GameHandler.EnemyArray[i]:getBoundingBox()
    --         if
    --             math.abs((GameHandler.EnemyArray[i]:getPositionX() - myRole:getPositionX())) * 2 <=
    --                 (rect.width + rectMyRole.width) and
    --                 math.abs(GameHandler.EnemyArray[i]:getPositionY() - myRole:getPositionY()) * 2 <=
    --                     (rect.height + rectMyRole.height)
    --          then
    --             -- sound
    --             if effectKey then
    --                 Audio.playEffectSync(ConstantsUtil.PATH_DESTROY_EFFECT, false)
    --             end
    --             --- 爆炸动画
    --             if self.myRoleWithTail:getMyHp() - ConstantsUtil.MINUS_ENEMY_COLLISION > 0 then
    --                 self.myRoleWithTail:setMyHp(self.myRoleWithTail:getMyHp() - ConstantsUtil.MINUS_ENEMY_COLLISION)
    --                 hp_item:setString(TypeConvert.Integer2StringLeadingZero(self.myRoleWithTail:getMyHp(), 3))
    --             else
    --                 GameHandler.pause = true
    --                 local over = OverNode:create(ConstantsUtil.COLOR_GREW_TRANSLUCENT, self.myRoleWithTail)
    --                 over:addTo(self)
    --                 Director:pause()
    --             end
    --             getExplosion(myRole:getPositionX(), myRole:getPositionY())
    --             --body
    --             GameHandler.EnemyArray[i]:removeFromParent()
    --             table.remove(GameHandler.EnemyArray, i)
    --             i = i - 1
    --             enemyArraySize = enemyArraySize - 1
    --         end
    --     end
    -- end
    -- collisionBetweenMyRoleAndEnemyEntry =
    --     Scheduler:scheduleScriptFunc(collisionBetweenMyRoleAndEnemy, ConstantsUtil.INTERVAL_COLLISION, false)

    -- 背景移动
    local bg0 = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "background_0"), "cc.Sprite")
    local bg1 = tolua.cast(ccui.Helper:seekWidgetByName(self.gameScene, "background_1"), "cc.Sprite")
    local bg = {}
    bg[0] = bg0
    bg[1] = bg1
    local nowBg = 0

    local function backgroundMove()
        bg[nowBg]:setPositionY(bg[nowBg]:getPositionY() - ConstantsUtil.SPEED_BG_MOVE)
        bg[(nowBg + 1) % 2]:setPositionY(bg[nowBg]:getPositionY() + WinSize.height - ConstantsUtil.SPEED_BG_MOVE) --- 吐槽 为什么连异或操作都没有 裂开
        if bg[(nowBg + 1) % 2]:getPositionY() == WinSize.height / 2 then
            bg[nowBg]:setPositionY(WinSize.height * 1.5)
            nowBg = (nowBg + 1) % 2
        end
    end
    backgroundEntry = Scheduler:scheduleScriptFunc(backgroundMove, ConstantsUtil.INTERVAL_BACKGROUND_MOVE, false)

    -- 重新设置continue
    if GameHandler.isContinue == true then
        GameHandler.isContinue = false
    end
end

function GameScene:onExit()
    Scheduler:unscheduleScriptEntry(backgroundEntry)
    Scheduler:unscheduleScriptEntry(addBulletEntry)
    Scheduler:unscheduleScriptEntry(addEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenBUlletAndEnemyEntry)
    Scheduler:unscheduleScriptEntry(collisionBetweenMyRoleAndEnemyEntry)
end

return GameScene