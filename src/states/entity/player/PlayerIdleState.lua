--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]] PlayerIdleState = Class {
    __includes = EntityIdleState
}

function PlayerIdleState:enter(params)

    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0

    local direction = self.entity.direction
    local pickupBoxX, pickupBoxY, pickupBoxWidth, pickupBoxHeight

    if direction == 'left' then
        pickupBoxWidth = 8
        pickupBoxHeight = 16
        pickupBoxX = self.entity.x - pickupBoxWidth
        pickupBoxY = self.entity.y + 2
    elseif direction == 'right' then
        pickupBoxWidth = 8
        pickupBoxHeight = 16
        pickupBoxX = self.entity.x + self.entity.width
        pickupBoxY = self.entity.y + 2
    elseif direction == 'up' then
        pickupBoxWidth = 16
        pickupBoxHeight = 8
        pickupBoxX = self.entity.x
        pickupBoxY = self.entity.y - pickupBoxHeight
    else
        pickupBoxWidth = 16
        pickupBoxHeight = 8
        pickupBoxX = self.entity.x
        pickupBoxY = self.entity.y + self.entity.height
    end

    self.pickupBox = Hitbox(pickupBoxX, pickupBoxY, pickupBoxWidth, pickupBoxHeight)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or love.keyboard.isDown('up') or
        love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
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
