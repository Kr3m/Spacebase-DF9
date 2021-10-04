local Class = require('Class')
local ImmigrationEvent = require('GameEvents.ImmigrationEvent')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local DockingEvent = Class.create(ImmigrationEvent)

local GameRules = require('GameRules')
local Docking = require('Docking')
local ModuleData = require('ModuleData')
local DFUtil = require('DFCommon.Util')
local GenericDialog = require('UI.GenericDialog')
local SoundManager = require('SoundManager')
local Portraits = require('UI.Portraits')
local AlertEntry = require('UI.AlertEntry')
local CharacterManager = require('CharacterManager')
local MiscUtil = require('MiscUtil')

DockingEvent.sEventType = 'friendlyDockingEvents'
DockingEvent.sAlertLC = 'ALERTS028TEXT'
DockingEvent.sFailureLC = 'ALERTS024TEXT'
DockingEvent.sDialogSet = 'dockingEvents'
DockingEvent.nDefaultWeight = 5.0
DockingEvent.nMinPopulation = 9
DockingEvent.nMaxPopulation = g_nPopulationCap
DockingEvent.nMinTime = 60*15
DockingEvent.nMaxTime = -1
DockingEvent.nMinUndiscoveredRooms = 2
DockingEvent.nMaxUndiscoveredRooms = -1
DockingEvent.nMinExteriorRooms = -1
DockingEvent.nMaxExteriorRooms = -1
DockingEvent.bHostile = false
DockingEvent.nChanceObey = 1.00
DockingEvent.nChanceHostile = 0.00
DockingEvent.sExpMod = 'population'
DockingEvent.bAllowKillbots = false
DockingEvent.bAttemptDock = true

DockingEvent.sAcceptedSuccessAlert='ALERTS029TEXT'

DockingEvent.nAllowedSetupFailures = 30

function DockingEvent.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
    Event.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
end

-- @param tEvent the upcoming event's persistent state
function DockingEvent.preExecuteSetup(rController, tEvent)
    Event.preExecuteSetup(rController, tEvent)

    local bPopcapFail = not tEvent.bHostile and CharacterManager.getOwnedCitizenPopulation() >= g_nPopulationCap
    if bPopcapFail or not tEvent.bClickedAlert then
        local rClass = rController.tEventClasses[tEvent.sEventType]
        local ignoreRefusal = false
        if math.random() > rClass.nChanceObey then
            ignoreRefusal = true
        end
        if ignoreRefusal or tEvent.bSkipDialog then
            -- nothing
        else
            AlertEntry.dOnClick:unregister(ImmigrationEvent.onAlertClick, tEvent)
            return false, ImmigrationEvent.sRejectionSuccessAlert
        end
    end

    -- check if the module data from onqueue is still valid
    if (tEvent.bValidDockingData and
        tEvent.bPrerolledSpawns and
        Docking.testModuleFitAtOffset(tEvent.sEventType,
                                      ModuleData[tEvent.sEventType][tEvent.sModuleEventName],
                                      tEvent.sSetName,
                                      tEvent.sModuleName,
                                      tEvent.tx, tEvent.ty)) then
        AlertEntry.dOnClick:unregister(ImmigrationEvent.onAlertClick, tEvent)
        return true
    else
        -- The module data isn't valid, so regenerate it
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

        AlertEntry.dOnClick:unregister(ImmigrationEvent.onAlertClick, tEvent)
        return tEvent.bValidDockingData
    end
end

function DockingEvent.tick(rController, dT, tCurrentEventPersistentState, tCurrentEventTransientState)
    local tPersistentState, tTransientState = tCurrentEventPersistentState, tCurrentEventTransientState

    if not tTransientState.bStarted then
        Event.pauseGame()
        tTransientState.bStarted=true
        tTransientState.tDialogStatus = {}
        return
    end

    if not tTransientState.bChoseDialog then
        if DockingEvent.dialogTick(rController, tPersistentState, tTransientState, dT) then
            tTransientState.bChoseDialog = true
        end
        return
    end

    -- bSpawn is set by dialogTick... kind of kludgey
    if tTransientState.bSpawn and not tTransientState.bSpawned then
        if not tTransientState.tCutscene then
            local tx,ty = tPersistentState.tDockingTile.x, tPersistentState.tDockingTile.y
            tTransientState.tCutscene = rController.initCameraMove(tx,ty)
            GameRules.startCutscene()
        end
        if rController.tickCamera(MOAISim.getStep(), tTransientState.tCutscene) then
            local wx,wy = g_World._getWorldFromTile(tPersistentState.tDockingTile.x, tPersistentState.tDockingTile.y,1)
            SoundManager.playSfx3D('derelictdocking',wx,wy,0)
            Docking.spawnModule(tPersistentState)
            tTransientState.bSpawned = true
        end
        return
    end
    GameRules.stopCutscene()
    GameRules.nLastNewShip = GameRules.elapsedTime
    Event.resumeGame()
    return true
end

function DockingEvent.dialogTick(rController, tPersistentEventState, tTransientEventState, dT)
    if tTransientEventState.bWaitingOnDialog then
        return
    end

    -- the initial dialog box has some branching logic for docking event
    -- vs immigration event, but after that just use the immigration event code
    if not tTransientEventState.tDialogStatus.tDlgSet then
        local rClass = rController.tEventClasses[tPersistentEventState.sEventType]
        local sHostility = 'ambiguous'
        if math.random() < rClass.nChanceHostile then
            sHostility = 'hostile'
        end
        tTransientEventState.tDialogStatus.tDlgSet = DFUtil.arrayRandom(EventData['dockingEvents'][sHostility])

        local tDlgSet = tTransientEventState.tDialogStatus.tDlgSet
        tTransientEventState.bWaitingOnDialog = true
        tTransientEventState.tDialogStatus.sPortrait = Portraits.getRandomPortrait()
        local function onDialogClick(bAccepted)
            tTransientEventState.bWaitingOnDialog = false
            tTransientEventState.bDialogAccepted = bAccepted
        end
        local rRequestUI = GenericDialog.new('UILayouts/DockingRequestLayout', onDialogClick, 'DockingButton')
        rRequestUI:setTemplateUITexture('Picture', tTransientEventState.tDialogStatus.sPortrait, Portraits.PORTRAIT_PATH)
        local tReplacements= {
            Title = tDlgSet.title,
            DockMessage = tDlgSet.request,
            DockingLabel = tDlgSet.acceptButton,
            DeclineLabel = tDlgSet.rejectButton
        }
        rRequestUI:replaceText(tReplacements)
        g_GuiManager.addToPopupQueue(rRequestUI, true)

        return
    end

    return ImmigrationEvent.dialogTick(rController, tPersistentEventState, tTransientEventState, dT)
end

return DockingEvent
