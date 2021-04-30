--[[
  animation class
  version 7 avril 2021
]] --

local Class = require "lib/class"
local Animation = Class {}

--
function Animation:init(atlas, tileWidth, tileHeight, interval, looping)
  self.atlas = atlas

  self.tileWidth = tileWidth
  self.tileHeight = tileHeight

  self.frames = {}
  self.interval = interval or 1 / 30
  self.looping = looping or false

  self.timer = 0
  self.currentFrame = 1
  self.go = false

  self:generateQuads()
end
--
function Animation:generateQuads()
  --
  local sheetWidth = self.atlas:getWidth() / self.tileWidth
  local sheetHeight = self.atlas:getHeight() / self.tileHeight

  local sheetCounter = 1
  --
  for y = 0, sheetHeight - 1 do
    for x = 0, sheetWidth - 1 do
      --
      self.frames[sheetCounter] =
        love.graphics.newQuad(
        x * self.tileWidth,
        y * self.tileHeight,
        self.tileWidth,
        self.tileHeight,
        self.atlas:getDimensions()
      )
      sheetCounter = sheetCounter + 1
    end
  end
end
--
function Animation:play()
  self.go = true
end
--
function Animation:isPlaying()
  return self.go
end
--
function Animation:stop()
  self.go = false
end
--
function Animation:update(dt)
  --
  if #self.frames > 1 and self.go then
    self.timer = self.timer + dt

    if self.timer > self.interval then
      self.timer = 0
      self.currentFrame = self.currentFrame + 1

      if self.currentFrame > #self.frames then
        self.currentFrame = 1
        --
        if self.looping == false then
          self.go = false
        end
      end
    end
  end
end
--
function Animation:getCurrentFrame()
  return self.frames[self.currentFrame]
end
--
function Animation:render(xp, yp)
  --
  love.graphics.draw(self.atlas, self.frames[self.currentFrame], xp, yp)
end
--
return Animation
