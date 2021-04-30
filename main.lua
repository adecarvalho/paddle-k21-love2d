--[[
  Projet Paddle 2K21
  A.DeCarvalho-2021
]] --
--
local game = require("lib/game")
local stageManager = require("lib/stageManager")

local introStage = require("src/intro_stage")
local playStage = require("src/play_stage")
local concluStage = require("src/conclu_stage")

--local variables
local WINDOW_WIDTH = 700
local WINDOW_HEIGHT = 500
local fps = 0
local timer = 0

--global variables
theGame = game(WINDOW_WIDTH, WINDOW_HEIGHT, "Paddle-lua")
--
--
function love.load()
    theGame:begin()

    --images
    theGame:getAssetManager():loadImage("background", "assets/images/background.png")
    theGame:getAssetManager():loadImage("paddle", "assets/images/paddle.bmp")
    theGame:getAssetManager():loadImage("ball", "assets/images/ball.png")
    theGame:getAssetManager():loadImage("block_blue", "assets/images/block_blue.png")
    theGame:getAssetManager():loadImage("block_green", "assets/images/block_green.png")
    theGame:getAssetManager():loadImage("block_red", "assets/images/block_red.png")
    theGame:getAssetManager():loadImage("block_yellow", "assets/images/block_yellow.png")

    -- sounds
    theGame:getAssetManager():loadSound("spawn", "assets/sounds/ball_spawn.ogg")
    theGame:getAssetManager():loadSound("bounce", "assets/sounds/ball_bounce.ogg")
    theGame:getAssetManager():loadSound("explosion", "assets/sounds/explosion.ogg")

    --music
    theGame:getAssetManager():loadMusic("song", "assets/musics/song.ogg")
    theGame:getAssetManager():loadMusic("menu", "assets/musics/menu.mp3")

    -- fonts
    theGame:getAssetManager():loadFont("large", "assets/fonts/free.ttf", 30)
    theGame:getAssetManager():loadFont("big", "assets/fonts/brick.ttf", 60)

    --
    theGame:loadStages(
        stageManager(
            {
                ["intro"] = function()
                    return introStage(WINDOW_WIDTH, WINDOW_HEIGHT)
                end,
                ["play"] = function()
                    return playStage(WINDOW_WIDTH, WINDOW_HEIGHT)
                end,
                ["conclu"] = function()
                    return concluStage(WINDOW_WIDTH, WINDOW_HEIGHT)
                end
            }
        )
    )
    --
    theGame:getStageManager():changeStage("intro")
    print("end loading")
end
--
--
function love.keypressed(key)
    theGame:getInputManager():setKeyPressed(key)
    --
    if key == "escape" then
        print("quit prog")
        theGame:exit()
    end
end
--
--
function love.keyreleased(key)
    theGame:getInputManager():setKeyReleased(key)
end
--
--
function love.mousepressed(x, y, button)
    theGame:getInputManager():setMousePressed(x, y, button)
end
--
function love.mousereleased(x, y, button)
    theGame:getInputManager():setMouseReleased(x, y, button)
end
--
--
function love.update(dt)
    theGame:update(dt)
end
--
--
function love.draw()
    theGame:render()
end
