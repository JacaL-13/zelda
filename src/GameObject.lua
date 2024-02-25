--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]] GameObject = Class {}

function GameObject:init(def, x, y, room)

    self.room = room

    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.thrownX = 0
    self.thrownY = 0
    self.thrownDirectionX = 0
    self.thrownDirectionY = 0
    self.thrownProgress = 0

    -- default empty collision callback
    self.onCollide = function()
    end
end

function GameObject:update(dt)
    -- if state = 'held' then follow player
    if self.state == 'held' then
        self.x = self.room.player.x
        self.y = self.room.player.y - 9
    elseif self.state == 'thrown' then
        if self.thrownProgress == 0 then
            self.thrownX = self.x
            self.thrownY = self.y

            local direction = self.room.player.direction

            self.thrownDirectionX = direction == 'left' and -1 or direction == 'right' and 1 or 0
            self.thrownDirectionY = direction == 'up' and -1 or direction == 'down' and 1 or 0

            self.thrownProgress = 1

            -- else if pot hits wall
        elseif self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE or self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 or
            self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height or self.y + self.height >= VIRTUAL_HEIGHT -
            TILE_SIZE * 2 then
            gSounds['hit-enemy']:play()
            self.state = 'broken'
        elseif self.thrownProgress > POT_THROW_RANGE then
            -- play hit sound
            gSounds['hit-enemy']:play()

            self.state = 'broken'
        else
            local potYTravel = self.thrownDirectionY == 0 and 1 / POT_THROW_RANGE or self.thrownDirectionY

            self.x = self.x + self.thrownDirectionX * TILE_SIZE * 30 * dt
            self.y = self.y + potYTravel * TILE_SIZE * 30 * dt

            self.thrownProgress = self.thrownProgress + 1

            for k, entity in pairs(self.room.entities) do
                if not entity.dead and entity:collides(self) then
                    print(entity.type)
                    entity:damage(1)

                    gSounds['hit-enemy']:play()

                    self.state = 'broken'
                end
            end
        end
    end
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or self.y + self.height < target.y or
               self.y > target.y + target.height)
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end
