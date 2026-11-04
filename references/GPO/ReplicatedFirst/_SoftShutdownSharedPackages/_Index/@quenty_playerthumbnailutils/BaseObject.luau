 

local u1 = require(script.Parent.loader).load(script)("Maid")
local u2 = {
    ["ClassName"] = "BaseObject"
}
u2.__index = u2
function u2.new(p3) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v4 = u2
    local v5 = setmetatable({}, v4)
    v5._maid = u1.new()
    v5._obj = p3
    return v5
end
function u2.Destroy(p6) --[[ Line: 32 ]]
    p6._maid:DoCleaning()
    setmetatable(p6, nil)
end
return u2