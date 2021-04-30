--[[
  game class
  version 7 avril 2021
]] --
local Class = require "lib/class"
local inputManager = require("lib/inputManager")
local assetManager = require("lib/assetManager")

local Game = Class {}
--
function Game:init(screenWidth, screenHeight, title)
	self.screenWidth = screenWidth
	self.screenHeight = screenHeight
	self.title = title
	--
	self.inputManager = inputManager()
	self.assetManager = assetManager()
	self.stageManager = nil
end
--
function Game:exit()
	love.event.quit()
end

--
function Game:getStageManager()
	return self.stageManager
end
--
function Game:getAssetManager()
	return self.assetManager
end
--
function Game:getInputManager()
	return self.inputManager
end
--
function Game:begin()
	math.randomseed(os.time())
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle(self.title)
	love.window.setMode(self.screenWidth, self.screenHeight, {fullscreen = false, vsync = true, resizable = false})
	--
end
--
function Game:loadStages(stages)
	self.stageManager = stages
end
--
function Game:update(dt)
	self.stageManager:update(dt)
	self.inputManager:reset()
end
--
function Game:render()
	self.stageManager:render()
end
--
function Game:exit()
	love.event.quit()
end
--
return Game
