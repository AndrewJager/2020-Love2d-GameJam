local signal = {}

local function createNoise()
    math.random(0, 10)
    return {math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10), math.random(0, 10), math.random(0, 10),
    math.random(0, 10), math.random(0, 10)}
end

local function noiseComments()
    local comments = {"This seems interesting", "I think this is of intelligent origin", "I don't think this is anything"}
    local commentWeights = {0, 0.4, -0.4}
    return comments, commentWeights
end
signal.noiseComments = noiseComments

-- Create either an empty signal or noise signal for all 4 channels
local function createRandomSignals()
    local signals = {}
    local choice = math.random(0, 100)
    if choice > 0 then
        signals.A = createNoise()
        signals.A.comments, signals.A.commentWeights = noiseComments()
        signals.A.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.B = createNoise()
        signals.B.comments, signals.B.commentWeights = noiseComments()
        signals.B.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.C = createNoise()
        signals.C.comments, signals.C.commentWeights = noiseComments()
        signals.C.id = "noise"
    end
    choice = math.random(0, 100)
    if choice > 60 then
        signals.D = createNoise()
        signals.D.comments, signals.D.commentWeights = noiseComments()
        signals.D.id = "noise"
    end
    return signals
end 
signal.createRandomSignals = createRandomSignals

return signal