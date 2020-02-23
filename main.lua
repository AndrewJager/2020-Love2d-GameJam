
local game = {}
game.level = "menu"
game.curLevel = "menu"
game.width = 1200
game.threeSixtyToWidth = game.width / 360
game.btnFont = love.graphics.newFont(24)
game.exitBtnFont = love.graphics.newFont(12)
game.textFont = love.graphics.newFont(18)
game.textFontSmall = love.graphics.newFont(12)

local space = require("space")
local menu = require("menu")

function love.load()
    love.window.setTitle("Unnamed")
    love.window.setMode(game.width, 700)
    math.randomseed(os.time())
    menu.load()
end

function love.update(dt)
    if game.level ~= game.curLevel then 
        if game.level == "stars" then 
            space.load(game)
        elseif game.level == "menu" then 
            menu.load()
        end
        game.curLevel = game.level
    end
    if game.level == "stars" then 
        space.update(dt, game)
    elseif game.level == "menu" then
        menu.update(dt, game)
    end
end

function love.draw()
    if game.level == "stars" then 
        space.draw(game)
    elseif game.level == "menu" then 
        menu.draw()
    end
end
