local uare = require "Libraries/uare"

local space = {}
space.stars = require("stars")
space.mode = "search" --search, listen, process
space.selectedStar = nil
space.selectedFreq = nil -- nil, "A", "B", "C", "D"
space.playSignal = false
space.playingSignal = false
space.signalTime = 0 -- Used for timing signals
space.sigStep = 1

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
    btnPlayStyle = uare.newStyle({
        width = 50,
        height = 50,
        --color
        color = {0.30,0.30,0.30},
        hoverColor = {0.10,0.10,0.10},
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
            space.mode = "process"
            space.selectedFreq = "A"
        end
        
    }):style(btnProcessStyle)
    freq2 = uare.new({
        text = {
        display = "7190 - 8450"
        },
        x = 425,
        y = 615,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "B"
        end
        
    }):style(btnProcessStyle)
    freq3 = uare.new({
        text = {
        display = "8451 - 31800"
        },
        x = 635,
        y = 545,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "C"
        end
        
    }):style(btnProcessStyle)
    freq4 = uare.new({
        text = {
        display = "31801 - 34700"
        },
        x = 635,
        y = 615,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "D"
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
            space.selectedFreq = nil
            space.selectedStar = nil
            space.playSignal = false
            space.playingSignal = false
        end
    }):style(btnExitStyle)
    play = uare.new({
        text = {
        display = ""
        },
        x = 50,
        y = 510,
        onClick = function() 
            space.playSignal = true
        end
    }):style(btnPlayStyle)
end
space.load = loadWorld

local function listenUI()
    freq1.draw = true
    freq2.draw = true
    freq3.draw = true
    freq4.draw = true
    freq1.active = true
    freq2.active = true
    freq3.active = true
    freq4.active = true
    play.draw = false
    play.active = false
end

local function processUI()
    freq1.draw = false
    freq2.draw = false
    freq3.draw = false
    freq4.draw = false
    freq1.active = false
    freq2.active = false
    freq3.active = false
    freq4.active = false
    play.draw = true 
    play.active = true
end

local function updateSignal(dt)
    local signal = space.stars.getSelectedSignal(space.selectedStar, space.selectedFreq)
    local signalStep = 2
    space.signalTime = space.signalTime + dt
    if space.signalTime < 0.5 then 
        signalStep = 1
    elseif space.signalTime < 1.0 then 
        signalStep = 2
    elseif space.signalTime < 1.5 then 
        signalStep = 3
    elseif space.signalTime < 2.0 then 
        signalStep = 4
    elseif space.signalTime < 2.5 then 
        signalStep = 5
    elseif space.signalTime < 3.0 then 
        signalStep = 6
    elseif space.signalTime < 3.5 then 
        signalStep = 7
    elseif space.signalTime < 4.0 then 
        signalStep = 8
    elseif space.signalTime < 4.5 then 
        signalStep = 9
    elseif space.signalTime < 5.0 then 
        signalStep = 10
    else 
        space.signalTime = 0
        signalStep = 2
    end
    space.sigStep = signalStep
end

local function drawSignalLine(signal, x, y)
    local xSegment = 20
    local yScale = 10
    love.graphics.setLineWidth(0.2)
    love.graphics.setColor(0.0, 0.9, 0.0)
    love.graphics.line(x, signal[1] * -yScale + y,
        x + xSegment * 1, signal[2] * -yScale + y,
        x + xSegment * 2, signal[3] * -yScale + y,
        x + xSegment * 3, signal[4] * -yScale + y,
        x + xSegment * 4, signal[5] * -yScale + y,
        x + xSegment * 5, signal[6] * -yScale + y,
        x + xSegment * 6, signal[7] * -yScale + y,
        x + xSegment * 7, signal[8] * -yScale + y,
        x + xSegment * 8, signal[9] * -yScale + y,
        x + xSegment * 9, signal[10] * -yScale + y)      
end

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
    elseif space.mode == "process" then
        if space.playSignal then 
            if not space.playingSignal then 
                space.signalTime = 0
                space.playingSignal = true
            end
            updateSignal(dt)
        end

        uare.update(dt, love.mouse.getX(), love.mouse.getY())
    end
end
space.update = updateWorld

local function drawWorld(game)
    love.graphics.setFont(game.textFont)
    love.graphics.setColor(0.95, 0.95, 0.95)
    love.graphics.print(ship.angle, 10, 10)
    space.stars.draw(game, space, ship)

    if space.mode == "listen" then
        listenUI()
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.rectangle("fill", 15, 500, 850, 185)
        love.graphics.setColor(0.9, 0.9, 0.9)
        love.graphics.print("Choose frequency to listen on", 430, 510)
        love.graphics.print(space.selectedStar.name, 30, 510)
        uare.draw()
    elseif space.mode == "process" then 
        processUI()
        love.graphics.setColor(0.2, 0.2, 0.2)
        love.graphics.rectangle("fill", 15, 500, 850, 185)
        local signal = space.stars.getSelectedSignal(space.selectedStar, space.selectedFreq)
        love.graphics.setColor(0.9, 0.9, 0.9)
        if signal ~= nil then  
            love.graphics.print(signal[space.sigStep], 430, 510)
            love.graphics.print(space.signalTime, 430, 530)
            love.graphics.print(space.sigStep, 430, 550)
            drawSignalLine(signal, 200, 630)
        else 
            love.graphics.print("No signal", 430, 510)
        end
        uare.draw()
    end
end
space.draw = drawWorld


return space