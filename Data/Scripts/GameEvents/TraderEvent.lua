local Class = require('Class')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local ImmigrationEvent = require('GameEvents.ImmigrationEvent')
local TraderEvent = Class.create(ImmigrationEvent)

local GameRules = require('GameRules')

TraderEvent.sEventType = 'traderEvents'
TraderEvent.bSkipAlert = false
TraderEvent.sAlertLC = 'ALERTS028TEXT'
TraderEvent.sFailureLC = 'ALERTS024TEXT'
TraderEvent.sDialogSet = 'traderEvents'
TraderEvent.nDefaultWeight = 25.0
TraderEvent.nMinPopulation = 6
TraderEvent.nMaxPopulation = 6
TraderEvent.nMinTime = 60*12
TraderEvent.nMaxTime = -1
TraderEvent.nMinExteriorRooms = -1
TraderEvent.nMaxExteriorRooms = -1
TraderEvent.nMaxUndiscoveredRooms = -1

function  TraderEvent.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
	--print("traderEvent queued")
	ImmigrationEvent.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)

	tUpcomingEventPersistentState.bTrader = true

	TraderEvent._prerollTrader(rController, tUpcomingEventPersistentState)
end

function TraderEvent._prerollTrader( rController, tUpcomingEventPersistentState )
	tUpcomingEventPersistentState.tCharSpawnStats = require('EventController').rollRandomTrader()
	tUpcomingEventPersistentState.nNumSpawns = 1
end

return TraderEvent
