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

return Utils