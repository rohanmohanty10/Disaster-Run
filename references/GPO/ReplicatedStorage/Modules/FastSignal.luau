 

local u1 = {}
u1.__index = u1
local u2 = {}
u2.__index = u2
function u2.new(p3, p4) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2
    return setmetatable({
        ["_handler"] = p4,
        ["_signal"] = p3
    }, v5)
end
function u2.Disconnect(p6) --[[ Line: 23 ]]
    p6._signal[p6] = nil
end
function u1.new() --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = u1
    return setmetatable({}, v7)
end
function u1.Connect(p8, p9) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = u2.new(p8, p9)
    p8[v10] = true
    return v10
end
function u1.DisconnectAll(p11) --[[ Line: 37 ]]
    table.clear(p11)
end
function u1.Fire(p12, ...) --[[ Line: 41 ]]
    if next(p12) then
        for v13, _ in pairs(p12) do
            v13._handler(...)
        end
    end
end
function u1.Wait(p14) --[[ Line: 49 ]]
    local u15 = coroutine.running()
    local u16 = nil
    u16 = p14:Connect(function(...) --[[ Line: 52 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u15
        --]]
        u16:Disconnect()
        task.spawn(u15, ...)
    end)
    return coroutine.yield()
end
return u1