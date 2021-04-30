--[[
  score Manager class
  version 7 avril 2021
]] --
local Class = require "lib/class"

local ScoreManager = Class {}
--
function ScoreManager:init(screenWidth, screenHeight)
  -- body...
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight
  self.player = {
    name = "---",
    points = 0,
    lives = 3
  }
end
-- --
function ScoreManager:reset(args)
  --
  self.player.points = 0
  self.player.lives = 3
end
--
function ScoreManager:setName(name)
  --
  self.player.name = name
end
-- --
function ScoreManager:getName()
  --
  return self.player.name
end
--
function ScoreManager:incrementsPoints(amt)
  --
  self.player.points = self.player.points + amt
end
-- --
function ScoreManager:getPoints()
  --
  return self.player.points
end
--
function ScoreManager:getLives()
  --
  return self.player.lives
end
-- --
function ScoreManager:decrementsLives()
  --
  self.player.lives = self.player.lives - 1
end
-- --
function ScoreManager:incrementsLives(amt)
  --
  self.player.lives = self.player.lives + amt
end
--
function ScoreManager:isGameOver()
  --
  if self.player.lives < 0 then
    return true
  else
    return false
  end
end
-- --
function ScoreManager:render(r, g, b, a)
  --name
  love.graphics.setColor(r or 1, g or 1, b or 1, a or 1)

  --love.graphics.setFont(gFonts['large'])
  love.graphics.setFont(love.graphics.newFont(30))

  --points
  love.graphics.printf("Score: " .. tostring(self.player.points), 2, 5, self.screenWidth, "left")

  --name
  love.graphics.print(self.player.name, self.screenWidth / 2, 5)

  --lives
  for i = 0, self.player.lives - 1 do
    love.graphics.circle("fill", (self.screenWidth - 100) + i * 40, 15, 10)
  end
  --
  love.graphics.setColor(1, 1, 1, 1)
end
-- --
return ScoreManager
