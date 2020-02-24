local prologue = {}
prologue.time = 0
prologue.textFont = love.graphics.newFont("fonts/Inconsolata-Regular.ttf", 18)
prologue.helpFont = love.graphics.newFont("fonts/Inconsolata-Regular.ttf", 14)

local function load(game)
    prologue.time = 0
    game.keyDown = 0
end
prologue.load = load 

local function update(dt, game)
    prologue.time = prologue.time + dt
    if prologue.time > 7.0 and game.keyDown > 0 then 
        game.level = "stars"
    end
end
prologue.update = update

local function draw()
    love.graphics.setFont(prologue.textFont)
    love.graphics.setColor(0.9,0.9,0.9)
    if prologue.time > 1.0 then
        love.graphics.print("Are we alone in the universe?", 80, 120)
    end
    if prologue.time > 2.5 then
        love.graphics.print("Today, our newest space probe begins its search for intelligent life.", 80, 180)
    end
    if prologue.time > 4.0 then
        love.graphics.print("It will analyse radio waves from other stars, listening for evidence that we are not alone.", 80, 240)
    end
    if prologue.time > 5.5 then
        love.graphics.print("If a suitable star is found, we will send a message attempting to make contact with any intelligence there.", 80, 300)
    end
    if prologue.time > 7.0 then
        love.graphics.setFont(prologue.helpFont)
        love.graphics.print("Press A/D (or left/right arrow keys) to pan the camera", 200, 400)
        love.graphics.print("Click on a star to analyse it", 200, 420)
        love.graphics.print("Select a frequency to listen to", 200, 440)
        love.graphics.print("If you believe that the signal could be from intelligence, send it back to mission control", 200, 460)
        love.graphics.print("(press any key to to begin)", 300, 500)
    end
end
prologue.draw = draw 

return prologue