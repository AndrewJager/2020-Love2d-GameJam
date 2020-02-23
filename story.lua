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
    space.stars[3].signals.C = nil
    space.stars[3].signals.B = {4,0,4,0,4,0,4,0,4,0}
    space.stars[3].signals.B.id="storyB"
    space.stars[3].signals.B.comments={"I think this is it!", "Probably just some interference", "Signal from Delta-702 - - - 7190 - 8450 frequency"}
    space.stars[3].signals.B.commentWeights={2, -2, 0}
    return result
end

local function signalB(space)
    local result = {}
    result[1] = "Our scientists have analyised the signals you recieved from this star, unfortunately," 
    result[2] = "they have concluded that this is just our signals bouncing off of space debris."
    result[3] = "Please continue your search."
    space.stars[3].signals.B = nil
    space.hintStar = "Dusk-646"
    space.stars[4].signals.A = {8,7,6,5,4,5,6,7,8,7}
    space.stars[4].signals.A.id="storyC"
    space.stars[4].signals.A.comments={"This is probably nothing, but check it anyways",
     "Here's the signal you're looking for", "I think this is it!"}
    space.stars[4].signals.A.commentWeights={-2, 1, 2}
    return result
end

local function signalC(space)
    local result = {}
    result[1] = "While this signal is interesting due to it's non-randomness, we still believe it "
    result[2] = "to be of natural origin."
    result[3] = "Please continue your search"
    space.stars[4].signals.A = nil 
    space.hintStar = "Solitude-624"
    space.stars[5].signals.D = {4,5,5,6,7,7,6,5,5,4}
    space.stars[5].signals.D.id="storyD"
    space.stars[5].signals.D.comments={"I don't think we're alone",
     "Signal from Solitude-624 - - - 31801 - 34700 frequency", "This whole endeavour is a waste of time"}
    space.stars[5].signals.D.commentWeights={4, 0, -4}
    return result
end

local function signalD(space)
    local result = {}
    result[1] = "We think we've found something here."
    result[2] = "Please check the same star and frequency again to confirm your results"
    space.stars[5].signals.D = {6,7,8,8,7,6,5,4,5,6}
    space.stars[5].signals.D.id="storyE"
    space.stars[5].signals.D.comments={"We did it, didn't we?",
     "Nothing to be excited about, I'm sure this is just more noise", "This is certainly interesting"}
    space.stars[5].signals.D.commentWeights={2, -2, 0}
    return result
end

local function signalE(space)
    local result = {}
    result[1] = "While it's impossible to prove, we believe that the best explination for these"
    result[2] = "signals is intelligent life. We belive this star is the best canidate for our message"
    result[3] = "Congratulations, this mission has been a success."
    space.mode = "epilogue"
    return result
end

local function parseSignal(signal, space)
    local result = ""
    if signal.id == "noise" then
        result = noiseSignal(space)
    elseif signal.id == "storyA" then
        result = signalA(space)
    elseif signal.id == "storyB" then 
        result = signalB(space)
    elseif signal.id == "storyC" then 
        result = signalC(space)
    elseif signal.id == "storyD" then 
        result = signalD(space)
    elseif signal.id == "storyE" then
        result = signalE(space)
    end

    return result
end 
story.parseSignal = parseSignal

return story