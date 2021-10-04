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
		{
			key = 'CurrentDirectoryPathSelector',
			type = 'onePixelButton',
			--pos = { 216, -575 },
			pos = { 0, 0 },
			scale = { 770, 60 },
			--scale = { 200,50 },
			color = Gui.BLACK,
			onPressed =
			{
				{
					key = 'CurrentDirectoryPathSelector',
					color = BRIGHT_AMBER,
				},
			},
			onReleased =
			{
				{
					key = 'CurrentDirectoryPathSelector',
					color = Gui.BROWN,
				},
			},
			onHoverOn =
			{
				{
					key = 'CurrentDirectoryPathSelector',
					color = Gui.AMBER,
				},
				{
					playSfx = 'hilight',
				},
			},
			onHoverOff =
			{
				{
					key = 'CurrentDirectoryPathSelector',
					color = Gui.BLACK,
				},
			},
		},
		--[[{
			key = 'CurrentDirectoryContentList',
			type = 'textBox',
			pos = { 0, 0 },
			text = '...',
			style = 'dosismedium44',
			rect = { 0, 100, 500, 0 },
			hAlign = MOAITextBox.LEFT_JUSTIFY,
			vAlign = MOAITextBox.LEFT_JUSTIFY,
			color = Gui.WHITE,
		},]]--
		--[[
		{
			key = 'CurrentPathDirectoryList',
			type = 'scrollPane',
			pos = { 790, 0 },
			--pos = { 216, -265 },
			rect = { 0, 0, 790, 455 },
		}, ]]--
		
		
	},
}