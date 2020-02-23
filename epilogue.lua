local e = {}
e.mood = 0
e.time = 0
e.creditsTime = 0
e.textFont = love.graphics.newFont("fonts/Inconsolata-regular.ttf", 18)
e.varText = ""
e.varText2 = ""
e.varText3 = ""
e.credits = false
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
        e.varText3 = "178 years till we possibly hear back. Maybe it doesn't matter. I'll be dead anyways."
    end
end
e.load = load 

local function update(dt, game)
    e.time = e.time + dt
    if game.keyDown > 0 and e.time > 14 then 
        e.credits = true
    end
    if e.credits then
        e.creditsTime = e.creditsTime + dt 
    end
end
e.update = update 

local function draw()
    love.graphics.setFont(e.textFont)
    if e.credits then 
        if e.creditsTime > textTime * 0.5 then
            love.graphics.print("Thanks for playing!", 80, 120)
        end
    else
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
    end
end
e.draw = draw 

return e 