
local size = cc.Director:getInstance():getWinSize()

--注意路径
local PlayScene = require("app/views/PlayScene")

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

-- 载入csb文件
MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()

    local isShow = false

    local director = cc.Director:getInstance()

    --载入csb文件
    local root = cc.CSLoader:createNode("MainScene.csb")
    self:addChild(root)

    -- 外部的 容器
    local rootP = root:getChildByName("rootP")

    --拿到图片
    local img = rootP:getChildByName("Center_img")

    --显示&隐藏 图片
    local btn_left = root:getChildByName("Button_left")
    btn_left:addTouchEventListener(function(sender, evt)
        if evt == 2 then
            print("坦克 ---> 左按钮")
            --self:getApp():enterScene("PlayScene")

            if not(isShow) then
                print("来到了 没显示")

                --显示
                img:setVisible(true)
                isShow = true
            else
                print("来到了 显示")
                img:setVisible(false)
                isShow = false
            end

        end
    end)

    local ang = 0;

    --使图片 旋转, 缩放 并改变 不透明度
    local btn_right = rootP:getChildByName("Button_right")
    btn_right:addClickEventListener(function(sender)
        print("坦克 --<< 右边按钮被点击")
        ang = ang + 30

        --旋转
        img:setRotation(ang)

        --缩放
        img:setScale(ang / 360)

        --透明度
        local opa = 30
        local realOpa = ang / 360 * 255

        if (realOpa <= 30) then
            realOpa = opa
        end

        img:setOpacity (realOpa)

        if(ang >= 360) then
            ang = 0
        end

    end)

    --push到别的场景
    local addLayerBtn = rootP:getChildByName("Button_NextScene")
    addLayerBtn:addClickEventListener(function(sender)
        print("添加层")

        --1. 需要跳转的场景
        local playScene = PlayScene.create()

        --2. 过度动画
        local ps = cc.TransitionJumpZoom:create(1.0, playScene)

        --3. 让 Director 进行场景跳转
        director:pushScene(ps)

    end)

    --弹出对话框, 底部有遮罩
    local maskLayBtn = rootP:getChildByName("Button_MaskLayer")
    maskLayBtn:addClickEventListener(function(sender)
        print("弹出遮罩")

        --获取 登录Layer
        local maskLayer = cc.CSLoader:createNode("LoadingMaskLayer.csb")
        self:addChild(maskLayer)

        local maskRootP = maskLayer:getChildByName("Panel_bg")

        --账号
        local countT = maskRootP:getChildByName("TextField_count")

        --密码
        local pwdT = maskRootP:getChildByName("TextField_pwd")

        --登录按钮
        local loadBtn = maskRootP:getChildByName("Button_login")
        loadBtn:addClickEventListener(function(sender)

            --获取输入框中的文本
            --print(countT:getStringValue())

            if (countT:getStringValue() == "" or pwdT:getStringValue() == "") then
                print("木有东西")

                --弹出提示框: 账号或密码错误
                local warmLayer = cc.CSLoader:createNode("WarmingLayer.csb")
                self:addChild(warmLayer)

            else
                print("移除登录画面")
                self:removeChild(maskLayer, true)

            end


        end)
        
    end)

end


return MainScene










