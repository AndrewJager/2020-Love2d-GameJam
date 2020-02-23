
local game = {}
game.level = "menu"
game.curLevel = "menu"
game.width = 1200
game.threeSixtyToWidth = game.width / 360
game.btnFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 28)
game.exitBtnFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 14)
game.textFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 18)
game.textFontSmall = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 12)
game.commentFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 12)
game.mood = 0
game.keyDown = 0

local music = love.audio.newSource("audio/panio.mp3", "stream")

local space = require("space")
local menu = require("menu")
local epilogue = require("epilogue")

function love.load()
    love.window.setTitle("Lonely Skies")
    love.window.setMode(game.width, 700)
    math.randomseed(os.time())
    menu.load()
end

function love.keypressed(key, unicode)
    game.keyDown = game.keyDown + 1
end

function love.update(dt)
    if game.level ~= game.curLevel then 
        if game.level == "stars" then 
            space.load(game)
        elseif game.level == "menu" then 
            menu.load()
        elseif game.level == "epilogue" then 
            epilogue.load(game)
        end
        game.curLevel = game.level
    end
    if game.level == "stars" then 
        space.update(dt, game)
    elseif game.level == "menu" then
        menu.update(dt, game)
    elseif game.level == "epilogue" then 
        epilogue.update(dt, game)
    end

    if not music:isPlaying() then 
        music:play()
    end
end

function love.draw()
    if game.level == "stars" then 
        space.draw(game)
    elseif game.level == "menu" then 
        menu.draw()
    elseif game.level == "epilogue" then 
        epilogue.draw()
    end
end
