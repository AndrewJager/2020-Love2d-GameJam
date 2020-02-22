local uare = require "Libraries/uare"

local space = {}
space.stars = require("stars")
space.mode = "search" --search, listen, process
space.selectedStar = nil

local ship = {} --Space ship/probe data
ship.angle = 180
ship.speed = 35
ship.fov = 180

space.ship = ship

local function loadWorld(game)
    ship.fovToView = 360 / ship.fov
    space.stars.load()

    btnProcessStyle = uare.newStyle({
        width = 200,
        height = 60,
        --color
        color = {0.00,0.82,0.08},
        hoverColor = {0.00,0.62,0.08},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.01,0.17,0.02},
        hoverColor = {0.01,0.17,0.02},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.btnFont,
        align = "center",
        offset = {
            x = 0,
            y = -25
        }
        },
    })
    btnExitStyle = uare.newStyle({
        width = 75,
        height = 20,
        --color
        color = {0.50,0.00,0.00},
        hoverColor = {0.40,0.00,0.00},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.0,0.0,0.0},
        hoverColor = {0.0,0.0,0.0},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.exitBtnFont,
        align = "center",
        offset = {
            x = 0,
            y = -8,
        }
        },
    })
    
    freq1 = uare.new({
        text = {
        display = "2110 - 7145"
        },
        x = 425,
        y = 545,
        onClick = function() 
            space.mode = "search"
        end
        
    }):style(btnProcessStyle)
    freq2 = uare.new({
        text = {
        display = "7190 - 8450"
        },
        x = 425,
        y = 615,
        onClick = function() 
            space.mode = "search"
        end
        
    }):style(btnProcessStyle)
    freq3 = uare.new({
        text = {
        display = "8451 - 31800"
        },
        x = 635,
        y = 545,
        onClick = function() 
            space.mode = "search"
        end
        
    }):style(btnProcessStyle)
    freq4 = uare.new({
        text = {
        display = "31801 - 34700"
        },
        x = 635,
        y = 615,
        onClick = function() 
            space.mode = "search"
        end
        
    }):style(btnProcessStyle)
    exit = uare.new({
        text = {
        display = "Close"
        },
        x = 780,
        y = 510,
        onClick = function() 
            space.mode = "search"
        end
    }):style(btnExitStyle)
end
space.load = loadWorld

local function updateWorld(dt, game)
    if space.mode == "search" then
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
        space.stars.update(dt, game, space, ship, move)
    elseif space.mode == "listen" then 
        uare.update(dt, love.mouse.getX(), love.mouse.getY())
    end
end
space.update = updateWorld

local function drawWorld(game)
    love.graphics.setFont(game.textFont)
    love.graphics.print(ship.angle, 10, 10)
    space.stars.draw(game, space, ship)

    if space.mode == "listen" then
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.rectangle("fill", 15, 500, 850, 185)
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.print("Choose frequency to listen on", 430, 510)
        love.graphics.print(space.selectedStar.name, 30, 510)
        uare.draw()
    end
end
space.draw = drawWorld


return space