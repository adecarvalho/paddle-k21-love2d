--[[
  assetManager class
  version 7 avril 2021
]] --

local Class = require("lib/class")
local AssetManager = Class {}
--
function AssetManager:init()
	self.images = {}
	self.sounds = {}
	self.musics = {}
	self.fonts = {}
end
--
function AssetManager:loadImage(id, path)
	self.images[id] = love.graphics.newImage(path)
end
--
function AssetManager:getImage(id)
	return self.images[id]
end
--
function AssetManager:loadSound(id, path)
	self.sounds[id] = love.audio.newSource(path, "static")
end
--
function AssetManager:getSound(id)
	return self.sounds[id]
end
--
function AssetManager:loadMusic(id, path)
	self.musics[id] = love.audio.newSource(path, "stream")
end
--
function AssetManager:getMusic(id)
	return self.musics[id]
end
--
function AssetManager:loadFont(id, path, size)
	self.fonts[id] = love.graphics.newFont(path, size or 12)
end
--
function AssetManager:getFont(id)
	return self.fonts[id]
end

--
return AssetManager
