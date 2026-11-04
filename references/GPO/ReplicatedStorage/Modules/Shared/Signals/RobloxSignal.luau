 

local u1 = {}
u1.__index = u1
function u1.new() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v2 = Instance.new("BindableEvent")
    local u3 = {}
    v2.Event:Connect(function(_, p4) --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3[p4] = nil
    end)
    local v5 = {
        ["_inst"] = v2,
        ["_args"] = u3,
        ["_event"] = v2.Event
    }
    local v6 = u1
    return setmetatable(v5, v6)
end
function u1.Connect(u7, u8) --[[ Line: 29 ]]
    return u7._event:Connect(function(p9, p10) --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u7
        --]]
        local v11 = u8
        local v12 = u7._args[p10]
        v11(unpack(v12, 1, p9))
    end)
end
function u1.DisconnectAll(p13) --[[ Line: 35 ]]
    p13._inst:Destroy()
    local v14 = Instance.new("BindableEvent")
    local u15 = {}
    v14.Event:Connect(function(_, p16) --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        u15[p16] = nil
    end)
    p13._inst = v14
    p13._args = u15
    p13._event = v14.Event
end
function u1.Fire(p17, ...) --[[ Line: 47 ]]
    local v18 = { ... }
    local v19 = #v18
    local function v20() --[[ Line: 51 ]] end
    p17._args[v20] = v18
    p17._inst:Fire(v19, v20)
end
function u1.Wait(p21) --[[ Line: 56 ]]
    local v22, v23 = p21._event:Wait()
    local v24 = p21._args[v23]
    return unpack(v24, 1, v22)
end
function u1.Once(u25, u26) --[[ Line: 61 ]]
    return u25._event:ConnectOnce(function(p27, p28) --[[ Line: 62 ]]
        --[[
        Upvalues:
            [1] = u26
            [2] = u25
        --]]
        local v29 = u26
        local v30 = u25._args[p28]
        v29(unpack(v30, 1, p27))
    end)
end
return u1