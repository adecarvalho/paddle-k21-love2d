--[[
  particule Generator class
  version 7 avril 2021
]] --
local Class = require "lib/class"
local Particule = require "lib/particule"

local ParticuleGenerator = Class {}
--
function ParticuleGenerator:init(xp, yp, speedMin, speedMax, angleMin, angleMax)
  --
  self.position = {x = xp, y = yp}
  self.speedMin = speedMin or 10
  self.speedMax = speedMax or 80
  self.angleMin = angleMin or 0.78
  self.angleMax = angleMax or 2.35
  self.go = false
  self.particules = {}
  --
  for i = 1, 100 do
    --
    local speed = math.random(self.speedMin, self.speedMax)
    local angle = self.angleMin + math.random() * (self.angleMax - self.angleMin)
    --
    local p = Particule(self.position.x, self.position.y, 10)
    p:setSpeeds(speed, angle)
    --
    table.insert(self.particules, p)
  end
end
--
function ParticuleGenerator:start()
  --
  self.go = true
end
--
function ParticuleGenerator:stop()
  --
  self.go = false
end
--
function ParticuleGenerator:move(xp, yp)
  --
  self.position.x = xp
  self.position.y = yp
end
--
function ParticuleGenerator:update(dt)
  --
  if #self.particules > 0 and self.go == true then
    --
    for k, p in pairs(self.particules) do
      --
      p:update(dt)
      if p:isDead() == true then
        --
        p:reset(self.position.x, self.position.y)

        local speed = math.random(self.speedMin, self.speedMax)
        local angle = self.angleMin + math.random() * (self.angleMax - self.angleMin)

        p:setSpeeds(speed, angle)
      end
    end
  end
end
--
function ParticuleGenerator:render()
  --
  if #self.particules > 0 and self.go == true then
    --
    for k, p in pairs(self.particules) do
      --
      p:render()
    end
  end
end
--
return ParticuleGenerator
