 

local u4 = {
    ["filled"] = function(p1) --[[ Name: filled, Line 9 ]]
        return #p1.history == p1.max_length
    end,
    ["push"] = function(p2, p3) --[[ Name: push, Line 13 ]]
        if p2:filled() then
            p2.history[p2.oldest] = p3
            p2.oldest = p2.oldest == p2.max_length and 1 or p2.oldest + 1
        else
            p2.history[#p2.history + 1] = p3
        end
    end,
    ["metatable"] = {}
}
function u4.metatable.__index(p5, p6) --[[ Line: 27 ]]
    local v7 = #p5.history
    if p6 == 0 or v7 < math.abs(p6) then
        return nil
    end
    if p6 >= 1 then
        local v8 = (p5.oldest - p6 - 1) % v7 + 1
        return p5.history[v8]
    end
    if p6 <= -1 then
        local v9 = (p6 + 1 + p5.oldest - 1) % v7 + 1
        return p5.history[v9]
    end
end
function u4.metatable.__len(p10) --[[ Line: 41 ]]
    return #p10.history
end
function u4.new(p11) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if type(p11) ~= "number" or p11 <= 1 then
        error("Buffer length must be a positive integer")
    end
    local v12 = {
        ["history"] = {},
        ["oldest"] = 1,
        ["max_length"] = p11,
        ["push"] = u4.push,
        ["filled"] = u4.filled
    }
    local v13 = u4.metatable
    setmetatable(v12, v13)
    return v12
end
return u4