local DFUtil = require("DFCommon.Util")
local UIElement = require('UI.UIElement')
local DFInput = require('DFCommon.Input')
local SoundManager = require('SoundManager')
local Gui = require("UI.Gui")

local m = {}


local sUILayoutFileName = 'UILayouts/LoadDirectoryLayout'


function cleanPathString(str)
	finalString = str:gsub("%/", "\\")
	return finalString
end


function m.create()
	
	local Ob = DFUtil.createSubclass(UIElement.create())
	local CurrentDir = cleanPathString(tostring(MOAIEnvironment.documentDirectory .. "/Saves/"))
    MOAIFileSystem.affirmPath(CurrentDir)
	
	
	function Ob:init()
        self:setRenderLayer('UIScrollLayerLeft')
		--self:setRenderLayer('UIOverlay')
		
		
        Ob.Parent.init(self)
        self:processUIInfo(sUILayoutFileName)
		
		
		self.rCurrentDirectoryPathSelector = self:getTemplateElement('CurrentDirectoryPathSelector')
		print('test2')
		self:loadDir()
		print('test3')
		self:_calcDimsFromElements()
	end
	
	function Ob:loadDir()
		--self.rCurrentDirectoryContentList
		
		MOAIFileSystem.setWorkingDirectory(CurrentDir)
		local tDirs = MOAIFileSystem.listDirectories()
		
		local w,h = 770, 60
		local nYLoc = 0
		--local xTopLeft = 216
		local yTopLeft = 0 ---475
		
		
		
		local currentPath = {
			key = 'CurrentDirectoryContentList',
			type = 'textBox',
			pos = { 0, 0 },
			text = '...',
			style = 'dosismedium44',
			rect = { 0, 100, 500, 0 },
			hAlign = MOAITextBox.LEFT_JUSTIFY,
			vAlign = MOAITextBox.LEFT_JUSTIFY,
			color = Gui.WHITE,
		}
		
		local sCurrentPathLabel = "CurrentDirectoryContentList"
		local tNewElementData = DFUtil.deepCopy(currentPath)
		tNewElementData.key = sCurrentPathLabel
		self:_addTemplateElement(sCurrentPathLabel, tNewElementData)
		
		
		for k,v in ipairs(tDirs) do
		
			yTopLeft = yTopLeft - h
			--self.rCurrentDirectoryContentList:setString(v)
			
			print('k: ' .. k .. ' v: ' .. v .. ' yTopLeft:' .. yTopLeft)
			currentPath.text = v
			currentPath.pos = { 0, yTopLeft }
			
			tNewElementData = DFUtil.deepCopy(currentPath)
			tNewElementData.key = sCurrentPathLabel
			self:_addTemplateElement(sCurrentPathLabel, tNewElementData)
					
		end
		
		--self.rCurrentDirectoryContentList = self:getTemplateElement('CurrentDirectoryContentList')
		
		
		
		--self.rCurrentPathDirectoryList:addScrollingItem(rNewEntry)
	
    --    if nNumEntriesToAdd > 0 then -- dynamically add entries
    --        for i = 1, nNumEntriesToAdd do
    --            self:addRosterEntry()
    --        end
    --    end
	
	end
	

	
	function Ob:setDir(_id, _name, callback)
		id = _id
		name = _name
		self.rCurrentDirectoryContentList:setString(name)
		self.callback = callback
	end
	
	function Ob:onButtonClicked(rButton, eventType)
		if eventType == DFInput.TOUCH_UP and not disabled then
			self:callback(self, id, name)
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