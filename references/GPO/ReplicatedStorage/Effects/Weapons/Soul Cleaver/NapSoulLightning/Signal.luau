 

local u1 = require(script.Connection)
local v2 = require(script.ThreadReuser)
local u3 = 1
local u4 = { v2.new(), v2.new(), v2.new() }
local u5 = {}
u5.__index = u5
function u5.new(p6, p7) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
    --]]
    local v8 = u5
    local v9 = setmetatable({}, v8)
    v9.OnConnectionAddedCallback = p6
    v9.OnConnectionRemovedCallback = p7
    v9.Head = nil
    v9.Tail = nil
    v9.ThreadReuser = u4[u3 % #u4 + 1]
    u3 = u3 + 1
    return v9
end
function u5.OnConnectionRemoved(p10, p11) --[[ Line: 32 ]]
    p10.OnConnectionRemovedCallback = p11
end
function u5.OnConnectionAdded(p12, p13) --[[ Line: 36 ]]
    p12.OnConnectionAddedCallback = p13
    local v14 = p12.Head
    while v14 do
        p12.ThreadReuser:Run(p13, v14)
        v14 = v14.Previous
    end
end
function u5.Connect(p15, p16) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v17 = u1.new(p15, p16)
    if p15.Head then
        p15.Tail.Previous = v17
        v17.Next = p15.Tail
        p15.Tail = v17
    else
        p15.Head = v17
        p15.Tail = v17
    end
    if p15.OnConnectionAddedCallback then
        p15.OnConnectionAddedCallback(v17)
    end
    return v17
end
function u5.Fire(p18, ...) --[[ Line: 63 ]]
    local v19 = p18.Head
    while v19 do
        p18.ThreadReuser:Run(v19.Callback, ...)
        v19 = v19.Previous
    end
end
function u5.Once(u20, u21) --[[ Line: 71 ]]
    local u22 = nil
    u22 = u20:Connect(function(...) --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u20
            [3] = u21
        --]]
        if u22.Disconnect then
            u22:Disconnect()
        end
        u20.ThreadReuser:Run(u21, ...)
    end)
    return u22
end
function u5.Wait(p23) --[[ Line: 82 ]]
    local u24 = coroutine.running()
    local u25 = nil
    u25 = p23:Connect(function(...) --[[ Line: 85 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u25
        --]]
        task.spawn(u24, ...)
        u25:Disconnect()
    end)
    return coroutine.yield()
end
function u5.DisconnectAll(p26) --[[ Line: 93 ]]
    local v27 = p26.Head
    while v27 do
        local v28 = v27.Next
        v27:Disconnect()
        v27 = v28
    end
end
function u5.Destroy(p29) --[[ Line: 102 ]]
    p29:DisconnectAll()
    setmetatable(p29, nil)
end
return u5