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
                    text = "LOAD BASE",
                    style = 'orbitronWhite',
                    --rect = { 0, 100,'g_GuiManager.getUIViewportSizeX() - 50', 0 },
                    rect = { 0, 70, 800, 0 },
					hAlign = MOAITextBox.CENTER_JUSTIFY,
                    vAlign = MOAITextBox.CENTER_JUSTIFY,
                    color = Gui.White,
                },				
				-- main border
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
					pos = { 1846, -450 }, --(g_GuiManager.getUIViewportSizeX() - 200)
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
					pos = { 1846, -1061 }, --(g_GuiManager.getUIViewportSizeX() - 200)
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
					pos = { 1840, -457 }, -- (g_GuiManager.getUIViewportSizeX() - 206)
					scale = { 6, 600 },
					color = Gui.AMBER,
				},
				-- inner borders
				{
					key = 'InnerTopBorder',
					type = 'onePixel',
					pos = { 206, -550 },
					--scale = { 9, 955 },
					scale = { 1635, 6 }, --818
					color = Gui.AMBER,
				},
				{
					key = 'InnerMiddleBorder',
					type = 'onePixel',
					pos = { 1024, -556 }, --456
					scale = { 6, 500 }, --600
					color = Gui.AMBER,
				},
				{
					key = 'InnerButtonBorder',
					type = 'onePixel',
					pos = { 1024, -955 },
					scale = { 818, 6 }, --1635
					color = Gui.AMBER,
				},
				{
					key = 'InnerButtonDividerBorder',
					type = 'onePixel',
					pos = { 1433, -955 },
					scale = { 6, 100 }, --1635
					color = Gui.AMBER,
				},
				--load and cancel buttons
				{
					key = 'LoadButton',
					type = 'onePixelButton',
					pos = { 1034, -965 },
					scale = { 396, 86 },
					color = Gui.BROWN,
					onPressed =
					{
						{
							key = 'LoadButton',
							color = BRIGHT_AMBER,
						},
					},
					onReleased =
					{
						{
							key = 'LoadButton',
							color = AMBER,
						},
					},
					onHoverOn =
					{
						{
							key = 'LoadButton',
							color = AMBER,
						},
						{
							key = 'LoadLabel',
							color = { 0, 0, 0 },
						},
						{
							key = 'LoadHotkey',
							color = { 0, 0, 0 },
						},
						{
							playSfx = 'hilight',
						},
					},
					onHoverOff =
					{
						{
							key = 'LoadButton',
							color = Gui.BROWN,
						},
						{
							key = 'LoadLabel',
							color = Gui.AMBER,
						},
						{
							key = 'LoadHotkey',
							color = Gui.AMBER,
						},
					},
				},
				{
					key = 'LoadLabel',
					type = 'textBox',
					pos = { 1034, -965 },
					text = 'LOAD GAME',
					style = 'dosismedium44',
					rect = { 0, 86, 396, 0 },
					hAlign = MOAITextBox.CENTER_JUSTIFY,
					vAlign = MOAITextBox.CENTER_JUSTIFY,
					color = Gui.AMBER,
				},
				{
					key = 'LoadHotkey',
					type = 'textBox',
					pos = { 1400, -1015 },
					text = 'L',
					style = 'dosissemibold30',
					rect = { 0, 100, 100, 0 },
					hAlign = MOAITextBox.LEFT_JUSTIFY,
					vAlign = MOAITextBox.LEFT_JUSTIFY,
					color = Gui.AMBER,
				},
				
				
				{
					key = 'CancelButton',
					type = 'onePixelButton',
					pos = { 1442, -965 },
					scale = { 396, 86 },
					color = Gui.BROWN,
					onPressed =
					{
						{
							key = 'CancelButton',
							color = BRIGHT_AMBER,
						},
					},
					onReleased =
					{
						{
							key = 'CancelButton',
							color = AMBER,
						},
					},
					onHoverOn =
					{
						{
							key = 'CancelButton',
							color = AMBER,
						},
						{
							key = 'CancelLabel',
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
							key = 'CancelButton',
							color = Gui.BROWN,
						},
						{
							key = 'CancelLabel',
							color = Gui.AMBER,
						},
						{
							key = 'CancelHotkey',
							color = Gui.AMBER,
						},
					},
				},
				{
					key = 'CancelLabel',
					type = 'textBox',
					pos = { 1442, -965 },
					text = 'CANCEL',
					style = 'dosismedium44',
					rect = { 0, 86, 396, 0 },
					hAlign = MOAITextBox.CENTER_JUSTIFY,
					vAlign = MOAITextBox.CENTER_JUSTIFY,
					color = Gui.AMBER,
				},
				{
					key = 'CancelHotkey',
					type = 'textBox',
					pos = { 1788, -1015 },
					text = 'ESC',
					style = 'dosissemibold30',
					rect = { 0, 100, 100, 0 },
					hAlign = MOAITextBox.LEFT_JUSTIFY,
					vAlign = MOAITextBox.LEFT_JUSTIFY,
					color = Gui.AMBER,
				},
				
				-- directory line edit
				{
					key = 'CurrentPathLabelEditBG',
					type = 'onePixelButton',
					pos = { 216, -473 },
					scale = { 1620, 70 }, --800
					--color = Gui.AMBER,
					color = Gui.BLACK,
				},
				{
					key = 'CurrentPathLabel',
					type = 'textBox',
					pos = { 216, -475 },
					text = 'fail',
					style = 'dosismedium44',
					--rect = { 0, 20, 300, 0 },
					rect = {0, 70, 1625, 0}, -- 0,70,800,0
					hAlign = MOAITextBox.LEFT_JUSTIFY,
					vAlign = MOAITextBox.LEFT_JUSTIFY,
					color = Gui.WHITE,
				},
				
				{
					key = 'CurrentPathEditButton',
					type = 'onePixelButton',
					pos = { 216, -473 },
					scale = { 1625, 70 }, --800
					color = { 1, 0, 0 },
					hidden = true,
					clickWhileHidden = true,
					
					onHoverOn =
					{
						--{ key = 'CurrentPathLabel', color = Gui.AMBER, },
						--{ key = 'CurrentPathLabelEditBG', color = Gui.AMBER_OPAQUE, },
						{ key = 'CurrentPathLabelTexture', hidden = false, },
					},
					
					onHoverOff =
					{
						--{ key = 'CurrentPathLabel', color = Gui.BLACK, },
						--{ key = 'CurrentPathLabelEditBG', color = Gui.AMBER },
						{ key = 'CurrentPathLabelTexture', hidden = true, },
					},
					onSelectedOn =
					{
						--{ key = 'CurrentPathLabel', color = Gui.AMBER, },
						--{ key = 'CurrentPathLabelEditBG', color = Gui.BLACK, },
						{ key = 'CurrentPathLabelTexture', hidden = true, },
					},
					onSelectedOff =
					{
						--{ key = 'CurrentPathLabel', color = Gui.BLACK, },
						--{ key = 'CurrentPathLabelEditBG', color = Gui.AMBER },
						{ key = 'CurrentPathLabelTexture', hidden = true, },
					},
				},
				{
					key = 'CurrentPathLabelTexture',
					type = 'uiTexture',
					textureName = 'ui_inspector_buttonEdit',
					sSpritesheetPath = 'UI/Inspector',
					pos = { 1840, -473 }, --1016
					color = Gui.AMBER,
					hidden = true,
				},
				{
					key = 'CurrentPathDirectoryList',
					type = 'scrollPane',
					pos = { 216, -565 },
					--pos = { 216, -265 },
					rect = { 0, 0, 790, 455 },
				},
				--file list
				
				
				
	}
}