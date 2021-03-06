local m = {}

local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local Renderer = require('Renderer')
local Gui = require('UI.Gui')
local GameRules = require('GameRules')


local sUILayoutFileName = 'UILayouts/AudioVideoSettingsLayout'

function m.create()
    local Ob = DFUtil.createSubclass(UIElement.create())

    function Ob:init()
        Ob.Parent.init(self)

        self:setRenderLayer("UIOverlay")

        self:processUIInfo(sUILayoutFileName)

        self.uiBG = self:getTemplateElement('Background')
        self:_updateBackground()

        self.sliderMusic = self:getTemplateElement('SliderMusic')
        self.sliderSFX = self:getTemplateElement('SliderSFX')
        --self.sliderDialog = self:getTemplateElement('SliderVoice')

        self.sliderMusic.onChangeCallback = Ob.audioLevelCallback
        self.sliderSFX.onChangeCallback = Ob.audioLevelCallback
        --self.sliderDialog.onChangeCallback = Ob.audioLevelCallback

        self.fullscreenCheckbox = self:getTemplateElement('FullscreenCheckbox')
        self.hwMouseCheckbox = self:getTemplateElement('HardwareMouseCheckbox')

        self.fullscreenCheckbox.onChangeCallback = Ob.fullscreenChanged
        self.hwMouseCheckbox.onChangeCallback = Ob.hwMouseChanged
    end

    function Ob:show(basePri)
        Ob.Parent.show(self, basePri)
        GameRules.timePause()
        self:refresh()
        self:onResize()
    end

    function Ob:onTick(dt)
        Ob.Parent.onTick(self, dt)
    end

    function Ob:refresh()
        self.sliderMusic:setValue()
        self.sliderSFX:setValue()
        --self.sliderDialog:setValue()
        self.fullscreenCheckbox:setValue(DFSpace.getFullscreenState(), true)
    end

    function Ob.audioLevelCallback()
        GameRules.bAudioLevelScaleApplied = false
        GameRules.updateAudioLevels()
    end

    function Ob.fullscreenChanged(sConfigKey, bValue)
        local ScreenManager = require('UI.ScreenManager')
        ScreenManager:setFullscreen(bValue)
    end

    function Ob.hwMouseChanged(sConfigKey, bValue)
        g_GuiManager.showCursorSprite(not bValue)
    end

    function Ob:playWarbleEffect(bFullscreen)
        if bFullscreen then
            local uiX,uiY,uiW,uiH = Renderer.getUIViewportRect()
            g_GuiManager.createEffectMaskBox(0, 0, uiW, uiH, 0.3)
        else
            g_GuiManager.createEffectMaskBox(0, 0, 500, 1444, 0.3, 0.3)
        end
    end


    function Ob:onFinger(touch, x, y, props)
        Ob.Parent.onFinger(self, touch, x, y, props)
    end

    function Ob:onKeyboard(key, bDown)
        -- capture all keyboard input
        if bDown and key == 27 then -- esc
            g_GuiManager.startMenu:resume(false)
        end
        return true
    end

    function Ob:inside(wx, wy)
        return Ob.Parent.inside(self, wx, wy)
    end

    function Ob:onFileChange(path)
        Ob.Parent.onFileChange(self, path)

        self:_updateBackground()
    end

    function Ob:onResize()
        Ob.Parent.onResize(self)
        self:_updateBackground()

        self:refresh()
    end

    function Ob:_updateBackground()
        self.uiBG:setScl(Renderer.getViewport().sizeX*2,Renderer.getViewport().sizeY*2)
        self.uiBG:setLoc(-Renderer.getViewport().sizeX*.5,Renderer.getViewport().sizeY*.5)
    end

    return Ob
end

function m.new(...)
    local Ob = m.create()
    Ob:init(...)

    return Ob
end

return m
