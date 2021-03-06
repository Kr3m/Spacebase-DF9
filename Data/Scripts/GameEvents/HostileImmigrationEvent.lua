local Class = require('Class')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local ImmigrationEvent = require('GameEvents.ImmigrationEvent')
local HostileImmigrationEvent = Class.create(ImmigrationEvent)

local Docking = require('Docking')
local CharacterManager = require('CharacterManager')
local Character = require('Character')
local AlertEntry = require('UI.AlertEntry')
local GameRules = require('GameRules')
local Malady = require('Malady')
local MiscUtil = require('MiscUtil')

HostileImmigrationEvent.sEventType = 'hostileImmigrationEvents'
HostileImmigrationEvent.sAlertLC = 'ALERTS028TEXT'
HostileImmigrationEvent.sFailureLC = 'ALERTS024TEXT'
HostileImmigrationEvent.sDialogSet = 'hostileImmigrationEvents'
HostileImmigrationEvent.nDefaultWeight = 15.0
HostileImmigrationEvent.nMinPopulation = 6
HostileImmigrationEvent.nMaxPopulation = -1
HostileImmigrationEvent.nMinTime = 60*12
HostileImmigrationEvent.nMaxTime = -1
HostileImmigrationEvent.nMinUndiscoveredRooms = -1
HostileImmigrationEvent.nMaxUndiscoveredRooms = -1
HostileImmigrationEvent.nMinExteriorRooms = -1
HostileImmigrationEvent.nMaxExteriorRooms = -1
HostileImmigrationEvent.bHostile = true
HostileImmigrationEvent.nChanceObey = 0.33
HostileImmigrationEvent.nChanceHostile = 1.00
HostileImmigrationEvent.sExpMod = 'population'
HostileImmigrationEvent.bAllowKillbots = false

function HostileImmigrationEvent.getModuleContentsDebugString(rController, tPersistentState)
    local s = "Challenge Lvls: "
    local s2 = nil
    local tAtkStances = {}
    for i=1,tPersistentState.nNumSpawns do
        if tPersistentState.tCharSpawnStats then
            s = s..tostring(tPersistentState.tCharSpawnStats[i].nChallengeLevel)..', '
        end
    end
    if tPersistentState.nNumMaladies > 0 and tPersistentState.tPrerolledMalady then
        s2 = Event.getMaladyDebugString(tPersistentState, tPersistentState.nNumMaladies)
    end
    return s .. " ", s2
end

return HostileImmigrationEvent
