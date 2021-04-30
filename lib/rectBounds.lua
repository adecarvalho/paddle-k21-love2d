--[[
  rectBounds class
  version 7 avril 2021
]] --
local Class = require "lib/class"

local RectBounds = Class {}
--
function RectBounds:init(x, y, w, h)
    self.x = x
    self.xi = 0

    self.y = y
    self.yi = 0

    self.w = w
    self.h = h
end
--
function RectBounds:update(xp, yp)
    self.x = xp
    self.x = self.x + self.xi

    self.y = yp
    self.y = self.y + self.yi
end
--
function RectBounds:inflate(xi, yi)
    self.xi = xi
    self.w = self.w - 2 * self.xi

    self.yi = yi
    self.h = self.h - 2 * self.yi

    self.x = self.x + xi
    self.y = self.y + yi
end
--
function RectBounds:collideRect(target)
    if target == nil then
        return false
    end
    --
    if
        (target.x > (self.x + self.w)) or (self.x > (target.x + target.w)) or (target.y > (self.y + self.h)) or
            (self.y > (target.y + target.h))
     then
        return false
    else
        return true
    end
end
--
function RectBounds:render()
    love.graphics.setColor(1, 0, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1, 1, 1, 1)
end
--
return RectBounds
