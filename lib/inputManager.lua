--[[
  inputManager class
  version 7 avril 2021
]] --
local Class = require "lib/class"

local InputManager = Class {}

--
function InputManager:init()
  --
  self.keysPressed = {}
  self.keysReleased = {}
  self.mouse = {x = -1, y = -1, button = 0, pressed = false, released = false}
end
--
function InputManager:setMousePressed(xp, yp, btn)
  self.mouse.x = xp
  self.mouse.y = yp
  self.mouse.button = btn
  self.mouse.pressed = true
  self.mouse.released = false
end
--
function InputManager:setMouseReleased(x, y, btn)
  self.mouse.x = xp
  self.mouse.y = yp
  self.mouse.button = btn
  self.mouse.pressed = false
  self.mouse.released = true
end
--
function InputManager:setKeyPressed(key)
  --
  self.keysPressed[key] = true
end
--
function InputManager:setKeyReleased(key)
  --
  self.keysReleased[key] = true
end
--
function InputManager:isKeyPressed(key)
  --
  if self.keysPressed[key] then
    return true
  else
    return false
  end
end
--
function InputManager:isKeyReleased(key)
  --
  if self.keysReleased[key] then
    return true
  else
    return false
  end
end
--
function InputManager:getMouseState()
  return self.mouse
end
--
function InputManager:reset(args)
  self.keysPressed = {}
  self.keysReleased = {}

  self.mouse.x = -1
  self.mouse.y = -1
  self.mouse.button = 0
  self.mouse.pressed = false
  self.mouse.released = false
end
--
return InputManager
