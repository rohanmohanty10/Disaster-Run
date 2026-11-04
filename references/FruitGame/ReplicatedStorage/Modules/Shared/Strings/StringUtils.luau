 

local v3 = {
    ["FirstToUpper"] = function(p1) --[[ Name: FirstToUpper, Line 3 ]]
        return p1:lower():gsub("^%l", string.upper)
    end,
    ["GetNumbersFromString"] = function(p2) --[[ Name: GetNumbersFromString, Line 7 ]]
        return string.gsub(p2, "%D", "")
    end
}
local function u5(p4) --[[ Line: 11 ]]
    return string.format("%02i", p4)
end
v3.TimeFormat = u5
function v3.ConvertToHMS(p6) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v7 = (p6 - p6 % 60) / 60
    local v8 = p6 - v7 * 60
    local v9 = (v7 - v7 % 60) / 60
    local v10 = v7 - v9 * 60
    return string.format("%02i", v9), string.format("%02i", v10), u5(v8)
end
return v3