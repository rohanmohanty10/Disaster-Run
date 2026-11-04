 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u1 = game:GetService("TweenService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, u3, p4, p5) --[[ Name: start, Line 26 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        if u3 == nil then
            return
        elseif _G.checkRenderDistance(u3.PrimaryPart.Position) == false then
            return
        else
            local u6 = p5.inFlame and script.Flame or script.Base
            if p4 == "FX" then
                local v7 = u3.PrimaryPart.CFrame
                for _, v8 in u3.PteraHybridForm:GetDescendants() do
                    if v8:IsA("Trail") then
                        v8.Enabled = true
                    end
                end
                local v9 = u6.Grab:Clone()
                v9.CFrame = u3.PrimaryPart.CFrame * CFrame.new(0.0118560791, 0.178841591, -2.32528687, 1, 7.4505806e-8, 1.1920929e-7, 7.4505806e-8, 1, -2.98023206e-8, 1.1920929e-7, -2.98023206e-8, 1)
                v9.Parent = workspace.Effects
                _G.customEmit(v9)
                _G.destroy(v9, 4)
                for _, v10 in v9:GetDescendants() do
                    if v10:IsA("PointLight") then
                        local v11 = v10.Range
                        v10.Range = 0
                        u1:Create(v10, TweenInfo.new(0.2), {
                            ["Range"] = v11
                        }):Play()
                        u1:Create(v10, TweenInfo.new(0.5), {
                            ["Brightness"] = 0
                        }):Play()
                    end
                end
                task.wait(0.825)
                local v12 = u6.GrabThrow:Clone()
                local v13 = v7 * CFrame.new(0, 0.5, 2)
                v12.CFrame = CFrame.new(v13.Position, (v13 * CFrame.new(0, 30, -35)).Position)
                v12.Parent = workspace.Effects
                _G.customEmit(v12)
                _G.destroy(v12, 4)
                task.delay(0.4, function() --[[ Line: 76 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u3
                        [3] = u1
                    --]]
                    local v14 = nil
                    local v15 = nil
                    for _, v16 in u6.TorsoEffects:GetChildren() do
                        local u17 = v16:Clone()
                        u17.Parent = u3.LowerTorso
                        _G.destroy(u17, 5)
                        if u17.Name == "center" then
                            v14 = u17
                        elseif u17.Name == "center2" then
                            v15 = u17
                        end
                        if u17:IsA("PointLight") then
                            local v18 = u17.Brightness
                            u17.Brightness = 0
                            u1:Create(u17, TweenInfo.new(0.8), {
                                ["Brightness"] = v18
                            }):Play()
                            task.delay(1.4, function() --[[ Line: 100 ]]
                                --[[
                                Upvalues:
                                    [1] = u1
                                    [2] = u17
                                --]]
                                u1:Create(u17, TweenInfo.new(2), {
                                    ["Brightness"] = 0
                                }):Play()
                            end)
                        end
                        task.delay(1.25, function() --[[ Line: 107 ]]
                            --[[
                            Upvalues:
                                [1] = u17
                            --]]
                            if u17:IsA("Trail") then
                                u17.Enabled = false
                            else
                                for _, v19 in u17:GetDescendants() do
                                    v19.Enabled = false
                                end
                            end
                        end)
                    end
                    for _, v20 in u3.LowerTorso:GetChildren() do
                        if v20.Name == "airgrabTrail" then
                            v20.Attachment1 = v14
                            v20.Attachment0 = v15
                        end
                    end
                end)
                task.wait(1.4)
                for _, v21 in u3.PteraHybridForm:GetDescendants() do
                    if v21:IsA("Trail") then
                        v21.Enabled = false
                    end
                end
            elseif p4 == "Jump" then
                local v22 = u3.HumanoidRootPart
                local _ = v22.CFrame - v22.CFrame.Position
                local v23 = v22.Position
                local v24 = p5.End
                local v25 = (v22.Position - v24).Magnitude / 2 + 30
                local v26 = Vector3.new(0, v25, 0)
                local v27 = v23:Lerp(v24, 0.5) + v26
                local v28 = 0
                repeat
                    v28 = v28 + 1 * task.wait()
                    local v29 = (1 - v28) ^ 2 * v23 + 2 * (1 - v28) * v28 * v27 + v28 ^ 2 * v24
                    v22.CFrame = CFrame.new(v29, v29 + (v24 - v29))
                until v28 >= 1
            elseif p4 == "Slam" then
                local v30 = workspace:Raycast(p5.Position, Vector3.new(0, -35, 0), u2)
                local _ = u3.HumanoidRootPart.Position + Vector3.new(0, -35, 0)
                local v31 = u3.PrimaryPart
                local v32 = u6.KickAway:Clone()
                v32.CFrame = CFrame.new(v31.Position, v31.Position + Vector3.new(0, -35, 0))
                v32.Parent = workspace.Effects
                _G.customEmit(v32)
                _G.destroy(v32, 4)
                if v30 then
                    local v33 = u6.Downslammed:Clone()
                    v33.CFrame = CFrame.new(v30.Position, v30.Position + v30.Normal) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(-0.1, 0, 0)
                    _G.recolorParticles(v33, v30.Instance.Color)
                    v33.Parent = workspace.Effects
                    _G.customEmit(v33)
                    for _, v34 in v33:GetDescendants() do
                        if v34:IsA("PointLight") then
                            u1:Create(v34, TweenInfo.new(0.9), {
                                ["Brightness"] = 0
                            }):Play()
                        end
                    end
                    local _ = v30.Position
                    _G.destroy(v33, 10)
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 16,
                        ["Position"] = v33.Position + Vector3.new(0, 1, 0),
                        ["DistanceRandomness"] = Vector2.new(0.2, 1),
                        ["Duration"] = 2,
                        ["TweenDuration"] = 0.5,
                        ["Radius"] = 14,
                        ["Direction"] = Vector3.new(0, -15, 0)
                    })
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 15,
                        ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                        ["Position"] = v33.Position + Vector3.new(0, 1, 0),
                        ["Direction"] = Vector3.new(0, 50, 0),
                        ["RaycastDirection"] = Vector3.new(0, -15, 0),
                        ["Size"] = Vector3.new(0.7, 0.7, 0.7),
                        ["TrailEnabled"] = true
                    }, true)
                end
            end
        end
    end
}