local Class = require('Class')
local Event = require('GameEvents.Event')
local EventData = require('GameEvents.EventData')
local MeteorEvent = Class.create(Event)

local Base = require('Base')
local DFMath = require('DFCommon.Math')
local Renderer = require('Renderer')
local GameRules = require('GameRules')
local Character = require('Character')
local Fire = require('Fire')
local Docking = require('Docking')
local Room = require('Room')
local Gui = require('UI.Gui')
local AnimatedSprite = require('AnimatedSprite')
local SoundManager = require('SoundManager')
local MiscUtil = require('MiscUtil')

MeteorEvent.sEventType = "meteorEvents"
MeteorEvent.sAlertLC = 'ALERTS026TEXT'
MeteorEvent.sFailureLC = 'ALERTS027TEXT'
MeteorEvent.METEOR_STRIKE_RADIUS=256*3
MeteorEvent.nDefaultWeight = 10.0
MeteorEvent.nMinPopulation = 4
MeteorEvent.nMaxPopulation = -1
MeteorEvent.nMinTime = 60*10
MeteorEvent.nMaxTime = -1
MeteorEvent.nMinUndiscoveredRooms = -1
MeteorEvent.nMaxUndiscoveredRooms = -1
MeteorEvent.nMinExteriorRooms = -1
MeteorEvent.nMaxExteriorRooms = -1
MeteorEvent.bHostile = false
MeteorEvent.nChanceObey = 0.00
MeteorEvent.nChanceHostile = 0.00
MeteorEvent.sExpMod = 'asteroids'
MeteorEvent.bAllowKillbots = false
MeteorEvent.bAttemptDock = false

function MeteorEvent.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
    Event.onQueue(rController, tUpcomingEventPersistentState, nPopulation, nElapsedTime)
end

function MeteorEvent.onAlertShown(rController, tUpcomingEventPersistentState)
    local tx, ty = g_World.getIndoorTarget(MeteorEvent.METEOR_STRIKE_RADIUS, true)
    tUpcomingEventPersistentState.tx, tUpcomingEventPersistentState.ty = tx, ty
    rController.showMeteorStrikeIndicator(tx, ty)
end

function MeteorEvent.tick(rController, dT, tCurrentEventPersistentState, tCurrentEventTransientState)
    local tPersistentState, tTransientState = tCurrentEventPersistentState, tCurrentEventTransientState

    local bDone = false

    if not tTransientState.bStarted then
        if not tPersistentState.tx then
            -- MTF TODO BIG HACK:
            -- The alert was sometimes not being shown, and we'd get a crash because that's where we determine the x and y.
            -- So for now I pretend the alert was shown.
            -- But really we should ensure it gets shown!
            -- Not sure on the repro. Might be loading a game with an inprogress strike.
            MeteorEvent.onAlertShown(rController, tPersistentState)
        end

        local tx,ty = tPersistentState.tx, tPersistentState.ty
        local wx,wy = g_World._getWorldFromTile(tx,ty)
        Base.eventOccurred(Base.EVENTS.EventAlert, {wx=wx,wy=wy,sLineCode="ALERTS033TEXT", tPersistentData=tPersistentState})

        local nDuration = tPersistentState.nDuration
        local nPeakIntensity = tPersistentState.nDuration * 0.65

        local nStartTime = GameRules.elapsedTime
        local nEndTime = GameRules.elapsedTime+nDuration

        -- hide visual indicator thingy
        rController.hideMeteorStrikeIndicator()

        tTransientState.tMeteors = {}

        SoundManager.playSfx("SFX/SFX/MeteorAppear")

        for i=1,nDuration do
            local nIntensity
            if i <= nPeakIntensity then
                nIntensity = i/nPeakIntensity
            else
                nIntensity = (nDuration-i+1)/(nDuration-nPeakIntensity+1)
            end
            nIntensity = nIntensity * nIntensity

            local nNumMeteors = 2+math.floor(nIntensity*3)
            for j=1,nNumMeteors do
                local nMeteorSize = (j==1 and nIntensity) or math.random()*nIntensity*.5
                local tMeteor = {}
                local wx,wy = MiscUtil.randomPointWithinRadius(wx,wy,MeteorEvent.METEOR_STRIKE_RADIUS)
                tx,ty = g_World._getTileFromWorld(wx,wy)
                tMeteor.tx = tx
                tMeteor.ty = ty
                tMeteor.wx,tMeteor.wy = g_World._getWorldFromTile(tMeteor.tx,tMeteor.ty)
                tMeteor.nSize = nMeteorSize
                tMeteor.scl = math.max(.1,nMeteorSize * .5)
                tMeteor.startWX,tMeteor.startWY = tMeteor.wx+700,tMeteor.wy+700
                tMeteor.passedWX,tMeteor.passedWY = tMeteor.wx-700,tMeteor.wy-700
                tMeteor.rMeteorSprite = AnimatedSprite.new(Renderer.getRenderLayer("WorldCeiling"), nil, "asteroid01_", {tSizeRange={tMeteor.scl,tMeteor.scl} })
                tMeteor.nStartTime=GameRules.elapsedTime + i-1+math.random()
                tMeteor.nDuration=DFMath.randomFloat(2.9,3.1)
                table.insert(tTransientState.tMeteors, tMeteor)
            end
        end

        tTransientState.farZ = g_World.getHackySortingZ(0,256)
        tTransientState.bStarted = true
    else
        bDone = true
        for i,t in ipairs(tTransientState.tMeteors) do
            if not t.bDone then bDone = false end

            if t.bDone then
            elseif not t.bStarted then
                if GameRules.elapsedTime > t.nStartTime then
                    t.rMeteorSprite:setLoc(t.startWX,t.startWY,tTransientState.farZ)
                    t.rMeteorSprite:play(true,-1)
                    t.rMeteorSprite:setColor(0,0,0,0)
                    t.bStarted = true
                end
            elseif t.bGoingAway then
                local nFraction = math.min(1, 2*(GameRules.elapsedTime-t.nStartTime-t.nDuration) / t.nDuration )
                local newX,newY = DFMath.lerp(t.wx, t.passedWX, nFraction),DFMath.lerp(t.wy, t.passedWY, nFraction)
                local nOpacity = math.min(1, 2*t.nDuration-GameRules.elapsedTime)
                t.rMeteorSprite:setColor(nOpacity,nOpacity,nOpacity,nOpacity)
                t.rMeteorSprite:setLoc(newX,newY,tTransientState.farZ)
                if nFraction == 1 then
                    t.bDone = true
                    t.rMeteorSprite:die()
                end
            else
                local nFraction = math.min(1, math.max(GameRules.elapsedTime-t.nStartTime,0) / t.nDuration )
                local nOpacity = nFraction
                t.rMeteorSprite:setColor(nOpacity,nOpacity,nOpacity,nOpacity)
                local newX,newY = DFMath.lerp(t.startWX, t.wx, nFraction),DFMath.lerp(t.startWY,t.wy, nFraction)
                t.rMeteorSprite:setLoc(newX,newY,tTransientState.farZ)
                if nFraction == 1 then
                    local tileVal = g_World._getTileValue(t.tx,t.ty,1)
                    if tileVal == g_World.logicalTiles.SPACE then
                        t.bGoingAway = true
                        t.rMeteorSprite:setLayer(Renderer.getRenderLayer("WorldFloor"))
                    else
                        t.bDone = true
                        t.rMeteorSprite:die()
                        SoundManager.playSfx("SFX/SFX/MeteorImpact",t.wx,t.wy)
                        local tDamage = {}

                        if t.nSize > .9 then
                            GameRules.startCameraShake(15,.2)
                        end
                        if t.nSize > .5 then
                            g_World.playExplosion(t.wx, t.wy)
                        end
                        tDamage.nDamageType = Character.DAMAGE_TYPE.Impact

                        local nDamage = g_World.TILE_STARTING_HIT_POINTS * t.nSize * .3
                        --[[
                            -- MTF TEMP HACK:
                            -- avoid causing breaches for now, until we fix breach repair AI.
                            local tHealth = g_World.getTileHealth(t.tx,t.ty)
                            if tHealth then
                            nDamage = math.max(0,math.min(math.floor(tHealth.nHitPoints*.75),nDamage))
                            end
                        ]]--
                        tDamage.nDamage = nDamage

                        local nResult = g_World.damageTile(t.tx,t.ty, 1, tDamage, true)
                        if nResult ~= g_World.logicalTiles.SPACE and t.nSize > .5 and math.random() < .25 then
                            Fire.startFire(g_World._getWorldFromTile(t.tx,t.ty))
                        end
                    end
                end
            end
        end
    end

    if bDone then
        return true
    end
end

function MeteorEvent.cleanup(rController)
    rController.hideMeteorStrikeIndicator()
end

function MeteorEvent.getModuleContentsDebugString(rController, tPersistentState)
    return string.format("Duration %.1f sec ", tPersistentState.nDuration)
end

return MeteorEvent
