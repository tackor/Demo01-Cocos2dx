
local size = cc.Director:getInstance():getWinSize()

local PlayScene = class("PlayScene", function()
    return cc.Scene:create()
end)

function PlayScene.create()

    local scene = PlayScene.new()
    scene:addChild(scene:createLayer())

    return scene
end

function PlayScene:ctor()
end

-- create layer
function PlayScene:createLayer()

    local layer = cc.Layer:create()
    local director = cc.Director:getInstance()

    --获取csb
    local ui = cc.CSLoader:createNode("PlayScene.csb") -- 参数为csb文件路径
    layer:addChild(ui)

    local rootP = ui:getChildByName("Panel_1")
    --获取按钮
    local btn = rootP:getChildByName("Button_Back")
    btn:addTouchEventListener(function(sender, evt)
        director:popScene()
    end)

    return layer

end

return PlayScene
