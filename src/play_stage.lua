local Class = require("lib/class")

local Paddle = require("src/paddle")
local Ball = require("src/ball")
local Matrice = require("src/matrice")
local ScoreManager = require("lib/scoreManager")

local PlayStage = Class {}

--constructeur
function PlayStage:init(screenWidth, screenHeight)
  --
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight

  self.img = theGame:getAssetManager():getImage("background")

  self.score = ScoreManager(self.screenWidth, self.screenHeight)

  self.paddle = Paddle(self.screenWidth, self.screenHeight)

  self.ball = Ball(self.screenWidth, self.screenHeight, self.paddle, self.score)
  self.matrice = Matrice(self.screenWidth, self.screenHeight)
end
--
--
function PlayStage:onEnter(datas)
  --
  theGame:getAssetManager():getMusic("song"):setLooping(true)
  theGame:getAssetManager():getMusic("song"):setVolume(0.3)
  theGame:getAssetManager():getMusic("song"):play()

  if datas then
    self.score:setName(datas.name)
  end
  --
  self.score:reset()
end
--
--
function PlayStage:onExit()
  theGame:getAssetManager():getMusic("song"):setLooping(false)
  theGame:getAssetManager():getMusic("song"):stop()
end
--
--
function PlayStage:update(dt)
  --
  if theGame:getInputManager():isKeyPressed("left") then
    self.paddle:move("left")
  end
  --
  if theGame:getInputManager():isKeyPressed("right") then
    self.paddle:move("right")
  end
  --
  if theGame:getInputManager():isKeyReleased("right") or theGame:getInputManager():isKeyReleased("left") then
    self.paddle:stop()
  end
  --
  if theGame:getInputManager():isKeyPressed("space") then
    self.ball:setMouvement()
  end
  --
  self.paddle:update(dt)

  self.ball:update(dt)

  --collide block ball
  if self.matrice:collideWithBall(self.ball) then
    self.score:incrementsPoints(1)
  end

  --is Matrice destroy
  if self.matrice:isDestroy() then
    --
    self.ball:setState("LOCKED")
    self.matrice:newWave()
  end
  --
  self:isGameOver()
end
--
--
function PlayStage:isGameOver()
  --
  if self.score:isGameOver() then
    --
    print("game over")
    local datas = {
      name = self.score:getName(),
      points = self.score:getPoints()
    }
    --next stage
    theGame:getStageManager():changeStage("conclu", datas)
  end
end
--
--
function PlayStage:render()
  --
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.img, 0, 0)
  --
  self.paddle:render()

  self.ball:render()

  self.matrice:render()

  self.score:render(0.9, 0.8, 0.1)
end
--
return PlayStage
