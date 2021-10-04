local Gui = require('UI.Gui')

local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }

return
{
    posInfo =
        {
        alignX = 'left',
        alignY = 'top',
        offsetX = 0,
        offsetY = 0,
    },
    tElements =
    {
        -- BG
        {
            key = 'Background',
            type = 'onePixel',
            pos = { 0, 0 },
            scale = { 2568, 1444 },
			color = { 0, 0, 0 },
        },
        -- Border
        {
            key = 'UpperLeftCorner',
            type = 'uiTexture',
            textureName = 'ui_boxCorner_3px',
            sSpritesheetPath = 'UI/Shared',
            pos = { 500, -200 },
			scale = { 2, 2 },
            color = Gui.AMBER,
        },
        {
            key = 'UpperRightCorner',
            type = 'uiTexture',
            textureName = 'ui_boxCorner_3px',
            sSpritesheetPath = 'UI/Shared',
            pos = { 1506, -200 },
            scale = { -2, 2 },
            color = Gui.AMBER,
        },
        {
            key = 'BottomLeftCorner',
            type = 'uiTexture',
            textureName = 'ui_boxCorner_3px',
            sSpritesheetPath = 'UI/Shared',
            pos = { 500, -910 },
            scale = { 2, -2 },
            color = Gui.AMBER,
        },
        {
            key = 'BottomRightCorner',
            type = 'uiTexture',
            textureName = 'ui_boxCorner_3px',
            sSpritesheetPath = 'UI/Shared',
            pos = { 1506, -910 },
            scale = { -2, -2 },
            color = Gui.AMBER,
        },
        {
            key = 'TopBorder',
            type = 'onePixel',
            pos = { 504, -200 },
            scale = { 996, 6 },
            color = Gui.AMBER,
        },
        {
            key = 'BottomBorder',
            type = 'onePixel',
            pos = { 504, -904 },
            scale = { 996, 6 },
            color = Gui.AMBER,
        },
        {
            key = 'LeftBorder',
            type = 'onePixel',
            pos = { 500, -207 },
            scale = { 6, 696 },
            color = Gui.AMBER,
        },
        {
            key = 'RightBorder',
            type = 'onePixel',
            pos = { 1500, -207 },
            scale = { 6, 696 },
			color = Gui.AMBER,
        },
		--button borders
		{
            key = 'InnerTopBorder',
            type = 'onePixel',
            pos = { 504, -450 },
            --scale = { 9, 955 },
			scale = { 996, 6 },
            color = Gui.AMBER,
        },
		{
            key = 'InnerMiddleBorder',
            type = 'onePixel',
            pos = { 504, -600 },
            scale = { 996, 6 },
            color = Gui.AMBER,
        },
		{
            key = 'InnerBottomBorder',
            type = 'onePixel',
            pos = { 504, -750 },
            scale = { 996, 6 },
            color = Gui.AMBER,
        },
		
		-- stripes
		{
            key = 'StripesTop',
            type = 'uiTexture',
            textureName = 'ui_dialog_docking_stripesBottom',
            sSpritesheetPath = 'UI/DialogBox',
            pos = { 504, -200 },
            scale = { 1.54, 1.54 },
            color = Gui.AMBER,
        },
        {
            key = 'StripesBottom',
            type = 'uiTexture',
            textureName = 'ui_dialog_docking_stripesBottom',
            sSpritesheetPath = 'UI/DialogBox',
            --pos = { 504, -894 },
            pos = { 504, -440 },
			scale = { 1.54, 1.54 },
            color = Gui.AMBER,
        },
		
		-- Save Buttons
        {
            key = 'SaveYesButton',
            type = 'onePixelButton',
			pos = { 514, -463 },
			scale = { 980, 130 },
            color = Gui.BROWN,
			layerOverride = 'UIForeground',
            onPressed =
            {
                {
                    key = 'SaveYesButton',
                    color = BRIGHT_AMBER,
                },
            },
            onReleased =
            {
                {
                    key = 'SaveYesButton',
                    color = AMBER,
                },
            },
            onHoverOn =
            {
                {
                    key = 'SaveYesButton',
                    color = AMBER,
                },
                {
                    key = 'SaveYesLabel',
                    color = { 0, 0, 0 },
                },
				{
                    key = 'SaveYesDockingIcon',
                    color = { 0, 0, 0 },
                },
                {
                    key = 'SaveYesHotkey',
                    color = { 0, 0, 0 },
                },
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                {
                    key = 'SaveYesButton',
                    color = Gui.BROWN,
                },
                {
                    key = 'SaveYesLabel',
                    color = Gui.AMBER,
                },
				{
                    key = 'SaveYesDockingIcon',
                    color = Gui.AMBER,
                },
				{
                    key = 'SaveYesHotkey',
                    color = Gui.AMBER,
                },
            },
        },
		{
            key = 'SaveYesLabel',
            type = 'textBox',
			pos = { 514, -463 },
            text = 'SAVE & QUIT',
            style = 'dosismedium44',
            rect = { 0, 130, 980, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'SaveYesHotkey',
            type = 'textBox',
            pos = { 1400, -554 },
            text = 'S',
            style = 'dosissemibold30',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
        -- Decline Button
        {
            key = 'SaveNoButton',
            type = 'onePixelButton',
            pos = { 514, -613 },
			scale = { 980, 130 },
			
            color = Gui.BROWN,
            layerOverride = 'UIForeground',
            onPressed =
            {
                {
                    key = 'SaveNoButton',
                    color = BRIGHT_AMBER,
                },
            },
            onReleased =
            {
                {
                    key = 'SaveNoButton',
                    color = AMBER,
                },
            },
            onHoverOn =
            {
                {
                    key = 'SaveNoButton',
                    color = AMBER,
                },
                {
                    key = 'SaveNoLabel',
                    color = { 0, 0, 0 },
                },
                {
                    key = 'SaveNoHotkey',
                    color = { 0, 0, 0 },
                },
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                {
                    key = 'SaveNoButton',
                    color = Gui.BROWN,
                },
                {
                    key = 'SaveNoLabel',
                    color = Gui.AMBER,
                },
                {
                    key = 'SaveNoHotkey',
                    color = Gui.AMBER,
                },
            },
        },
        {
            key = 'SaveNoLabel',
            type = 'textBox',
			pos = { 514, -613 },
            text = 'QUIT WITHOUT SAVE',
            style = 'dosismedium44',
            rect = { 0, 130, 980, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'SaveNoHotkey',
            type = 'textBox',
            pos = { 1400, -702 },
            text = 'Q',
            style = 'dosissemibold30',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
		
		
		-- Cancel Button
		{
            key = 'SaveCancelButton',
            type = 'onePixelButton',
            pos = { 514, -763 },
			scale = { 980, 130 },
            color = Gui.BROWN,
            layerOverride = 'UIForeground',
            onPressed =
            {
                {
                    key = 'SaveCancelButton',
                    color = BRIGHT_AMBER,
                },
            },
            onReleased =
            {
                {
                    key = 'SaveCancelButton',
                    color = AMBER,
                },
            },
            onHoverOn =
            {
                {
                    key = 'SaveCancelButton',
                    color = AMBER,
                },
                {
                    key = 'SaveCancelLabel',
                    color = { 0, 0, 0 },
                },
                {
                    key = 'CancelHotkey',
                    color = { 0, 0, 0 },
                },
                {
                    playSfx = 'hilight',
                },
            },
            onHoverOff =
            {
                {
                    key = 'SaveCancelButton',
                    color = Gui.BROWN,
                },
                {
                    key = 'SaveCancelLabel',
                    color = Gui.AMBER,
                },
                {
                    key = 'CancelHotkey',
                    color = Gui.AMBER,
                },
            },
        },
        {
            key = 'SaveCancelLabel',
            type = 'textBox',
			pos = { 504, -763 },
            text = 'CANCEL',
            style = 'dosismedium44',
            rect = { 0, 130, 980, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'CancelHotkey',
            type = 'textBox',
            pos = { 1400, -852 },
            text = 'ESC',
            style = 'dosissemibold30',
            rect = { 0, 100, 100, 0 },
            hAlign = MOAITextBox.LEFT_JUSTIFY,
            vAlign = MOAITextBox.LEFT_JUSTIFY,
            color = Gui.AMBER,
        },
		{
            key = 'QuitMessage',
            type = 'textBox',
            pos = { 504, -240 },
            text = 'ARE YOU SURE YOU WANT TO QUIT?',
            style = 'dosismedium32',
            rect = { 0, 100, 980, 0 },
            hAlign = MOAITextBox.CENTER_JUSTIFY,
            vAlign = MOAITextBox.CENTER_JUSTIFY,
            color = Gui.AMBER,
        },
	}
}