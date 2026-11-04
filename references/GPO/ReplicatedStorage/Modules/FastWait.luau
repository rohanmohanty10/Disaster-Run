 

local v1 = {}
local v2 = game:GetService("RunService")
local u3 = nil
local function u8(p4, p5) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = { p4, p5 }
    if u3 then
        if p5 <= u3[2] then
            v6[3] = u3
            u3 = v6
        else
            local v7 = u3
            while v7[3] and v7[3][2] < p5 do
                v7 = v7[3]
            end
            v6[3] = v7[3]
            if v7[3] then
                v6[3][4] = v6
            end
            v7[3] = v6
            v6[4] = v7
        end
    else
        u3 = v6
        return
    end
end
local function v12() --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v9 = tick()
    while u3 and u3[2] - v9 < 0.005 do
        local v10 = u3[1]
        local v11 = u3[3]
        if v11 then
            v11[4] = nil
        end
        u3 = v11
        coroutine.resume(v10, v9)
    end
end
if v2:IsClient() == false then
    v2.Heartbeat:Connect(v12)
else
    v2.Heartbeat:Connect(v12)
end
function v1.Wait(_, p13) --[[ Line: 88 ]]
    task.wait((tonumber(p13)))
end
function v1.Spawn(_, u14, ...) --[[ Line: 100 ]]
    debug.profilebegin("Thread:Spawn")
    local u15 = { ... }
    local u16 = select("#", ...)
    local u17 = Instance.new("BindableEvent")
    u17.Event:Connect(function(p18) --[[ Line: 107 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u17
        --]]
        u14(p18())
        u17:Destroy()
    end)
    u17:Fire(function() --[[ Line: 112 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u16
        --]]
        local v19 = u15
        local v20 = u16
        return unpack(v19, 1, v20)
    end)
    debug.profileend()
end
function v1.Delay(u21, u22, u23) --[[ Line: 119 ]]
    u21:Spawn(function() --[[ Line: 120 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
            [3] = u23
        --]]
        local v24, v25 = u21:Wait(u22)
        u23(v24, v25)
    end)
end
return function(p26) --[[ Name: fastwait, Line 126 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v27 = tonumber(p26) or 0.03333333333333333
    local v28 = tick()
    u8(coroutine.running(), v28 + (v27 or 0))
    return coroutine.yield() - v28, elapsedTime()
end