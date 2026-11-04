 

game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Workspace")
local u1 = script.Move3
local _ = u1.Anims
local v2 = {}
local function u6(p3, p4, p5) --[[ Line: 45 ]]
    _G.tween(p3, {
        p4,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = p5
    })
end
function AlignCFrame(p7, p8, _)
    local v9 = p7.Position
    local v10 = p7.LookVector:Cross(p8).Unit
    local v11 = (v10.Magnitude > 0.001 and v10 and v10 or p7.RightVector).Unit
    local v12 = v11:Cross(p8).Unit.Unit
    return CFrame.fromMatrix(v9, v11, p8, v12)
end
function v2.start(_, p13) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u6
    --]]
    local v14 = p13.typ
    local v15 = p13.char
    local v16 = p13.startCFrame
    local v17 = p13.endCFrame
    if v15 ~= nil then
        local v18
        if v15 then
            v18 = v15.PrimaryPart
        else
            v18 = v15
        end
        if v18 ~= nil then
            if _G.checkRenderDistance(v15.PrimaryPart.Position) == false then
                return
            else
                local v19 = p13.hakiColor
                local v20 = v15:WaitForChild("HumanoidRootPart")
                v15:WaitForChild("Humanoid")
                local v21 = v15 == game.Players.LocalPlayer.Character
                if v14 == "startup" then
                    if v21 == false then
                        v15:SetPrimaryPartCFrame(p13.charCFrame)
                    end
                    local v22 = u1.Startup:Clone()
                    v22.CFrame = v20.CFrame
                    local v23, v24, v25 = _G.getRayFloor(v22.CFrame, 8)
                    if v23 then
                        _G.recolorParticles(v22, v23.Color)
                        local v26 = v24 + Vector3.new(0, 0.2, 0)
                        local v27 = CFrame.new(v26, v26 + v25)
                        local v28 = CFrame.Angles
                        local v29 = math.random(0, 360)
                        local v30 = v27 * v28(-1.5707963267948966, math.rad(v29), 0)
                        v22.VFX.WorldCFrame = v30
                    else
                        _G.removeParticles(v22)
                    end
                    if v19 then
                        _G.PlayEffect("3SSRecolor", nil, v22, v19)
                    end
                    v22.Parent = workspace.Effects
                    _G.customEmit(v22)
                    _G.destroy(v22, 4)
                else
                    v15:SetPrimaryPartCFrame(v16)
                    _G.enableSwordTrails(v15, 0.4)
                    local v31 = u1.Onigiri:Clone()
                    local u32 = u1.Pierce:Clone()
                    local v33 = u1.Distort:Clone()
                    v31:PivotTo(v20.CFrame * CFrame.new(0, 0, -20))
                    u32.CFrame = v20.CFrame * CFrame.new(0, 0, -20) * CFrame.Angles(0, -1.5707963267948966, 0)
                    v33.CFrame = u32.CFrame * CFrame.Angles(0, 0, -1.5707963267948966)
                    local v34, v35, v36 = _G.getRayFloor(v16, 8)
                    if v34 then
                        local v37 = (v16.Position - v17.Position).Magnitude
                        _G.recolorParticles(v31, v34.Color)
                        v31.GroundCut.Size = Vector3.new(10, 0.25, v37)
                        v31.GroundCut.CFrame = AlignCFrame(CFrame.new(Vector3.new(), v16.LookVector) + v35, v36) * CFrame.new(0, 0, -v37 / 2)
                    else
                        _G.removeParticles(v31)
                        v31.GroundCut:Destroy()
                    end
                    local v38 = Instance.new("Highlight")
                    v38.OutlineTransparency = 1
                    v38.DepthMode = Enum.HighlightDepthMode.Occluded
                    v38.FillTransparency = 1
                    v38.OutlineColor = Color3.fromRGB(91, 255, 66)
                    v38.FillColor = Color3.fromRGB(0, 0, 0)
                    v38.Parent = v33
                    local v39 = Instance.new("Highlight")
                    v39.OutlineTransparency = 0
                    v39.DepthMode = Enum.HighlightDepthMode.Occluded
                    v39.FillTransparency = 0
                    v39.OutlineColor = Color3.fromRGB(91, 255, 66)
                    v39.FillColor = Color3.fromRGB(0, 0, 0)
                    v39.Parent = u32
                    if v19 then
                        v38.OutlineColor = v19
                        v39.OutlineColor = v19
                        _G.PlayEffect("3SSRecolor", nil, { v31, u32, v33 }, v19)
                    end
                    v31.Parent = workspace.Effects
                    u32.Parent = workspace.Effects
                    v33.Parent = workspace.Effects
                    v15:SetPrimaryPartCFrame(v16)
                    _G.PlaySound(v15.PrimaryPart, script["3ssOnigiriLaunch"]).Parent = v20
                    _G.customEmit(v31)
                    _G.tween(v20, {
                        0.1,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = v17
                    })
                    if v15 == game.Players.LocalPlayer.Character then
                        _G.tween(workspace.CurrentCamera, {
                            0.05,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            true,
                            0
                        }, {
                            ["FieldOfView"] = 90
                        })
                    end
                    for _, v40 in ipairs(v31:GetDescendants()) do
                        if v40:IsA("Beam") then
                            _G.tween(v40, {
                                0.6,
                                "Quad",
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            })
                        end
                    end
                    _G.tween(v31.BeamSlashes, {
                        0.75,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = v31.BeamSlashes.CFrame * CFrame.new(20, 0, 0) * CFrame.Angles(-3.4033920413889427, 0, 0)
                    })
                    local v41 = u6
                    local v42 = u32.Size.X
                    v41(u32, 0.17, (Vector3.new(v42, 0, 0)))
                    local v43 = u6
                    local v44 = u32.Size.Y
                    v43(v33, 0.3, (Vector3.new(0, v44, 0)))
                    task.delay(0.5, function() --[[ Line: 177 ]]
                        --[[
                        Upvalues:
                            [1] = u32
                        --]]
                        u32:Destroy()
                    end)
                    _G.destroy({ v31, v33 }, 5)
                end
            end
        end
    end
end
return v2