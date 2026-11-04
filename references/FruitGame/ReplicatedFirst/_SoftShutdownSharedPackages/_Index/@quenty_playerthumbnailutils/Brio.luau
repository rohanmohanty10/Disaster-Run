 

local u1 = require(script.Parent.loader).load(script)("Maid")
local u2 = {
    ["ClassName"] = "Brio"
}
u2.__index = u2
function u2.isBrio(p3) --[[ Line: 76 ]]
    local v4
    if type(p3) == "table" then
        v4 = p3.ClassName == "Brio"
    else
        v4 = false
    end
    return v4
end
function u2.new(...) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = {
        ["_values"] = table.pack(...)
    }
    local v6 = u2
    return setmetatable(v5, v6)
end
function u2.delayed(p7, ...) --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u8 = u2.new(...)
    task.delay(p7, function() --[[ Line: 107 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        u8:Kill()
    end)
    return u8
end
function u2.GetDiedSignal(p9) --[[ Line: 133 ]]
    if p9:IsDead() then
        error("Brio is dead")
    end
    if p9._diedEvent then
        return p9._diedEvent.Event
    end
    p9._diedEvent = Instance.new("BindableEvent")
    return p9._diedEvent.Event
end
function u2.IsDead(p10) --[[ Line: 160 ]]
    return p10._values == nil
end
function u2.ErrorIfDead(p11) --[[ Line: 171 ]]
    if not p11._values then
        error("[Brio.ErrorIfDead] - Brio is dead")
    end
end
function u2.ToMaid(p12) --[[ Line: 196 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v13 = p12._values ~= nil
    assert(v13, "Brio is dead")
    local u14 = u1.new()
    u14:GiveTask(p12:GetDiedSignal():Connect(function() --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        u14:DoCleaning()
    end))
    return u14
end
function u2.GetValue(p15) --[[ Line: 226 ]]
    local v16 = p15._values
    assert(v16, "Brio is dead")
    local v17 = p15._values
    local v18 = p15._values.n
    return unpack(v17, 1, v18)
end
function u2.GetPackedValues(p19) --[[ Line: 238 ]]
    local v20 = p19._values
    assert(v20, "Brio is dead")
    return p19._values
end
function u2.Destroy(p21) --[[ Line: 259 ]]
    if p21._values then
        p21._values = nil
        if p21._diedEvent then
            p21._diedEvent:Fire()
            p21._diedEvent:Destroy()
            p21._diedEvent = nil
        end
    end
end
u2.Kill = u2.Destroy
u2.DEAD = u2.new()
u2.DEAD:Kill()
return u2