
local game = {}
game.level = "stars"
game.curLevel = "stars"

local space = require("space")

function love.load()
    love.window.setTitle("Unnamed")
    love.window.setMode(900, 750)
    space.load()
end

function love.update(dt)
    space.update(dt)
end

function love.draw()
    space.draw()
end
