local Class = require("lib/class")
local Entity = require("lib/entity")

local Paddle = Class {__includes = Entity}
--
function Paddle:init(screenWidth, screenHeight)
    self.screenWidth = screenWidth
    self.screenHeight = screenHeight

    local px = self.screenWidth / 2
    local py = self.screenHeight - 50

    Entity.init(self, px, py, theGame:getAssetManager():getImage("paddle"))
    self.speed = 300
end
--
--
function Paddle:stop()
    self:setVelocityXY(0, 0)
end
--
--
function Paddle:limites()
    -- left
    if self:getLeft() <= 0 then
        self:setLeft(0)
    end
    -- right
    if self:getRight() >= self.screenWidth then
        self:setRight(self.screenWidth)
    end
end
--
--
function Paddle:move(direction)
    --
    if direction == "left" then
        self:setVelocityX(-self.speed)
    end
    --
    if direction == "right" then
        self:setVelocityX(self.speed)
    end
end
--
--
function Paddle:update(dt)
    Entity.update(self, dt)
    self:limites()
end
--
--
function Paddle:render()
    Entity.render(self)
end
--
return Paddle
