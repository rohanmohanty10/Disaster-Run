 

local u1 = {}
u1.__index = u1
local u2 = require(script.Dedicated)
local v3 = script.Parent.Util
local u4 = require(v3.Key)
local u5 = require(v3.Assert)
local u6 = {}
function u1.new(p7) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u1
    --]]
    u5(typeof(p7) == "string", (("[Signal]: Identifier must be a string type, got %*"):format((typeof(p7)))))
    if u6[p7] then
        return u6[p7]
    end
    local v8 = u1
    local v9 = setmetatable({}, v8)
    u6[p7] = v9
    return v9
end
function u1.Connect(p10, p11, p12) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    if not p12 then
        local v13 = u4
        p12 = tostring(v13())
    end
    p10[p12] = u2(p10, p11)
    return p12
end
function u1.Once(u14, u15) --[[ Line: 31 ]]
    local u16 = nil
    u16 = u14:Connect(function(...) --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u16
            [3] = u15
        --]]
        u14:Disconnect(u16)
        task.spawn(u15, ...)
    end)
    return u16
end
function u1.Disconnect(p17, p18) --[[ Line: 40 ]]
    if p17[p18] then
        p17[p18]:Disconnect()
        p17[p18] = nil
    end
end
function u1.DisconnectAll(p19) --[[ Line: 46 ]]
    table.clear(p19)
end
function u1.Wait(p20) --[[ Line: 50 ]]
    local u21 = os.clock()
    local u22 = coroutine.running()
    p20:Once(function() --[[ Line: 52 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u21
        --]]
        task.spawn(u22, os.clock() - u21)
    end)
    return coroutine.yield()
end
function u1.DeferFire(p23, ...) --[[ Line: 58 ]]
    for _, v24 in p23 do
        task.defer(v24.fn, ...)
    end
end
function u1.Fire(p25, ...) --[[ Line: 64 ]]
    for _, v26 in p25 do
        task.spawn(v26.fn, ...)
    end
end
function u1.FireTo(_, p27, ...) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    local v28 = u6[p27]
    if v28 then
        u1.Fire(v28, ...)
    end
end
function u1.Invoke(p29, p30, ...) --[[ Line: 76 ]]
    local v31 = p29[p30]
    if v31 then
        return v31.fn(...)
    end
end
function u1.InvokeTo(_, p32, p33, ...) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    if u6[p32] then
        return u1.Invoke(u6[p32], p33, ...)
    end
end
function u1.Destroy(p34) --[[ Line: 87 ]]
    p34:DisconnectAll()
    setmetatable(p34, nil)
end
return u1.new