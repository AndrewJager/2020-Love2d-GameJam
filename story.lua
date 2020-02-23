local story = {}

local signal = require("signals")

local function noiseSignal(space)
    space.hintCount = space.hintCount + 1
    local result = {}
    if space.hintCount > 4 then 
        result[1] = "Our analysis indicates that this is simply random noise."
        result[2] =  "Our scientists think you should try at "..space.hintStar.."."
    else
        result[1] = "Our analysis indicates that this is simply random noise."
        result[2] = "Please continue your search."
    end
    return result
end

local function signalA(space)
    local result = {}
    result[1] = "This is interesting." 
    result[2] = "See if there's anything on the 7190 - 8450 frequency"
    space.stars[3].signals.B = {1,0,1,0,1,0,1,0,1,0}
    space.stars[3].signals.B.id="storyB"
    space.stars[3].signals.B.comments, space.stars[3].signals.C.commentWeights = signal.noiseComments()
    return result
end

local function parseSignal(signal, space)
    local result = ""
    if signal.id == "noise" then
        result = noiseSignal(space)
    elseif signal.id == "storyA" then
        result = signalA(space)
    elseif signal.id == "storyB" then 

    elseif signal.id == "storyC" then 

    end

    return result
end 
story.parseSignal = parseSignal

return story