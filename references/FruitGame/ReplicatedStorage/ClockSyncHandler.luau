 

local v1 = {}
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("Players")
local u5 = v3:WaitForChild("ClockSync")
local u6 = u2:IsClient()
function v1.GetTime(p7, p8) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if not u6 then
        return p8 or tick()
    end
    local v9 = p7.ServerTimeOffset or 0
    return (p8 or tick()) + v9
end
function v1.Update(u10) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
    --]]
    local u11 = tick()
    u10.AverageFrameTime = u10.AverageFrameTime * 0.9 + (u11 - u10.LastUpdate) * 0.1
    u10.LastUpdate = u11
    if not u6 then
        for u12, u13 in u10.AverageDelays do
            local u14 = u10.PlayerCaches[u12]
            for v15, v16 in u14 do
                if u11 - v16[1] > 10 then
                    u14[v15] = nil
                end
            end
            coroutine.resume(coroutine.create(function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u12
                    [3] = u11
                    [4] = u13
                    [5] = u10
                    [6] = u14
                --]]
                local v17, _, _, v18, v19, v20, v21 = pcall(function() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u12
                        [3] = u11
                        [4] = u13
                        [5] = u10
                    --]]
                    return u5:InvokeClient(u12, u11, u13, u10.AverageFrameTime)
                end)
                local v22 = tick() - u11
                if v17 and u10.PlayerCaches[u12] then
                    if v21 then
                        local v23 = v21[1]
                        local v24 = u14[v23]
                        if v24 then
                            for v25, v26 in i(v21[2]) do
                                local v27 = v24[2][v25]
                                if v27 then
                                    local v28 = 0.5 * (v27 - (v26[1] + v26[2]))
                                    u10.AverageDelays[u12] = u10.AverageDelays[u12] * 0.9 + v28 * 0.1
                                end
                            end
                            u14[v23] = nil
                        end
                    end
                    if not u14[v19] and v18 then
                        u14[v19] = {
                            tick(),
                            {}
                        }
                    end
                    local v29 = u14[v19]
                    if v29 then
                        v29[2][v20] = v22
                    end
                end
            end))
        end
    end
end
if u6 then
    function v1.InvokeSignal(p30, p31, p32, p33) --[[ Line: 104 ]]
        local v34 = tick()
        local v35 = v34 - (p31 + p32)
        if not p30.LastDelta then
            p30.LastDelta = v35
        end
        local v36 = (v35 - p30.LastDelta) / p33
        p30.LastDelta = v35
        local v37 = v36 + 0.5
        local v38 = math.floor(v37)
        local v39 = false
        local v40 = nil
        local v41 = false
        if p30.CurrentReference and v38 < 0 then
            p30.CurrentReference = p30.CurrentReference - v38
        else
            p30.TotalShift = v38
            v40 = p30.Grouping
            p30.Grouping = (p30.Grouping + 1) % 1000
            p30.CurrentReference = 0
            v39 = true
            v41 = true
        end
        local v42 = nil
        if v39 then
            if #p30.Cache > 0 then
                local v43 = p30.Cache[#p30.Cache][1] + 1
                local v44 = {}
                local v45 = 0
                v42 = { v40, v44 }
                for v46 = 1, #p30.Cache do
                    local v47 = p30.Cache[v46]
                    local v48 = (v43 - v47[1]) * v47[3]
                    v45 = v45 + (v47[5] + v47[4] + v48)
                    v44[v46] = { v47[2], v48 }
                end
                local v49 = v45 / #p30.Cache
                if p30.ServerTimeOffset then
                    p30.ServerTimeOffset = p30.ServerTimeOffset * 0.98 + v49 * 0.02
                else
                    p30.ServerTimeOffset = v49
                end
            end
            p30.Cache = {}
        end
        local v50 = #p30.Cache + 1
        p30.Cache[v50] = {
            p30.CurrentReference,
            p30.AverageFrameTime,
            p33,
            p32,
            p31 - v34
        }
        return v34, p30.AverageFrameTime, v41, p30.Grouping, v50, v42
    end
else
    function v1.PlayerAdded(p51, p52) --[[ Line: 168 ]]
        p51.AverageDelays[p52] = 0
        p51.PlayerCaches[p52] = {}
    end
    function v1.PlayerRemoving(p53, p54) --[[ Line: 173 ]]
        p53.AverageDelays[p54] = nil
        p53.PlayerCaches[p54] = nil
    end
end
function v1.Initialize(u55) --[[ Line: 179 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
        [4] = u4
    --]]
    u55.AverageFrameTime = 0.0167
    u55.LastUpdate = tick()
    u2.Heartbeat:Connect(function() --[[ Line: 183 ]]
        --[[
        Upvalues:
            [1] = u55
        --]]
        u55:Update()
    end)
    if u6 then
        u55.ServerTimeOffset = nil
        u55.LastDelta = nil
        u55.CurrentReference = nil
        u55.Cache = {}
        u55.Grouping = 0
        u55.TotalShift = 0
        function u5.OnClientInvoke(...) --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            u55:InvokeSignal(...)
        end
    else
        u55.AverageDelays = {}
        u55.PlayerCaches = {}
        u4.PlayerAdded:Connect(function(p56) --[[ Line: 203 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            u55:PlayerAdded(p56)
        end)
        u4.PlayerRemoving:Connect(function(p57) --[[ Line: 207 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            u55:PlayerRemoving(p57)
        end)
    end
end
return v1