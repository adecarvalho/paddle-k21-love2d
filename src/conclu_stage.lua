local Class = require("lib/class")
local Label = require("lib/label")

local ConcluStage = Class {}

--constructeur
function ConcluStage:init(screenWidth, screenHeight)
    self.screenWidth = screenWidth
    self.screenHeight = screenHeight
    --
    self.img = theGame:getAssetManager():getImage("background")
    self.name = "---"
    self.points = 0
    --
    self.gameover = Label("GameOver", theGame:getAssetManager():getFont("big"))
    self.gameover:setColor(0.9, 0.9, 0.1)

    self.lname = Label("name", theGame:getAssetManager():getFont("large"))
    self.lname:setColor(0.9, 0.9, 0.1)

    self.lpoints = Label("points", theGame:getAssetManager():getFont("big"))
    self.lpoints:setColor(0.9, 0.9, 0.1)

    self.commande = Label("Press enter...", theGame:getAssetManager():getFont("large"))
    self.commande:setColor(0.9, 0.9, 0.1)
end
--
--
function ConcluStage:onEnter(datas)
    if datas then
        self.name = datas.name
        self.points = datas.points

        self.lname:setText(self.name)
        self.lpoints:setText(self.points)
    end
    --
    theGame:getAssetManager():getMusic("menu"):setLooping(true)
    theGame:getAssetManager():getMusic("menu"):setVolume(0.3)
    theGame:getAssetManager():getMusic("menu"):play()
end
--
--
function ConcluStage:onExit()
    theGame:getAssetManager():getMusic("menu"):setLooping(false)
    theGame:getAssetManager():getMusic("menu"):stop()
end
--
--
function ConcluStage:update(dt)
    if theGame:getInputManager():isKeyPressed("enter") or theGame:getInputManager():isKeyPressed("return") then
        theGame:getStageManager():changeStage("intro")
    end
end
--
--
function ConcluStage:render()
    --
    love.graphics.draw(self.img, 0, 0)
    --
    self.gameover:render(200, 10)

    self.lname:render(300, 150)

    self.lpoints:render(300, 250)

    self.commande:render(220, self.screenHeight - 100)
end
--
return ConcluStage
