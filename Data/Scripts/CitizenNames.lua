local DFUtil = require('DFCommon.Util')
local MiscUtil = require('MiscUtil')
local Character = require('CharacterConstants')
local CharacterManager = require('CharacterManager')

local CitizenNames = {

    tHumanFirstNames_Female = {
        "NAMESX001TEXT", "NAMESX002TEXT", "NAMESX003TEXT",
        "NAMESX004TEXT", "NAMESX005TEXT", "NAMESX006TEXT",
        "NAMESX007TEXT", "NAMESX008TEXT", "NAMESX009TEXT",
        "NAMESX010TEXT", "NAMESX011TEXT", "NAMESX012TEXT",
        "NAMESX013TEXT", "NAMESX014TEXT", "NAMESX015TEXT",
        "NAMESX016TEXT", "NAMESX017TEXT", "NAMESX018TEXT",
        "NAMESX019TEXT", "NAMESX020TEXT", "NAMESX021TEXT",
        "NAMESX138TEXT", "NAMESX141TEXT", "NAMESX142TEXT",
        "NAMESX143TEXT","NAMESX147TEXT", "NAMESX144TEXT",
        "NAMESX145TEXT", "NAMESX149TEXT", },

    tHumanFirstNames_Male = {
        "NAMESX022TEXT", "NAMESX023TEXT", "NAMESX024TEXT",
        "NAMESX025TEXT", "NAMESX026TEXT", "NAMESX027TEXT",
        "NAMESX028TEXT", "NAMESX029TEXT", "NAMESX030TEXT",
        "NAMESX031TEXT", "NAMESX032TEXT", "NAMESX033TEXT",
        "NAMESX034TEXT",
        "NAMESX035TEXT", "NAMESX036TEXT", "NAMESX037TEXT",
        "NAMESX038TEXT", "NAMESX039TEXT", "NAMESX040TEXT",
        "NAMESX041TEXT", "NAMESX042TEXT", "NAMESX043TEXT",
        "NAMESX044TEXT", "NAMESX045TEXT", "NAMESX046TEXT",
        "NAMESX047TEXT", "NAMESX048TEXT", "NAMESX049TEXT",
        "NAMESX050TEXT", "NAMESX051TEXT", "NAMESX052TEXT",
        "NAMESX053TEXT", "NAMESX054TEXT", "NAMESX055TEXT",
        "NAMESX056TEXT", "NAMESX057TEXT", "NAMESX058TEXT",
        "NAMESX059TEXT", "NAMESX060TEXT", "NAMESX061TEXT",
        "NAMESX062TEXT", "NAMESX063TEXT", "NAMESX064TEXT",
        "NAMESX065TEXT",
        "NAMESX066TEXT", "NAMESX067TEXT", "NAMESX068TEXT",
        "NAMESX069TEXT", "NAMESX070TEXT", "NAMESX071TEXT",
        "NAMESX072TEXT", "NAMESX073TEXT", "NAMESX118TEXT",
        "NAMESX139TEXT", "NAMESX140TEXT", "NAMESX146TEXT",
        "NAMESX148TEXT", "NAMESX150TEXT", "NAMESX151TEXT",
        "NAMESX152TEXT", },

    tHumanLastNames = {
        "NAMESX074TEXT", "NAMESX075TEXT", "NAMESX076TEXT",
        "NAMESX077TEXT", "NAMESX078TEXT", "NAMESX079TEXT",
        "NAMESX080TEXT", "NAMESX081TEXT", "NAMESX082TEXT",
        "NAMESX083TEXT", "NAMESX084TEXT", "NAMESX085TEXT",
        "NAMESX086TEXT", "NAMESX087TEXT", "NAMESX088TEXT",
        "NAMESX089TEXT", "NAMESX090TEXT", "NAMESX091TEXT",
        "NAMESX092TEXT", "NAMESX093TEXT", "NAMESX094TEXT",
        "NAMESX095TEXT", "NAMESX096TEXT", "NAMESX097TEXT",
        "NAMESX098TEXT", "NAMESX099TEXT", "NAMESX100TEXT",
        "NAMESX101TEXT", "NAMESX102TEXT", "NAMESX103TEXT",
        "NAMESX104TEXT", "NAMESX105TEXT", "NAMESX106TEXT",
        "NAMESX107TEXT", "NAMESX108TEXT", "NAMESX109TEXT",
        "NAMESX110TEXT", "NAMESX111TEXT", "NAMESX112TEXT",
        "NAMESX113TEXT", "NAMESX114TEXT", "NAMESX115TEXT",
        "NAMESX116TEXT", "NAMESX117TEXT", "NAMESX262TEXT",
        "NAMESX263TEXT", "NAMESX264TEXT", "NAMESX265TEXT",
        "NAMESX266TEXT", "NAMESX267TEXT", "NAMESX268TEXT",
        "NAMESX269TEXT", "NAMESX270TEXT", "NAMESX271TEXT",
        "NAMESX272TEXT", "NAMESX273TEXT", "NAMESX274TEXT",
        "NAMESX275TEXT", "NAMESX276TEXT", "NAMESX277TEXT",
        "NAMESX278TEXT", "NAMESX279TEXT", "NAMESX280TEXT",
        "NAMESX281TEXT", "NAMESX282TEXT", "NAMESX283TEXT",
        "NAMESX284TEXT", "NAMESX285TEXT", "NAMESX286TEXT",
        "NAMESX287TEXT", "NAMESX288TEXT", "NAMESX289TEXT",
        "NAMESX290TEXT", "NAMESX291TEXT", "NAMESX292TEXT",
        "NAMESX293TEXT", "NAMESX294TEXT", "NAMESX295TEXT",
        "NAMESX296TEXT", "NAMESX297TEXT", "NAMESX298TEXT",
        "NAMESX299TEXT", "NAMESX300TEXT", "NAMESX301TEXT",
        "NAMESX302TEXT", "NAMESX303TEXT", "NAMESX304TEXT",
    },

    tBirdSharkNames = {
        "NAMESX154TEXT", "NAMESX155TEXT", "NAMESX156TEXT",
        "NAMESX157TEXT", "NAMESX158TEXT", "NAMESX159TEXT",
        "NAMESX160TEXT", "NAMESX161TEXT", "NAMESX162TEXT",
        "NAMESX163TEXT", "NAMESX164TEXT", "NAMESX165TEXT",
        "NAMESX166TEXT", "NAMESX167TEXT", "NAMESX168TEXT",
        "NAMESX169TEXT", "NAMESX170TEXT", "NAMESX171TEXT",
    },

    tChickenNames_Female = {
        "NAMESX172TEXT", "NAMESX174TEXT", "NAMESX175TEXT",
        "NAMESX176TEXT", "NAMESX177TEXT", "NAMESX181TEXT",
        "NAMESX250TEXT",
    },

    tChickenNames_Male = {
        "NAMESX173TEXT", "NAMESX178TEXT", "NAMESX179TEXT",
        "NAMESX180TEXT", "NAMESX182TEXT", "NAMESX183TEXT",
        "NAMESX184TEXT",
    },

    tCatFirstNames_Male = {
        "NAMESX185TEXT", "NAMESX187TEXT", "NAMESX191TEXT",
        "NAMESX192TEXT", "NAMESX193TEXT", "NAMESX194TEXT",
        "NAMESX195TEXT", "NAMESX196TEXT", "NAMESX197TEXT",
        "NAMESX199TEXT", "NAMESX200TEXT",
    },

    tCatFirstNames_Female = {
        "NAMESX186TEXT", "NAMESX188TEXT", "NAMESX189TEXT",
        "NAMESX190TEXT", "NAMESX198TEXT", "NAMESX201TEXT",
        "NAMESX324TEXT", "NAMESX325TEXT", "NAMESX326TEXT",
    },

    tCatLastNames = {
        "NAMESX319TEXT", "NAMESX320TEXT", "NAMESX321TEXT",
        "NAMESX322TEXT", "NAMESX323TEXT",
    },

    tJellyFirstNames = {
        "NAMESX203TEXT", "NAMESX205TEXT", "NAMESX206TEXT",
        "NAMESX208TEXT", "NAMESX209TEXT", "NAMESX210TEXT",
        "NAMESX211TEXT", "NAMESX213TEXT", "NAMESX214TEXT",
        "NAMESX216TEXT", "NAMESX217TEXT",
    },

    tJellyLastNames = {
        "NAMESX202TEXT", "NAMESX204TEXT", "NAMESX207TEXT",
        "NAMESX212TEXT", "NAMESX215TEXT", "NAMESX218TEXT",
        "NAMESX219TEXT", "NAMESX220TEXT", "NAMESX221TEXT",
        "NAMESX316TEXT", "NAMESX317TEXT", "NAMESX318TEXT",
    },

    tShamonLastNames = {
        "NAMESX327TEXT", "NAMESX328TEXT", "NAMESX329TEXT",
        "NAMESX330TEXT", "NAMESX331TEXT", "NAMESX332TEXT",
        "NAMESX333TEXT", "NAMESX334TEXT", "NAMESX335TEXT",
        "NAMESX336TEXT", "NAMESX337TEXT", "NAMESX338TEXT",
        "NAMESX339TEXT",
    },

    tTobianNames = {
        "NAMESX246TEXT", "NAMESX247TEXT", "NAMESX248TEXT",
        "NAMESX249TEXT", "NAMESX251TEXT", "NAMESX252TEXT",
        "NAMESX305TEXT", "NAMESX306TEXT", "NAMESX307TEXT",
        "NAMESX308TEXT", "NAMESX309TEXT", "NAMESX310TEXT",
        "NAMESX311TEXT", "NAMESX312TEXT", "NAMESX313TEXT",
        "NAMESX314TEXT", "NAMESX315TEXT",
    },

    --
    -- easter egg names: don't bother with linecodes
    --
    tEasterEggNames_Female = {
        'Tamara', 'Annie', 'Taylor', 'Willow', 'Gemma', 'Riley', 'Ellen Ripley', 'Nyota U', 'River Song', 'Zoe Graystone', 'Astrid Farnsyworth', 'B-arb*arella', 'Starbuck', 'Donna Noble', 'Anastasia Dualla',
		'Echo', 'River Tam', '6', 'Trinity',
		},

    tEasterEggNames_Male = {
        'Bryce Harrington', 'knotted1', 'Skenners', 'Deeks', 'Andrew Hewson', 'Jack Jones', 'jaywjay03', 'cxsquared', 'Cody Claborn', 'Untrustedlife **Suspciously**', 'Michael Hamm',
        'Spirit', 'henkvdlaan', 'Henk Van Der Laan', 'Mike D', 'bigmikeit', 'Pavan Rikhi', 'lysergia', 'Dan Mattingley', 'Jimmedy',
        'Edwin Wiersma', 'Edwiersma', 'radian2pi', 'Greg Benzschawel',
    },

    tEasterEggNames_Other = {
        'Matth Flagg',
    },

}

function CitizenNames.testGenerateNames(race, sex, count)
    -- function for testing name generation
    local sRace = g_LM.line(Character.tRaceNames[race])
    Print(TT_Info, 'character name test dump: '..sex..' '..race)
    count = count or 50
    while count > 0 do
        count = count - 1
        Print(TT_Info, CitizenNames.getNewUniqueName(race, sex))
    end
end

function CitizenNames.getTobianName()
    local name = g_LM.line(DFUtil.arrayRandom(CitizenNames.tTobianNames))
    -- chance to also have a human surname, ie cultural "humanization"
    local nHumanizedChance = 0.2
    if math.random() <= nHumanizedChance then
        name = name .. ' ' .. g_LM.line(DFUtil.arrayRandom(CitizenNames.tHumanLastNames))
    end
    return name
end

function CitizenNames.getBirdSharkName(sex)
    local name = ''
    -- male iwo names encased in vowels (plumage)
    if sex == 'M' then
        name = DFUtil.arrayRandom({'u', 'o', 'i', 'oo', 'uu', 'ii'})
    end
    -- consonant, vowel, middle -> mirror
    name = name .. DFUtil.arrayRandom({'w', 'm', 'x', 'l', 'v', 'b', 'd'})
    name = name .. DFUtil.arrayRandom({'u', 'o', 'i'})
    local middle = DFUtil.arrayRandom({'X', 'W', 'Y', '8', '0', 'I', 'U', 'O'})
    local backhalf = name:reverse()
    if backhalf:find('b') then
        backhalf = backhalf:gsub('b', 'd')
    elseif backhalf:find('d') then
        backhalf = backhalf:gsub('d', 'b')
    end
    return string.format('%s%s%s', name, middle, backhalf)
end

function CitizenNames.getChickenName(sex)
    local tNameTable = CitizenNames.tChickenNames_Female
    if sex == 'M' then
        tNameTable = CitizenNames.tChickenNames_Male
    end
    local name = g_LM.line(DFUtil.arrayRandom(tNameTable))
    local number = string.format('%s', math.random(1, 99999))
    number = MiscUtil.padString(number, 7, false, '0')
    return string.format('%s %s', name, number)
end

function CitizenNames.getCatName(sex)
    local tNameTable
    local nHumanizedChance = 0.1
    if math.random() <= nHumanizedChance then
        if sex == 'F' then
            tNameTable = CitizenNames.tHumanFirstNames_Female
        elseif sex == 'M' then
            tNameTable = CitizenNames.tHumanFirstNames_Male
        end
    else
        if sex == 'F' then
            tNameTable = CitizenNames.tCatFirstNames_Female
        elseif sex == 'M' then
            tNameTable = CitizenNames.tCatFirstNames_Male
        end
    end
    local first = g_LM.line(DFUtil.arrayRandom(tNameTable))
    local last = g_LM.line(DFUtil.arrayRandom(CitizenNames.tCatLastNames))
    local number = math.random(10, 101)
    return string.format('%s %s %s', first, last, MiscUtil.toRoman(number))
end

function CitizenNames.getShamonName()
    local first = DFUtil.arrayRandom({'T','R','G','Z','C','K','M'})
    local last = g_LM.line(DFUtil.arrayRandom(CitizenNames.tShamonLastNames))
    return string.format('%s %s', first, last)
end

function CitizenNames.getJellyName()
    local first = g_LM.line(DFUtil.arrayRandom(CitizenNames.tJellyFirstNames))
    local nHumanizedChance = 0.05
    if math.random() <= nHumanizedChance then
        first = g_LM.line(DFUtil.arrayRandom(CitizenNames.tHumanFirstNames_Female))
    end
    local last = g_LM.line(DFUtil.arrayRandom(CitizenNames.tJellyLastNames))
    return string.format('%s **%s**', first, last)
end

function CitizenNames.getHumanName(sex)
    local thisName

    if sex == 'M' then
        thisName = g_LM.line(DFUtil.arrayRandom(CitizenNames.tHumanFirstNames_Male))
    elseif sex == 'F' then
        thisName = g_LM.line(DFUtil.arrayRandom(CitizenNames.tHumanFirstNames_Female))
    end
    thisName = thisName .. ' ' .. g_LM.line(DFUtil.arrayRandom(CitizenNames.tHumanLastNames))

    return thisName
end

function CitizenNames.getEasterEggName(race, sex)
    if race == Character.RACE_HUMAN then
        if sex == 'M' then
            return DFUtil.arrayRandom(CitizenNames.tEasterEggNames_Male)
        else
            return DFUtil.arrayRandom(CitizenNames.tEasterEggNames_Female)
        end
    else
        return DFUtil.arrayRandom(CitizenNames.tEasterEggNames_Other)
    end
end

function CitizenNames.getNewUniqueName(nRace, sSex)
    local sName = CitizenNames.getName(nRace, sSex)
    local function alreadyUsed(sNewName)
        local tChars = CharacterManager.getCharacters()
        for _,rChar in pairs(tChars) do
            if rChar.tStats.sName == sNewName then
                return true
            end
        end
        return false
    end
    while alreadyUsed(sName) do
        sName = CitizenNames.getName(nRace, sSex)
    end
    return sName
end

function CitizenNames.getName(race, sex)
    -- % chance to grab an easter egg name (team member or paid tier name)
    -- (we can bump this up as needed once/if people pay to have their name in the game)
    local nEasterEggChance = 0.1  -- 10% chance
    if math.random() <= nEasterEggChance then
        return CitizenNames.getEasterEggName(race, sex)
    else
        -- races with gendered names
        if race == Character.RACE_CHICKEN then
            return CitizenNames.getChickenName(sex)
        elseif race == Character.RACE_CAT then
            return CitizenNames.getCatName(sex)
        elseif race == Character.RACE_BIRDSHARK then
            return CitizenNames.getBirdSharkName(sex)
            -- shamon names are gender-neutral
        elseif race == Character.RACE_SHAMON then
            return CitizenNames.getShamonName()
            -- tobians are hermaphroditic
        elseif race == Character.RACE_TOBIAN then
            return CitizenNames.getTobianName()
            -- jellies are all female
        elseif race == Character.RACE_JELLY then
            return CitizenNames.getJellyName()
        elseif race == Character.RACE_KILLBOT then
            return "Kill Bot"
            -- human (or undefined)
        else
            return CitizenNames.getHumanName(sex)
        end
    end
end

return CitizenNames
