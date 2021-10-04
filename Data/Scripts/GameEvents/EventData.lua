------------------------------------------------------------------------
-- The contents of this file are subject to the Common Public
-- Attribution License Version 1.0. (the "License"); you may not use
-- this file except in compliance with this License.  You may obtain a
-- copy of the License from the COPYING file included in this code
-- base. The License is based on the Mozilla Public License Version 1.1,
-- but Sections 14 and 15 have been added to cover use of software over
-- a computer network and provide for limited attribution for the
-- Original Developer. In addition, Exhibit A has been modified to be
-- consistent with Exhibit B.
--
-- Software distributed under the License is distributed on an "AS IS"
-- basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
-- the License for the specific language governing rights and
-- limitations under the License.
--
-- The code in this file is the original work of Derelict Games,
-- authored by Bryce Harrington.
--
-- Copyright (c) 2015  Bryce Harrington <bryce@bryceharrington.org>
-- All Rights Reserved.
------------------------------------------------------------------------


local tEvents =
{
    CompoundEvent = {
        {
            -- Smuggler's Incorporated
            title='EVENT001TEXT01', request='EVENT001TEXT02',
            acceptButton='EVENT001TEXT03', rejectButton='EVENT001TEXT04',
            -- can't avoid final siege with dialog, just different responses
            acceptedResponse='EVENT001TEXT05', acceptedResponseButton='EVENT001TEXT06',
            rejectedResponse='EVENT001TEXT07', rejectedResponseButton='EVENT001TEXT06',
            screwYouResponse='EVENT001TEXT07', screwYouResponseButton='EVENT001TEXT06',
        },
        {
            title='EVENT022TEXT01', request='EVENT022TEXT02',
            acceptButton='EVENT022TEXT03', rejectButton='EVENT022TEXT04',
            -- can't avoid final siege with dialog, just different responses
            acceptedResponse='EVENT022TEXT05', acceptedResponseButton='EVENT022TEXT06',
            rejectedResponse='EVENT022TEXT07', rejectedResponseButton='EVENT022TEXT06',
            screwYouResponse='EVENT022TEXT07', screwYouResponseButton='EVENT022TEXT06',
        },
    },

    -- Brings 1-2 new crew members to the station unless population cap
    -- has been reached.  Occurs more frequently in early portion of the game.
    immigrationEvents = {
        {   -- kessel runner
           title='EVENT002TEXT01', request='EVENT002TEXT02',
           acceptButton='EVENT002TEXT03', rejectButton='EVENT002TEXT04',
           acceptedResponse='EVENT002TEXT05', acceptedResponseButton='EVENT002TEXT06',
           rejectedResponse='EVENT002TEXT07', rejectedResponseButton='EVENT002TEXT08',
           screwYouResponse='EVENT002TEXT09', screwYouResponseButton='EVENT002TEXT10',
        },
        {   -- lister
           title='EVENT003TEXT01', request='EVENT003TEXT02',
           acceptButton='EVENT003TEXT03', rejectButton='EVENT003TEXT04',
           acceptedResponse='EVENT003TEXT05', acceptedResponseButton='EVENT003TEXT06',
           rejectedResponse='EVENT003TEXT07', rejectedResponseButton='EVENT003TEXT08',
           screwYouResponse='EVENT003TEXT09', screwYouResponseButton='EVENT003TEXT10',
        },
        {   --holiday confusion
           title='EVENT004TEXT01', request='EVENT004TEXT02',
           acceptButton='EVENT004TEXT03', rejectButton='EVENT004TEXT04',
           acceptedResponse='EVENT004TEXT05', acceptedResponseButton='EVENT004TEXT06',
           rejectedResponse='EVENT004TEXT07', rejectedResponseButton='EVENT004TEXT08',
           screwYouResponse='EVENT004TEXT09', screwYouResponseButton='EVENT004TEXT10',
        },
        {   --Dark Side of the Moon
           title='EVENT005TEXT01', request='EVENT005TEXT02',
           acceptButton='EVENT005TEXT03', rejectButton='EVENT005TEXT04',
           acceptedResponse='EVENT005TEXT05', acceptedResponseButton='EVENT005TEXT06',
           rejectedResponse='EVENT005TEXT07', rejectedResponseButton='EVENT005TEXT08',
           screwYouResponse='EVENT005TEXT09', screwYouResponseButton='EVENT005TEXT10',
        },
        {   --Hitchhikers Guide to the galaxy reference
           title='EVENT006TEXT01', request='EVENT006TEXT02',
           acceptButton='EVENT006TEXT03', rejectButton='EVENT006TEXT04',
           acceptedResponse='EVENT006TEXT05', acceptedResponseButton='EVENT006TEXT06',
           rejectedResponse='EVENT006TEXT07', rejectedResponseButton='EVENT006TEXT08',
           screwYouResponse='EVENT006TEXT09', screwYouResponseButton='EVENT006TEXT10',
        },
        {   --Bad thing happened
            title='EVENT009TEXT01', request='EVENT009TEXT02',
            acceptButton='EVENT009TEXT03', rejectButton='EVENT009TEXT04',
            acceptedResponse='EVENT009TEXT05', acceptedResponseButton='EVENT009TEXT06',
            rejectedResponse='EVENT009TEXT07', rejectedResponseButton='EVENT009TEXT08',
            screwYouResponse='EVENT009TEXT09', screwYouResponseButton='EVENT009TEXT10',
        },
        {   -- anti-janitors
           title='EVENT021TEXT01', request='EVENT021TEXT02',
           acceptButton='EVENT021TEXT03', rejectButton='EVENT021TEXT04',
           acceptedResponse='EVENT021TEXT05', acceptedResponseButton='EVENT021TEXT06',
           rejectedResponse='EVENT021TEXT07', rejectedResponseButton='EVENT021TEXT08',
           screwYouResponse='EVENT021TEXT09', screwYouResponseButton='EVENT021TEXT10',
        },
        {  -- Grishnak escaped survivors
           title='EVENT023TEXT01', request='EVENT023TEXT02',
           acceptButton='EVENT023TEXT03', rejectButton='EVENT023TEXT04',
           acceptedResponse='EVENT023TEXT05', acceptedResponseButton='EVENT023TEXT06',
           rejectedResponse='EVENT023TEXT07', rejectedResponseButton='EVENT023TEXT08',
           screwYouResponse='EVENT023TEXT09', screwYouResponseButton='EVENT023TEXT10',
        },
        {  -- Grishnak: Defectors
           title='EVENT024TEXT01', request='EVENT024TEXT02',
           acceptButton='EVENT024TEXT03', rejectButton='EVENT024TEXT04',
           acceptedResponse='EVENT024TEXT05', acceptedResponseButton='EVENT024TEXT06',
           rejectedResponse='EVENT024TEXT07', rejectedResponseButton='EVENT024TEXT08',
           screwYouResponse='EVENT024TEXT09', screwYouResponseButton='EVENT024TEXT10',
        },
        {  -- Grishnak: Fleeing miners
           title='EVENT025TEXT01', request='EVENT025TEXT02',
           acceptButton='EVENT025TEXT03', rejectButton='EVENT025TEXT04',
           acceptedResponse='EVENT025TEXT05', acceptedResponseButton='EVENT025TEXT06',
           rejectedResponse='EVENT025TEXT07', rejectedResponseButton='EVENT025TEXT08',
           screwYouResponse='EVENT025TEXT09', screwYouResponseButton='EVENT025TEXT10',
        },
        {  -- Grishnak: Escape pod with battered victims
           title='EVENT026TEXT01', request='EVENT026TEXT02',
           acceptButton='EVENT026TEXT03', rejectButton='EVENT026TEXT04',
           acceptedResponse='EVENT026TEXT05', acceptedResponseButton='EVENT026TEXT06',
           rejectedResponse='EVENT026TEXT07', rejectedResponseButton='EVENT026TEXT08',
           screwYouResponse='EVENT026TEXT09', screwYouResponseButton='EVENT026TEXT10',
        },
        {  -- Grishnak: Abandoned slave ship
           title='EVENT027TEXT01', request='EVENT027TEXT02',
           acceptButton='EVENT027TEXT03', rejectButton='EVENT027TEXT04',
           acceptedResponse='EVENT027TEXT05', acceptedResponseButton='EVENT027TEXT06',
           rejectedResponse='EVENT027TEXT07', rejectedResponseButton='EVENT027TEXT08',
           screwYouResponse='EVENT027TEXT09', screwYouResponseButton='EVENT027TEXT10',
        },
        {  -- Grishnak: Old Colleague
           title='EVENT028TEXT01', request='EVENT028TEXT02',
           acceptButton='EVENT028TEXT03', rejectButton='EVENT028TEXT04',
           acceptedResponse='EVENT028TEXT05', acceptedResponseButton='EVENT028TEXT06',
           rejectedResponse='EVENT028TEXT07', rejectedResponseButton='EVENT028TEXT08',
           screwYouResponse='EVENT028TEXT09', screwYouResponseButton='EVENT028TEXT10',
        },
        {  -- Grishnak: Wreckage with near dead prisoners
           title='EVENT029TEXT01', request='EVENT029TEXT02',
           acceptButton='EVENT029TEXT03', rejectButton='EVENT029TEXT04',
           acceptedResponse='EVENT029TEXT05', acceptedResponseButton='EVENT029TEXT06',
           rejectedResponse='EVENT029TEXT07', rejectedResponseButton='EVENT029TEXT08',
           screwYouResponse='EVENT029TEXT09', screwYouResponseButton='EVENT029TEXT10',
        },
        {  -- Grishnak: Desperate workers
           title='EVENT030TEXT01', request='EVENT030TEXT02',
           acceptButton='EVENT030TEXT03', rejectButton='EVENT030TEXT04',
           acceptedResponse='EVENT030TEXT05', acceptedResponseButton='EVENT030TEXT06',
           rejectedResponse='EVENT030TEXT07', rejectedResponseButton='EVENT030TEXT08',
           screwYouResponse='EVENT030TEXT09', screwYouResponseButton='EVENT030TEXT10',
        },

        -- FIXME: Duplicate events to take the place of the dropped DF events
        {   --Dark Side of the Moon
           title='EVENT005TEXT01', request='EVENT005TEXT02',
           acceptButton='EVENT005TEXT03', rejectButton='EVENT005TEXT04',
           acceptedResponse='EVENT005TEXT05', acceptedResponseButton='EVENT005TEXT06',
           rejectedResponse='EVENT005TEXT07', rejectedResponseButton='EVENT005TEXT08',
           screwYouResponse='EVENT005TEXT09', screwYouResponseButton='EVENT005TEXT10',
        },
    },

    -- Ship drops off 1-2 raiders who attack crew and/or try to board station
    -- if the station has at least 6 crew members.
    hostileImmigrationEvents = {
        {   --hero trap.
           title='EVENT008TEXT01', request='EVENT008TEXT02',
           acceptButton='EVENT008TEXT03', rejectButton='EVENT008TEXT04',
           acceptedResponse='EVENT008TEXT05', acceptedResponseButton='EVENT008TEXT06',
           rejectedResponse='EVENT008TEXT07', rejectedResponseButton='EVENT008TEXT08',
           screwYouResponse='EVENT008TEXT09', screwYouResponseButton='EVENT008TEXT10',
        },
        {   --fifty shades.
           title='EVENT012TEXT01', request='EVENT012TEXT02',
           acceptButton='EVENT012TEXT03', rejectButton='EVENT012TEXT04',
           acceptedResponse='EVENT012TEXT05', acceptedResponseButton='EVENT012TEXT06',
           rejectedResponse='EVENT012TEXT07', rejectedResponseButton='EVENT012TEXT08',
           screwYouResponse='EVENT012TEXT09', screwYouResponseButton='EVENT012TEXT10',
        },
        {   --balls of.
           title='EVENT013TEXT01', request='EVENT013TEXT02',
           acceptButton='EVENT013TEXT03', rejectButton='EVENT013TEXT04',
           acceptedResponse='EVENT013TEXT05', acceptedResponseButton='EVENT013TEXT06',
           rejectedResponse='EVENT013TEXT07', rejectedResponseButton='EVENT013TEXT08',
           screwYouResponse='EVENT013TEXT09', screwYouResponseButton='EVENT013TEXT10',
        },
        {   --black hole.
           title='EVENT014TEXT01', request='EVENT014TEXT02',
           acceptButton='EVENT014TEXT03', rejectButton='EVENT014TEXT04',
           acceptedResponse='EVENT014TEXT05', acceptedResponseButton='EVENT014TEXT06',
           rejectedResponse='EVENT014TEXT07', rejectedResponseButton='EVENT014TEXT08',
           screwYouResponse='EVENT014TEXT09', screwYouResponseButton='EVENT014TEXT10',
        },

        {  -- Grishnak: You Are Intruders!
           title='EVENT031TEXT01', request='EVENT031TEXT02',
           acceptButton='EVENT031TEXT03', rejectButton='EVENT031TEXT04',
           acceptedResponse='EVENT031TEXT05', acceptedResponseButton='EVENT031TEXT06',
           rejectedResponse='EVENT031TEXT07', rejectedResponseButton='EVENT031TEXT08',
           screwYouResponse='EVENT031TEXT09', screwYouResponseButton='EVENT031TEXT10',
        },
        {  -- Grishnak: DEATH OR VICTORY
           title='EVENT032TEXT01', request='EVENT032TEXT02',
           acceptButton='EVENT032TEXT03', rejectButton='EVENT032TEXT04',
           acceptedResponse='EVENT032TEXT05', acceptedResponseButton='EVENT032TEXT06',
           rejectedResponse='EVENT032TEXT07', rejectedResponseButton='EVENT032TEXT08',
           screwYouResponse='EVENT032TEXT09', screwYouResponseButton='EVENT032TEXT10',
        },
        {  -- Grishnak: My Life For My Power
           title='EVENT033TEXT01', request='EVENT033TEXT02',
           acceptButton='EVENT033TEXT03', rejectButton='EVENT033TEXT04',
           acceptedResponse='EVENT033TEXT05', acceptedResponseButton='EVENT033TEXT06',
           rejectedResponse='EVENT033TEXT07', rejectedResponseButton='EVENT033TEXT08',
           screwYouResponse='EVENT033TEXT09', screwYouResponseButton='EVENT033TEXT10',
        },
        {  -- Grishnak: Die in Diaspora
           title='EVENT034TEXT01', request='EVENT034TEXT02',
           acceptButton='EVENT034TEXT03', rejectButton='EVENT034TEXT04',
           acceptedResponse='EVENT034TEXT05', acceptedResponseButton='EVENT034TEXT06',
           rejectedResponse='EVENT034TEXT07', rejectedResponseButton='EVENT034TEXT08',
           screwYouResponse='EVENT034TEXT09', screwYouResponseButton='EVENT034TEXT10',
        },
        {  -- Grishnak: Transmission from the General
           title='EVENT035TEXT01', request='EVENT035TEXT02',
           acceptButton='EVENT035TEXT03', rejectButton='EVENT035TEXT04',
           acceptedResponse='EVENT035TEXT05', acceptedResponseButton='EVENT035TEXT06',
           rejectedResponse='EVENT035TEXT07', rejectedResponseButton='EVENT035TEXT08',
           screwYouResponse='EVENT035TEXT09', screwYouResponseButton='EVENT035TEXT10',
        },
        {  -- Grishnak: Subversion of event 24
           title='EVENT040TEXT01', request='EVENT040TEXT02',
           acceptButton='EVENT040TEXT03', rejectButton='EVENT040TEXT04',
           acceptedResponse='EVENT040TEXT05', acceptedResponseButton='EVENT040TEXT06',
           rejectedResponse='EVENT040TEXT07', rejectedResponseButton='EVENT040TEXT08',
           screwYouResponse='EVENT040TEXT09', screwYouResponseButton='EVENT040TEXT10',
        },
        {  -- Grishnak: Subersion of event 30
           title='EVENT041TEXT01', request='EVENT041TEXT02',
           acceptButton='EVENT041TEXT03', rejectButton='EVENT041TEXT04',
           acceptedResponse='EVENT041TEXT05', acceptedResponseButton='EVENT041TEXT06',
           rejectedResponse='EVENT041TEXT07', rejectedResponseButton='EVENT041TEXT08',
           screwYouResponse='EVENT041TEXT09', screwYouResponseButton='EVENT041TEXT10',
        },
    },

    -- Attempts a dock a derelict to the station
    dockingEvents = {
        ambiguous={
            {
                -- banu
                title='EVENT018TEXT01', request='EVENT018TEXT02',
                acceptButton='EVENT018TEXT03', rejectButton='EVENT018TEXT04',
                acceptedResponse='EVENT018TEXT05', acceptedResponseButton='EVENT018TEXT06',
                rejectedResponse='EVENT018TEXT07', rejectedResponseButton='EVENT018TEXT08',
                screwYouResponse='EVENT018TEXT09', screwYouResponseButton='EVENT018TEXT10',
            },
            {
                -- notsure
                title='EVENT019TEXT01', request='EVENT019TEXT02',
                acceptButton='EVENT019TEXT03', rejectButton='EVENT019TEXT04',
                acceptedResponse='EVENT019TEXT05', acceptedResponseButton='EVENT019TEXT06',
                rejectedResponse='EVENT019TEXT07', rejectedResponseButton='EVENT019TEXT08',
                screwYouResponse='EVENT019TEXT09', screwYouResponseButton='EVENT019TEXT10',
            },
            {
                -- murke
                title='EVENT020TEXT01', request='EVENT020TEXT02',
                acceptButton='EVENT020TEXT03', rejectButton='EVENT020TEXT04',
                acceptedResponse='EVENT020TEXT05', acceptedResponseButton='EVENT020TEXT06',
                rejectedResponse='EVENT020TEXT07', rejectedResponseButton='EVENT020TEXT08',
                screwYouResponse='EVENT020TEXT09', screwYouResponseButton='EVENT020TEXT10',
            },
            {
                -- Grishnak superspace transmission
                title='EVENT036TEXT01', request='EVENT036TEXT02',
                acceptButton='EVENT036TEXT03', rejectButton='EVENT036TEXT04',
                acceptedResponse='EVENT036TEXT05', acceptedResponseButton='EVENT036TEXT06',
                rejectedResponse='EVENT036TEXT07', rejectedResponseButton='EVENT036TEXT08',
                screwYouResponse='EVENT036TEXT09', screwYouResponseButton='EVENT036TEXT10',
            },
        },
        hostile={
            {   --In the way of a hostile construction fleet
                title='EVENT007TEXT01', request='EVENT007TEXT02',
                acceptButton='EVENT007TEXT03', rejectButton='EVENT007TEXT04',
                acceptedResponse='EVENT007TEXT05', acceptedResponseButton='EVENT007TEXT06',
                rejectedResponse='EVENT007TEXT07', rejectedResponseButton='EVENT007TEXT08',
                screwYouResponse='EVENT007TEXT09', screwYouResponseButton='EVENT007TEXT10',
            },
            {   -- Unknown delivery for Mr. Mumble
                title='EVENT010TEXT01', request='EVENT010TEXT02',
                acceptButton='EVENT010TEXT03', rejectButton='EVENT010TEXT04',
                acceptedResponse='EVENT010TEXT05', acceptedResponseButton='EVENT010TEXT06',
                rejectedResponse='EVENT010TEXT07', rejectedResponseButton='EVENT010TEXT08',
                screwYouResponse='EVENT010TEXT09', screwYouResponseButton='EVENT010TEXT10',
            },
            {
                -- emlins
                title='EVENT015TEXT01', request='EVENT015TEXT02',
                acceptButton='EVENT015TEXT03', rejectButton='EVENT015TEXT04',
                acceptedResponse='EVENT015TEXT05', acceptedResponseButton='EVENT015TEXT06',
                rejectedResponse='EVENT015TEXT07', rejectedResponseButton='EVENT015TEXT08',
                screwYouResponse='EVENT015TEXT09', screwYouResponseButton='EVENT015TEXT10',
            },
            {
                -- pirates
                title='EVENT016TEXT01', request='EVENT016TEXT02',
                acceptButton='EVENT016TEXT03', rejectButton='EVENT016TEXT04',
                acceptedResponse='EVENT016TEXT05', acceptedResponseButton='EVENT016TEXT06',
                rejectedResponse='EVENT016TEXT07', rejectedResponseButton='EVENT016TEXT08',
                screwYouResponse='EVENT016TEXT09', screwYouResponseButton='EVENT016TEXT10',
            },
            {
                -- sheriff
                title='EVENT017TEXT01', request='EVENT017TEXT02',
                acceptButton='EVENT017TEXT03', rejectButton='EVENT017TEXT04',
                acceptedResponse='EVENT017TEXT05', acceptedResponseButton='EVENT017TEXT06',
                rejectedResponse='EVENT017TEXT07', rejectedResponseButton='EVENT017TEXT08',
                screwYouResponse='EVENT017TEXT09', screwYouResponseButton='EVENT017TEXT10',
            },
            {
                -- Grishnak: Red Grixyl Raider
                title='EVENT037TEXT01', request='EVENT037TEXT02',
                acceptButton='EVENT037TEXT03', rejectButton='EVENT037TEXT04',
                acceptedResponse='EVENT037TEXT05', acceptedResponseButton='EVENT037TEXT06',
                rejectedResponse='EVENT037TEXT07', rejectedResponseButton='EVENT037TEXT08',
                screwYouResponse='EVENT037TEXT09', screwYouResponseButton='EVENT037TEXT10',
            },
            {
                -- Grishnak: Hyde Skenner
                title='EVENT038TEXT01', request='EVENT038TEXT02',
                acceptButton='EVENT038TEXT03', rejectButton='EVENT038TEXT04',
                acceptedResponse='EVENT038TEXT05', acceptedResponseButton='EVENT038TEXT06',
                rejectedResponse='EVENT038TEXT07', rejectedResponseButton='EVENT038TEXT08',
                screwYouResponse='EVENT038TEXT09', screwYouResponseButton='EVENT038TEXT10',
            },
            {
                -- Grishnak: Collision course
                title='EVENT039TEXT01', request='EVENT039TEXT02',
                acceptButton='EVENT039TEXT03', rejectButton='EVENT039TEXT04',
                acceptedResponse='EVENT039TEXT05', acceptedResponseButton='EVENT039TEXT06',
                rejectedResponse='EVENT039TEXT07', rejectedResponseButton='EVENT039TEXT08',
                screwYouResponse='EVENT039TEXT09', screwYouResponseButton='EVENT039TEXT10',
            },
            {
                -- Grishnak: Subersion of event 29
                title='EVENT042TEXT01', request='EVENT042TEXT02',
                acceptButton='EVENT042TEXT03', rejectButton='EVENT042TEXT04',
                acceptedResponse='EVENT042TEXT05', acceptedResponseButton='EVENT042TEXT06',
                rejectedResponse='EVENT042TEXT07', rejectedResponseButton='EVENT042TEXT08',
                screwYouResponse='EVENT042TEXT09', screwYouResponseButton='EVENT042TEXT10',
            },
        },
        {
            -- lottery winner
            title='EVENT011TEXT01', request='EVENT011TEXT02',
            acceptButton='EVENT011TEXT03', rejectButton='EVENT011TEXT04',
            acceptedResponse='EVENT011TEXT05', acceptedResponseButton='EVENT011TEXT06',
            rejectedResponse='EVENT011TEXT07', rejectedResponseButton='EVENT011TEXT08',
            screwYouResponse='EVENT011TEXT09', screwYouResponseButton='EVENT011TEXT10',
        },
        {
            -- Diaspora resupply vessel
            title='EVENT037TEXT01', request='EVENT037TEXT02',
            acceptButton='EVENT037TEXT03', rejectButton='EVENT037TEXT04',
            acceptedResponse='EVENT037TEXT05', acceptedResponseButton='EVENT037TEXT06',
            rejectedResponse='EVENT037TEXT07', rejectedResponseButton='EVENT037TEXT08',
            screwYouResponse='EVENT037TEXT09', screwYouResponseButton='EVENT037TEXT10',
        },
    },

    -- Introduces a trader
    traderEvents = {
        {   -- vacuum trader
            title='TRADE001TEXT', request='TRADE002TEXT',
            acceptButton='TRADE003TEXT', rejectButton='TRADE004TEXT',
            acceptedResponse='TRADE005TEXT', acceptedResponseButton='TRADE006TEXT',
            rejectedResponse='TRADE007TEXT', rejectedResponseButton='TRADE008TEXT',
            screwYouResponse='TRADE009TEXT', screwYouResponseButton='TRADE010TEXT',
        },
    },
}

return tEvents
