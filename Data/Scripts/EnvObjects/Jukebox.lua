local Class=require('Class')
local DFUtil = require("DFCommon.Util")
local EnvObject=require('EnvObjects.EnvObject')
local Gui = require('UI.Gui')
local CharacterManager=require('CharacterManager')
local SoundManager=require('SoundManager')
local Renderer=require('Renderer')
local Camera=require('Camera')
local Character=require('CharacterConstants')
--local MOAIFmodEventInstance=require('MOAIFmodEventInstance ')

local Jukebox = Class.create(EnvObject, MOAIProp.new)

Jukebox.LISTEN_RANGE_TILES = 8
Jukebox.LISTEN_RANGE_WORLD = 8*128

function Jukebox:init(sName, wx, wy, bFlipX, bForce, tSaveData, nTeam)
	EnvObject.init(self, sName, wx, wy, bFlipX, bForce, tSaveData, nTeam)
	self.bIsOn = false
	self.rMusic = nil
end

function Jukebox:setOn(isOn)
	--print("Trying to switch jukebox")
	if self.bIsOn == isOn then return end

	self.bIsOn = isOn

	if self.bIsOn then
		self.rMusic = SoundManager.playSfx3D("jukebox_music", self.wx, self.wy, 0)
	else
		if self.rMusic ~= nil then
			self.rMusic.stop()
		end
	end

	return self.bIsOn
end

function Jukebox:isOn()
	if self.bDestroyed or self.nCondition < 1 then
		return false
	end

	if self.bIsOn then
		return true
	end

	return false
end


function Jukebox:_listenGate(rChar)
	--print("Using listen gate")
	if not self:isOn() then
		return false, 'Jukebox isn\'t on or wrong zone'
	end
	return true
end

function Jukebox:boostMoodOfListeners(reason)
	local tListeners = self:getValidListenList()
	for _,rChar in ipairs(tListeners) do
		print("Boosting mood for " .. rChar:getNiceName())
		rChar:alterMorale(Character.MORALE_DID_HOBBY/2, reason)
	end
end

function Jukebox:getValidListenList( )
	local swx,swy = self:getLoc()
	local tTargetChars
	local tOwnedChars
	tOwnedChars = CharacterManager.getOwnedCharacters()
	tTargetChars = CharacterManager.getCharactersInRange(swx, swy, Jukebox.LISTEN_RANGE_WORLD, tOwnedChars)
	
	local t = {}
	for _,v in ipairs(tTargetChars) do
		if v.rEnt:getRoom() == self:getRoom() then
			table.insert(t, v.rEnt)
		end
	end
	return t
end

return Jukebox
