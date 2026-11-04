 

local u1 = require(script.Parent.loader).load(script)("Subscription")
local u2 = {
    ["ClassName"] = "Observable"
}
u2.__index = u2
function u2.isObservable(p3) --[[ Line: 73 ]]
    local v4
    if type(p3) == "table" then
        v4 = p3.ClassName == "Observable"
    else
        v4 = false
    end
    return v4
end
function u2.new(p5) --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = type(p5) == "function"
    assert(v6, "Bad onSubscribe")
    local v7 = u2
    return setmetatable({
        ["_source"] = "",
        ["_onSubscribe"] = p5
    }, v7)
end
function u2.Pipe(p8, p9) --[[ Line: 134 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = type(p9) == "table"
    assert(v10, "Bad transformers")
    for _, v11 in pairs(p9) do
        local v12 = type(v11) == "function"
        assert(v12, "Bad transformer")
        p8 = v11(p8)
        local v13 = u2.isObservable
        assert(v13(p8))
    end
    return p8
end
function u2.Subscribe(p14, p15, p16, p17) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v18 = u1.new(p15, p16, p17)
    local v19 = p14._onSubscribe(v18)
    if v19 then
        v18:_giveCleanup(v19)
    end
    return v18
end
return u2