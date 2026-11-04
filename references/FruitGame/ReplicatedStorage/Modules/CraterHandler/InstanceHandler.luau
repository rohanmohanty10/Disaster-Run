 

local u1 = {}
u1.__index = u1
local u2 = require(script:WaitForChild("InstanceCache"))
function u1.new(p3, ...) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v4 = u2.new(p3, ...)
    u1[p3.Name] = v4
end
function u1.getInstance(p5) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6 = u1[p5]
    if v6 then
        v6 = u1[p5]:GetObject()
    end
    return v6
end
function u1.returnInstance(p7, p8) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v9 = u1[p7]
    if v9 then
        v9 = u1[p7]:ReturnObject(p8)
    end
    return v9
end
return u1