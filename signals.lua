local signal = {}

local function createNoise()
    math.random(0, 10)
    return {math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10)}
end

local function noiseComments(signal)
    signal.comments = {"One", "Two", "Three"}
end

-- Create either an empty signal or noise signal for all 4 channels
local function createRandomSignals()
    local signals = {}
    local choice = math.random(0, 100)
    if choice > 0 then
        signals.A = createNoise()
        noiseComments(signals.A)
        signals.A.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.B = createNoise()
        noiseComments(signals.B)
        signals.B.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.C = createNoise()
        noiseComments(signals.C)
        signals.C.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.D = createNoise()
        noiseComments(signals.D)
        signals.D.id = "noise"
    end
    return signals
end 
signal.createRandomSignals = createRandomSignals

return signal