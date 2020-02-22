local signal = {}

local function createNoise()
    math.random(0, 10)
    return {math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10)}
end

-- Create either an empty signal or noise signal for all 4 channels
local function createRandomSignals()
    local signals = {}
    local choice = math.random(0, 100)
    if choice > 0 then
        signals.A = createNoise()
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.B = createNoise()
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.C = createNoise()
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.D = createNoise()
    end
    return signals
end 
signal.createRandomSignals = createRandomSignals

return signal