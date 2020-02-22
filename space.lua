local space = {}
space.stars = require("stars")

local ship = {} --Space ship/probe data
ship.angle = 180
ship.speed = 15
ship.fov = 120

space.ship = ship

local function loadWorld()
    space.stars.load()
end
space.load = loadWorld

local function updateWorld(dt)
    local move = "none"
    if love.keyboard.isDown('right', 'd') then
        ship.angle = ship.angle + (ship.speed * dt)
        move = "right"
    elseif love.keyboard.isDown('left', 'a') then
        ship.angle = ship.angle - (ship.speed * dt)
        move = "left"
    end

    space.stars.update(dt, ship, move)
end
space.update = updateWorld

local function drawWorld()
    love.graphics.print(ship.angle, 10, 10)
    space.stars.draw(ship)
end
space.draw = drawWorld


return space