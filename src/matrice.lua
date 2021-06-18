local Class = require ("lib/class")
local Block = require ("src/block")

local BLOCK_WIDTH = 50
local BLOCK_HEIGHT = 25

local Matrice = Class {}
--
function Matrice:init(screenWidth, screenHeight)
  self.screenWidth = screenWidth
  self.screenHeight = screenHeight

  self.nbCol = math.floor(self.screenWidth / (2 * BLOCK_WIDTH))

  self.nbRow = 4
  self.nbBlocs = self.nbRow * self.nbCol
  self.points = self.nbBlocs
  self.py = 50
  self.blocks = {}
  self:createGrid()
end
--
function Matrice:createGrid()
  for row = 1, self.nbRow do
    --
    for col = 1, self.nbCol do
      self.blocks[row] = {}
    end
  end
  --
  local r = 1
  self:createRow(r, self.py, "BLUE")
  --
  self.py = self.py + 50
  r = r + 1
  self:createRow(r, self.py, "GREEN")
  --
  self.py = self.py + 50
  r = r + 1
  self:createRow(r, self.py, "RED")
  --
  self.py = self.py + 50
  r = r + 1
  self:createRow(r, self.py, "YELLOW")
end
--
function Matrice:createRow(row, yp, type)
  --
  for col = 1, self.nbCol do
    self.blocks[row][col] = Block((col - 1) * BLOCK_WIDTH * 2, yp, type)
  end
end
--
function Matrice:newWave()
  --
  for row = 1, self.nbRow do
    --
    for col = 1, self.nbCol do
      --
      --self.blocks[row][col].state = "VISIBLE"
      self.blocks[row][col]:setState("VISIBLE")
      self.points = self.nbBlocs
    end
  end
end
--
function Matrice:isDestroy()
  --
  if self.points > 0 then
    return false
  else
    return true
  end
end
--
function Matrice:collideWithBall(ball)
  --
  for row = 1, self.nbRow do
    --
    for col = 1, self.nbCol do
      --
      local item = self.blocks[row][col]
      if item:getState() == "VISIBLE" and ball:getState() == "MOVE" then
        --
        if ball:collide(item) then
          --
          theGame:getAssetManager():getSound("explosion"):stop()
          theGame:getAssetManager():getSound("explosion"):play()

          self.points = self.points - 1
          item:touched()
          ball:removeX()
          ball:removeY()
          return true
        end
      end
    end
  end
  return false
end
--
function Matrice:render()
  --
  for row = 1, self.nbRow do
    --
    for col = 1, self.nbCol do
      self.blocks[row][col]:render()
    end
  end
end
--
return Matrice
