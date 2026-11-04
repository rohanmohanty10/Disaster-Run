 

local u1 = game:GetService("RunService")
local u2 = require("../mod/attributes")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../pkg/Shake")
local u6 = {}
local u7 = CFrame.identity
local function u17() --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
        [3] = u7
    --]]
    if #u6 ~= 0 then
        local v8 = workspace.CurrentCamera
        if not u1:IsRunning() then
            v8.CFrame = v8.CFrame * u7:Inverse()
            local v9 = v8.CFrame
            local v10, v11 = v9:ToOrientation()
            v8.CFrame = CFrame.new(v9.Position) * CFrame.fromOrientation(v10, v11, 0)
        end
        local v12 = CFrame.identity
        local v13 = Vector3.new(0, 0, 0)
        local v14 = {}
        for _, v15 in u6 do
            if not v15.done then
                v13 = v13 + v15.pos
                v12 = v12 * CFrame.Angles(v15.rot.x, v15.rot.y, v15.rot.z)
                table.insert(v14, v15)
            end
        end
        u6 = v14
        local v16 = CFrame.new(v13) * v12
        if not u1:IsRunning() then
            u7 = v16
        end
        v8.CFrame = v8.CFrame * v16
    end
end
local v18 = {}
local u19 = nil
local u20 = nil
function v18.init() --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u1
        [3] = u20
        [4] = u17
    --]]
    if not u19 then
        if u1:IsRunning() then
            u19 = u1.Heartbeat:Connect(function() --[[ Line: 69 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                if u20 then
                    workspace.CurrentCamera.CFrame = u20
                end
            end)
        end
        u1:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, u17)
    end
end
function v18.deinit() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u1
    --]]
    if u19 then
        u19:Disconnect()
        u19 = nil
    end
    u1:UnbindFromRenderStep("forge_updateCameraShake")
end
function v18.emit(u21, p22) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u3
        [4] = u4
        [5] = u1
        [6] = u6
        [7] = u20
    --]]
    local v23 = u2.get(u21, "EmitDelay", 0)
    local v24 = u2.get(u21, "EmitDuration", 0)
    local u25 = u2.get(u21, "Falloff", 30)
    local v26 = u2.get(u21, "Amplitude", 2.5)
    local v27 = u2.get(u21, "Frequency", 0.2)
    local v28 = u2.get(u21, "FadeInTime", 0.3)
    local v29 = u2.get(u21, "FadeOutTime", 2)
    local v30 = u2.get(u21, "SustainTime", 1)
    local v31 = u2.get(u21, "PositionInfluence", Vector3.new(1, 1, 1))
    local v32 = u2.get(u21, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2))
    local u33 = u2.get(u21, "Speed_Start", 1)
    local u34 = u2.get(u21, "Speed_End", 1)
    local v35 = v24 > 0
    local v36 = u5.new()
    v36.Sustain = v35
    v36.Amplitude = v26
    v36.Frequency = v27
    v36.FadeInTime = v28
    v36.FadeOutTime = v29
    v36.SustainTime = v30
    v36.PositionInfluence = v31
    v36.RotationInfluence = v32
    local u37 = 1
    local u38 = 0
    function v36.TimeFunction() --[[ Line: 125 ]]
        --[[
        Upvalues:
            [1] = u38
        --]]
        return u38
    end
    if u33 ~= u34 then
        local v41 = u3.fromParams(u2.get(u21, "Speed_Curve", u4.default_bezier), u2.get(u21, "Speed_Duration", 0.1), function(p39, p40) --[[ Line: 133 ]]
            --[[
            Upvalues:
                [1] = u37
                [2] = u4
                [3] = u33
                [4] = u34
            --]]
            u37 = u4.lerp(u33, u34, p39)
            return p40
        end)
        table.insert(p22, v41)
    end
    local v42 = u1.RenderStepped
    local function v44(p43) --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u38
            [2] = u37
        --]]
        u38 = u38 + p43 * u37
    end
    table.insert(p22, v42:Connect(v44))
    local u45 = {
        ["done"] = false,
        ["pos"] = Vector3.new(0, 0, 0),
        ["rot"] = Vector3.new(0, 0, 0)
    }
    task.wait(v23)
    local v46 = u6
    table.insert(v46, u45)
    local u47 = coroutine.running()
    v36:BindToRenderStep(u5.NextRenderName(), u4.RENDER_PRIORITY + p22.depth, function(p48, p49, p50) --[[ Line: 161 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u21
            [3] = u4
            [4] = u25
            [5] = u45
            [6] = u47
        --]]
        local v51 = workspace.CurrentCamera
        u20 = v51.CFrame
        local v52 = u21:FindFirstAncestorOfClass("Attachment") or u21:FindFirstAncestorWhichIsA("BasePart")
        if v52 then
            local v53 = u4.getTransformedOriginExtents(v52)
            local v54 = v53 and v53.Position or v52.Position
            local v55 = (v51.CFrame.Position - v54).Magnitude / u25
            local v56 = 1 - math.clamp(v55, 0, 1)
            p48 = p48 * v56
            p49 = p49 * v56
        end
        u45.pos = p48
        u45.rot = p49
        u45.done = p50
        if p50 then
            u20 = nil
            task.spawn(u47)
        end
    end)
    v36:Start()
    if v35 then
        task.wait(v24)
        v36:StopSustain()
    end
    if not u45.done then
        coroutine.yield()
    end
end
return v18