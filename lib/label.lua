--[[
  label class
  version 7 avril 2021
]] --
local Class = require "lib/class"
local Label = Class {}
--
function Label:init(text, font, size)
  --
  self.color = {r = 1, g = 1, b = 1, a = 1}
  self.text = text or "?"

  self.size = size or 30

  if font ~= nil then
    --
    self.font = font
  else
    self.font = love.graphics.newFont(self.size)
  end
end
--
function Label:setText(txt)
  --
  self.text = txt
end
--
function Label:setColor(red, green, blue, alpha)
  --
  self.color = {r = red, g = green, b = blue, a = alpha}
end
--
function Label:render(xp, yp)
  love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
  love.graphics.setFont(self.font)

  love.graphics.print(tostring(self.text), xp, yp)

  love.graphics.setColor(1, 1, 1, 1)
end
--
return Label
