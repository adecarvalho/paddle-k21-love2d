--[[
  entity class
  version 7 avril 2021
]] --

local Class = require "lib/class"
local RectBounds = require "lib/rectBounds"

local Entity = Class {}
--
function Entity:init(xp, yp, image, width, height)
    -- position et dim
    self.position = {x = xp or 0, y = yp or 0}
    self.image = image or nil
    self.width = width or 20
    self.height = height or 20

    -- speed
    self.velocity = {x = 0, y = 0}

    -- dim
    if self.image then
        self.width = self.image:getWidth()
        self.height = self.image:getHeight()
    end

    -- bounds
    self.recbounds = RectBounds(self.position.x, self.position.y, self.width, self.height)

    -- states
    self.state = ""
end
--
function Entity:getPositionX()
    return self.position.x
end
--
function Entity:getPositionY()
    return self.position.y
end
--
function Entity:getPositionXY()
    return self.position.x, self.position.y
end
--
function Entity:getVelocityX()
    return self.velocity.x
end
--
function Entity:getVelocityY()
    return self.velocity.y
end
--
function Entity:getVelocityXY()
    return self.velocity.x, self.velocity.y
end
--
function Entity:getLeft()
    return self.position.x
end
--
function Entity:getRight()
    return self.position.x + self.width
end
--
function Entity:getTop()
    return self.position.y
end
--
function Entity:getBottom()
    return self.position.y + self.height
end
--
function Entity:getCenterX()
    return self.position.x + self.width / 2
end
--
function Entity:getCenterY()
    return self.position.y + self.height / 2
end
--
function Entity:getBounds()
    return self.recbounds
end
--
function Entity:getState()
    return self.state
end
--
function Entity:setVelocityX(dx)
    self.velocity.x = dx
end
--
function Entity:setVelocityY(dy)
    self.velocity.y = dy
end
--
function Entity:setVelocityXY(dx, dy)
    self.velocity.x = dx
    self.velocity.y = dy
end
--
function Entity:setPositionX(xp)
    self.position.x = xp
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setPositionY(yp)
    self.position.y = yp
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setPositionXY(xp, yp)
    self.position.x = xp
    self.position.y = yp
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setLeft(left)
    self.position.x = left
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setCenterX(xc)
    self.position.x = xc - self.width / 2
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setCenterY(yc)
    self.position.y = yc - self.height / 2
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setCenterXY(xc, yc)
    self.position.x = xc - self.width / 2
    self.position.y = yc - self.height / 2
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setRight(right)
    self.position.x = right - self.width
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setTop(top)
    self.position.y = top
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setBottom(bottom)
    self.position.y = bottom - self.height
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:setState(state)
    self.state = state
end
--
function Entity:inflate(xi, yi)
    self.recbounds:inflate(xi, yi)
end
--
function Entity:update(dt)
    self.position.x = math.floor(self.position.x + self.velocity.x * dt)
    self.position.y = math.floor(self.position.y + self.velocity.y * dt)
    -- recbounds
    self.recbounds:update(self.position.x, self.position.y)
end
--
function Entity:render()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.position.x, self.position.y)
    --
end
--
function Entity:renderDebug()
    self.recbounds:render()
end
--
function Entity:collide(target)
    if self.recbounds:collideRect(target.recbounds) then
        return true
    else
        return false
    end
end
--
return Entity
