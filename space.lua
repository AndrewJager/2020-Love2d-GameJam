local space = {}
space.stars = require("stars")

local ship = {} --Space ship/probe data
ship.angle = 180
ship.speed = 35
ship.fov = 180

space.ship = ship

local function loadWorld(game)
    ship.fovToView = 360 / ship.fov
    space.stars.load()
end
space.load = loadWorld

local function updateWorld(dt, game)
    local move = "none"
    if love.keyboard.isDown('right', 'd') then
        ship.angle = ship.angle + (ship.speed * dt)
        move = "right"
    elseif love.keyboard.isDown('left', 'a') then
        ship.angle = ship.angle - (ship.speed * dt)
        move = "left"
    end

    if (ship.angle > 360) then 
        local amtOver = ship.angle - 360
        ship.angle = amtOver
    end
    if (ship.angle < 0) then 
        local amtUnder = ship.angle + 360
        ship.angle = amtUnder
    end

    space.stars.update(dt, game, ship, move)
end
space.update = updateWorld

local function drawWorld(game)
    love.graphics.print(ship.angle, 10, 10)
    space.stars.draw(game, ship)
end
space.draw = drawWorld


return space