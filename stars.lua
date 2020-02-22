
local stars = {}
stars.points = {}

local Utils = require("utils")

local function load()
    table.insert(stars.points, {180, 450})
    table.insert(stars.points, {110, 150})
    table.insert(stars.points, {180, 250})
end
stars.load = load

local function updateStars(stars, amt)
    for i = 1, #stars do 
        stars[i][1] = stars[i][1] + amt 
        if (stars[i][1] > 360) then 
            local amtOver = stars[i][1] - 360
            stars[i][1] = amtOver
        end
        if (stars[i][1] < 0) then 
            local amtUnder = stars[i][1] + 360
            stars[i][1] = amtUnder
        end
    end
end

local function update(dt, game, ship, move)
    local amt = 0
    if move == "right" then 
        amt = dt * ship.speed 
    elseif move == "left" then 
        amt = dt * -ship.speed 
    end
    updateStars(stars.points, amt)
end
stars.update = update

local function starDrawPoint(star, rotToWidth, ship)
    result = {star[1], star[2]}
    result[1] = result[1] * rotToWidth
    result[1] = result[1] * ship.fovToView
    result[1] = result[1] - (ship.fov * rotToWidth)
    return result
end

local showDistance = 15
local function draw(game, ship)
    love.graphics.setColor(1,1,1)
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local points = stars.points
    for i = 1, #points do 
        point = starDrawPoint(stars.points[i], game.threeSixtyToWidth, ship)
        love.graphics.points(point)

        if Utils.inRange(x, point[1] - showDistance, point[1] + showDistance) 
        and Utils.inRange(y, point[2] - showDistance, point[2] + showDistance) then 
            love.graphics.rectangle("line", point[1] - showDistance / 2, point[2] - showDistance / 2, showDistance, showDistance)
        end
    end
end
stars.draw = draw 

return stars