--[[
  stage Manager class
  version 7 avril 2021
]] --

local Class = require "lib/class"

local StageManager = Class {}
--
function StageManager:init(stages)
    self.emply = {
        onEnter = function()
        end,
        onExit = function()
        end,
        update = function()
        end,
        render = function()
        end
    }
    self.stages = stages or {}
    self.current = self.emply
end
--
function StageManager:changeStage(stageName, datas)
    assert(self.stages[stageName])
    self.current:onExit()
    self.current = self.stages[stageName]()
    self.current:onEnter(datas)
end
--
function StageManager:update(dt)
    self.current:update(dt)
end
---
function StageManager:render()
    self.current:render()
end

return StageManager
