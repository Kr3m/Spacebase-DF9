local Gui = require('UI.Gui')

local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }

return
    {
        posInfo =
            {
                alignX = 'center',
                alignY = 'center',
                offsetX = 0,
                offsetY = 0,
                scale = { 1, 1 },
            },
        tElements =
            {
                {
                    key = 'Background',
                    type = 'onePixel',
                    pos = { -777, 641 },
                    scale = { 2568, 1444 },
                    color = { 0, 0, 0, 0.83 },
                    hidden = false,
                },
                {
                    key = 'Logo',
                    type = 'uiTexture',
                    textureName = 'logo',
                    sSpritesheetPath = 'UI/StartMenu',
                    pos = { -1920/2, 1152/2 + 50 },
                    scale = { 1.5, 1.5 },
                    color = Gui.WHITE,
                    hidden = false,
                },
                {
                    key = 'SliderMusic',
                    type = 'slider',
                    pos = { 25, 100 },
                    configKey = "music_volume",
                },
                {
                    key = 'MusicText',
                    type = 'textBox',
                    pos = { -825, 110 },
                    linecode = "SETMENU02",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                {
                    key = 'SliderSFX',
                    type = 'slider',
                    pos = { 25, 30 },
                    configKey = "sfx_volume",
                },
                {
                    key = 'SFXText',
                    type = 'textBox',
                    pos = { -825, 40 },
                    linecode = "SETMENU03",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                --[[
                    {
                    key = 'SliderVoice',
                    type = 'slider',
                    pos = { 25, -40 },
                    configKey = "voice_volume",
                    },
                    {
                    key = 'VoiceText',
                    type = 'textBox',
                    pos = { -825, -30 },
                    text = "DIALOG VOLUME",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                    },
                ]]--
                {
                    key = 'CheckboxAutoSave',
                    type = 'checkbox',
                    pos = { 15, -108 },
                    configKey = "autosave",
                },
                {
                    key = 'AutoSaveText',
                    type = 'textBox',
                    pos = { -825, -108 },
                    linecode = "SETMENU04",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                {
                    key = 'HardwareMouseCheckbox',
                    type = 'checkbox',
                    pos = { 15, -180 },
                    configKey = "use_os_mouse",
                },
                {
                    key = 'HardwareMouseText',
                    type = 'textBox',
                    pos = { -825, -180 },
                    linecode = "SETMENU05",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                {
                    key = 'FullscreenCheckbox',
                    type = 'checkbox',
                    pos = { 15, -252 },
                    configKey = "launch_fullscreen",
                },
                {
                    key = 'FullscreenText',
                    type = 'textBox',
                    pos = { -825, -252 },
                    linecode = "SETMENU06",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                {
                    key = 'ColorblindCheckbox',
                    type = 'checkbox',
                    pos = { 15, -324 },
                    configKey = "colorblind",
                },
                {
                    key = 'ColorblindText',
                    type = 'textBox',
                    pos = { -825, -324 },
                    linecode = "SETMENU07",
                    style = 'dosissemibold35',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.RIGHT_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
                {
                    key = 'HeaderText',
                    type = 'textBox',
                    pos = { -5, 200 },
                    linecode = "SETMENU01",
                    style = 'orbitronWhite',
                    rect = { 0, 70, 800, 0 },
                    hAlign = MOAITextBox.CENTER_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },
            },
    }
