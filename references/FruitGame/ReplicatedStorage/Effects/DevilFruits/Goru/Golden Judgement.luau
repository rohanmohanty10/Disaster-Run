 

local v1 = {}
local function u5(p2, p3) --[[ Line: 3 ]]
    for _, v4 in p2:GetDescendants() do
        if v4:IsA("ParticleEmitter") then
            v4.Enabled = p3
        end
    end
end
local u6 = RaycastParams.new()
u6.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
u6.FilterType = Enum.RaycastFilterType.Include
local u7 = _G.tween
function v1.start(_, p8) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u7
    --]]
    for _, u9 in p8 do
        local v10 = u9.PrimaryPart.CFrame
        local v11, v12, v13 = _G.getRayFloor(v10, 15)
        local v14 = v12 + Vector3.new(0, 0.1, 0)
        local v15 = CFrame.new(v14, v14 + v13)
        local v16 = CFrame.Angles
        local v17 = math.random(0, 360)
        local u18 = v15 * v16(-1.5707963267948966, math.rad(v17), 0)
        local u19 = script.Burst:Clone()
        u19.CFrame = u18
        if v11 == nil then
            u19.Rocks:Destroy()
        else
            _G.recolorParticles(u19, v11.Color)
        end
        u19.Parent = workspace.Effects
        _G.PlaySound(u19, script["Audio/GoldPierceMarkTarget"], {
            ["RandomPitch"] = true
        })
        task.delay(0.35, function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u19
                [3] = u18
                [4] = u9
                [5] = u6
                [6] = u7
            --]]
            u5(u19.Flash, false)
            u5(u19.Main, true)
            local u20 = script.Tendril:Clone()
            local v21 = u20:FindFirstChild("NurbsPath.014")
            u20:PivotTo(u18)
            u20["NurbsPath.014"].Transparency = 1
            u20.Head.Anchored = true
            u20.Head.WeldConstraint:Destroy()
            v21.Anchored = true
            u20.Parent = workspace.Effects
            local u22 = u20.AnimationController:LoadAnimation(script.Impale)
            u22:AdjustWeight(2)
            u22:Play(0)
            task.spawn(function() --[[ Line: 60 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u20
                --]]
                u22.KeyframeReached:Wait("start")
                u20["NurbsPath.014"].Transparency = 0
            end)
            local v23 = u9.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
            local v24 = u20:GetPivot().UpVector * 60
            local v25 = workspace:Raycast(v23, v24, u6)
            if v25 then
                local _ = (u9.HumanoidRootPart.Position + Vector3.new(0, 40, 0) - v25.Position).Magnitude
                u19.Rocks.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v25.Instance.Color), ColorSequenceKeypoint.new(1, v25.Instance.Color) })
            end
            for _, v26 in ipairs(u20:GetDescendants()) do
                if v26:IsA("PointLight") then
                    u7(v26, {
                        0.6,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Brightness"] = 0
                    })
                end
            end
            _G.PlaySound(u20.PrimaryPart, script["Audio/GoldPierceHit"], {
                ["RandomPitch"] = true
            })
            task.delay(0.3, function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u20
                --]]
                u5(u20, false)
            end)
            _G.customEmit(u19)
            _G.destroy(u20, 1.8)
            local v27 = script.AuraWind:Clone()
            v27:PivotTo(u18)
            v27.FlashWave.Decal.Transparency = 0.87
            v27.CurvedImage.Decal.Transparency = 0.87
            v27.Parent = workspace.Effects
            u7(v27.FlashWave.Decal, {
                0.3,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Transparency"] = 1
            })
            u7(v27.FlashWave.Mesh, {
                0.3,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Scale"] = v27.FlashWave.Mesh.Scale * 2
            })
            u7(v27.CurvedImage.Decal, {
                0.3,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Transparency"] = 1
            })
            u7(v27.CurvedImage.Mesh, {
                0.3,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Scale"] = v27.CurvedImage.Mesh.Scale * 2
            })
            _G.destroy(v27, 2)
            local v28 = u20:GetPivot().Position
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 8,
                ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
                ["Position"] = v28,
                ["Direction"] = Vector3.new(0, 90, 0),
                ["RaycastDirection"] = Vector3.new(0, -10, 0),
                ["Size"] = Vector3.new(0.5833333, 0.6666667, 0.5833333)
            })
            task.wait(1.45)
            u5(u19, false)
            _G.destroy(u19, 3)
        end)
    end
end
return v1