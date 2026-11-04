 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("TweenService")
local u2 = game:GetService("Debris")
local u3 = game:GetService("RunService")
local v4 = {}
local function u18(p5, p6, p7, p8, p9) --[[ Line: 9 ]]
    local v10 = 1 - p5
    local v11 = v10 * v10
    local v12 = v11 * v10
    local v13 = p5 * p5
    local v14 = v13 * p5
    local v15 = p6.Position * v12 + p7.Position * (v11 * 3 * p5) + p8.Position * (v10 * 3 * v13) + p9.Position * v14
    local v16 = (p7.Position - p6.Position) * (v11 * 3) + (p8.Position - p7.Position) * (v10 * 6 * p5) + (p9.Position - p8.Position) * (v13 * 3)
    if v16.Magnitude < 0.001 then
        if p5 < 0.5 then
            v16 = (p7.Position - p6.Position).Unit
        else
            v16 = (p9.Position - p8.Position).Unit
        end
        if v16.Magnitude < 0.001 then
            local v17 = p9.Position - p6.Position
            v16 = v17.Magnitude < 0.001 and Vector3.new(0, 0, -1) or v17
        end
    end
    return CFrame.lookAt(v15, v15 + v16)
end
function v4.Fire(p19, p20, u21, p22) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u18
        [4] = u2
    --]]
    if not (p19 and p19:IsA("Model")) then
        return nil
    end
    if not (p20 and u21) then
        return nil
    end
    local v23 = p22 or {}
    local v24 = p19:Clone()
    local u25 = v24.PrimaryPart
    if not u25 then
        v24:Destroy()
        return nil
    end
    u25.CFrame = p20 * (v23.Offset or CFrame.new())
    v24.Parent = v23.Parent or workspace
    local u26 = u25.CFrame
    local v27 = v23.Lifetime or 5
    local v28 = v23.Duration or 1
    local v29 = v23.EasingStyle or Enum.EasingStyle.Quad
    local v30 = v23.EasingDirection or Enum.EasingDirection.Out
    if v23.ControlPoints and #v23.ControlPoints >= 2 then
        local u31 = v23.ControlPoints[1]
        local u32 = v23.ControlPoints[2]
        local u33 = Instance.new("NumberValue")
        u33.Value = 0
        u33.Name = "ProjectileBezierProgress"
        u33.Parent = nil
        local u34 = u1:Create(u33, TweenInfo.new(v28, v29, v30, 0, false, 0), {
            ["Value"] = 1
        })
        local u35 = nil
        u35 = u3.Heartbeat:Connect(function() --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u34
                [3] = u18
                [4] = u33
                [5] = u26
                [6] = u31
                [7] = u32
                [8] = u21
                [9] = u35
            --]]
            if u25 and (u25.Parent and u34.PlaybackState == Enum.PlaybackState.Playing) then
                u25.CFrame = u18(u33.Value, u26, u31, u32, u21)
            elseif u35 then
                u35:Disconnect()
                u35 = nil
            end
        end)
        u34:Play()
        u34.Completed:Connect(function() --[[ Line: 119 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u33
            --]]
            if u35 then
                u35:Disconnect()
                u35 = nil
            end
            u33:Destroy()
        end)
    else
        local v36 = u1:Create(u25, TweenInfo.new(v28, v29, v30, 0, false, 0), {
            ["CFrame"] = u21
        })
        v36:Play()
        v36.Completed:Connect(function(p37) --[[ Line: 140 ]]
            local _ = p37 == Enum.TweenStatus.Completed
        end)
    end
    u2:AddItem(v24, v27)
    return v24
end
return v4