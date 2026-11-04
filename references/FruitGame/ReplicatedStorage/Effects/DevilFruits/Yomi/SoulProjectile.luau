 

local v1 = {}
local u2 = script:WaitForChild("Animations")
game:GetService("TweenService")
local u3 = game:GetService("RunService")
function PlayAnim(p4, p5)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = (p4:FindFirstChild("Humanoid") or p4:FindFirstChild("AnimationController")).Animator:LoadAnimation(u2[p5])
    v6:Play(0, 1, -1)
    return v6
end
function CreateMesh(p7, p8)
    local v9 = script:WaitForChild("MeshImage"):Clone()
    v9.CFrame = p8 * CFrame.Angles(0, -1.5707963267948966, 0)
    v9.Parent = workspace.Effects
    v9.Decal.Texture = "rbxassetid://" .. p7
    return v9
end
local u10 = _G.customEmit
function ReturnSoul(p11, p12)
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v13 = script:WaitForChild("ReEnter").Attachment:Clone()
    v13.Parent = p11.PrimaryPart
    _G.scaleParticle(v13, 1.3)
    u10(v13)
    _G.destroy(v13, 1)
    _G.destroy(p12, 1)
end
local u14 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
function v1.start(_, u15, u16, u17, p18) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u14
    --]]
    if u16 == "freeze" then
        local u19
        if u17.Humanoid:findFirstChild("BodyHeightScale") then
            local v20 = u17.Humanoid.BodyWidthScale.Value
            local v21 = u17.Humanoid.BodyHeightScale.Value
            local v22 = u17.Humanoid.BodyDepthScale.Value
            u19 = Vector3.new(v20, v21, v22)
        else
            u19 = 1
        end
        local v23 = script:WaitForChild("Freeze").Attachment:Clone()
        v23.Parent = u17.PrimaryPart
        if typeof(u19) == "Vector3" then
            local v24 = u19.Magnitude
        end
        _G.scaleParticle(v23, v24)
        _G.customEmit(v23)
        _G.destroy(v23, 2)
        local u25 = u17.PrimaryPart
        if u17:findFirstChild("UpperTorso") then
            u25 = u17.UpperTorso
        end
        local v26 = script:WaitForChild("IceCube"):Clone()
        local v27 = Color3.fromRGB(103, 173, 219)
        local v28 = Enum.Material.Neon
        v26.Color = v27
        v26.Material = v28
        v26.CFrame = u17:GetPrimaryPartCFrame()
        v26.Parent = workspace.Effects
        _G.customWeld(v26, u25, CFrame.new(), v26)
        _G.tween(v26, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["Size"] = Vector3.new(6.399, 6.566, 4.47) * u19 * 1.25
        })
        _G.tween(v26, { 0.35, "Cubic", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.destroy(v26, 0.35)
        local u29 = script:WaitForChild("IceCube"):Clone()
        u29.CFrame = u17:GetPrimaryPartCFrame()
        u29.Parent = workspace.Effects
        _G.customWeld(u29, u25, CFrame.new(), u29)
        _G.tween(u29, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["Size"] = Vector3.new(6.399, 6.566, 4.47) * u19
        })
        _G.PlaySound(u17.PrimaryPart, script.YomiProjectilleHitFreeze)
        task.delay(p18, function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u25
                [3] = u19
                [4] = u17
            --]]
            u29:Destroy()
            local v30 = script:WaitForChild("IceCubeParts"):Clone()
            v30:PivotTo(u25.CFrame)
            _G.scaleModel(v30, u19)
            v30.Parent = workspace.Effects
            _G.destroy(v30, 2)
            local v31 = Random.new()
            local v32 = next
            local v33, v34 = v30:GetChildren()
            for _, u35 in v32, v33, v34 do
                local v36 = Instance.new("BodyAngularVelocity")
                local v37 = Instance.new("BodyVelocity")
                local v38 = v31:NextUnitVector() * 10
                v36.MaxTorque = Vector3.new(25000000, 25000000, 25000000)
                v36.AngularVelocity = v38
                v36.P = 1250
                local v39 = v31:NextNumber(-1, 1)
                local v40 = v31:NextNumber(0.25, 1)
                v37.Velocity = Vector3.new(v39, v40, v31:NextNumber(-1, 1)) * math.random(15, 35)
                v37.MaxForce = Vector3.new(50000000, 50000000, 50000000)
                v37.Parent = u35
                v36.Parent = u35
                _G.destroy(v37, 0.225)
                task.delay(0.1, function() --[[ Line: 100 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                    --]]
                    _G.tween(u35, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                        ["Size"] = Vector3.new(0, 0, 0)
                    })
                end)
            end
            if u17.Parent ~= nil then
                _G.PlaySound(u17.PrimaryPart, script.YomiProjectilleFreezeBreak)
            end
        end)
        return
    elseif u16 == "return" then
        ReturnSoul(u15)
        _G.PlaySound(u15.PrimaryPart, script.YomiProjectileReturnToBody)
        return
    else
        local u41 = script:WaitForChild("Projectile"):Clone()
        local v42 = Instance.new("Highlight")
        v42.DepthMode = Enum.HighlightDepthMode.Occluded
        v42.FillTransparency = 0.3
        v42.OutlineColor = Color3.fromRGB(29, 43, 29)
        v42.FillColor = Color3.fromRGB(119, 182, 113)
        v42.Parent = u41
        u41:PivotTo(u15:GetPrimaryPartCFrame())
        u41.PrimaryPart.YomiProjectileFlyLOOP:Play()
        u41.PrimaryPart.YomiProjectileStart:Play()
        u41.Parent = workspace.Effects
        PlayAnim(u41, "Projectile")
        if u15 == game.Players.LocalPlayer.Character then
            local u43 = false
            local u44 = tick()
            local u45 = script.ColorCorrection:Clone()
            u45.TintColor = Color3.fromRGB(255, 255, 255)
            u45.Saturation = 0
            u45.Parent = workspace.CurrentCamera
            _G.tween(u45, { 0.75, "Cubic", Enum.EasingDirection.Out }, {
                ["Saturation"] = script.ColorCorrection.Saturation,
                ["TintColor"] = script.ColorCorrection.TintColor
            })
            local u46 = 0
            local u47 = nil
            local u48 = {}
            local u49 = workspace.CurrentCamera
            u47 = u3.Heartbeat:Connect(function(p50) --[[ Line: 146 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u47
                    [3] = u41
                    [4] = u15
                    [5] = u49
                    [6] = u45
                    [7] = u43
                    [8] = u46
                    [9] = u14
                    [10] = u44
                    [11] = u48
                --]]
                if u16 == nil or u16 and u16:IsDescendantOf(game) == false then
                    u47:Disconnect()
                    u47 = nil
                    local v51 = next
                    local v52, v53 = u41:GetDescendants()
                    for _, v54 in v51, v52, v53 do
                        if ({
                            ["ParticleEmitter"] = true,
                            ["Highlight"] = true,
                            ["Trail"] = true
                        })[v54.ClassName] then
                            v54.Enabled = false
                        elseif v54:IsA("BasePart") then
                            _G.tween(v54, { 0.35, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(0, 0, 0),
                                ["Transparency"] = 1,
                                ["Position"] = u15.PrimaryPart.Position
                            })
                        end
                    end
                    u41.PrimaryPart.YomiProjectileFlyLOOP:Stop()
                    _G.destroy(u41, 3)
                    u49.CameraSubject = u15.Humanoid
                    _G.tween(u45, { 0.75, "Cubic", Enum.EasingDirection.Out }, {
                        ["Saturation"] = 0,
                        ["TintColor"] = Color3.fromRGB(255, 255, 255)
                    })
                    u41.PrimaryPart.YomiProjectileFlyLOOP:Stop()
                    return
                end
                if u16 and u16.Name == "keygo" then
                    local v55 = u41.PrimaryPart.Position
                    u41:PivotTo(u41:GetPrimaryPartCFrame():Lerp(CFrame.new(v55, u15.PrimaryPart.Position), 0.65 ^ (1 / (p50 * 60))))
                    u41:PivotTo(u41:GetPrimaryPartCFrame() * CFrame.new(0, 0, -120 * p50))
                    u43 = true
                else
                    local v56 = u41.PrimaryPart.Position
                    u41:PivotTo(u41.PrimaryPart.CFrame:Lerp(CFrame.new(v56, v56 + u49.CFrame.LookVector), 0.1 * (p50 * 60)))
                    u41:PivotTo(u41:GetPrimaryPartCFrame() * CFrame.new(0, 0, -75 * p50))
                end
                if u16 and tick() - u46 >= 0.03333333333333333 then
                    u16:FireServer("replicate", u41.PrimaryPart.CFrame)
                    u46 = tick()
                end
                local v57 = u14.new(u41.PrimaryPart.CFrame, Vector3.new(9, 9, 9))
                local v58 = _G.getTargets(u15)
                local v59 = u15
                table.insert(v58, v59)
                local v60 = v57:FindPartsInRegion3WithWhiteList(v58, 50000)
                for v61 = 1, #v60 do
                    if v60[v61].Parent:FindFirstChild("HumanoidRootPart") then
                        local u62 = v60[v61].Parent
                        if v60[v61].Parent == u15 and (tick() - u44 >= 0.3 or u16.Name == "keygo") then
                            if u16 then
                                u16:FireServer("return")
                            end
                            u43 = true
                            break
                        end
                        if v60[v61].Parent ~= u15 and (u48[u62] == nil and u43 == false) then
                            u48[u62] = true
                            if u16 then
                                u16:FireServer("freeze", v60[v61].Parent)
                            end
                            task.delay(4, function() --[[ Line: 197 ]]
                                --[[
                                Upvalues:
                                    [1] = u48
                                    [2] = u62
                                --]]
                                u48[u62] = nil
                            end)
                        end
                    end
                end
                u49.CameraSubject = u41.CamPart
            end)
        else
            local u63 = tick()
            u16.OnClientEvent:Connect(function(p64, p65) --[[ Line: 210 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u63
                --]]
                if p64 == "replicate" then
                    _G.tween(u41.PrimaryPart, { tick() - u63, "Quad", Enum.EasingDirection.Out }, {
                        ["CFrame"] = p65
                    }, nil, true)
                    u63 = tick()
                else
                    local _ = p64 == "return"
                end
            end)
            repeat
                task.wait()
            until u16 == nil or u16 and u16:IsDescendantOf(game) == false
            local v66 = next
            local v67, v68 = u41:GetDescendants()
            for _, v69 in v66, v67, v68 do
                if ({
                    ["ParticleEmitter"] = true,
                    ["Highlight"] = true,
                    ["Trail"] = true
                })[v69.ClassName] then
                    v69.Enabled = false
                elseif v69:IsA("BasePart") then
                    _G.tween(v69, { 0.35, "Cubic", Enum.EasingDirection.Out }, {
                        ["Size"] = Vector3.new(0, 0, 0),
                        ["Transparency"] = 1,
                        ["Position"] = u15.PrimaryPart.Position
                    })
                end
            end
            u41.PrimaryPart.YomiProjectileFlyLOOP:Stop()
            _G.destroy(u41, 3)
        end
    end
end
return v1