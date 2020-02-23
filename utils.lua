local Utils = {}

local function inRange(x, min, max)
    local result = true 
    if x > max then 
        result = false
    end 
    if x < min then 
        result = false 
    end 
    return result 
end
Utils.inRange = inRange

local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
Utils.round = round

return Utils