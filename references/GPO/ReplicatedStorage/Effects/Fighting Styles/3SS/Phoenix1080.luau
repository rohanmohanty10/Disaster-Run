 

game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("Workspace")
local u1 = script.Move1
local v2 = {}
local function u6(p3, p4) --[[ Line: 17 ]]
    for _, v5 in ipairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = p4
        end
    end
end
function AlignCFrame(p7, p8, _)
    local v9 = p7.Position
    local v10 = p7.LookVector:Cross(p8).Unit
    local v11 = (v10.Magnitude > 0.001 and v10 and v10 or p7.RightVector).Unit
    local v12 = v11:Cross(p8).Unit.Unit
    return CFrame.fromMatrix(v9, v11, p8, v12)
end
local function u16(p13, p14, p15) --[[ Line: 48 ]]
    _G.tween(p13, {
        p15,
        "Sine",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = p14,
        ["Transparency"] = 1
    })
end
function v2.start(_, p17) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u16
        [3] = u6
    --]]
    local v18 = p17.typ
    local v19 = p17.char
    local u20 = p17.startCFrame
    local v21 = p17.endCFrame
    if v19 ~= nil then
        local v22
        if v19 then
            v22 = v19.PrimaryPart
        else
            v22 = v19
        end
        if v22 ~= nil then
            if _G.checkRenderDistance(v19.PrimaryPart.Position) == false then
                return
            else
                local u23 = p17.groundCFrame
                local u24 = p17.groundColor
                local v25 = p17.ProjectileDuration
                local u26 = p17.hakiColor
                local v27 = v19.PrimaryPart
                if v18 == "startup" then
                    local v28 = u1.Charge:Clone()
                    v28.Parent = workspace.Effects
                    if u26 then
                        _G.PlayEffect("3SSRecolor", nil, v28, u26, "isBlue", Color3.fromRGB(134, 192, 255))
                    end
                    v28.CFrame = v27.CFrame
                    _G.customEmit(v28)
                    _G.destroy(v28, 3)
                else
                    local u29 = Instance.new("Folder")
                    u29.Parent = workspace.Effects
                    local v30 = u1.Throw:Clone()
                    local u31 = u1.Projectile:Clone()
                    local u32 = u1.Mesh:Clone()
                    local v33 = u1.Pierce:Clone()
                    local v34 = v21.Position
                    v30.CFrame = CFrame.lookAt(v27.Position, v34)
                    u31.CFrame = u20
                    u32.CFrame = v30.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
                    v33.CFrame = v30.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
                    local v35 = Instance.new("Highlight")
                    v35.DepthMode = Enum.HighlightDepthMode.Occluded
                    v35.FillTransparency = 0.05
                    v35.OutlineColor = Color3.fromRGB(82, 145, 255)
                    v35.FillColor = Color3.fromRGB(19, 29, 47)
                    v35.Parent = v33
                    if u26 then
                        v35.OutlineColor = u26
                    end
                    local v36 = Instance.new("Highlight")
                    v36.OutlineTransparency = 1
                    v36.DepthMode = Enum.HighlightDepthMode.Occluded
                    v36.FillTransparency = 1
                    v36.Parent = u32
                    if u26 then
                        _G.PlayEffect("3SSRecolor", nil, {
                            v30,
                            u31,
                            u32,
                            v33
                        }, u26, "isBlue", Color3.fromRGB(134, 192, 255))
                    end
                    v30.Parent = u29
                    u31.Parent = u29
                    u32.Parent = u29
                    v33.Parent = u29
                    u16(u32, Vector3.new(19, 0, 19), 0.15)
                    u16(v33, Vector3.new(24, 0, 0), 0.25)
                    _G.customEmit(v30)
                    _G.tween(u31, {
                        v25,
                        "Linear",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CFrame"] = v21
                    })
                    _G.PlaySound(u31, script["Audio/3ss108PoundHoShoot"]).Parent = u31
                    local v37 = tick()
                    local function v41(p38, p39) --[[ Line: 139 ]]
                        for _, v40 in ipairs(p38:GetChildren()) do
                            if v40:IsA("Beam") then
                                table.insert(p39, v40)
                                v40.Enabled = true
                            end
                        end
                    end
                    local u47 = game["Run Service"].Heartbeat:Connect(function(p42) --[[ Line: 149 ]]
                        --[[
                        Upvalues:
                            [1] = u31
                        --]]
                        local v43 = u31.TrailAttachments
                        local v44 = v43.WorldCFrame
                        local v45 = CFrame.Angles
                        local v46 = 1500 * p42
                        v43.WorldCFrame = v44 * v45(0, 0, (math.rad(v46)))
                    end)
                    local v48 = 0
                    if u23 ~= nil then
                        task.delay(v25, function() --[[ Line: 156 ]]
                            --[[
                            Upvalues:
                                [1] = u23
                                [2] = u26
                                [3] = u20
                                [4] = u24
                            --]]
                            local v49 = script.groundHit:Clone()
                            v49:SetPrimaryPartCFrame(u23)
                            if u26 then
                                _G.PlayEffect("3SSRecolor", nil, v49, u26, "isBlue", Color3.fromRGB(134, 192, 255))
                            end
                            v49.Ground.Attachment.WorldCFrame = CFrame.new(v49.Ground.Attachment.WorldPosition, u20.Position)
                            _G.recolorParticles(v49, u24)
                            v49.Parent = workspace.Effects
                            _G.customEmit(v49)
                            _G.destroy(v49, 5)
                            _G.PlaySound(v49, script["Audio/3ss108PoundHoGroundHit"], {
                                ["RandomPitch"] = true
                            })
                        end)
                    end
                    while v25 > tick() - v37 do
                        if tick() - v48 >= 0.03 then
                            local v50 = {}
                            local v51 = u1.BeamSlashes:Clone()
                            v41(v51, v50)
                            if u26 then
                                _G.PlayEffect("3SSRecolor", nil, v51, u26, "isBlue", Color3.fromRGB(134, 192, 255))
                            end
                            v51.CFrame = u31.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                            v51.Parent = u29
                            for _, v52 in ipairs(v50) do
                                _G.tween(v52, {
                                    0.1,
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
                            v48 = tick()
                        end
                        task.wait()
                    end
                    task.delay(0.1, function() --[[ Line: 207 ]]
                        --[[
                        Upvalues:
                            [1] = u47
                            [2] = u32
                            [3] = u6
                            [4] = u31
                        --]]
                        u47:Disconnect()
                        u47 = nil
                        u32:Destroy()
                        u6(u31, false)
                    end)
                    task.delay(2.5, function() --[[ Line: 215 ]]
                        --[[
                        Upvalues:
                            [1] = u29
                        --]]
                        u29:Destroy()
                    end)
                end
            end
        end
    end
end
return v2