 

local u1 = require(script.Parent.Logging)
local u2 = {
    ["Disabled"] = "Disabled",
    ["Suspended"] = "Suspended",
    ["Enabled"] = "Enabled"
}
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v5 = {
        ["_suspendedEventQueue"] = {},
        ["_connections"] = {},
        ["_listeners"] = {},
        ["_status"] = u2.Disabled,
        ["_isResuming"] = false,
        ["_instance"] = p4
    }
    local v6 = u3
    return setmetatable(v5, v6)
end
function u3.connectEvent(p7, p8, p9) --[[ Line: 51 ]]
    p7:_connect(p8, p7._instance[p8], p9)
end
function u3.connectPropertyChange(u10, u11, p12) --[[ Line: 55 ]]
    local v13, v14 = pcall(function() --[[ Line: 56 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
        --]]
        return u10._instance:GetPropertyChangedSignal(u11)
    end)
    if not v13 then
        error(("Cannot get changed signal on property %q: %s"):format(tostring(u11), v14), 0)
    end
    u10:_connect("Change." .. u11, v14, p12)
end
function u3._connect(u15, u16, p17, p18) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p18 == nil then
        if u15._connections[u16] ~= nil then
            u15._connections[u16]:Disconnect()
            u15._connections[u16] = nil
        end
        u15._listeners[u16] = nil
    else
        if u15._connections[u16] == nil then
            u15._connections[u16] = p17:Connect(function(...) --[[ Line: 78 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u2
                    [3] = u16
                --]]
                if u15._status == u2.Enabled then
                    u15._listeners[u16](u15._instance, ...)
                elseif u15._status == u2.Suspended then
                    local v19 = select("#", ...)
                    local v20 = u15._suspendedEventQueue
                    local v21 = { u16, v19, ... }
                    table.insert(v20, v21)
                end
            end)
        end
        u15._listeners[u16] = p18
    end
end
function u3.suspend(p22) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    p22._status = u2.Suspended
end
function u3.resume(p23) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    if not p23._isResuming then
        p23._isResuming = true
        local v24 = 1
        while v24 <= #p23._suspendedEventQueue do
            local v25 = p23._suspendedEventQueue[v24]
            local v26 = p23._listeners[v25[1]]
            local v27 = v25[2]
            if v26 ~= nil then
                local v28 = coroutine.create(v26)
                local v29 = coroutine.resume
                local v30 = p23._instance
                local v31 = 2 + v27
                local v32, v33 = v29(v28, v30, unpack(v25, 3, v31))
                if not v32 then
                    u1.warn("%s", v33)
                end
            end
            v24 = v24 + 1
        end
        p23._isResuming = false
        p23._status = u2.Enabled
        p23._suspendedEventQueue = {}
    end
end
return u3