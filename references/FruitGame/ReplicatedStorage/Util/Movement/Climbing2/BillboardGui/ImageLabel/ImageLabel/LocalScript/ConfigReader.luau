 

local u1 = math.floor
local u2 = math.sqrt
function GetOffset(p3, p4)
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v5 = u2(p3.count)
    local v6 = u1(p4) % p3.count
    return (p3.diameter + p3.padding * 2) * u1(v6 % v5) + p3.padding, (p3.diameter + p3.padding * 2) * u1(v6 / v5) + p3.padding
end
function GetSize(p7)
    return p7.diameter, p7.diameter
end
return {
    ["GetOffset"] = GetOffset,
    ["GetSize"] = GetSize
}