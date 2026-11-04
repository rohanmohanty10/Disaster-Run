 

local u1 = nil
local function u4(p2, ...) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    u1 = nil
    p2(...)
    u1 = v3
end
local function u5(...) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4(...)
    while true do
        u4(coroutine.yield())
    end
end
local u6 = {}
u6.__index = u6
function u6.new(p7, p8) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v9 = u6
    return setmetatable({
        ["_connected"] = true,
        ["_signal"] = p7,
        ["_fn"] = p8,
        ["_next"] = false
    }, v9)
end
function u6.Disconnect(p10) --[[ Line: 65 ]]
    local v11 = p10._connected
    assert(v11, "Can\'t disconnect a connection twice.", 2)
    p10._connected = false
    local v12 = p10._signal
    if v12._handlerListHead == p10 then
        v12._handlerListHead = p10._next
    else
        local v13 = v12._handlerListHead
        while v13 and v13._next ~= p10 do
            v13 = v13._next
        end
        if v13 then
            v13._next = p10._next
        end
    end
    if v12.connectionsChanged then
        v12.totalConnections = v12.totalConnections - 1
        v12.connectionsChanged:Fire(-1)
    end
end
setmetatable(u6, {
    ["__index"] = function(_, p14) --[[ Name: __index, Line 94 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p14))), 2)
    end,
    ["__newindex"] = function(_, p15, _) --[[ Name: __newindex, Line 97 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p15))), 2)
    end
})
local u16 = {}
u16.__index = u16
function u16.new(p17) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    local v18 = u16
    local v19 = setmetatable({
        ["_handlerListHead"] = false
    }, v18)
    if p17 then
        v19.totalConnections = 0
        v19.connectionsChanged = u16.new()
    end
    return v19
end
function u16.Connect(p20, p21) --[[ Line: 117 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v22 = u6.new(p20, p21)
    if p20._handlerListHead then
        v22._next = p20._handlerListHead
        p20._handlerListHead = v22
    else
        p20._handlerListHead = v22
    end
    if p20.connectionsChanged then
        p20.totalConnections = p20.totalConnections + 1
        p20.connectionsChanged:Fire(1)
    end
    return v22
end
function u16.DisconnectAll(p23) --[[ Line: 135 ]]
    p23._handlerListHead = false
    if p23.connectionsChanged then
        p23.connectionsChanged:Fire(-p23.totalConnections)
        p23.connectionsChanged:Destroy()
        p23.connectionsChanged = nil
        p23.totalConnections = 0
    end
end
u16.Destroy = u16.DisconnectAll
u16.destroy = u16.DisconnectAll
function u16.Fire(p24, ...) --[[ Line: 152 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    local v25 = p24._handlerListHead
    while v25 do
        if v25._connected then
            if not u1 then
                u1 = coroutine.create(u5)
            end
            task.spawn(u1, v25._fn, ...)
        end
        v25 = v25._next
    end
end
function u16.Wait(p26) --[[ Line: 167 ]]
    local u27 = coroutine.running()
    local u28 = nil
    u28 = p26:Connect(function(...) --[[ Line: 170 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u27
        --]]
        u28:Disconnect()
        task.spawn(u27, ...)
    end)
    return coroutine.yield()
end
return u16