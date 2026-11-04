 

local u1 = game:GetService("RunService")
local u2 = require("./mod/tween")
local u3 = require("./mod/utility")
local u4 = require("./obj/Shake")
local u5 = {}
local u6 = CFrame.identity
local function u16() --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
        [3] = u6
    --]]
    if #u5 ~= 0 then
        local v7 = workspace.CurrentCamera
        if not u1:IsRunning() then
            v7.CFrame = v7.CFrame * u6:Inverse()
            local v8 = v7.CFrame
            local v9, v10 = v8:ToOrientation()
            v7.CFrame = CFrame.new(v8.Position) * CFrame.fromOrientation(v9, v10, 0)
        end
        local v11 = CFrame.identity
        local v12 = Vector3.new(0, 0, 0)
        local v13 = {}
        for _, v14 in u5 do
            if not v14.done then
                v12 = v12 + v14.pos
                v11 = v11 * CFrame.Angles(v14.rot.x, v14.rot.y, v14.rot.z)
                table.insert(v13, v14)
            end
        end
        u5 = v13
        local v15 = CFrame.new(v12) * v11
        if not u1:IsRunning() then
            u6 = v15
        end
        v7.CFrame = v7.CFrame * v15
    end
end
local v17 = {}
local u18 = nil
local u19 = nil
function v17.init() --[[ Line: 63 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u1
        [3] = u19
        [4] = u16
    --]]
    if not u18 then
        if u1:IsRunning() then
            u18 = u1.Heartbeat:Connect(function() --[[ Line: 69 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                if u19 then
                    workspace.CurrentCamera.CFrame = u19
                end
            end)
        end
        u1:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, u16)
    end
end
function v17.deinit() --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u1
    --]]
    if u18 then
        u18:Disconnect()
        u18 = nil
    end
    u1:UnbindFromRenderStep("forge_updateCameraShake")
end
function v17.emit(u20, p21) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
        [4] = u1
        [5] = u5
        [6] = u19
    --]]
    local v22 = u3.getAttribute(u20, "EmitDelay", 0)
    local v23 = u3.getAttribute(u20, "EmitDuration", 0)
    local v24 = u3.getAttribute(u20, "Amplitude", 2.5)
    local v25 = u3.getAttribute(u20, "Frequency", 0.2)
    local v26 = u3.getAttribute(u20, "FadeInTime", 0.3)
    local v27 = u3.getAttribute(u20, "FadeOutTime", 2)
    local v28 = u3.getAttribute(u20, "SustainTime", 1)
    local v29 = u3.getAttribute(u20, "PositionInfluence", Vector3.new(1, 1, 1))
    local v30 = u3.getAttribute(u20, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2))
    local u31 = u3.getAttribute(u20, "Speed_Start", 1)
    local u32 = u3.getAttribute(u20, "Speed_End", 1)
    local v33 = v23 > 0
    local v34 = u4.new()
    v34.Sustain = v33
    v34.Amplitude = v24
    v34.Frequency = v25
    v34.FadeInTime = v26
    v34.FadeOutTime = v27
    v34.SustainTime = v28
    v34.PositionInfluence = v29
    v34.RotationInfluence = v30
    local u35 = 1
    local u36 = 0
    function v34.TimeFunction() --[[ Line: 123 ]]
        --[[
        Upvalues:
            [1] = u36
        --]]
        return u36
    end
    if u31 ~= u32 then
        speedTween = u2.fromParams(u3.getAttribute(u20, "Speed_Curve", u3.default_bezier), u3.getAttribute(u20, "Speed_Duration", 0.1), function(p37, p38) --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u3
                [3] = u31
                [4] = u32
            --]]
            u35 = u3.lerp(u31, u32, p37)
            return p38
        end)
        local v39 = speedTween
        table.insert(p21, v39)
    end
    local v40 = u1.RenderStepped
    local function v42(p41) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u35
        --]]
        u36 = u36 + p41 * u35
    end
    table.insert(p21, v40:Connect(v42))
    local u43 = {
        ["done"] = false,
        ["pos"] = Vector3.new(0, 0, 0),
        ["rot"] = Vector3.new(0, 0, 0)
    }
    task.wait(v22)
    local v44 = u5
    table.insert(v44, u43)
    local u45 = coroutine.running()
    v34:BindToRenderStep(u4.NextRenderName(), u3.RENDER_PRIORITY + p21.depth, function(p46, p47, p48) --[[ Line: 159 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u20
            [3] = u43
            [4] = u45
        --]]
        local v49 = workspace.CurrentCamera
        u19 = v49.CFrame
        local v50 = u20:FindFirstAncestorOfClass("Attachment") or u20:FindFirstAncestorWhichIsA("BasePart")
        if v50 then
            local v51 = (v49.CFrame.Position - (v50:IsA("Attachment") and v50.WorldPosition or v50.Position)).Magnitude / 30
            local v52 = 1 - math.clamp(v51, 0, 1)
            p46 = p46 * v52
            p47 = p47 * v52
        end
        u43.pos = p46
        u43.rot = p47
        u43.done = p48
        if p48 then
            u19 = nil
            task.spawn(u45)
        end
    end)
    v34:Start()
    if v33 then
        task.wait(v23)
        v34:StopSustain()
    end
    if not u43.done then
        coroutine.yield()
    end
end
return v17