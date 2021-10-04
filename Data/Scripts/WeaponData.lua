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
-- The Initial developer of the Original Code is Doublefine Productions Inc.
--
-- The initial developer of this file is Michael
-- Hamm of Derelict Games.

--
-- The code in this file is the original work of Derelict Games,
-- authored by Michael Hamm
--
-- Copyright (c) 2015  Michael Hamm <untrustedlife2@gmail.com>
-- All Rights Reserved.
------------------------------------------------------------------------


local Log=require('Log')
local Character=require('CharacterConstants')

--Consider adding shivs for prisoners to make, and perhaps let tantrumers have "pipes" or be given a random melee weapon.
--nPoints is a number representing how powerful a weapon is
local tWeaponList = {

    PunchingGloves=
        {
            sName='WEP01TEXT',
            sDesc='WEP02TEXT',
            Job=Character.EMERGENCY,
            bJobTool=true,
            bStuff=true,
            sStance = 'melee',
            nDamage=30,
            nRange=0,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Stunner,
            tPossibleTags={'Color','Style','Texture','Material'},
        },
    VibroKnife=
        {
            sName='WEP03TEXT',
            sDesc='WEP04TEXT',
            Job=Character.EMERGENCY,
            bJobTool=true,
            bStuff=true,
            sStance = 'melee',
            --for now knives are going to be damn terrifying
            nDamage=40,
            nRange=0,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Melee,
            nMeleeCoolDown=1,
            tPossibleTags={'Style','Texture','Material'},
        },
    Pistol=
        {
            sName='WEP33TEXT',
            sDesc='WEP34TEXT',

            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            bStuff=true,
            nDamage = 15,
            nRange=18,
            nPoints=1,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_PISTOL,
            tPossibleTags={'Style','Texture','Material'},
            tForcedTags={Color='Blue'},
        },
    --Showing  that it works, can rebalence other weapons later
    AutoPistol=
        {
            sName='WEP11TEXT',
            sDesc='WEP12TEXT',
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            bStuff=true,
            nDamage = 5,
            nRange=8,
            nPoints=2,
            nMaxCoolDown=.1,
            nMinCoolDown=.01,
            nMinAimTime=.05,
            nMaxAimTime=.1,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_PISTOL,
            tPossibleTags={'Style','Texture','Material'},
            tForcedTags={Color='Red'},
        },
    RedPistol =
        {
            sName='WEP05TEXT',
            sDesc='WEP06TEXT',

            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            nDamage = 20,
            nRange=15,
            nPoints=1,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_ENEMY_PISTOL,
            tPossibleTags={'Style','Texture','Material'},
            tForcedTags={Color='Red'},
        },
    KillbotRifle=
        {
            sName='WEP35TEXT',
            sDesc='WEP36TEXT',
            nPoints=4,
            bDisappearOnDrop=true,
            nDamage = 20,
            nRange=18,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_ENEMY_RIFLE,
        },
    LaserRifle=
        {
            sName='WEP37TEXT',
            sDesc='WEP38TEXT',

            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 30,
            nRange=18,
            nPoints=3,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
            tPossibleTags={'Style','Texture','Material'},
            tForcedTags={Color='Blue'},
        },
    RedLaserRifle=
        {
            sName='WEP07TEXT',
            sDesc='WEP08TEXT',

            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 30,
            nRange=18,
            nPoints=3,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_ENEMY_RIFLE,
            tPossibleTags={'Color','Style','Texture','Material'},
            tForcedTags={Color='Red'},
        },
    PlasmaRifle=
        {
            sName='WEP39TEXT',
            sDesc='WEP40TEXT',

            bStuff=true,
            Job=Character.EMERGENCY,
            tPossibleTags={'Color','Style','Texture','Material'},
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 45,
            nRange=18,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    --Will make into a placeable item at some point similar to the plasma rifle, no sprite yet though.
    SniperRifle=
        {
            sName='WEP09TEXT',
            sDesc='WEP10TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 50,
            nRange=30,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_ENEMY_RIFLE,
        },
    Stunner=
        {
            sName='WEP41TEXT',
            sDesc='WEP42TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'stunner',
            nDamage = 15,
            nRange=3,
            nPoints=1,
            nDamageType = Character.DAMAGE_TYPE.Stunner,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_PISTOL,
        },
    SuperStunner=
        {
            sName='WEP43TEXT',
            sDesc='WEP44TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'stunner',
            nDamage = 30,
            nRange=6,
            nPoints=3,
            nDamageType = Character.DAMAGE_TYPE.Stunner,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Nebuliser=
        {
            sName='WEP13TEXT',
            sDesc='WEP14TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            nDamage = 30,
            nRange=15,
            nPoints=3,
            nDamageType = Character.DAMAGE_TYPE.Fire,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Sling_of_Truth=
        {
            sName='WEP15TEXT',
            sDesc='WEP16TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            nDamage = 40,
            nRange=15,
            nMaxCoolDown=5,
            nMinCoolDown=1,
            nMinAimTime=1,
            nMaxAimTime=3,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Stunner,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Plasmatron=
        {
            sName='WEP17TEXT',
            sDesc='WEP18TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 30,
            nRange=10,
            nMaxCoolDown=3,
            nMinCoolDown=1,
            nMinAimTime=1,
            nMaxAimTime=3,
            nPoints=3,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Derezzer=
        {
            sName='WEP19TEXT',
            sDesc='WEP20TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 25,
            nRange=12,
            nPoints=2,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    CryoVise=
        {
            sName='WEP21TEXT',
            sDesc='WEP22TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'melee',
            nDamage = 25,
            nPoints=2,
            nRange=0,
            nDamageType = Character.DAMAGE_TYPE.Melee,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Rey5w0rd=
        {
            sName='WEP23TEXT',
            sDesc='WEP24TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'melee',
            nDamage = 40,
            nRange=3,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Impact,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    TeleMag44=
        {
            sName='WEP25TEXT',
            sDesc='WEP26TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'pistol',
            nDamage = 25,
            nRange=20,
            nMaxCoolDown=5,
            nMinCoolDown=1,
            nMinAimTime=.5,
            nMaxAimTime=1,
            nPoints=2,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Uberfist=
        {
            sName='WEP27TEXT',
            sDesc='WEP28TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'melee',
            nDamage = 15,
            nRange=0,
            nPoints=1,
            nDamageType = Character.DAMAGE_TYPE.Impact,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Schizodestroyer=
        {
            sName='WEP29TEXT',
            sDesc='WEP30TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'rifle',
            nDamage = 20,
            nRange=10,
            nPoints=2,
            nDamageType = Character.DAMAGE_TYPE.Stunner,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
    Sonicdirk=
        {
            sName='WEP31TEXT',
            sDesc='WEP32TEXT',
            tPossibleTags={'Color','Style','Texture','Material'},
            bStuff=true,
            Job=Character.EMERGENCY,
            bJobTool=true,
            sStance = 'melee',
            nDamage = 30,
            nRange=4,
            nPoints=4,
            nDamageType = Character.DAMAGE_TYPE.Laser,
            sBulletSprite=Character.SPRITE_NAME_FRIENDLY_RIFLE,
        },
}
return tWeaponList
