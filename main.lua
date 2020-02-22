
local game = {}
game.level = "stars"
game.curLevel = "stars"
game.width = 1200
game.threeSixtyToWidth = game.width / 360
game.btnFont = love.graphics.newFont(24)
game.exitBtnFont = love.graphics.newFont(12)
game.textFont = love.graphics.newFont(18)

local space = require("space")

function love.load()
    love.window.setTitle("Unnamed")
    love.window.setMode(game.width, 700)
    math.randomseed(os.time())
    space.load(game)
end

function love.update(dt)
    space.update(dt, game)
end

function love.draw()
    space.draw(game)
end
