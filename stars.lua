
local stars = {}

local Utils = require("utils")
local signal = require("signals")

local function makeDiamond(width, height)
    local w = width
    local h = height
    local poly = {}
    poly = {
    0 - (w/2), 0,
    0, 0 - (h/2),
    0 + (w/2), 0,
    0, 0 + (h/2),
    }
    return poly
end

local function addStar(name, x, y)
    local height = 8
    local width = 6
    local randPercent = 0.3
    local starHeight=math.random(height - (height * randPercent), height + (height * randPercent))
    local starWidth=math.random(width - (width * randPercent), width + (width * randPercent))
    table.insert(stars, {name=name, 
        points={x, y},
        height=starHeight,
        width=starWidth,
        color={0.80,0.93,1.00},
        shape=makeDiamond(starWidth, starHeight),
        portrait=makeDiamond(starWidth * 6, starHeight * 6),
        signals=signal.createRandomSignals(),
        distance=math.random(4.5, 1500)
    })
end

local function createNoise()
    math.random(0, 10)
    return {math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10)}
end

local function load()
    math.randomseed(os.time())
    table.insert(stars, {name="Sun", 
        points={300, 120},
        height=80,
        width=80,
        color={1.00,0.98,0.60},
        shape=makeDiamond(40, 40),
        portrait=makeDiamond(40, 40),
        signals={},
        distance=0.2
    })  
    table.insert(stars, {name="Home", 
        points={285, 135},
        height=10,
        width=10,
        color={0.6,0.6,0.90},
        shape=makeDiamond(5, 5),
        portrait=makeDiamond(10, 10),
        signals={},
        distance=0.3
    })   
    table.insert(stars, {name="Delta-702", 
        points={92, 79},
        height=10,
        width=10,
        color={0.80,0.93,1.00},
        shape=makeDiamond(10, 14),
        portrait=makeDiamond(10, 10),
        signals={C=
            {0,8,8,0,0,0,0,8,8,0},
        },
        distance=4.68
    })  
    stars[3].signals.C.id="storyA"
    stars[3].signals.C.comments, stars[3].signals.C.commentWeights = signal.noiseComments()


    addStar("Kelper-28", 180, 450)
    addStar("Feathers-61", 110, 150)
    addStar("Snow-975", 188, 250)
    addStar("MI-481", 221, 61)
    addStar("North-4681", 0, 450)
    addStar("Zeus-343", 345, 104)
    addStar("Osiris-74", 95, 145)
    addStar("Osiris-76", 88, 190)
    addStar("Osiris-77", 97, 175)
    addStar("Osiris-90", 91, 201)
    addStar("Cody-124", 61, 332)
    addStar("Valentine-912", 27, 13)
    addStar("Felis-1006", 41, 120)
    addStar("Gray-2019", 156, 223)


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
        amt = dt * -ship.speed 
    elseif move == "left" then 
        amt = dt * ship.speed 
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
        love.graphics.setColor(stars[i].color[1], stars[i].color[2], stars[i].color[3])
        love.graphics.polygon("fill", poly)

        if space.mode == "search" then
            if Utils.inRange(x, point[1] - showDistance, point[1] + showDistance) 
            and Utils.inRange(y, point[2] - showDistance, point[2] + showDistance) then 
                love.graphics.setLineWidth(0.2)
                love.graphics.setColor(0.95, 0.95, 0.95)
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

local function getSelectedSignal(star, sig)
    if sig == "A" then 
        return star.signals.A
    elseif sig == "B" then 
        return star.signals.B 
    elseif sig == "C" then 
        return star.signals.C 
    elseif sig == "D" then 
        return star.signals.D 
    end
end
stars.getSelectedSignal = getSelectedSignal

return stars