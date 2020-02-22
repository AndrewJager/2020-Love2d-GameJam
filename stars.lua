
local stars = {}

local Utils = require("utils")

local function makeDiamond(width, height)
    local poly = {
    0 - (width/2), 0,
    0, 0 - (height/2),
    0 + (width/2), 0,
    0, 0 + (height/2),
    }
    return poly
end

local function addStar(name, x, y)
    local height = 10
    local width = 6
    table.insert(stars, {name=name, 
        points={x, y},
        height=height,
        width=width,
        color={0.9, 0.9, 0.9},
        shape=makeDiamond(width, height)})
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

local function starDrawPoly(star, point)
    result = {star.shape[1], star.shape[2], star.shape[3], star.shape[4],
    star.shape[5], star.shape[6], star.shape[7], star.shape[8]}
    result[1] = result[1] + point[1]
    result[2] = result[2] + point[2]
    result[3] = result[3] + point[1]
    result[4] = result[4] + point[2]
    result[5] = result[5] + point[1]
    result[6] = result[6] + point[2]
    result[7] = result[7] + point[1]
    result[8] = result[8] + point[2]
    return result
end

local showDistance = 15
local function draw(game, space, ship)
    love.graphics.setColor(1,1,1)
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    for i = 1, #stars do 
        point = starDrawPoint(stars[i], game.threeSixtyToWidth, ship)
        poly = starDrawPoly(stars[i], point)
        -- love.graphics.points(point)
        love.graphics.polygon("fill", poly)

        if space.mode == "search" then
            if Utils.inRange(x, point[1] - showDistance, point[1] + showDistance) 
            and Utils.inRange(y, point[2] - showDistance, point[2] + showDistance) then 
                love.graphics.setLineWidth(0.2)
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