
local stars = {}

local Utils = require("utils")

local function addStar(name, x, y)
    table.insert(stars, {name=name, points={x, y}})
end

local function load()
    addStar("one", 180, 450)
    addStar("two", 110, 150)
    addStar("three", 180, 250)
end
stars.load = load

local function updateStars(stars, amt)
    for i = 1, #stars do 
        stars[i].points[1] = stars[i].points[1] + amt 
        if (stars[i].points[1] > 360) then 
            local amtOver = stars[i].points[1] - 360
            stars[i].points[1] = amtOver
        end
        if (stars[i].points[1] < 0) then 
            local amtUnder = stars[i].points[1] + 360
            stars[i].points[1] = amtUnder
        end
    end
end

local function update(dt, game, space, ship, move)
    local amt = 0
    if move == "right" then 
        amt = dt * ship.speed 
    elseif move == "left" then 
        amt = dt * -ship.speed 
    end
    updateStars(stars, amt)
end
stars.update = update

local function starDrawPoint(star, rotToWidth, ship)
    result = {star.points[1], star.points[2]}
    result[1] = result[1] * rotToWidth
    result[1] = result[1] * ship.fovToView
    result[1] = result[1] - (ship.fov * rotToWidth)
    return result
end

local showDistance = 15
local function draw(game, space, ship)
    love.graphics.setColor(1,1,1)
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    for i = 1, #stars do 
        point = starDrawPoint(stars[i], game.threeSixtyToWidth, ship)
        love.graphics.points(point)

        if space.mode == "search" then
            if Utils.inRange(x, point[1] - showDistance, point[1] + showDistance) 
            and Utils.inRange(y, point[2] - showDistance, point[2] + showDistance) then 
                love.graphics.rectangle("line", point[1] - showDistance / 2, point[2] - showDistance / 2, showDistance, showDistance)
                if love.mouse.isDown(1) then
                    space.selectedStar = stars[i]
                    space.mode = "listen"
                end
            end
        end
    end
end
stars.draw = draw 

return stars