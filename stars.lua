

local stars = {}
stars.points = {}

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

local function draw(game, ship)
    love.graphics.setColor(1,1,1)
    local points = stars.points
    for i = 1, #points do 
        love.graphics.points(starDrawPoint(stars.points[i], game.threeSixtyToWidth, ship))
    end
end
stars.draw = draw 

return stars