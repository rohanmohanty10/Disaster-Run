 

game:GetService("TweenService")
game:GetService("Debris")
local u1 = game:GetService("RunService")
Random.new()
require(script.Parent.Shared)
local u2 = script.VFX
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u3.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 20 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u3
        --]]
        warn("this is new too fx")
        local v5 = p4.Start
        local v6 = p4.Zeus
        local u7 = p4.Character
        local v8 = p4.Detect
        local v9 = p4.StartPosition
        local v10 = p4.Speed
        local v11 = p4.Modifier
        local v12 = u7.HumanoidRootPart
        u7:FindFirstChild("Humanoid")
        local _ = u7.PrimaryPart
        local v13 = v8.Position
        local v14 = u2.Trail:Clone()
        v14:PivotTo(v12.CFrame)
        v14.Parent = workspace.Effects
        local v15 = Instance.new("BodyVelocity")
        v15.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
        v15.Parent = v12
        _G.PlaySound(u7.PrimaryPart, script.SoulZeusLeapSlamJump).Parent = u7.PrimaryPart
        local v16 = u7.Humanoid:LoadAnimation(script.charLand)
        local v17 = v6.RageModel.AnimationController:LoadAnimation(script.soulLand)
        local v18 = v9
        local v19 = 0
        while u7:GetAttribute("Raijin") and v19 < 1 do
            local _, _ = u1.Stepped:Wait()
            local v20 = (workspace:GetServerTimeNow() - v5) * v10
            v19 = math.clamp(v20, 0, 1)
            local v21 = (1 - v19) * (1 - v19) * v9 + 2 * (1 - v19) * v19 * v11 + v19 * v19 * v13
            local v22 = v21 - v18
            local v23 = workspace:Raycast(v18, v22, u3)
            if v23 then
                v22 = v22.Unit * v23.Distance or v22
            end
            if v23 then
                warn("client hit a wall?")
                break
            end
            local v24 = v22.Unit
            local v25 = CFrame.lookAlong(v21, v24)
            u7.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            u7:PivotTo(v25)
            v12.Velocity = Vector3.new(0, 0, 0)
            v14:PivotTo(v25)
            v18 = v21
        end
        u7.PrimaryPart.Anchored = true
        task.delay(0.5, function() --[[ Line: 91 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7.PrimaryPart.Anchored = false
        end)
        v15:Destroy()
        _G.particleEnabled(v14, false)
        _G.destroy(v14, 3)
        v16:Play(0)
        v17:Play(0)
    end
}