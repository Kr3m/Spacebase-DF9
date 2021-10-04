local Class = require('Class')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local DerelictEvent = Class.create(Event)

local Base = require('Base')
local GameRules = require('GameRules')
local Docking = require('Docking')
local Room = require('Room')
local ModuleData = require('ModuleData')
local Character = require('Character')
local CharacterManager = require('CharacterManager')
local MiscUtil = require('MiscUtil')

-- if there are at least this many undiscovered rooms, no more
-- new (non immigrant shuttle) ships will show up
DerelictEvent.nMaxUndiscoveredRooms = 15

DerelictEvent.sEventType = 'friendlyDerelictEvents'
DerelictEvent.sAlertLC = 'ALERTS023TEXT'
--DerelictEvent.sFailureLC = 'ALERTS024TEXT'
DerelictEvent.nCharactersToSpawn= { 1, 3 }
DerelictEvent.bSkipAlert = true
DerelictEvent.nAlertPriority = 0
DerelictEvent.nDefaultWeight = 5
DerelictEvent.nMinPopulation = 4
DerelictEvent.nMaxPopulation = g_nPopulationCap
DerelictEvent.nMinTime = 10*60
DerelictEvent.nMaxTime = -1
DerelictEvent.nMinUndiscoveredRooms = -1
DerelictEvent.nMaxUndiscoveredRooms = -1
DerelictEvent.nMinExteriorRooms = -1
DerelictEvent.nMaxExteriorRooms = -1
DerelictEvent.bHostile = false
DerelictEvent.nChanceObey = 1.00
DerelictEvent.nChanceHostile = 0.00
DerelictEvent.sExpMod = 'population'
DerelictEvent.bAllowKillbots = true
DerelictEvent.bAttemptDock = true

function DerelictEvent.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
    Event.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
end

function DerelictEvent.preExecuteSetup(rController, tEvent)
    Event.preExecuteSetup(rController, tEvent)

    local _,nPlayerRooms,nHiddenRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
    local bAllowDerelict = nHiddenRooms < DerelictEvent.nMaxUndiscoveredRooms or
        DerelictEvent.nMaxUndiscoveredRooms == -1
    if not bAllowDerelict then
        Print(TT_Info, 'EventController: at undiscovered room limit, no derelicts')
        return false
    end
    local bPopcapFail = not tEvent.bHostile and CharacterManager.getOwnedCitizenPopulation() >= g_nPopulationCap
    if bPopcapFail then
        Print(TT_Info, 'EventController: at undiscovered room limit, no derelicts')
        return false
    end

    -- check if the module data from onqueue is still valid
    if (tEvent.bValidDockingData and
        tEvent.bPrerolledSpawns and
        Docking.testModuleFitAtOffset(tEvent.sEventType,
                                      ModuleData[tEvent.sEventType][tEvent.sModuleEventName],
                                      tEvent.sSetName,
                                      tEvent.sModuleName,
                                      tEvent.tx, tEvent.ty)) then
        return true
    else
        -- TODO: Instead of validating the fit and placement, just postpone deciding where to place
        --       it until now.
        -- didn't have valid docking data, so try and get some now
        local tDockingData = Docking.attemptQueueEvent(
            tEvent.sEventType,
            tEvent.nDifficulty)

        if tDockingData then
            for k, v in pairs(tDockingData) do
                tEvent[k] = v
            end
            tEvent.bValidDockingData = true
            if not tEvent.bPrerolledSpawns then
                if tEvent.bValidDockingData then
                    local rEventClass = rController.tEventClasses[tEvent.sEventType]
                    local tModule = Docking.getModule(tEvent.sSetName,tEvent.sModuleName)
                    if tModule.tCrewSpawns then
                        local nChanceOfMalady = tEvent.nChanceOfMalady or (rEventClass and rEventClass.nChanceOfMalady) or 0
                        tEvent.tCrewData = Event.spawnModuleCrew(tModule, tEvent.nDifficulty, nChanceOfMalady)
                    end
                    if tModule.tObjectSpawns then
                        tEvent.tObjectData = Event.spawnModuleObjects(tModule)
                    end
                    tEvent.bPrerolledSpawns = true
                end
            end
            if not tEvent.bPrerolledSpawns then
                tEvent.bValidDockingData = false
            end
        else
            tEvent.bValidDockingData = false
        end
        return tEvent.bValidDockingData
    end
end


function DerelictEvent.tick(rController, dT, tPersistentState, tTransientState)
    Docking.spawnModule(tPersistentState)
    local wx,wy = g_World._getWorldFromTile(tPersistentState.tx, tPersistentState.ty)
    Base.eventOccurred(Base.EVENTS.EventAlert,{wx=wx,wy=wy,sLineCode="ALERTS032TEXT", tPersistentData=tPersistentState, nPriority = DerelictEvent.nAlertPriority})
    GameRules.nLastNewShip = GameRules.elapsedTime
    return true
end

return DerelictEvent
