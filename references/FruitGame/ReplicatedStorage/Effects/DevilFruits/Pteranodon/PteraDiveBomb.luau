 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
game:GetService("TweenService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p3, p4) --[[ Name: start, Line 27 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v5 = p4.Character
        local v6 = p4.EndPosition
        if v5 == nil then
            return
        end
        if _G.checkRenderDistance(v5.PrimaryPart.Position) == false then
            return
        end
        if p3 == "Initial" then
            local v7 = p4.StartPosition
            local _ = p4.Distance
            local v8 = p4.Speed
            local v9 = p4.Modifier
            local v10 = 0
            while v10 < 1 do
                local v11 = v10 + u1.Heartbeat:Wait() * v8
                v10 = math.clamp(v11, 0, 1)
                local v12 = (1 - v10) * (1 - v10) * v7 + 2 * (1 - v10) * v10 * v9 + v10 * v10 * v6
                local v13 = v10 + 0.01
                local v14 = (1 - v13) * (1 - v13) * v7 + 2 * (1 - v13) * v13 * v9 + v13 * v13 * v6
                v5.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                v5:PivotTo(CFrame.new(v12, v14))
                v5.PrimaryPart.Velocity = Vector3.new()
                if v5:GetAttribute("PteraUltStart") == nil or v5:GetAttribute("PteraUltCancel") then
                    break
                end
            end
        elseif p3 == "FollowUp" then
            local v15 = p4.Thunderous
            local v16 = p4.StartPosition
            local _ = p4.Distance
            local v17 = p4.Speed
            local v18 = p4.Modifier
            local v19 = p4.tickS
            local v20 = p4.tickSCurve
            local v21 = p4.CurveInfluence
            local v22 = p4.SpeedScale
            local v23 = p4.EndPosition
            v5:SetAttribute("PteraUltCancel", true)
            local v24 = 0
            while v24 < 1 do
                local v25 = (workspace:GetServerTimeNow() - v19) * v22
                local v26 = (workspace:GetServerTimeNow() - v20 * (v15 and 2 or 1)) * (v15 and 8 or 3)
                local v27 = v25 + math.cos(v26) * v21
                local v28 = v17 * math.min(v27, 1)
                local v29 = v24 + u1.Heartbeat:Wait() * v28
                v24 = math.clamp(v29, 0, 1)
                local v30 = (1 - v24) * (1 - v24) * v16 + 2 * (1 - v24) * v24 * v18 + v24 * v24 * v23
                local v31 = v24 + 0.01
                local v32 = (1 - v31) * (1 - v31) * v16 + 2 * (1 - v31) * v31 * v18 + v31 * v31 * v23
                if workspace:Raycast(v30, v32 - v30, u2) then
                    break
                end
                v5.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                v5:PivotTo(CFrame.new(v30, v32))
                v5.PrimaryPart.Velocity = Vector3.new()
            end
            v5:SetAttribute("PteraUltCancel", nil)
        end
    end
}