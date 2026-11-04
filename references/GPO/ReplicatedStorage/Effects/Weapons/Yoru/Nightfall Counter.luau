 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local _ = v1.LocalPlayer
local u4 = workspace.Effects
local v5 = RaycastParams.new()
v5.FilterType = Enum.RaycastFilterType.Include
v5.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p6, p7) --[[ Name: start, Line 23 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u2
        --]]
        local v8 = p7.char
        local v9 = p7.Victim
        local v10 = p7.startCF
        local v11 = p7.endCF
        local v12 = p7.Color
        if v8 == nil then
            return
        elseif _G.checkRenderDistance(v8.PrimaryPart.Position) == false then
            return
        else
            local v13 = v8.PrimaryPart
            if p6 == "Counter" then
                local v14 = script.CounterActivate:Clone()
                v14.CFrame = v13.CFrame
                if v12 then
                    _G.recolorParticles(v14, v12)
                    u3.apply(v14, v8)
                end
                v14.Parent = u4
                _G.customEmit(v14)
                _G.destroy(v14, 1)
                _G.customWeld(v14, v13, CFrame.new(), v14)
                return
            elseif p6 == "CounterTrue" then
                local v15 = script.CounterTrue:Clone()
                v15.CFrame = v13.CFrame * CFrame.new(0, -2, 0)
                if v12 then
                    _G.recolorParticles(v15, v12)
                    u3.apply(v15, v8)
                end
                v15.Parent = u4
                _G.customEmit(v15)
                _G.destroy(v15, 1)
                for _, u16 in v15:GetDescendants() do
                    if u16.ClassName == "Beam" then
                        local _ = u16.Width0
                        local _ = u16.Width1
                        u16.Width0 = 0
                        u16.Width1 = 0
                        task.delay(0.1, function() --[[ Line: 66 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u16
                            --]]
                            u2:Create(u16, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                    end
                end
                local v17 = script.Teleport1:Clone()
                v17.CFrame = v10
                if v12 then
                    _G.recolorParticles(v17, v12)
                    u3.apply(v17, v8)
                end
                v17.Parent = u4
                _G.customEmit(v17)
                _G.destroy(v17, 2)
                return
            elseif p6 == "Travel" then
                local v18 = Instance.new("Highlight")
                v18.FillColor = Color3.fromRGB(85, 255, 127)
                if v12 then
                    v18.FillColor = v12
                end
                v18.OutlineTransparency = 1
                v18.FillTransparency = 0
                v18.OutlineTransparency = 1
                v18.OutlineColor = Color3.fromRGB(0, 0, 0)
                v18.DepthMode = Enum.HighlightDepthMode.Occluded
                v18.Parent = v8
                _G.tween(v18, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["FillTransparency"] = 1,
                    ["OutlineTransparency"] = 1
                })
                _G.destroy(v18, 0.5)
                _G.tween(v8.PrimaryPart, {
                    p7.duration,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v10
                })
            elseif p6 == "GroundSlam" then
                local v19 = v9:FindFirstChild("HumanoidRootPart")
                local v20, v21, v22 = _G.getRayFloor(v19.CFrame, 5)
                local v23 = script.GroundSlam:Clone()
                v23.CFrame = v19.CFrame * CFrame.new(0, -3, 0)
                v23.CFrame = CFrame.new(v21, v21 + v22) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                if v20 then
                    v23.Smoke.Color = ColorSequence.new(v20.Color)
                else
                    v23.Smoke:Destroy()
                end
                if v12 then
                    _G.recolorParticles(v23, v12)
                    u3.apply(v23, v8)
                end
                v23.Parent = u4
                _G.tween(v23.PointLight, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Brightness"] = 0,
                    ["Range"] = 45
                })
                _G.customEmit(v23)
                _G.destroy(v23, 3)
                local v24 = script.Meshes:Clone()
                if v12 then
                    u3.apply(v24, v8)
                end
                v24:PivotTo(v23.CFrame * CFrame.new(0, 6, 0))
                v24.Parent = u4
                _G.destroy(v24, 3.3)
                for _, v25 in v24:GetChildren() do
                    local v26 = v25.Size * 1.25
                    local v27 = v26.Y * 1.4
                    v25.Size = Vector3.new(0, v27, 0)
                    u2:Create(v25, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        ["Size"] = v26
                    }):Play()
                    for _, v28 in v25:GetChildren() do
                        v28.Transparency = -0.5
                        u2:Create(v28, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                            ["Transparency"] = 1
                        }):Play()
                    end
                end
                local v29 = script.CounterTrue:Clone()
                v29.CFrame = CFrame.new(v23.Position + Vector3.new(0, 1, 0))
                v29["Beam Start"].WorldCFrame = v11
                v29["Beam Start"]["Beam End"].WorldCFrame = v10
                if v12 then
                    _G.recolorParticles(v29, v12)
                    u3.apply(v29, v8)
                end
                v29.Parent = u4
                for _, v30 in v29:GetDescendants() do
                    if v30.ClassName == "Beam" then
                        local _ = v30.Width0
                        local _ = v30.Width1
                        v30.Width1 = v30.Width1 * 2
                        v30.Width0 = v30.Width1
                        v30.Width1 = v30.Width1 * 4
                        u2:Create(v30, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end
                end
                _G.customEmit(v29)
                _G.destroy(v29, 10)
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 13,
                    ["Position"] = v19.Position + Vector3.new(0, 5, 0),
                    ["DistanceRandomness"] = Vector2.new(0.7, 1),
                    ["Duration"] = 2,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 12,
                    ["Direction"] = Vector3.new(0, -35, 0)
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 12,
                    ["RandomVelocityMagnitude"] = Vector2.new(-75, 75) / 2,
                    ["Position"] = v21,
                    ["Direction"] = Vector3.new(0, 75, 0),
                    ["RaycastDirection"] = Vector3.new(0, -30, 0),
                    ["Size"] = Vector3.new(0.6666667, 0.6666667, 0.6666667),
                    ["TrailEnabled"] = true
                })
            end
        end
    end
}