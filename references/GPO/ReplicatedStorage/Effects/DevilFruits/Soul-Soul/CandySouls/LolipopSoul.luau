 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
Random.new()
local v2 = {}
local u3 = script
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u4.FilterType = Enum.RaycastFilterType.Include
local u5 = script.SFX
function v2.start(_, p6) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u5
        [4] = u4
    --]]
    local u7 = p6.Character
    local u8 = p6.Summon
    local v9 = p6.ActionType
    if v9 == "SecondTrigger" then
        u8:GetScale()
        local u10 = Instance.new("NumberValue")
        u10.Value = 0
        u10:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
                [3] = u10
            --]]
            if u8.PrimaryPart then
                u8:SetPrimaryPartCFrame(u8.PrimaryPart.CFrame:Lerp(u7.RightHand.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0), u10.Value))
            end
        end)
        local u11 = u1:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
            ["Value"] = 1
        })
        u11:Play()
        _G.PlayEffect("Homie Scale", nil, {
            ["Homie"] = u8,
            ["Time"] = 0.5,
            ["Scale"] = 0.4
        })
        u11.Completed:Connect(function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u10
                [3] = u8
                [4] = u3
                [5] = u7
                [6] = u5
            --]]
            u11:Destroy()
            u10:Destroy()
            u8:Destroy()
            local v12 = u3.Bite:Clone()
            v12:PivotTo(u7.Head.CFrame * CFrame.new(0, -0.5, -1.5))
            v12.Parent = workspace.Effects
            task.delay(2, v12.Destroy, v12)
            _G.particleEnabled(v12, false)
            _G.customEmit(v12)
            _G.PlaySound(u7.PrimaryPart, u5.SoulMiniHomiesCandyEatingEnd).Parent = u7.PrimaryPart
            task.wait(0.5)
            local v13 = u3.Heal:Clone()
            v13.Anchored = false
            v13.Parent = workspace.Effects
            local v14 = Instance.new("Weld")
            v14.Part0 = u7.PrimaryPart
            v14.Part1 = v13
            v14.Parent = v13
            task.delay(2, v13.Destroy, v13)
            _G.particleEnabled(v13, true)
            task.wait(1)
            _G.particleEnabled(v13, false)
        end)
    elseif v9 == "Attack" then
        local v15 = p6.TargetPosition
        local v16 = u8.PrimaryPart.Position
        local _ = (v16 - v15).Magnitude
        local v17 = p6.Speed
        local v18 = CFrame.new(v16, v15).Position + Vector3.new(0, 5, 0)
        local v19 = workspace:GetServerTimeNow() - p6.serverStartTime
        local v20 = CFrame.new()
        u8:SetPrimaryPartCFrame(CFrame.new(u8.PrimaryPart.Position, v15) * v20)
        _G.PlaySound(u8.PrimaryPart, u5.CandyDash).Parent = u8.PrimaryPart
        tick()
        while v19 < 1 do
            local v21 = v19 + task.wait() * v17
            v19 = math.clamp(v21, 0, 1)
            local v22 = (1 - v19) * (1 - v19) * v16 + 2 * (1 - v19) * v19 * v18 + v19 * v19 * v15
            local v23 = v19 + 0.01
            local v24 = (1 - v23) * (1 - v23) * v16 + 2 * (1 - v23) * v23 * v18 + v23 * v23 * v15
            if v22 ~= v15 then
                v24 = v15
            end
            u8:SetPrimaryPartCFrame(CFrame.new(v22, v24) * v20)
            v15 = v24
        end
        workspace:Raycast(u8:GetPivot().Position, Vector3.new(0, -10, 0), u4)
        local v25 = u3.Slam:Clone()
        v25.CFrame = u8:GetModelCFrame()
        v25.CFrame = v25.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
        v25.Parent = workspace.Effects
        _G.particleEnabled(v25, false)
        _G.customEmit(v25)
        _G.PlaySound(v25, u5.SoulMiniHomiesCandyBoom, {
            ["RandomPitch"] = true
        })
        _G.destroy(v25, 5)
        _G.shakenear(v25.Position, 50, 35, 75, -1)
        if u8 then
            u8:Destroy()
        end
    end
end
return v2