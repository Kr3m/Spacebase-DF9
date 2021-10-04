
local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local DFInput = require('DFCommon.Input')
local Renderer = require('Renderer')
local Gui = require('UI.Gui')
local GameRules = require('GameRules')
local GameScreen = require('GameScreen')

--local rCurrentPathDirectoryList = require('UI.ScrollableUI')

local LoadDirectory = require('UI.LoadDirectory')


local sUILayoutFileName = 'UILayouts/LoadBaseLayout'


--local BUTTON_X_AVAILABLE = 800 - 10


local m = {}


function cleanPathString(str)
	finalString = str:gsub("%/", "\\")
	return finalString
end

function m.create()
	local Ob = DFUtil.createSubclass(UIElement.create())
	local CurrentDir = tostring(MOAIEnvironment.documentDirectory)
	--local rCurrentPathDirectoryList
	
	function Ob:init()
        Ob.Parent.init(self)
        --self:setRenderLayer("UIOverlay")
		--self:setRenderLayer("UIForeground")
		
        g_GuiManager.statusBar:hide()
		g_GuiManager.tutorialText:hide()
        g_GuiManager.hintPane:hide()
        g_GuiManager.alertPane:hide()
		g_GuiManager.newSideBar:hide()
		
		
		
		
		self.tDirEntries = {}
		
		self:processUIInfo(sUILayoutFileName)
		self.uiBG = self:getTemplateElement('Background')
		self.uiBG:setScl( Renderer.getViewport().sizeX * 2, Renderer.getViewport().sizeY * 2 )
        self.uiBG:setLoc( -Renderer.getViewport().sizeX * .5, Renderer.getViewport().sizeY * .5 )
		self:_updateBackground()
		
		
		--[[
		self.rNameText = self:getTemplateElement('NameLabel')
        self.rNameEditBG = self:getTemplateElement('NameEditBG')
		self.rNameEditButton = self:getTemplateElement('NameEditButton')
		self.rNameEditButton:addPressedCallback(self.onNameEditButtonPressed, self)
		]]--
		
		
		self.rCurrentPathLabel = self:getTemplateElement('CurrentPathLabel')
		self.rCurrentPathLabel:setString(cleanPathString(CurrentDir))
		self.rCurrentPathLabelEditBG = self:getTemplateElement('CurrentPathLabelEditBG')
		self.rCurrentPathEditButton = self:getTemplateElement('CurrentPathEditButton')
		self.rCurrentPathEditButton:addPressedCallback(self.onCurrentPathEditButtonPressed, self)
		
		self.rCurrentPathDirectoryList = self:getTemplateElement('CurrentPathDirectoryList')
		self.rCurrentDirectoryContentList = self:getTemplateElement('CurrentDirectoryContentList')

		--self.rScrollableUI = self:getTemplateElement('CurrentPathDirectoryList')
		
		self.rButtonLoad = self:getTemplateElement('LoadButton')
        self.rButtonLoad:addPressedCallback(self.loadFile, self)
		
		self.rButtonLoadCancel = self:getTemplateElement('CancelButton')
        self.rButtonLoadCancel:addPressedCallback(self.loadCancel, self)
	   
		self:generateDirList()
	end


	function Ob:generateDirList()
		local rNewEntry = LoadDirectory.new()
		--[[
		print('rNewEntry: ')
		for k,v in ipairs(rNewEntry) do
			print('k: ' .. tostring(k) .. ' v: ' .. tostring(v))
		end
		local nNumEntries = table.getn(self.tDirEntries)
        print('nNumEntries: ' .. nNumEntries)
		local w,h = rNewEntry:getDims()
		print('w: ' .. w .. ' h: ' .. h)
		local nYLoc = h * (nNumEntries - 1)
		print('nYLoc: ' .. nYLoc)
		
        rNewEntry:setLoc(0, nYLoc) -- assuming uniform Y size for entries
        self:_calcDimsFromElements()
		]]--
		
		
		
		self.rCurrentPathDirectoryList:addScrollingItem(rNewEntry)
		--table.insert(self.tDirEntries, rNewEntry)
		
		
	end
	
	function Ob:onCurrentPathEditButtonPressed(rButton, eventType)
		if eventType == DFInput.TOUCH_UP and not GameScreen.inTextEntry() then
			g_inLoadOrSave = true
			GameScreen.beginTextEntry(self.rCurrentPathLabel, self, self.confirmTextEntry, self.cancelTextEntry)
			self.rCurrentPathEditButton:setSelected(true)
			
		end
	end
	
	
	function Ob:confirmTextEntry(text)
		if text then
			--local sTrimmedText = text:gsub("^%s*(.-)%s*$", "%1")
			--if sTrimmedText ~= "" then
				--self.rCurrentPathLabel:setString(cleanPathString(sTrimmedText))
				self.rCurrentPathLabel:setString(cleanPathString(text))
				self.rCurrentPathEditButton:setSelected(false)
			--end
		end
	end
	
	function Ob:cancelTextEntry(text)
		self.rCurrentPathEditButton:setSelected(false)
		g_inLoadOrSave = false
	end
	

	function Ob:loadCancel()
		--g_GuiManager.startMenu:resume(false)
		g_GuiManager.showStartMenu(true)
	end
	
	function Ob:loadFile()
		--g_GuiManager.startMenu:resume(false)
		g_GuiManager.showStartMenu(true)
	end
	
    function Ob:_updateBackground()
        self.uiBG:setScl(Renderer.getViewport().sizeX*2,Renderer.getViewport().sizeY*2)
        self.uiBG:setLoc(-Renderer.getViewport().sizeX*.5,Renderer.getViewport().sizeY*.5)
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
        --dirList = MOAIFileSystem.listDirectories()
		--self:loadDirectory(dirList)
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

		local bHandled = false
        if self.rCurrentPathDirectoryList:onFinger(touch, x, y, props) then
            bHandled = true
        end
        if self.rCurrentPathDirectoryList:isInsideScrollPane(x, y) then
                   
        end
        if Ob.Parent.onFinger(self, touch, x, y, props) then       
			bHandled = true
        end
 
		return bHandled
		
    end
	
    function Ob:inside(wx, wy)
        local bHandled = Ob.Parent.inside(self, wx, wy)
        self.rCurrentPathDirectoryList:inside(wx, wy)
             
        return bHandled
    end
	
	function Ob:onKeyboard(key, bDown)
        -- capture all keyboard input
        if bDown and key == 27 then -- esc
			self:loadCancel()
        end
        return true
    end
	
	function Ob:onResize()
        Ob.Parent.onResize(self)
		self.rCurrentPathDirectoryList:onResize()
        self:_updateBackground()
        self:refresh()
    end
	
	function Ob:onBackButtonPressed(rButton, eventType)
        if eventType == DFInput.TOUCH_UP then
			menuManager.closeMenu()
			SoundManager.playSfx('degauss')
        end
    end
    return Ob
end

function m.new(...)
    local Ob = m.create()
    Ob:init(...)

    return Ob
end

return m
