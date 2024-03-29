--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]] GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unconsumed',
        states = {
            ['unconsumed'] = {
				frame = nil
			},
            ['consumed'] = {
				frame = nil
			}
        }
    },
    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'sitting',
        states = {
            ['sitting'] = {
				frame = nil
			},
            ['held'] = {
				frame = nil
			},
			['thrown'] = {
				frame = nil
			},
			['broken'] = {
				frame = nil
			}
        }
    }
}
