PlayerPotIdleState = Class {
    __includes = BaseState
}

function PlayerPotIdleState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    self.player:changeAnimation('pot-idle-' .. self.player.direction)
end

function PlayerPotIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or love.keyboard.isDown('up') or
        love.keyboard.isDown('down') then
        self.entity:changeState('PlayerPotWalkState')
    end

    if love.keyboard.wasPressed('space') then
        -- Throw pot
    end

    if love.keyboard.wasPressed('lalt') or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('lctrl') then
        -- check if hitbox collides with any pots in the scene

        for k, object in pairs(self.entity.room.objects) do
            if object:collides(self.pickupBox) and object.type == 'pot' then
                self.entity:changeState('pickup', object)
                break
            end
        end

        -- self.entity:changeState('pickup')
    end
end

function PlayerPotIdleState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end
