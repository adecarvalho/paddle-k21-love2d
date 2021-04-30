local Class = require("/lib/class")
local Entity = require("/lib/Entity")

local Block = Class {__includes = Entity}

--constructeur
function Block:init(xp, yp, type)
  --
  if type == "BLUE" then
    Entity.init(self, xp, yp, theGame:getAssetManager():getImage("block_blue"))
  end
  --
  if type == "GREEN" then
    Entity.init(self, xp, yp, theGame:getAssetManager():getImage("block_green"))
  end
  --
  if type == "RED" then
    Entity.init(self, xp, yp, theGame:getAssetManager():getImage("block_red"))
  end
  --
  if type == "YELLOW" then
    Entity.init(self, xp, yp, theGame:getAssetManager():getImage("block_yellow"))
  end
  --
  self:setState("VISIBLE") -- "VISIBLE" or "TOUCHED"
  self:inflate(5, 5)
end
--
--
function Block:touched()
  self:setState("TOUCHED")
end
--
--
function Block:toString()
  --
  return ("x= " .. self.position.x .. "y= " .. self.position.y)
end
--
--
function Block:render()
  --
  if self:getState() == "VISIBLE" then
    Entity.render(self)
  end
  --Entity.renderDebug(self)
end

return Block
