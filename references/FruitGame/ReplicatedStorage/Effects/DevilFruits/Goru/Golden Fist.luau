 

local v1 = {}
local u2 = RaycastParams.new()
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u2.FilterType = Enum.RaycastFilterType.Include
function v1.start(_, u3) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u4 = false
    local v5 = script.Tendrils:Clone()
    v5:PivotTo(CFrame.new(u3.RightLowerArm.Position + Vector3.new(0, 0.15, 0)))
    v5.Parent = workspace.Effects
    local v6 = Instance.new("Motor6D")
    v6.Name = "NurbsPath.013"
    v6.Part0 = u3.RightLowerArm
    v6.Part1 = v5["NurbsPath.013"]
    v6.C0 = CFrame.new(-0.074, 0.142, -0.011)
    v6.Parent = v5
    local v7 = u3:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
    local v8 = v7:LoadAnimation(script.StartUp)
    v8:Play(0)
    v8.Priority = Enum.AnimationPriority.Action4
    local v9 = v5.AnimationController:LoadAnimation(script.StartUp)
    v9:Play(0)
    v9.Priority = Enum.AnimationPriority.Action4
    _G.PlaySound(u3.PrimaryPart, script.GoldFistStart)
    task.wait(0.429)
    local v10 = script.GoldFistHoldLoop:Clone()
    v10.Parent = u3.PrimaryPart
    v10:Play()
    v5["NurbsPath.013"].Transparency = 1
    _G.destroy(v5, 2)
    _G.customEmit(v5)
    local v11 = script.Gauntlet:Clone()
    v11:PivotTo(u3.HumanoidRootPart.CFrame)
    v11.Parent = workspace.Effects
    local v12 = Instance.new("Motor6D")
    v12.Name = "RootPart"
    v12.Part0 = u3.RightLowerArm
    v12.Part1 = v11.RootPart
    v12.C0 = CFrame.new(-1.5, 0.172, -0.031)
    v12.Parent = v11
    local v13 = v11.AnimationController:LoadAnimation(script.Charge)
    v13:Play()
    v13.Priority = Enum.AnimationPriority.Action4
    local v14 = v7:LoadAnimation(script.Charge)
    v14:Play()
    v14.Priority = Enum.AnimationPriority.Action4
    local u15 = script.Hold:Clone()
    u15.CFrame = u3.HumanoidRootPart.CFrame - Vector3.new(0, 2.5, 0)
    u15.Parent = workspace.Effects
    local u16 = nil
    task.spawn(function() --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u15
            [4] = u16
            [5] = u4
        --]]
        local v17 = u3.HumanoidRootPart.Position
        local v18 = workspace:Raycast(v17, Vector3.new(0, -10, 0), u2)
        if v18 then
            u15.CFrame = CFrame.new(v18.Position, v18.Position + v18.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
            for _, v19 in u15.color:GetChildren() do
                v19.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v18.Instance.Color), ColorSequenceKeypoint.new(1, v18.Instance.Color) })
            end
            u16 = v18.Instance
        else
            u15:Destroy()
        end
        if u15 then
            repeat
                local v20 = u15
                v20.CFrame = v20.CFrame * CFrame.Angles(0, 0.12217304763960307, 0)
                task.wait()
            until u4 == true
        end
    end)
    local v21 = os.clock()
    local v22 = u16
    repeat
        task.wait()
    until u3:GetAttribute("GoldenFistCFrame") ~= nil or os.clock() - v21 > 5
    if u3:GetAttribute("GoldenFistCFrame") then
        local u23 = u3:GetAttribute("GoldenFistCFrame")
        v14:Stop()
        u4 = true
        _G.particleEnabled(u15, false)
        _G.destroy(u15, 3)
        _G.PlaySound(u23, script.GoldFistLaunch)
        _G.tween(v10, {
            0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v10, 0.15)
        local v24 = u15:FindFirstChild("MoreWind")
        if v24 then
            v24:Destroy()
        end
        local v25 = v7:LoadAnimation(script.Use)
        v25:Play()
        v25.Priority = Enum.AnimationPriority.Action4
        _G.customEmit(v11)
        _G.destroy(v11, 0.3)
        task.wait(0.15)
        local v26 = script.Fx:Clone()
        v26:PivotTo(u23)
        if v22 then
            _G.recolorParticles(v26, v22.Color)
        end
        v26.Parent = workspace.Effects
        _G.customEmit(v26)
        _G.destroy(v26, 4)
        _G.tween(v26.Floor.PointLight, {
            1.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Brightness"] = 0
        })
        _G.shakenear(u23.Position, 75, 125, 100, -1.5)
        task.delay(0.05, function() --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u23
            --]]
            local v27 = Random.new()
            local v28, _, _ = _G.getRayFloor(u23, 5)
            if v28 ~= nil then
                for _ = 1, 15 do
                    local v29 = _G.PlayEffect
                    local v30 = {
                        ["Position"] = u23.Position
                    }
                    local v31 = u23.LookVector * math.random(50, 80)
                    local v32 = v27:NextNumber(-35, 35)
                    local v33 = v27:NextNumber(25, 60)
                    v30.Velocity = v31 + Vector3.new(v32, v33, v27:NextNumber(-35, 35))
                    v30.AngularVelocity = Random.new():NextUnitVector() * 3
                    local v34 = v27:NextNumber(0.5, 3)
                    local v35 = v27:NextNumber(0.5, 1) / 2
                    v30.Size = Vector3.new(v34, v35, v27:NextNumber(0.5, 3))
                    v30.Duration = v27:NextInteger(1, 3)
                    v30.Color = Color3.fromRGB(239, 184, 56)
                    v30.Material = Enum.Material.Metal
                    v30.customModel = script.Parent.Gold_shatter:GetChildren()[math.random(1, #script.Parent.Gold_shatter:GetChildren())]
                    local v36 = v29("CreateRock", "skipThread", v30)
                    script.SurfaceAppearance:Clone().Parent = v36
                end
            end
        end)
        local v37 = script.Wind:Clone()
        v37:PivotTo(u23)
        v37.Parent = workspace.Effects
        v37.HumanoidRootPart.Anchored = true
        _G.destroy(v37, 2.7)
        for _, u38 in pairs(v37:GetDescendants()) do
            if u38:IsA("Beam") then
                task.spawn(function() --[[ Line: 202 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                    --]]
                    _G.tween(u38, {
                        1.35,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false
                    }, {
                        ["Transparency"] = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }),
                        ["TextureSpeed"] = 0.3
                    })
                end)
            end
        end
        local u39 = script.MoreWind:Clone()
        u39.CFrame = u23 * CFrame.new(0, -2.5, 0)
        u39.Decal.Transparency = 1
        u39.Parent = u15
        task.delay(0.1, function() --[[ Line: 219 ]]
            --[[
            Upvalues:
                [1] = u39
            --]]
            u39.Decal.Transparency = 0.75
            _G.tween(u39.Decal, {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Transparency"] = 1
            })
            _G.tween(u39, {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["CFrame"] = u39.CFrame * CFrame.Angles(0, 0.6108652381980153, 0)
            })
            _G.tween(u39.Mesh, {
                0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false
            }, {
                ["Scale"] = u39.Mesh.Scale * 3
            })
        end)
        local v40 = script.AuraWind:Clone()
        v40:PivotTo(u23 * CFrame.Angles(0, 3.141592653589793, 0))
        v40.FlashWave.Decal.Transparency = 0.87
        v40.CurvedImage.Decal.Transparency = 0.87
        v40.Parent = workspace.Effects
        _G.tween(v40.FlashWave.Decal, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Transparency"] = 1
        })
        _G.tween(v40.FlashWave.Mesh, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Scale"] = v40.FlashWave.Mesh.Scale * 2
        })
        _G.tween(v40.CurvedImage.Decal, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Transparency"] = 1
        })
        _G.tween(v40.CurvedImage.Mesh, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Scale"] = v40.CurvedImage.Mesh.Scale * 2
        })
        _G.tween(v40.CurvedImage, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Position"] = v40.CurvedImage.Position + u23.LookVector * 25
        })
        _G.tween(v40.FlashWave, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false
        }, {
            ["Position"] = v40.CurvedImage.Position + u23.LookVector * 25
        })
        _G.destroy(v40, 2)
        local v41 = script.Ring:Clone()
        v41:PivotTo(u23)
        v41.Parent = workspace.Effects
        _G.tween(v41.Ring, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            1,
            false
        }, {
            ["Size"] = Vector3.new(35, 0, 35)
        })
        _G.tween(v41.Ring, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            1,
            false
        }, {
            ["Position"] = v40.CurvedImage.Position + u23.LookVector * 25
        })
        _G.destroy(v41, 0.5)
    else
        warn("TIMEOUT: GoldenFist yield expired")
        u4 = true
        v14:Stop()
        v10:Destroy()
        _G.destroy(v11, 0)
        _G.destroy(u15, 0)
    end
end
return v1