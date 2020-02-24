local menu = {}
uare = require "Libraries/uare"

menu.stars = {}
menu.time = 0
menu.time2 = 0
menu.selectedStar = 5
menu.starTime = 0.6
menu.font = love.graphics.newFont("fonts/TradeWinds-regular.ttf", 120)
menu.fontSmall = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 24)

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

local function starDrawPoly(shape, point)
    result = {shape[1], shape[2], shape[3], shape[4],
    shape[5], shape[6], shape[7], shape[8]}
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

local function load(game)
    menu.time = 0
    menu.time2 = 0
    game.keyDown = 0
    for i = 1, 50 do 
        table.insert(menu.stars,{math.random(0, 1200), math.random(0, 700)} )
    end
end
menu.load = load 


local function update(dt, game)
    menu.time = menu.time + dt
    menu.time2 = menu.time2 + dt
    if menu.time > menu.starTime then 
        menu.selectedStar = math.random( 1, #menu.stars )
        menu.starTime = math.random( 0.6, 2.0 )
        menu.time = 0
    end
    if (game.keyDown > 0) and (menu.time2 > 1) then 
        game.level = "prologue"
    end

    for i = 1, #menu.stars do 
        menu.stars[i][1] = menu.stars[i][1] - 0.5
        if menu.stars[i][1] < -5 then 
            menu.stars[i][1] = 1205
        end
    end
end
menu.update = update 

local function draw()
    local poly = makeDiamond(4, 10)
    love.graphics.setColor(0.80,0.93,1.00)
    for i = 1,  #menu.stars do 
        local drawThis = starDrawPoly(poly, {menu.stars[i][1], menu.stars[i][2]})
        love.graphics.polygon("fill", drawThis)
    end
    love.graphics.setLineWidth(0.1)
    love.graphics.rectangle("line", menu.stars[menu.selectedStar][1] - 15 / 2, menu.stars[menu.selectedStar][2] - 15 / 2, 15, 15)

    love.graphics.setFont(menu.font)
    love.graphics.print("Lonely Skies", 200, 50)
    love.graphics.setFont(menu.fontSmall)
    love.graphics.print("Press any key to start", 460, 550)
end
menu.draw = draw 

return menu