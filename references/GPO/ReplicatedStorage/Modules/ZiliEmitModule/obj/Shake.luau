 

local u1 = game:GetService("RunService")
local u2 = Random.new()
local u3 = 0
local u4 = {}
u4.__index = u4
function u4.new() --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
        [3] = u2
    --]]
    local v5 = u4
    local v6 = setmetatable({}, v5)
    v6.Amplitude = 1
    v6.Frequency = 1
    v6.FadeInTime = 1
    v6.FadeOutTime = 1
    v6.SustainTime = 0
    v6.Sustain = false
    v6.PositionInfluence = Vector3.new(1, 1, 1)
    v6.RotationInfluence = Vector3.new(1, 1, 1)
    local v7
    if u1:IsRunning() then
        v7 = time
    else
        v7 = os.clock
    end
    v6.TimeFunction = v7
    v6._timeOffset = u2:NextNumber(-1000000, 1000000)
    v6._startTime = 0
    v6._running = false
    v6._signalConnections = {}
    v6._renderBindings = {}
    return v6
end
function u4.InverseSquare(p8, p9) --[[ Line: 281 ]]
    local v10 = p9 < 1 and 1 or p9
    return p8 * (1 / (v10 * v10))
end
function u4.NextRenderName() --[[ Line: 297 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3 = u3 + 1
    return ("__shake_%.4i__"):format(u3)
end
function u4.Start(p11) --[[ Line: 310 ]]
    p11._startTime = p11.TimeFunction()
    p11._running = true
end
function u4.Stop(p12) --[[ Line: 322 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    p12._running = false
    for _, v13 in p12._renderBindings do
        u1:UnbindFromRenderStep(v13)
    end
    table.clear(p12._renderBindings)
    for _, v14 in p12._signalConnections do
        v14:Disconnect()
    end
    table.clear(p12._signalConnections)
end
function u4.IsShaking(p15) --[[ Line: 340 ]]
    return p15._running
end
function u4.StopSustain(p16) --[[ Line: 349 ]]
    local v17 = p16.TimeFunction()
    p16.Sustain = false
    p16.SustainTime = v17 - p16._startTime - p16.FadeInTime
end
function u4.Update(p18) --[[ Line: 377 ]]
    local v19 = false
    local v20 = p18.TimeFunction()
    local v21 = v20 - p18._startTime
    local v22 = (v20 + p18._timeOffset) / p18.Frequency % 10000
    local v23 = 1
    local v24 = v21 >= p18.FadeInTime and 1 or v21 / p18.FadeInTime
    if not p18.Sustain and p18.FadeInTime + p18.SustainTime < v21 then
        if p18.FadeOutTime == 0 then
            v19 = true
        else
            v23 = 1 - (v21 - p18.FadeInTime - p18.SustainTime) / p18.FadeOutTime
            if not p18.Sustain and p18.FadeInTime + p18.SustainTime + p18.FadeOutTime <= v21 then
                v19 = true
            end
        end
    end
    local v25 = math.noise(v22, 0) / 2
    local v26 = math.noise(0, v22) / 2
    local v27 = math.noise(v22, v22) / 2
    local v28 = Vector3.new(v25, v26, v27) * p18.Amplitude * math.min(v24, v23)
    if v19 then
        p18:Stop()
    end
    return p18.PositionInfluence * v28, p18.RotationInfluence * v28, v19
end
function u4.OnSignal(u29, p30, u31) --[[ Line: 435 ]]
    local v32 = p30:Connect(function() --[[ Line: 436 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u29
        --]]
        u31(u29:Update())
    end)
    local v33 = u29._signalConnections
    table.insert(v33, v32)
    return v32
end
function u4.BindToRenderStep(u34, p35, p36, u37) --[[ Line: 465 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1:BindToRenderStep(p35, p36, function() --[[ Line: 466 ]]
        --[[
        Upvalues:
            [1] = u37
            [2] = u34
        --]]
        u37(u34:Update())
    end)
    local v38 = u34._renderBindings
    table.insert(v38, p35)
end
function u4.Clone(p39) --[[ Line: 502 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v40 = u4.new()
    for _, v41 in {
        "Amplitude",
        "Frequency",
        "FadeInTime",
        "FadeOutTime",
        "SustainTime",
        "Sustain",
        "PositionInfluence",
        "RotationInfluence",
        "TimeFunction"
    } do
        v40[v41] = p39[v41]
    end
    return v40
end
function u4.Destroy(p42) --[[ Line: 524 ]]
    p42:Stop()
end
return {
    ["new"] = u4.new,
    ["InverseSquare"] = u4.InverseSquare,
    ["NextRenderName"] = u4.NextRenderName
}