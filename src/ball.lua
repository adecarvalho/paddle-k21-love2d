--
local Class = require("/lib/class")
local Entity = require("/lib/Entity")

local Ball = Class {__includes = Entity}

--constructeur
function Ball:init(screenWidth, screenHeight, paddle, score)
  --
  Entity.init(self, 0, 0, theGame:getAssetManager():getImage("ball"))

  self.screenWidth = screenWidth
  self.screenHeight = screenHeight

  self.score = score
  self.paddle = paddle

  self:setState("LOCKED")
  self.speedMin = 250
  self.speedMax = 300
end
--
--
function Ball:stop()
  self:setVelocityXY(0, 0)
end
--
--
function Ball:setMouvement()
  if self:getState() == "LOCKED" then
    self:setState("MOVE")
    self:newSpeedX()
    self:newSpeedY()
  end
end
--
--
function Ball:newSpeedX()
  self:setVelocityX(math.random(self.speedMin, self.speedMax))
end
--
--
function Ball:newSpeedY()
  self:setVelocityY(-math.random(self.speedMin, self.speedMax))
end
--
--
function Ball:removeX()
  self:setVelocityX(-self:getVelocityX())
end
--
--
function Ball:removeY()
  self:setVelocityY(-self:getVelocityY())
end
--
--
function Ball:limites()
  --left
  if self:getLeft() < 0 and self:getVelocityX() <= 0 then
    self:removeX()
  end

  --right
  if self:getRight() > self.screenWidth and self:getVelocityX() >= 0 then
    self:removeX()
  end

  --top
  if self:getTop() < 0 and self:getVelocityY() <= 0 then
    self:removeY()
  end

  --bottom
  if self:getBottom() > self.screenHeight and self:getVelocityY() >= 0 then
    --
    if self.score then
      self.score:decrementsLives()
    end
    --
    theGame:getAssetManager():getSound("spawn"):stop()
    theGame:getAssetManager():getSound("spawn"):play()
    self:setState("LOCKED")
    self:stop()
  end
end
--
--
function Ball:collideWithPaddle()
  --
  if self:collide(self.paddle) and self:getVelocityY() > 0 then
    theGame:getAssetManager():getSound("bounce"):stop()
    theGame:getAssetManager():getSound("bounce"):play()
    --
    local xball = self:getCenterX()
    local ypadd = self.paddle:getCenterX()
    local delta = xball - ypadd

    local v = math.random(self.speedMin, self.speedMax)

    local angle = -0.02 * delta + 1.57

    self:setVelocityX(v * math.cos(angle))
    self:setVelocityY(-v * math.sin(angle))
  end
end
--
--
function Ball:update(dt)
  --
  Entity.update(self, dt)

  if self:getState() == "LOCKED" then
    --
    local xc = self.paddle:getCenterX()
    local xt = self.paddle:getTop()

    self:setCenterX(xc)
    self:setBottom(xt)
  end

  self:collideWithPaddle()

  --limites
  self:limites()
end
--
function Ball:render()
  --
  Entity.render(self)
  --Entity.renderDebug(self)
end
--
return Ball
