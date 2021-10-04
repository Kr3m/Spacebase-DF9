local Class = require('Class')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local DerelictEvent = require('GameEvents.DerelictEvent')
local HostileDerelictEvent = Class.create(DerelictEvent)

local Base = require('Base')
local GameRules = require('GameRules')
local Docking = require('Docking')
local Room = require('Room')
local Character = require('Character')
local CharacterManager = require('CharacterManager')
local MiscUtil = require('MiscUtil')

HostileDerelictEvent.sEventType = 'hostileDerelictEvents'
HostileDerelictEvent.nDefaultWeight = 10.0
HostileDerelictEvent.nMinPopulation = 12
HostileDerelictEvent.nMaxPopulation = -1
HostileDerelictEvent.nMinTime = 15*60
HostileDerelictEvent.nMaxTime = -1
HostileDerelictEvent.nMinUndiscoveredRooms = -1
HostileDerelictEvent.nMaxUndiscoveredRooms = 15
HostileDerelictEvent.nMinExteriorRooms = -1
HostileDerelictEvent.nMaxExteriorRooms = -1
HostileDerelictEvent.bHostile = true
HostileDerelictEvent.nChanceObey = 0.00
HostileDerelictEvent.nChanceHostile = 1.00
HostileDerelictEvent.sExpMod = 'population'
HostileDerelictEvent.bAllowKillbots = true

return HostileDerelictEvent
