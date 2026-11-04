 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
require(v1.Modules.CraterHandler)
require(v1.Modules.Bezier)
require(v1.Modules.LightningBolt)
local _ = v3.LocalPlayer
local u4 = workspace.Effects
local u5 = {}
local u6 = script.Parent["SulongThunderous Whirlwind"].TornadoFlipBooks
local v7 = RaycastParams.new()
v7.FilterType = Enum.RaycastFilterType.Include
v7.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p8, p9, p10, p11, _) --[[ Name: start, Line 62 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u2
            [4] = u6
        --]]
        if _G.checkRenderDistance(p9.PrimaryPart.Position) == false then
            return
        elseif p8 == "Charge" then
            local v12 = p9.HumanoidRootPart
            u5[p9] = {}
            local v13 = script.HoldEmit:Clone()
            v13.CFrame = v12.CFrame
            v13.Parent = u4
            _G.customEmit(v13)
            _G.destroy(v13, 3)
            local v14 = script.HoldEnable:Clone()
            v14.CFrame = p9.UpperTorso.CFrame
            local v15 = Instance.new("WeldConstraint")
            v15.Part0 = v14
            v15.Part1 = v12
            v15.Parent = v14
            v14.Parent = u4
            _G.particleEnabled(v14, true)
            local v16 = Instance.new("Highlight")
            v16.FillColor = Color3.fromRGB(235, 249, 255)
            v16.FillTransparency = 1
            v16.OutlineTransparency = 1
            v16.Adornee = p9
            v16.DepthMode = Enum.HighlightDepthMode.Occluded
            v16.Parent = v14
            _G.tween(v16, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                ["FillTransparency"] = 0.1
            })
            local v17 = u5[p9]
            table.insert(v17, v14)
            local v18 = script.SLDashLoop:Clone()
            v18.Parent = v14
            v18:Play()
            _G.PlaySound(p9.PrimaryPart, script.SLDashStart)
            local v19 = script.PointLight:Clone()
            v19.Name = "tackleLight"
            v19.Parent = p9.PrimaryPart
        elseif p8 == "Tackle" then
            local u20 = p9.HumanoidRootPart
            local v21 = u5[p9]
            local v22 = table.unpack(v21)
            _G.particleEnabled(v22, false)
            _G.destroy(v22, 3)
            local v23 = script.BodyVFX:Clone()
            v23:PivotTo(CFrame.new(p10, p11.Position) * CFrame.Angles(1.5707963267948966, 0, 0))
            local v24 = Instance.new("WeldConstraint")
            v24.Part0 = v23.BodyVFX
            v24.Part1 = u20
            v24.Parent = v23.BodyVFX
            v23.Parent = u4
            _G.particleEnabled(v23.BodyVFX, true)
            _G.customEmit(v23.Emit)
            local v25 = script.ReleaseEmit:Clone()
            v25.CFrame = u20.CFrame
            v25.Parent = u4
            _G.customEmit(v25)
            _G.destroy(v25, 3)
            _G.tween(v22.SLDashLoop, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                ["Volume"] = 0
            })
            _G.destroy(v22.SLDashLoop, 0.25)
            _G.PlaySound(p9.PrimaryPart, script.SLDash).Parent = p9.PrimaryPart
            local v26 = p9.PrimaryPart:FindFirstChild("tackleLight")
            tick()
            task.spawn(function() --[[ Line: 150 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u4
                    [3] = u2
                    [4] = u6
                --]]
                for _ = 1, 5 do
                    task.spawn(function() --[[ Line: 152 ]]
                        --[[
                        Upvalues:
                            [1] = u20
                            [2] = u4
                            [3] = u2
                            [4] = u6
                        --]]
                        local u27 = script.SecondCone:Clone()
                        local v28 = u20.CFrame * CFrame.new(0, 0, -10)
                        local v29 = CFrame.Angles
                        local v30 = math.random(-360, 360)
                        u27.CFrame = v28 * v29(1.5707963267948966, math.rad(v30), 0)
                        u27.Parent = u4
                        _G.customEmit(u27)
                        _G.destroy(u27, 3)
                        local v31 = u27.Mesh.Scale
                        _G.tween(u27, {
                            0.5,
                            "Linear",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1
                        })
                        local v32 = _G.tween
                        local v33 = u27.Mesh
                        local v34 = {
                            0.7,
                            "Linear",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }
                        local v35 = {}
                        local v36 = v31.X * 2
                        local v37 = v31.Y * 3
                        local v38 = v31.Z * 2
                        v35.Scale = Vector3.new(v36, v37, v38)
                        v32(v33, v34, v35)
                        local v40 = u2.Heartbeat:Connect(function() --[[ Line: 163 ]]
                            --[[
                            Upvalues:
                                [1] = u27
                            --]]
                            local v39 = u27
                            v39.CFrame = v39.CFrame * CFrame.Angles(0, 0.13962634015954636, 0)
                        end)
                        for v41 = 6, 24 do
                            u27.Mesh.TextureId = u6["" .. v41].Texture
                            task.wait(0.016666666666666666)
                        end
                        v40:Disconnect()
                    end)
                    task.wait(0.066)
                end
            end)
            Color3.fromRGB(142, 161, 255)
            task.spawn(function() --[[ Line: 180 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                for _ = 1, 20 do
                    local v42 = u20.CFrame
                    local _ = {
                        ["WorldPosition"] = u20.Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    local v43 = {
                        ["WorldPosition"] = (v42 * CFrame.new(math.random(-15, 15), math.random(-15, 15), math.random(15, 25))).Position,
                        ["WorldAxis"] = Vector3.new(0, 1, 0)
                    }
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = u20.Position,
                        ["EndPosition"] = v43.WorldPosition,
                        ["Points"] = 3,
                        ["Size"] = 1,
                        ["Branches"] = true,
                        ["NoHighlight"] = true,
                        ["RandomSize"] = NumberRange.new(0.15, 1),
                        ["Offset"] = NumberRange.new(-25, 25),
                        ["MainColor"] = Color3.fromRGB(230, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(142, 161, 255),
                        ["LightningDuration"] = 0.1,
                        ["WaitFunction"] = function(p44, _) --[[ Name: WaitFunction, Line 201 ]]
                            if p44 % 2 == 0 then
                                task.wait()
                            end
                        end
                    })
                    task.wait(0.0165)
                end
            end)
            task.wait(0.35)
            if v26 then
                _G.tween(v26, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                    ["Brightness"] = 0
                })
                _G.destroy(v26, 0.25)
            end
            _G.particleEnabled(v23.BodyVFX, false)
            _G.destroy(v23, 2)
            _G.tween(v22.Highlight, { 0.1, "Cubic", Enum.EasingDirection.Out }, {
                ["FillTransparency"] = 1
            })
            _G.destroy(v22.Highlight, 0.1)
        end
    end
}