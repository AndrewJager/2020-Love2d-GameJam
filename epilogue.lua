local e = {}
e.mood = 0
e.time = 0
e.creditsTime = 0
e.textFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 18)
e.smallFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 12)
e.titleFont = love.graphics.newFont("fonts/TradeWinds-regular.ttf", 80)
e.varText = ""
e.varText2 = ""
e.varText3 = ""
e.credits = false
e.resetKeys = false
local textTime = 1.5

local function load(game)
    e.mood = game.mood
    game.keyDown = 0
    if e.mood >= 0 then 
        e.varText = "I suspect that you think that we're not alone, that there is intelligence out there."
        e.varText2 = "I hope you're right, but I doubt I'll ever know. 178 years is too long for me."
    elseif e.mood < 0 then 
        e.varText = "I suspect that you think that there's no one out there, that we've just been listening to our echos."
        e.varText2 = "That we're alone."
        e.varText3 = "178 years till we possibly hear back. Maybe it doesn't matter. I'll won't be here anyways."
    end
end
e.load = load 

local function update(dt, game)
    e.time = e.time + dt
    if game.keyDown > 0 and e.time > 0 then 
        e.credits = true
    end
    if e.credits then
        e.creditsTime = e.creditsTime + dt 
    end
    if e.creditsTime > 5 and (not e.resetKeys) then
        e.resetKeys = true
        game.keyDown = 0
    end
end
e.update = update 

local function draw()
    
    if e.credits then 
        if e.creditsTime > textTime * 0.5 then
            love.graphics.setFont(e.titleFont)
            love.graphics.setColor(0.80,0.93,1.00)
            love.graphics.print("Lonely Skies", 350, 20)
        end
        love.graphics.setFont(e.textFont)
        love.graphics.setColor(0.9,0.9,0.9)
        if e.creditsTime > textTime * 1.0 then
            love.graphics.print("Created over 72 hours for LÖVE Jam 2020", 180, 220)
        end
        if e.creditsTime > textTime * 2.0 then
            love.graphics.print("Music: The paino that no one in my family can play", 180, 260)
        end
        if e.creditsTime > textTime * 3.0 then
            love.graphics.print("Audio: Audacity tone generator", 180, 300)
        end
        if e.creditsTime > textTime * 4.0 then
            love.graphics.print("Ending shamelessly stolen from \"Ad Astra\"", 180, 340)
        end
        if e.creditsTime > textTime * 5.0 then
            love.graphics.print("Thanks for playing!", 180, 380)
        end
    else
        love.graphics.setColor(0.9,0.9,0.9)
        love.graphics.setFont(e.textFont)
        if e.time > textTime * 1 then 
            love.graphics.print("We've sent the message. 89 light years away. Best case scenario, we get a response in 178 years.", 80, 100)
        end
        if e.time > textTime * 2.0 then 
            love.graphics.print("If there's anyone actually there.", 80, 120)
        end
        if e.time > textTime * 4 then 
            love.graphics.print(e.varText, 80, 200)
        end
        if e.time > textTime * 5.0 then 
            love.graphics.print(e.varText2, 80, 220)
        end
        if e.time > textTime * 6.0 then 
            love.graphics.print(e.varText3, 80, 240)
        end
        if e.time > textTime * 7.5 then 
            love.graphics.print("Either way, for the time being at least, we are alone.", 80, 400)
        end
        if e.time > textTime * 9.0 then 
            love.graphics.print("We're all we've got.", 80, 420)
        end
        if e.time > textTime * 11.5 then 
            love.graphics.print("End transmission", 550, 650)
        end
        if e.time > textTime * 12.5 then 
            love.graphics.setFont(e.smallFont)
            love.graphics.print("(press any key)", 550, 670)
        end
    end
end
e.draw = draw 

return e 