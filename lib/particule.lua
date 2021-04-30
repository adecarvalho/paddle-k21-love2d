--[[
  particule class
  version 7 avril 2021
]] --
local Class = require "lib/class"

local Particule = Class {}

--
function Particule:init(xi, yi, radius)
  --
  self.positionInit = {x = xi, y = yi}
  self.position = {x = xi, y = yi}
  self.radius = radius or 10
  self.velocity = {x = 0, y = 0}
  self.alpha = 255
  self.color = {r = 0, g = 0, b = 0}
  self.timer = 0
  self.live = math.random() * 2
  self.state = "LIVE" -- or DEAD
end
--
function Particule:isDead()
  --
  if self.state == "DEAD" then
    --
    return true
  end
  return false
end
--
function Particule:move(xp, yp)
  --
  self.positionInit.x = xp
  self.positionInit.y = yp
end
--
function Particule:reset(xi, yi)
  --
  self.positionInit.x = xi
  self.positionInit.y = yi

  self.position.x = xi
  self.position.y = yi

  self.live = math.random() * 2
  self.timer = 0
  self.alpha = 255
  self.state = "LIVE"
end
--
function Particule:setVelocities(dx, dy)
  --
  self.velocity.x = dx
  self.velocity.y = dy
end
--
function Particule:setSpeeds(module, angle)
  --
  self.velocity.x = module * math.cos(angle)
  self.velocity.y = module * math.sin(angle)
end
--
function Particule:update(dt)
  --
  self.timer = self.timer + dt
  --
  if self.timer > self.live and self.state == "LIVE" then
    --
    self.timer = 0
    self.state = "DEAD"
  end
  --
  self.alpha = 255 - (255 * self.timer) / self.live

  self.position.x = self.position.x + self.velocity.x * dt
  self.position.y = self.position.y + self.velocity.y * dt
end
--
function Particule:render(args)
  --
  love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.alpha / 255)
  love.graphics.circle("fill", self.position.x, self.position.y, self.radius)

  love.graphics.setColor(1, 1, 1, 1)
end
--
return Particule
