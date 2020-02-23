local story = {}

local function noiseSignal()
    local result = "Nothing here"
    return result
end

local function parseSignal(signal)
    local result = ""
    if signal.id == "noise" then
        result = noiseSignal()
    end

    return result
end 
story.parseSignal = parseSignal

return story