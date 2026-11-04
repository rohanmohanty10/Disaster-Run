 

local v1 = {}
game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
local function u5(p3) --[[ Line: 8 ]]
    for _, u4 in p3:GetDescendants() do
        if u4:IsA("ParticleEmitter") then
            task.delay(u4:GetAttribute("EmitDelay"), function() --[[ Line: 11 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                _G.customEmit(u4)
            end)
        end
    end
end
function v1.start(_, p6, p7, p8) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
    --]]
    if _G.checkRenderDistance(p6.PrimaryPart.Position) ~= false then
        local u9 = Random.new()
        local _ = p6 == game.Players.LocalPlayer.Character
        local v10 = p6:GetPivot().Position
        local v11 = (v10 - p7).Magnitude
        local v12 = 1 / (v11 / 150)
        local v13 = math.clamp(v12, 0.65, 3.5)
        local v14 = (CFrame.new(v10, p7) * CFrame.new(0, v11, v11 / -2)).Position
        local v15 = script.Trail:Clone()
        v15.CFrame = p6:GetPivot()
        _G.recolorParticles(v15, p8)
        v15.Parent = workspace.Effects
        local v16 = CFrame.new(v10, p7) * CFrame.new(0, 0, -1000)
        local v17 = 0
        while p6 and (p6.PrimaryPart ~= nil and v17 < 1) do
            local v18 = v17 + task.wait() * v13
            v17 = math.clamp(v18, 0, 1)
            local v19 = (1 - v17) * (1 - v17) * v10 + 2 * (1 - v17) * v17 * v14 + v17 * v17 * p7
            local v20 = v17 + 0.01
            local v21 = (1 - v20) * (1 - v20) * v10 + 2 * (1 - v20) * v20 * v14 + v20 * v20 * p7
            local v22 = v21 * Vector3.new(1, 0, 1)
            local v23 = v19.Y
            local _ = v22 + Vector3.new(0, v23)
            p6.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            local v24 = p6.PrimaryPart
            local v25 = CFrame.new
            local v26 = v16.X
            local v27 = v19.Y
            local v28 = v16.Z
            v24.CFrame = v25(v19, Vector3.new(v26, v27, v28) + Vector3.new(0.01, 0, 0.01))
            p6.PrimaryPart.Velocity = Vector3.new()
            v15.CFrame = CFrame.new(p6.PrimaryPart.Position, v21)
        end
        local v29 = RaycastParams.new()
        local v30 = { workspace.Islands, workspace.Env, workspace.Ships }
        local v31 = Enum.RaycastFilterType.Include
        v29.FilterDescendantsInstances = v30
        v29.FilterType = v31
        local v32 = workspace:Raycast(p7 + Vector3.new(0, 1, 0), Vector3.new(0, -15, 0), v29)
        if v32 then
            if (p7 - workspace.CurrentCamera.CFrame.Position).Magnitude <= 150 then
                _G.camShake:Shake(_G.camShake.Presets.AceBlowUp)
            end
            local v33 = v32.Position + Vector3.new(0, 6.93, 0)
            local v34 = script.SlamHit:Clone()
            v34:PivotTo(CFrame.new(v33, v33 + v32.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0))
            v34.Images.CFrame = CFrame.new(v32.Position, v32.Position + v32.Normal) + Vector3.new(0, 0.1, 0)
            _G.recolorParticles(v34, p8)
            v34.Main.Floor.DetailDust.Color = ColorSequence.new(v32.Instance.Color)
            v34.Main.Floor.DetailDustup.Color = ColorSequence.new(v32.Instance.Color)
            v34.Main.Floor.Rocks.Color = ColorSequence.new(v32.Instance.Color)
            v34.Main.Floor.Smoke.Color = ColorSequence.new(v32.Instance.Color)
            v34.Main.Floor.Smoke2.Color = ColorSequence.new(v32.Instance.Color)
            v34.Parent = workspace.Effects
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v33 + Vector3.new(0, 1, 0),
                ["DistanceRandomness"] = Vector2.new(0.1, 1),
                ["Duration"] = 2,
                ["TweenDuration"] = 2,
                ["Radius"] = 15,
                ["Direction"] = Vector3.new(0, -15, 0)
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 15,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45),
                ["Position"] = v33 + Vector3.new(0, 1, 0),
                ["Direction"] = Vector3.new(0, 65, 0),
                ["RaycastDirection"] = Vector3.new(0, -15, 0),
                ["Size"] = Vector3.new(0.5, 0.5, 0.5),
                ["TrailEnabled"] = true
            }, true)
            for _, u35 in v34:GetDescendants() do
                if u35:IsA("Decal") then
                    task.delay(2, function() --[[ Line: 118 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u35
                            [3] = u9
                        --]]
                        u2:Create(u35, TweenInfo.new(u9:NextNumber(0.6, 0.75)), {
                            ["Transparency"] = 1
                        }):Play()
                    end)
                elseif u35:IsA("PointLight") then
                    u2:Create(u35, TweenInfo.new(0.44), {
                        ["Brightness"] = 0
                    }):Play()
                elseif u35:IsA("BasePart") and u35.Name == "Rocks" then
                    local v36 = workspace:Raycast(u35.Position + Vector3.new(0, 1, 0), Vector3.new(0, -10, 0), v29)
                    if v36 then
                        u35.Position = v36.Position
                        local v37 = v36.Instance.Material
                        local v38 = v36.Instance.Color
                        u35.Material = v37
                        u35.Color = v38
                        task.delay(u9:NextNumber(2, 2.5), function() --[[ Line: 130 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u35
                                [3] = u9
                            --]]
                            u2:Create(u35, TweenInfo.new(u9:NextNumber(0.45, 0.65)), {
                                ["Position"] = u35.Position - Vector3.new(0, 5, 0),
                                ["Size"] = Vector3.new(0, 0, 0)
                            }):Play()
                        end)
                    else
                        u35:Destroy()
                    end
                end
            end
            u5(v34)
            _G.destroy(v34, 5)
        end
        for _, v39 in v15:GetDescendants() do
            if v39:IsA("ParticleEmitter") then
                v39.Enabled = false
            end
        end
        _G.destroy(v15, 1.5)
    end
end
return v1