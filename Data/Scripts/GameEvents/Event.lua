local Class = require('Class')
local Event = Class.create(nil)
local EventData = require('GameEvents.EventData')
local CharacterManager = require('CharacterManager')
local Character = require('Character')
local GameRules = require('GameRules')
local ModuleData = require('ModuleData')
local MaladyData = require('NewMaladyData')
local Base = require('Base')
local Portraits = require('UI.Portraits')
local Malady = require('Malady')
local MiscUtil = require('MiscUtil')
local DFMath = require('DFCommon.Math')
local DFUtil = require('DFCommon.Util')

-- TODO make DockingEvent subclass
local Docking = require('Docking')
local Room = require('Room')

Event.nMinPopulation = 0
Event.nMaxPopulation = -1
Event.nMinTime = 0
Event.nMaxTime = -1
Event.nMinUndiscoveredRooms = -1
Event.nMaxUndiscoveredRooms = -1
Event.nMinExteriorRooms = -1
Event.nMaxExteriorRooms = -1

Event.nAllowedSetupFailures = 30

Event.nDebugLineLength = 40

-- Chance of a newly spawned character having a disease, out of 100
Event.nChanceOfMalady = 15
-- if a new strain is discovered, the probability that it requires research.
Event.PROBABILITY_REQUIRES_RESEARCH = .66
-- affliction probabilities are used in a MiscUtil.weightedRandom
-- new strain probabilities are used as out of 100
Event.tMaladyProbabilities = MaladyData

Event.nAlertPriority = 1
Event.nDefaultWeight = 5

function Event._getExpMod(sMod)
    -- map 0-1 hostility to .5 to 2x, where 0.5 hostility = 1x.
    local tLandingZone = GameRules.getLandingZone()
    local nSpawnLocModifier = MiscUtil.getGalaxyMapValue(tLandingZone.x,tLandingZone.y,sMod)
    nSpawnLocModifier = 2*nSpawnLocModifier
    nSpawnLocModifier = 2^nSpawnLocModifier
    nSpawnLocModifier = .5*nSpawnLocModifier
    return nSpawnLocModifier
end

function Event.getHostilityMod(bHostile)
    local nMod = Event._getExpMod('hostility')
    if not bHostile then nMod = 1/nMod end
    return nMod
end

function Event.spawnsCharacters()
    return false, 0
end

-- Weighting for this event type
-- we pipe in these two arguments because we are likely generating a weight
-- for a future event.
function Event.getWeight(nPopulation, nElapsedTime)
    return Event.nDefaultWeight
end

--- Handler for when event is queued.
-- Called when the event is placed on the event queue. E.g. turn on meteor indicator
-- @param rController the event controller
-- @param tEvent upcoming event's persistent state
-- @param nPopulation number of crew members at time of the event
-- @param nElapsedTime length of time since start of the game
function Event.onQueue(rController, tEvent, nPopulation, nElapsedTime)
    local rClass = rController.tEventClasses[tEvent.sEventType]
    local nTime = nElapsedTime or GameRules.elapsedTime or 0

    -- Select the exact event instance
    tEvent.tEventData = {}
    tPossibleEvents = EventData[tEvent.sEventType]
    if tPossibleEvents then
        tEvent.tEventData = DFUtil.arrayRandom(tPossibleEvents)
    end

    -- Set event properties using per-event overrides, class settings, or defaults
    tEvent.nTargetTime = nElapsedTime
    tEvent.bHostile = rClass.bHostile or false
    tEvent.nNumMaladies = 0

    tEvent.nDifficulty             = tEvent.tEventData.nDifficulty             or Event.getDifficulty(nElapsedTime, nPopulation)
    tEvent.bAllowKillbots          = tEvent.tEventData.bAllowKillbots          or rClass.bAllowKillbots or false
    tEvent.tNumSpawnsRange         = tEvent.tEventData.tNumSpawnsRange         or rClass.tNumSpawnsRange or nil
    tEvent.sPortrait               = tEvent.tEventData.sPortraitName           or Portraits.getRandomPortrait()
    tEvent.sMaladyType             = tEvent.tEventData.sMaladyType             or rClass.sMaladyType or nil
    tEvent.nChanceOfMalady         = tEvent.tEventData.nChanceOfMalady         or rClass.nChanceOfMalady or 0
    tEvent.nChanceOfNewStrain      = tEvent.tEventData.nChanceOfNewStrain      or rClass.nChanceOfNewStrain or -1
    tEvent.nChanceOfStrainResearch = tEvent.tEventData.nChanceOfStrainResearch or 100*Event.PROBABILITY_REQUIRES_RESEARCH
    tEvent.nStrainResearchTime     = tEvent.tEventData.nStrainResearchTime     or 1200*tEvent.nDifficulty

    -- Nerf strain research early in game or if difficulty set low
    if nTime < 15 * 60 or tEvent.nDifficulty < 0.15 then
        -- TODO: Is better to handle to handle this as an event prerequisite?
        tEvent.nChanceOfStrainResearch = 0
    end

    -- Meteor storm
    tEvent.nDuration = 12 + ((DFMath.randomFloat(0, 2) + 6) * tEvent.nDifficulty)

    -- Spawn immigrants
    tEvent.nNumSpawns = 0
    if tEvent.tNumSpawnsRange then
        local tRange = {-1,-1}
        tRange = rClass.tNumSpawnsRange
        if tRange[1] < 0 or tRange[2] < 1 then
            tEvent.nNumSpawns = 0
        else
            tEvent.nNumSpawns = math.random(tRange[1], tRange[2])
        end
        print("Spawning ", tEvent.nNumSpawns, " characters for event")
    end

    -- Raiders
    if tEvent.bHostile then
        tEvent.tCharSpawnStats = require('EventController').rollRandomRaiders(tEvent.nDifficulty, tEvent.bAllowKillbots)
        tEvent.nNumSpawns = #tEvent.tCharSpawnStats
    end

    -- Determine if any immigrants or raiders have maladies
    if tEvent.nNumSpawns and tEvent.nNumSpawns > 0 then
        for i=1,tEvent.nNumSpawns do
            if math.random(0,100) <= tEvent.nChanceOfMalady then
                tEvent.nNumMaladies = tEvent.nNumMaladies + 1
            end
        end
    end

    -- Docking
    if rClass.bAttemptDock then
        -- TODO: At this point only generate the ship, don't place it.
        --       Leave actual x,y placement and bridge creation until preExecuteSetup

        tEvent.bValidDockingData = false
        local tDockingData = Docking.attemptQueueEvent(
            tEvent.sEventType,
            tEvent.nDifficulty)

        if tDockingData then
            for k, v in pairs(tDockingData) do
                tEvent[k] = v
            end
            if not tEvent.bPrerolledSpawns then
                -- Preroll crew and objects if applicable.
                local tModule = Docking.getModule(tEvent.sSetName,tEvent.sModuleName)
                if tModule.tCrewSpawns then
                    tEvent.tCrewData = Event.spawnModuleCrew(tModule, tEvent.nDifficulty, tEvent.nChanceOfMalady)
                end
                if tModule.tObjectSpawns then
                    tEvent.tObjectData = Event.spawnModuleObjects(tModule)
                end
                tEvent.bPrerolledSpawns = true
                tEvent.bValidDockingData = true

                -- Force malady generation
                -- TODO: Only do this if any spawns actually have maladies
                tEvent.nNumMaladies = 1
            end
        end
    end

    -- Generate a malady if needed
    if tEvent.nNumMaladies > 0 then
        local sMaladyType = tEvent.sMaladyType or Event.randomMaladyType()
        local tMalady = Event.tMaladyProbabilities[sMaladyType]

        -- Determine if we should create a new strain
        local bMakeNewStrain = false
        if tMalady.nChanceOfNewStrain == 100 then
            bMakeNewStrain = true
        elseif tMalady.nChanceOfNewStrain > 0 and tEvent.nChanceOfNewStrain > 0 then
            local chance = math.max(tMalady.nChanceOfNewStrain, tEvent.nChanceOfNewStrain)
            bMakeNewStrain = math.random(1,100) <= chance
        end

        -- Determine if new strain requires research
        local bRequireResearch = false
        if bMakeNewStrain then
            bRequireResearch = math.random(1,100) < tEvent.nChanceOfStrainResearch
        end

        -- Determine how much research the new strain requires
        local nResearchTime = nil
        if bRequireResearch then
            nResearchTime = tEvent.nStrainResearchTime
        end

        tEvent.tPrerolledMalady = Malady.createNewMaladyInstance(sMaladyType, not bMakeNewStrain, bRequireResearch, nResearchTime)
        -- TODO: We should actually apply the maladies to crew members at this point
    end
end

function Event.getDifficulty(nOptionalTime,nOptionalPopulation)
    if not nOptionalTime then nOptionalTime = GameRules.elapsedTime end
    if not nOptionalPopulation then nOptionalPopulation = CharacterManager.getOwnedCitizenPopulation() end
    nOptionalTime = math.min(nOptionalTime, g_EventController.nMaxPlaytime)
    nOptionalPopulation = math.min(nOptionalPopulation, g_nPopulationCap)

    -- TODO weight these two attributes.
    -- I am guessing time should affect difficulty the most
    local nTimeWeight = 0.75
    local nPopulationWeight = 1.0 - nTimeWeight
    -- Where on the difficulty curve are we
    local x = ((nOptionalTime / g_EventController.nMaxPlaytime) * nTimeWeight) + ((nOptionalPopulation / g_nPopulationCap) * nPopulationWeight)
    -- this should be in [0,1], but just in case
    x = math.min(1.0, math.max(0.0, x))

    return x
end

--- Called when the alert for this event is displayed.
-- Note not all events have alerts.
-- Note event is not executing yet, it is still in queue.
function Event.onAlertShown(rController, tUpcomingEventPersistentState)
end

--- Called when the event is about to be popped off the queue and executed for the first time.
-- @returns true if the event should go forward with execution, false to discard it.
function Event.preExecuteSetup(rController, tUpcomingEventPersistentState)
    return true
end

--- Called during event execution.
-- @returns true when event is completed.
function Event.tick(rController, dT, tCurrentEventPersistentState, tCurrentEventTransientState)
    assertdev(false)
end

function Event.cleanup(rController)
end

--- Attempts to get a tile of open space that is relatively near the base.
-- !!NOT guaranteed to be an open space tile. We attempt nAttempt tries!!
-- @returns x,y coordinate of open space
function Event._getTileInOpenSpace(nAttempts)
    nAttempts = nAttempts or 5

    -- Grab exterior room, and trace out into space a certain distance.
    -- If you can't get an exterior room, choose a random direction
    -- from a random room
    local tExteriorRooms = {}
    local tRooms = Room.getRoomsOfTeam(Character.TEAM_ID_PLAYER)
    for room,id in pairs(tRooms) do
        if room.bExterior and not room:isDangerous() then
            table.insert(tExteriorRooms, room)
        end
    end
    local rRoomToTraceFrom = nil
    local tTileToTraceFrom = nil
    local nEmptySpaceDirection = nil
    local nMaxTraceDist = 20
    if #tExteriorRooms > 0 then
        rRoomToTraceFrom = DFUtil.arrayRandom(tExteriorRooms)
        local nExteriorTiles = DFUtil.tableSize(rRoomToTraceFrom.tExteriors)
        tTileToTraceFrom = DFUtil.tableRandom(rRoomToTraceFrom.tExteriors, nExteriorTiles)
        if not tTileToTraceFrom then return end
        nEmptySpaceDirection = g_World.getOppositeDirection(tTileToTraceFrom.nRoomDirection)
    else
        -- not an exterior room, but we can select a random room and
        -- trace from a border tile in the room
        local nRooms = DFUtil.tableSize(tRooms)
        _, rRoomToTraceFrom = DFUtil.tableRandom(tRooms, nRooms)
        if rRoomToTraceFrom then
            local nBorderTiles = DFUtil.tableSize(rRoomToTraceFrom.tExteriors)
            tTileToTraceFrom = DFUtil.tableRandom(rRoomToTraceFrom.tBorders, nBorderTiles)
            if not tTileToTraceFrom then return end
            nEmptySpaceDirection = g_World.getOppositeDirection(tTileToTraceFrom.nRoomDirection)
            -- trace farther out into space to be safe
            nMaxTraceDist = 30
        end
    end

    if not tTileToTraceFrom then return end

    -- trace out into space (hopefully)
    local tx, ty = tTileToTraceFrom.x, tTileToTraceFrom.y
    for nAttempt = 1, nAttempts do
        local nDist = math.random(15, nMaxTraceDist)
        for i = 1, nDist do
            tx, ty = g_World._getAdjacentTile(tx, ty, nEmptySpaceDirection)
        end
        tx, ty = g_World.clampTileToBounds(tx, ty)

        -- if we got an open tile of space, stop and return what we have
        if g_World._getTileValue(tx, ty, 1) == g_World.logicalTiles.SPACE then
            break
        else
            -- we're going to try this again! Try tracing out a little farther
            nMaxTraceDist = nMaxTraceDist + 5
            -- if not tracing from an exterior room, try a different direction as well
            if #tExteriorRooms == 0 then
                nEmptySpaceDirection = math.random(2, 9)
            end
        end
    end

    return tx, ty
end

function Event._getRandomDatacubeResearch()
    local tOptions,nOptions = Base.getAvailableDiscoveries()
    if nOptions == 0 then
        tOptions,nOptions = Base.getAvailableResearch()
    end
    if nOptions > 0 then
        return MiscUtil.randomKey(tOptions)
    end
end

function Event.getChallengeLevel(nOptionalDifficulty)
    if not nOptionalDifficulty then nOptionalDifficulty = Event.getDifficulty() end
    local nChallenge = math.min(1, math.max(0, nOptionalDifficulty - 0.15 + (math.random(0,30)/100.0)))
    return nChallenge
end

function Event.spawnModuleCrew(tModule, nDifficulty, nChanceOfMalady)
    local tPrerolledCrew = {}
    for sLocName, tSpawnOptions in pairs(tModule.tCrewSpawns) do
        local spawnName = MiscUtil.weightedRandom(tSpawnOptions)
        if ModuleData.characterSpawns[spawnName] then
            tPrerolledCrew[sLocName] = DFUtil.deepCopy(ModuleData.characterSpawns[spawnName])
            tPrerolledCrew[sLocName].sSpawnName = spawnName

            -- if raider, pre-roll how difficult they are ie rifle?
            if tPrerolledCrew[sLocName].tStats and tPrerolledCrew[sLocName].tStats.nRace == Character.RACE_RAIDER then
                tPrerolledCrew[sLocName].tStats.nChallengeLevel = Event.getChallengeLevel(nDifficulty)
            end

            -- preroll if they will have a malady
            tPrerolledCrew[sLocName].bSpawnWithMalady = math.random(0,100) <= nChanceOfMalady
        end
    end
    return tPrerolledCrew
end

function Event.spawnModuleObjects(tModule)
    local tPrerolledObjects = {}
    for sLocName, tSpawnOptions in pairs(tModule.tObjectSpawns) do
        local spawnName = MiscUtil.weightedRandom(tSpawnOptions)
        if ModuleData.objectSpawns[spawnName] then
            local sResearchData = nil
            local sTemplate = ModuleData.objectSpawns[spawnName].sTemplate
            if sTemplate == 'ResearchDatacube' then
                sResearchData = Event._getRandomDatacubeResearch()
            end
            -- if no new research is found, we don't spawn it.
            if sTemplate ~= 'ResearchDatacube' or sResearchData ~= nil then
                tPrerolledObjects[sLocName] = ModuleData.objectSpawns[spawnName]
                tPrerolledObjects[sLocName].sSpawnName = spawnName
                if sResearchData then
                    if not tPrerolledObjects[sLocName].tSaveData then
                        tPrerolledObjects[sLocName].tSaveData = {}
                    end
                    tPrerolledObjects[sLocName].tSaveData.sResearchData = sResearchData
                    tPrerolledObjects[sLocName].tSaveData.bHasResearchData = true
                    local sFriendlyName = Base.getResearchName(sResearchData)
                    if sFriendlyName then
                        tPrerolledObjects[sLocName].tSaveData.sDesc = g_LM.line('PROPSX071TEXT') .. sFriendlyName
                    end
                end
            end
        end
    end
    return tPrerolledObjects
end

function Event.randomMaladyType()
    local tChoices = {}
    for sName, tData in pairs(Event.tMaladyProbabilities) do
        if tData.nChanceOfAffliction then
            tChoices[sName] = tData.nChanceOfAffliction or 0
        end
    end
    return MiscUtil.weightedRandom(tChoices)
end

function Event.getModuleContentsDebugString(rController, tPersistentState)
    local s = ""
    local s2 = nil

    if tPersistentState.bValidDockingData and tPersistentState.bPrerolledSpawns then
        if tPersistentState.tCrewData then
            local tCrewTypes = {}
            local nNumSick = 0
            for sLoc, tData in pairs(tPersistentState.tCrewData) do
                local sName = tData.sSpawnName
                if tData.bSpawnWithMalady then
                    nNumSick = nNumSick+1
                end
                if not tCrewTypes[sName] then
                    tCrewTypes[sName] = 1
                else
                    tCrewTypes[sName] = tCrewTypes[sName] + 1
                end
            end
            local cs = ""
            for sCrewType, nNum in pairs(tCrewTypes) do
                if #sCrewType > 6 then
                    sCrewType = string.sub(sCrewType, 1, 6)
                end
                cs = cs .. tostring(nNum) .. " " .. sCrewType .. ", "
            end
            cs = string.sub(cs, 1, #cs - 2)
            s = s .. cs
            if nNumSick > 0 and tPersistentState.tPrerolledMalady then
                s2 = Event.getMaladyDebugString(tPersistentState, nNumSick)
            elseif nNumSick > 0 then
                s2 = 'ERROR: NO GENERATED MALADY'
            end
        end
        if tPersistentState.tObjectData then
            local tObjTypes = {}
            local nNumSick = 0
            for sLoc, tData in pairs(tPersistentState.tObjectData) do
                local sName = tData.sSpawnName
                if not tObjTypes[sName] then
                    tObjTypes[sName] = 1
                else
                    tObjTypes[sName] = tObjTypes[sName] + 1
                end

                -- Objects with maladies.
                if tData.bSpawnWithMalady then
                    nNumSick = nNumSick + 1
                end
            end
            local obs = ""
            for sObjType, nNum in pairs(tObjTypes) do
                if #sObjType > 5 then
                    sObjType = string.sub(sObjType, 1, 5)
                end
                obs = obs .. tostring(nNum) .. " " .. sObjType .. ", "
            end
            obs = string.sub(obs, 1, #obs - 2)
            if #s > 0 then
                s = s .. "; "
            end
            s = s .. obs
            if nNumSick > 0 and tPersistentState.tPrerolledMalady then
                if s2 then s2 = s2..'\n' else s2 = '' end
                s2 = s2.."ObjectMaladies: " .. Event.getMaladyDebugString(tPersistentState, nNumSick)
            elseif nNumSick > 0 then
                if s2 then s2 = s2..'\n' else s2 = '' end
                s2 = s2..'ERROR: NO GENERATED MALADY'
            end
        end
    elseif tPersistentState.nNumSpawns then
        local sType = "Friend"
        if tPersistentState.bHostile then
            sType = "Raider"
        end
        s = s .. string.format("%d %s", tPersistentState.nNumSpawns, sType)
        if tPersistentState.nNumMaladies then
            if tPersistentState.nNumMaladies > 0 and tPersistentState.tPrerolledMalady then
                s2 = Event.getMaladyDebugString(tPersistentState, tPersistentState.nNumMaladies)
            elseif tPersistentState.nNumMaladies > 0 then
                s2 = 'ERROR: NO GENERATED MALADY'
            end
        end
    else
        s = "<no module data>"
    end
    return s .. " ", s2
end

function Event.getMaladyDebugString(tPersistentState, n)
    local s2 = string.format("{ %d /w %s ", n, tPersistentState.tPrerolledMalady.sMaladyName)
    local sStrainName = tPersistentState.tPrerolledMalady.sMaladyName
    if Malady.tS.tResearch[sStrainName] then
        local nResearchTime = Malady.tS.tResearch[sStrainName].nResearchCure - Malady.tS.tResearch[sStrainName].nCureProgress
        s2 = s2 .. string.format("rsrch %d }", nResearchTime)
    else
        s2 = s2 .. "no rsrch }"
    end
    return s2
end

function Event.getDebugString(rController, tPersistentState, tTransientState)
    local s = ""
    if tPersistentState then
        local n = tPersistentState.nStartTime - GameRules.elapsedTime
        local name = string.gsub(tPersistentState.sEventType, "Events", "")
        name = string.sub(name, 1, math.min(#name, 11))
        name = MiscUtil.padString(name, 11, true)
        local sModuleInfo1, sModuleInfo2 = rController.tEventClasses[tPersistentState.sEventType].getModuleContentsDebugString(rController, tPersistentState)
        s = string.format("%s [%1.2f] %s", name, tPersistentState.nDifficulty, sModuleInfo1)
                s = MiscUtil.padString(s, Event.nDebugLineLength, true)
                s = s .. MiscUtil.formatTime(n)
        if sModuleInfo2 then
            s = s .. string.format("\n    %s", sModuleInfo2)
        end
    end
    return s
end

--- Pauses the game.
function Event.pauseGame()
    GameRules.timePause()
end

--- Resumes the game.
function Event.resumeGame()
    if GameRules.getTimeScale() == 0 then
        GameRules.setTimeScale(1)
    end
end

return Event
