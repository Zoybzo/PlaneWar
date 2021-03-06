ConstantsUtil = ConstantsUtil or {}
--- object
Director = cc.Director:getInstance()
Scheduler = Director:getScheduler()
WinSize = Director:getWinSize()
UserDefault = cc.UserDefault:getInstance()
CSLoader = cc.CSLoader:getInstance()
Audio = require("framework.Audio")

--- string
ConstantsUtil.BACKGROUND = "background"
ConstantsUtil.SETTING = "setting"
ConstantsUtil.RANK = "rank"

ConstantsUtil.ROLE_PURPLE_PLANE = "PURPLE_PLANE"
ConstantsUtil.ROLE_RED_PLANE = "RED_PLANE"

ConstantsUtil.MUSIC_KEY = "music_key"
ConstantsUtil.EFFECT_KEY = "effect_key"
ConstantsUtil.CONTINUE_KEY = "continue_key"

--- constants
-- ConstantsUtil.DEFAULT_HP = 100
ConstantsUtil.DEFAULT_HP = 20
ConstantsUtil.DEFAULT_SCORE = 0
ConstantsUtil.DEFAULT_DELTA_HEIGHT = 30

ConstantsUtil.MINUS_ENEMY_COLLISION = 20
ConstantsUtil.PLUS_ENEMY_SCORE = 1

ConstantsUtil.SPEED_BG_MOVE = 5
ConstantsUtil.SPEED_BULLET_MOVE = 15
ConstantsUtil.SPEED_ENEMY_MOVE = 10
ConstantsUtil.SPEED_EXPLOSION = 1 / 35

ConstantsUtil.FPS = 60
ConstantsUtil.INTERVAL_ANIMATION = 1.0 / ConstantsUtil.FPS
ConstantsUtil.INTERVAL_BULLET = 0.2
ConstantsUtil.INTERVAL_BACKGROUND_MOVE = 1.0 / 60
ConstantsUtil.INTERVAL_ENEMY = 1.0
ConstantsUtil.INTERVAL_COLLISION = 1.0 / 60

ConstantsUtil.BORN_PLACE_ENEMY = 1.3
ConstantsUtil.DIE_PLACE_ENEMY = -0.3
ConstantsUtil.DIE_BULLET = WinSize.height

ConstantsUtil.LEVEL_VISIABLE_HIGH = 10
ConstantsUtil.LEVEL_VISIABLE_MEDIUM = 5
ConstantsUtil.LEVEL_VISIABLE_LOW = 0

ConstantsUtil.INIT_PLANE_X = 0.5
ConstantsUtil.INIT_PLANE_Y = -0.3

ConstantsUtil.COLOR_GREW_TRANSLUCENT = cc.c4b(0, 0, 0, 110)

--- path
ConstantsUtil.PATH_SAVE_JSON = "save.json"
ConstantsUtil.PATH_RANK_JSON = "rank.json"

ConstantsUtil.PATH_BG_JPG = "ui/main/bg_menu.jpg"

ConstantsUtil.PATH_BULLET_PNG = "player/blue_bullet.png"
ConstantsUtil.PATH_SMALL_ENEMY_PNG = "player/small_enemy.png"
ConstantsUtil.PATH_ROLE = {
    [ConstantsUtil.ROLE_PURPLE_PLANE] = "player/purple_plane.png",
    [ConstantsUtil.ROLE_RED_PLANE] = "player/red_plane.png"
}
ConstantsUtil.PATH_TAIL_FLAME_PLIST = "particle/fire.plist"

ConstantsUtil.PATH_SETTING_CLOSE_PNG = "ui/setting/soundon2_cover.png"
ConstantsUtil.PATH_SETTING_OPEN_PNG = "ui/setting/soundon1_cover.png"

ConstantsUtil.PATH_INGAME_CONTINUE_PNG = "ui/continue/pauseResume.png"
ConstantsUtil.PATH_INGAME_BACK_PNG = "ui/continue/pauseBackRoom.png"

ConstantsUtil.PATH_OVER_BACK_PNG = "ui/gameover/back.png"
ConstantsUtil.PATH_OVER_RESTART_PNG = "ui/gameover/restart.png"

ConstantsUtil.PATH_BACKGROUND_MUSIC = "sounds/bgMusic.ogg"
ConstantsUtil.PATH_MAIN_MUSIC = "sounds/mainMainMusic.ogg"
ConstantsUtil.PATH_DESTROY_EFFECT = "sounds/shipDestroyEffect.ogg"
ConstantsUtil.PATH_EXPLOSION_EFFECT = "sounds/explodeEffect.ogg"
ConstantsUtil.PATH_BUTTON_EFFECT = "sounds/buttonEffect.ogg"
ConstantsUtil.PATH_FIRE_EFFECT = "sounds/fireEffect.ogg"

ConstantsUtil.PATH_EXPLOSION_PLIST = "animation/explosion.plist"
ConstantsUtil.PATH_EXPLOSION_PNG = "animation/explosion.png"

ConstantsUtil.PATH_BIG_NUM = "ui/rank/islandcvbignum.fnt"

--- global variable
ConstantsUtil.musicKey = UserDefault:getBoolForKey(ConstantsUtil.MUSIC_KEY, true)
ConstantsUtil.effectKey = UserDefault:getBoolForKey(ConstantsUtil.EFFECT_KEY, true)
ConstantsUtil.username = ""

-- function
function ConstantsUtil.playButtonEffect()
    if ConstantsUtil.effectKey then
        Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
    end
end

function ConstantsUtil.playExplosionEffect()
    if ConstantsUtil.effectKey then
        Audio.playEffectSync(ConstantsUtil.PATH_EXPLOSION_EFFECT, false)
    end
end

return ConstantsUtil
