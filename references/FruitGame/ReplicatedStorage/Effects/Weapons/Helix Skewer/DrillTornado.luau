 

local v1 = {}
game:GetService("TweenService")
Random.new()
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, u3, p4) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = workspace:GetServerTimeNow() - p4
    local v6 = u3.Humanoid:LoadAnimation(script.Startup)
    local u7 = u3.Humanoid:LoadAnimation(script.Hold)
    v6:Play()
    v6.Stopped:Connect(function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:Play()
    end)
    _G.PlayEffect("DrillSwordCoating", nil, u3, true)
    _G.PlaySound(u3.PrimaryPart, script.Skill1Windup).Parent = u3.PrimaryPart
    repeat
        task.wait()
    until u3:GetAttribute("DrillTornadoHold") == nil and u3:GetAttribute("DrillTornadoReleaseTime")
    local v8 = u3:GetAttribute("DrillTornadoReleaseTime")
    if v8 == "cancel" then
        v6:Stop()
        u7:Stop()
        _G.PlayEffect("DrillSwordCoating", nil, u3, false)
    else
        v5 = workspace:GetServerTimeNow() - v8
        v6:Stop()
        u7:Stop()
        local u9 = u3.Humanoid:LoadAnimation(script.Release)
        u9.TimePosition = v5
        u9.Priority = Enum.AnimationPriority.Action4
        u9:Play()
        u9:AdjustSpeed(0.5)
        _G.PlaySound(u3.PrimaryPart, script.Skill1Swing).Parent = u3.PrimaryPart
        task.wait(0.15 - v5)
        local v10 = u3.PrimaryPart.CFrame * CFrame.new(0, -3, -15)
        local v11 = script.Stab:Clone()
        v11.CFrame = u3.PrimaryPart.CFrame * CFrame.new(0, 0, -8)
        v11.Parent = workspace.Effects
        _G.destroy(v11, 2)
        _G.customEmit(v11)
        local v12 = workspace:Raycast(v10.Position, Vector3.new(0, -10, 0), u2)
        if v12 then
            local v13 = v12.Position.Y
            v10 = CFrame.new(v10.Position.X, v13, v10.Position.Z) * v10.Rotation
        end
        local u14 = script.Fx:Clone()
        u14:PivotTo(v10 * CFrame.new(0, 4.5, 0))
        local v15 = workspace:Raycast(v10.Position + Vector3.new(0, 3, 0), Vector3.new(0, -15, 0), u2)
        if v15 then
            local v16 = v15.Position
            local v17 = v15.Normal
            u14.Floor.CFrame = CFrame.new(v16, v16 + v17) * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.particleEnabled(u14.Floor, true)
        end
        u14.Parent = workspace.Effects
        _G.customEmit(u14)
        local u18 = _G.PlaySound(u14:GetPivot(), script.Skill1Twirl)
        local v19 = script.Wind:Clone()
        v19.CFrame = v10 * CFrame.new(0, 4.5, 0)
        v19.Parent = workspace.Effects
        _G.destroy(v19, 2.5)
        _G.tween(v19, {
            2.5,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = v19.Size * 1.5,
            ["Orientation"] = v19.Orientation + Vector3.new(0, 2300, 0),
            ["Transparency"] = 1
        })
        local v20 = script.Wind2:Clone()
        v20.CFrame = v10 * CFrame.new(0, 4.5, 0)
        v20.Parent = workspace.Effects
        _G.destroy(v20, 2.5)
        _G.tween(v20, {
            2.5,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Orientation"] = v20.Orientation + Vector3.new(0, 2300, 0)
        })
        _G.tween(v20.Mesh, {
            2.5,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = v20.Mesh.Scale * 1.5
        })
        _G.tween(v20.Decal, {
            2.5,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        local u21 = script.Swirl:Clone()
        u21.CFrame = v10 * CFrame.new(0, 7, 0)
        u21.Parent = workspace.Effects
        _G.tween(u21.Mesh, {
            0.8,
            "Sine",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = u21.Mesh.Scale * 1.2
        })
        _G.tween(u21, {
            1.85,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Orientation"] = u21.Orientation + Vector3.new(0, 1400, 0)
        })
        task.delay(1.1, function() --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u21
            --]]
            _G.tween(u21.Decal, {
                1.1,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(u21, 1.1)
        end)
        local u22 = nil
        local u23 = false
        u22 = u3.ChildAdded:Connect(function(p24) --[[ Line: 132 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u18
                [3] = u9
                [4] = u22
                [5] = u23
            --]]
            if p24.Name == "PB" then
                _G.particleEnabled(u14, false)
                _G.tween(u18, {
                    0.25,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                u9:Stop()
                if u22 then
                    u22:Disconnect()
                    u22 = nil
                end
                u23 = true
            end
        end)
        task.delay(1.485, function() --[[ Line: 142 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u3
            --]]
            if u23 ~= true then
                local v25 = script.Slash:Clone()
                v25.CFrame = u3.PrimaryPart.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0.17453292519943295, 0, 0.17453292519943295)
                v25.Parent = workspace.Effects
                _G.destroy(v25, 2)
                _G.customEmit(v25)
                _G.PlaySound(u3.PrimaryPart, script.Skill1Swing2)
            end
        end)
        task.wait(1.5)
        _G.particleEnabled(u14, false)
        _G.destroy(u14, 2)
        if u3:FindFirstChild("PB") == nil and u23 == false then
            local v26 = script.Fx2:Clone()
            v26.CFrame = v10 * CFrame.new(0, 4, 0)
            v26.Parent = workspace.Effects
            _G.destroy(v26, 3)
            _G.customEmit(v26)
            local v27 = script.Shockwave:Clone()
            v27.CFrame = v10
            v27.Parent = workspace.Effects
            _G.destroy(v27, 0.5)
            _G.tween(v27, {
                0.5,
                "Sine",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Position"] = v27.Position + Vector3.new(0, 3, 0),
                ["Size"] = v27.Size * 3,
                ["Orientation"] = v27.Orientation + Vector3.new(0, 150, 0),
                ["Transparency"] = 1
            })
            _G.PlaySound(v26.CFrame, script.Skill1Explosion)
            local v28 = Random.new()
            for _ = 1, 8 do
                local v29 = _G.PlayEffect
                local v30 = {
                    ["origin"] = v26.CFrame,
                    ["Amount"] = 1,
                    ["Velocity"] = 45,
                    ["TimeUntilDelete"] = 2
                }
                local v31 = v28:NextNumber(-15, 15)
                local v32 = v28:NextNumber(75, 125)
                v30.CustomVelocity = Vector3.new(v31, v32, v28:NextNumber(-15, 15)) * 0.5
                v30.Projectile = script.Parent.DropletAssets.Droplet
                local v33 = -workspace.Gravity * 2
                v30.CustomGravity = Vector3.new(0, v33, 0)
                v30.UseRaycast = true
                function v30.CustomHitFunction(p34) --[[ Line: 190 ]]
                    local v35 = script.Parent.DropletAssets.DropletHit:Clone()
                    v35.WorldCFrame = p34 * CFrame.new(0, 0.1, 0)
                    v35.Parent = workspace.Terrain
                    _G.customEmit(v35)
                    _G.destroy(v35, 3)
                    _G.PlaySound(v35, script.Parent.DropletAssets.SFX, {
                        ["RandomSound"] = true,
                        ["RandomPitch"] = true
                    })
                end
                v29("CustomImpactDroplet", nil, v30)
            end
        end
        if u22 then
            u22:Disconnect()
            u22 = nil
        end
        u23 = true
        _G.PlayEffect("DrillSwordCoating", nil, u3, false)
    end
end
return v1