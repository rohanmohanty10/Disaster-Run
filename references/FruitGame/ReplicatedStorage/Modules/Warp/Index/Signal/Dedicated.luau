 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    return setmetatable({
        ["fn"] = p3,
        ["root"] = p2
    }, v4)
end
function u1.Disconnect(p5) --[[ Line: 14 ]]
    table.clear(p5)
    setmetatable(p5, nil)
end
return u1.new