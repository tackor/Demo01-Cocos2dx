# Demo01-Cocos2dx

事先说明, 我并不看好 Cocos2dx 即使它跨平台, 我一向觉得 有Unity就够了. 但是无奈需要做一个 旧项目(Cocos2dx lua 配合 Cocos studio实现的). 然后就各种搜索学习, 现在基本上没有多少关于 coocs studio 的视频了, 有的也是很旧的, 不是很想看. 辅助书籍 关东升的 `Cocos2d-x 实战 Lua卷 第2版`

(里面有 `Cocos Studio` 很难官方似乎已经把下载链接藏起来了, 然后只允许下载 `Cocos Creator`, 而

##1. 条件:

1. Mac系统
2. 安装Xcode
3. 安装 Cocos (里面有 `Cocos Studio` 安装地址: [Cocos安装地址: http://www.cocos2d-x.org/download/cocos](http://www.cocos2d-x.org/download/cocos))
4. 似乎还要安装Python 什么的, 一些我之前肯能就安装了的东西, 如果有什么问题就百度谷歌吧.

##2. Demo介绍

![Snip20170922_7.png](http://upload-images.jianshu.io/upload_images/1476913-1f8972bb03842d5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###说明:

#####1. MainScene  类似于首页

首个界面是 MainScene, 有四个按钮

	1. 显示&隐藏    在 MainScene 中其实默认有个隐藏的图片, 该按钮控制图片的显示与隐藏
	2. 旋转       让默认的隐藏的图片进行旋转, 缩放, 透明度变化
	3. 场景2      跳转到 第二个场景 PlayScene 中
	4. 登录       在当前场景(MainScene)中弹出一个 LoadingMaskLayer 的层级(Layer)

#####2. PlayeScene  类似于游戏主场景

第二个场景, 模拟游戏场景, 但是实际上只有一个返回按钮, 功能 返回到上一个场景

#####3. LoadingMaskLayer   类似于登录页

登录层, 在用户点击 MainScene 的`登录`按钮时弹出登录层(Layer)

	可以输入账号&密码, 
	如果用户将 账号和密码都输入的话, 点击登录 会将 登录层销毁.
	如果有一个没有输入任何字符的话 会弹出 提示框 提示用户没有输入账号密码
	
#####4. WarmingLayer      类似于各种提示弹框

	只有一个确定按钮, 点击确定, 就将 WarmingLayer 销毁
	
##3. Cocos 创建项目流程

先说下我的项目, 一个古老的棋牌什么的, 反正一大堆. 然后还用了Cocos Studio. 没有法子到网上搜了一圈居然都没搜索到, 后来在一个论坛上看到了最新版也是终结版的Cocos Studio. 

根据上面的下载地址, 下载下来的 Cocos 包含有Cocos studio. 

其实现在想来 Cocos Studio 集成到 Cocos 也还可以, 感觉不会很松散

1. 打开 `Cocos` 
2. 如图, 只要3步就创建好项目了
![Snip20170922_12.png](http://upload-images.jianshu.io/upload_images/1476913-d192e8ed106adc44.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 创建好项目之后, Cocos 会自动打开 Cocos Studio. 如果没有自动打开 可以点击 Cocos 界面 右侧的按钮进行打开

4. 这里我安装的 Xcode, Android Studio 是相对于 iOS 和Android设备的, 如果你是在windows上安装了 VS的话, 这里应该还会出现 VS的打开方式.

5. 然后如果你要构建项目的 UI的话, 可以使用 Cocos Studio, 如果要写代码的话可以通过自己现有的IDE, 如果有VS, 最好用VS, 我使用的是Xcode, 然后没有任何提示. 需要一遍配合 书籍和 API(网上找的, 没保存链接) 

6. 编写好的UI如何传到Xcode中呢?
![Snip20170922_14.png](http://upload-images.jianshu.io/upload_images/1476913-4b1a5111de49da1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Snip20170922_15.png](http://upload-images.jianshu.io/upload_images/1476913-f49e3a89e84be9f1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
快捷键 `command P`

这时候你可以在 Xcode项目的 `Resources/res` 下面看到有些 图片和 `.csb` 文件以及过来了, 

7. 如何编写`Lua`脚本
在Xcode工程 我们需要关注的代码都在 目录`Resources/src/app/views` 下面.

##4. 主要的代码

MainScene.lua

```

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

                print("账号或密码为空提示")

                --弹出提示框: 账号或密码错误
                local warmLayer = cc.CSLoader:createNode("WarmingLayer.csb")
                self:addChild(warmLayer)

                local rootP = warmLayer:getChildByName("Panel_WarmBg")

                -- 提示框的内容
                local warmTitle = rootP:getChildByName("Text_WarmTitle")
                local warmContent = rootP:getChildByName("Text_WarmContent")

                --设置提示框的标题
                warmTitle:setText("警  告")
                warmContent:setText("警告: 你似乎没有输入账\n号或者密码, 所以是无法\n登陆的 哈哈哈!")

                -- 提示框 确定按钮
                local sureBtn = rootP:getChildByName("Button_WarmSureBtn")
                sureBtn:addClickEventListener(function(sender)
                    self:removeChild(warmLayer, true)
                end)

            else
                print("移除登录画面")
                self:removeChild(maskLayer, true)

            end

        end)
        
    end)

end


return MainScene
```

PlayScene.lua

```

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

```

##5. 项目
[项目源文件: https://github.com/tackor/Demo01-Cocos2dx](https://github.com/tackor/Demo01-Cocos2dx)
