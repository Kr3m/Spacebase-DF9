local Gui = require('UI.Gui')

local AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.95 }
local BRIGHT_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 1 }
local SELECTION_AMBER = { Gui.AMBER[1], Gui.AMBER[2], Gui.AMBER[3], 0.01 }

-- Have to use the actually value if you use getUIViewportSixe()

-- Save button is about 300 pixels wide for scale

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
                {
					key = 'Background',
					type = 'onePixel',
					pos = { 0, 0 },
					scale = { 2568, 1444 },
					color = { 0, 0, 0, 0.83 },
					hidden = false,
				},
				{
					key = 'Logo',
					type = 'uiTexture',
					textureName = 'logo',
					sSpritesheetPath = 'UI/StartMenu',
					pos = { 57, 50 },
					scale = { 1.5, 1.5 },
					color = Gui.WHITE,
					hidden = false,
				},
                {
                    key = 'HeaderText',
                    type = 'textBox',
                    pos = { 1005, -380 },
                    text = "SAVE BASE",
                    style = 'orbitronWhite',
                    --rect = { 0, 100,'g_GuiManager.getUIViewportSizeX() - 50', 0 },
                    rect = { 0, 70, 800, 0 },
					hAlign = MOAITextBox.CENTER_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },				
				{
					key = 'UpperLeftCorner',
					type = 'uiTexture',
					textureName = 'ui_boxCorner_3px',
					sSpritesheetPath = 'UI/Shared',
					pos = { 200, -450 },
					scale = { 2, 2 },
					color = Gui.AMBER,
				},
				{
					key = 'UpperRightCorner',
					type = 'uiTexture',
					textureName = 'ui_boxCorner_3px',
					sSpritesheetPath = 'UI/Shared',
					pos = { (g_GuiManager.getUIViewportSizeX() - 200), -450 },
					scale = { -2, 2 },
					color = Gui.AMBER,
				},
				{
					key = 'BottomLeftCorner',
					type = 'uiTexture',
					textureName = 'ui_boxCorner_3px',
					sSpritesheetPath = 'UI/Shared',
					pos = { 200, -1061 },
					scale = { 2, -2 },
					color = Gui.AMBER,
				},
				{
					key = 'BottomRightCorner',
					type = 'uiTexture',
					textureName = 'ui_boxCorner_3px',
					sSpritesheetPath = 'UI/Shared',
					pos = { (g_GuiManager.getUIViewportSizeX() - 200), -1061 },
					scale = { -2, -2 },
					color = Gui.AMBER,
				},
				{
					key = 'TopBorder',
					type = 'onePixel',
					pos = { 206, -450 },
					scale = { 1635, 6 },
					color = Gui.AMBER,
				},
				{
					key = 'BottomBorder',
					type = 'onePixel',
					pos = { 206, -1055 },
					scale = { 1635, 6 },
					color = Gui.AMBER,
				},
				{
					key = 'LeftBorder',
					type = 'onePixel',
					pos = { 200, -457 },
					scale = { 6, 600 },
					color = Gui.AMBER,
				},
				{
					key = 'RightBorder',
					type = 'onePixel',
					pos = { (g_GuiManager.getUIViewportSizeX() - 206), -457 },
					scale = { 6, 600 },
					color = Gui.AMBER,
				},
				--button borders
				--{
				--	key = 'InnerTopBorder',
				--	type = 'onePixel',
				--	pos = { 504, -450 },
				--	--scale = { 9, 955 },
				--	scale = { 996, 6 },
				--	color = Gui.AMBER,
				--},
				
				
				-- stripes
				--{
				--	key = 'StripesTop',
				--	type = 'uiTexture',
				--	textureName = 'ui_dialog_docking_stripesBottom',
				--	sSpritesheetPath = 'UI/DialogBox',
				--	pos = { 206, -450 },
				--	scale = { 1.54, 1.54 },
				--	color = Gui.AMBER,
				--},
				--{
				--	key = 'StripesBottom',
				--	type = 'uiTexture',
				--	textureName = 'ui_dialog_docking_stripesBottom',
				--	sSpritesheetPath = 'UI/DialogBox',
				--	--pos = { 504, -894 },
				--	pos = { 504, -440 },
				--	scale = { 1.54, 1.54 },
				--	color = Gui.AMBER,
				--},
	}
}