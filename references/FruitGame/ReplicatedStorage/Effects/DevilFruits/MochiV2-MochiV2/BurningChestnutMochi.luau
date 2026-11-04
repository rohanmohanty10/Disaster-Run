 

local v1 = {}
local u2 = script.MochiChestnut
local u3 = workspace.Effects
local u4 = game:GetService("TweenService")
local u5 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
function v1.start(_, u6, p7, u8, u9) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u3
        [4] = u4
    --]]
    if u6 == "shoot" then
        local v10 = Random.new()
        local v11 = v10:NextNumber(0.75, 1.25)
        local v12 = p7[1]
        local u13 = p7[2]
        local u14 = v10:NextInteger(1.5, 2)
        local v15 = u14 * 2
        local u16
        if u8 then
            u16 = u8.Character
        else
            u16 = u8
        end
        local u17 = u2.MochiSpike:Clone()
        if u16 then
            u5.apply(u17, u16)
        end
        u17.CFrame = CFrame.new(v12, u13) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -v15 / 2, 0)
        u17.Material = "Neon"
        u17.Color = Color3.new(1, 0.419608, 0.369467)
        u17.Size = Vector3.new(u14, v15, u14)
        local v18 = u17:GetChildren()
        for v19 = 1, #v18 do
            if v18[v19]:IsA("Attachment") then
                local v20 = v18[v19]
                local v21 = v18[v19].Position.X
                local v22 = -v15 / 2
                local v23 = v18[v19].Position.Z * (u14 / 2)
                v20.Position = Vector3.new(v21, v22, v23)
            end
        end
        u17.Parent = u3
        local v24 = u2:WaitForChild("ShootSpikeVFX"):Clone()
        if u16 then
            u5.apply(v24, u16)
        end
        v24.CFrame = CFrame.new(v12, u13) * CFrame.new(0, 0, -2.5 * v11) * CFrame.Angles(0, 1.5707963267948966, 0)
        v24.Parent = u3
        _G.customEmit(v24)
        _G.destroy(v24, 1.25)
        local v25 = (v12 - u13).Magnitude
        u4:Create(u17, TweenInfo.new(u8.Duration, Enum.EasingStyle.Linear), {
            ["CFrame"] = u17.CFrame * CFrame.new(0, v25, 0),
            ["Color"] = Color3.new(0, 0, 0)
        }):Play()
        _G.PlaySound(CFrame.new(v12), script["Audio/BurningChestnutMochiShoot" .. math.random(1, 3)], {
            ["RandomPitch"] = true
        })
        task.delay(u8.Duration, function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u2
                [3] = u16
                [4] = u5
                [5] = u13
                [6] = u14
                [7] = u3
                [8] = u17
            --]]
            if u8.Pos ~= nil then
                local v26 = u2:WaitForChild("SpikeHitVFX"):Clone()
                if u16 then
                    u5.apply(v26, u16)
                end
                v26.CFrame = CFrame.new(u13)
                _G.scaleParticle(v26, u14 / 1.5)
                v26.Parent = u3
                _G.customEmit(v26)
                _G.destroy(v26, 3)
                if u8.Humanoid == nil then
                    _G.PlaySound(v26, script["Audio/BurningChestnutMochiHitGround" .. math.random(1, 3)], {
                        ["RandomPitch"] = true
                    })
                else
                    _G.PlaySound(v26, script["Audio/BurningChestnutMochiH" .. math.random(1, 3)], {
                        ["RandomPitch"] = true
                    })
                end
                _G.tween(u17.PointLight, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 15,
                    ["Brightness"] = 0
                })
            end
            _G.particleEnabled(u17, false)
            u17.Transparency = 1
            _G.destroy(u17, 3)
        end)
        return
    end
    if not _G.checkRenderDistance(u6.HumanoidRootPart.Position) then
        return
    end
    local v27 = Random.new():NextNumber(0.75, 1.25)
    local u28 = u6.PrimaryPart
    local u29 = u2.MochiPivotRig:Clone()
    u5.apply(u29, u6)
    u29.RootPart.CFrame = u28:GetPivot() * CFrame.new(5, -50, 0)
    u29.Parent = u3
    local u30 = u2.RigDough:Clone()
    u5.apply(u30, u6)
    u30.Parent = u3
    u30.CFrame = u29.RootPart:GetPivot()
    local v31 = u29.AnimationController:WaitForChild("Animation")
    u29.AnimationController.Animator:LoadAnimation(v31):Play(0)
    u4:Create(u29.MochiStrand, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
        ["Size"] = Vector3.new(5.4985147, 43.85319, 5.8261895)
    }):Play()
    local u32 = u30.CFrame * CFrame.new(0, 0, -3)
    local u33 = CFrame.new(5, 8, 5)
    local u34 = nil
    task.delay(0.21, function() --[[ Line: 112 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u29
            [3] = u28
            [4] = u33
            [5] = u30
            [6] = u32
        --]]
        u34 = game["Run Service"].RenderStepped:Connect(function() --[[ Line: 113 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u28
                [3] = u33
                [4] = u30
                [5] = u32
            --]]
            if u29.PrimaryPart then
                u29.RootPart.CFrame = u28.CFrame * u33
            end
            u30.CFrame = u28.CFrame * u33
            u32 = u30.CFrame
        end)
    end)
    task.delay(0.9, function() --[[ Line: 123 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u30
            [3] = u29
        --]]
        u4:Create(u30, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            ["Transparency"] = 0
        }):Play()
        local v35 = u4
        local v36 = u30
        local v37 = TweenInfo.new(0.75, Enum.EasingStyle.Cubic)
        local v38 = {}
        local v39 = u30.Orientation.X
        local v40 = u30.Orientation.Y
        v38.Orientation = Vector3.new(v39, v40, 360)
        v35:Create(v36, v37, v38):Play()
        task.delay(0.1, function() --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u30
            --]]
            local v41 = u4
            local v42 = u30
            local v43 = TweenInfo.new(0.3, Enum.EasingStyle.Cubic)
            local v44 = {}
            local v45 = u30.Size.X
            local v46 = u30.Size.Y
            local v47 = u30.Size.Z
            v44.Size = Vector3.new(v45, v46, v47) * 1.25
            v41:Create(v42, v43, v44):Play()
        end)
        task.delay(0.3, function() --[[ Line: 130 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u29
                [3] = u30
            --]]
            u4:Create(u29.MochiStrand, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(u29, 0.2)
            task.wait(0.1)
            local v48 = u4
            local v49 = u30
            local v50 = TweenInfo.new(0.19, Enum.EasingStyle.Cubic)
            local v51 = {}
            local v52 = u30.Size.X
            local v53 = u30.Size.Y
            local v54 = u30.Size.Z
            v51.Size = Vector3.new(v52, v53, v54) * 0.85
            v48:Create(v49, v50, v51):Play()
            task.delay(0.2, function() --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u30
                --]]
                local v55 = u4
                local v56 = u30
                local v57 = TweenInfo.new(0.5, Enum.EasingStyle.Sine)
                local v58 = {}
                local v59 = u30.Size.X
                local v60 = u30.Size.Y
                local v61 = u30.Size.Z
                v58.Size = Vector3.new(v59, v60, v61) * 1.75
                v55:Create(v56, v57, v58):Play()
                task.wait(0.125)
                u4:Create(u30, TweenInfo.new(0.3, Enum.EasingStyle.Cubic), {
                    ["Color"] = Color3.new(0.926024, 0.422263, 0.36817),
                    ["Transparency"] = 0.25
                }):Play()
                u30.Material = "Neon"
            end)
        end)
    end)
    _G.PlaySound(u30, script["Audio/BurningChestnutMochiStart"]).Parent = u6.PrimaryPart
    task.wait(1.75)
    u4:Create(u30, TweenInfo.new(0.05, Enum.EasingStyle.Sine), {
        ["Transparency"] = 1
    }):Play()
    _G.destroy(u30, 0.05)
    u6.PrimaryPart:FindFirstChild("RootAttachment")
    local v62 = Instance.new("Attachment")
    local v63 = u33.X
    local v64 = u33.Y
    local v65 = u33.Z
    v62.Position = Vector3.new(v63, v64, v65)
    v62.Parent = u6.PrimaryPart
    local v66 = u2.Torus:Clone()
    u5.apply(v66, u6)
    local u67 = v66.PrimaryPart
    u67.Material = "Neon"
    u67.Color = Color3.new(1, 0.419608, 0.369467)
    u67.Position = u32.Position
    u67.Orientation = u30.Orientation
    u67.AlignPosition.Attachment1 = v62
    v66.Parent = u3
    local v68 = script["Audio/BurningChestnutMochiLoop"]:Clone()
    v68.Parent = u67
    v68:Play()
    local v69 = u67.AnimationController:WaitForChild("Animation")
    local v70 = u67.AnimationController.Animator:LoadAnimation(v69)
    v70:Play()
    v70:AdjustSpeed(2)
    u4:Create(u67, TweenInfo.new(0.55, Enum.EasingStyle.Cubic), {
        ["Color"] = Color3.new(0.177554, 0.220401, 0.257954)
    }):Play()
    task.delay(0.25, function() --[[ Line: 181 ]]
        --[[
        Upvalues:
            [1] = u67
        --]]
        u67.Material = "Metal"
    end)
    u34:Disconnect()
    local v71 = u2:WaitForChild("TorusSpawnVFX").Particles:Clone()
    u5.apply(v71, u6)
    v71.Parent = u67
    _G.customEmit(v71)
    _G.destroy(v71, 2)
    u4:Create(u67.PointLight, TweenInfo.new(0.4 * v27, Enum.EasingStyle.Cubic), {
        ["Brightness"] = 0,
        ["Range"] = 40
    }):Play()
    local u72 = nil
    local u73 = 0
    local u74 = 0
    local u75 = u6 == game.Players.LocalPlayer.Character
    local u76 = u6.PrimaryPart.CFrame
    local u77 = nil
    local v90 = game["Run Service"].RenderStepped:Connect(function(p78) --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u73
            [2] = u74
            [3] = u6
            [4] = u72
            [5] = u9
            [6] = u76
            [7] = u33
            [8] = u75
            [9] = u77
            [10] = u67
        --]]
        u73 = u73 + p78
        u74 = u74 + p78 * 500
        local v79 = u73 * 4
        local v80 = math.sin(v79) * 2
        if u6.PrimaryPart == nil then
            u72:Disconnect()
            return
        else
            local v81 = u6.PrimaryPart.CFrame
            if u9 ~= nil then
                v81 = u76
            end
            local v82 = (v81 * u33).Position + Vector3.new(0, v80, 0)
            local v83
            if u75 == true and u9 == nil then
                v83 = _G.MouseCF.Position
            else
                v83 = u6:GetAttribute("BurningChestnutMochiTargetPosition")
            end
            local v84 = false
            if v83 == nil then
                v84 = true
            else
                u77 = v83
            end
            if v83 == nil then
                v83 = u77
            end
            if v83 ~= nil and v82 ~= nil then
                local v85 = CFrame.new(v82, v83) * CFrame.Angles(3.141592653589793, 0, 0)
                if v84 == false then
                    local v86 = u74
                    v85 = v85 * CFrame.Angles(0, 0, (math.rad(v86)))
                end
                local v87 = u67
                local v88 = u67.CFrame
                local v89 = p78 * 50
                v87.CFrame = v88:Lerp(v85, (math.clamp(v89, 0, 1)))
            end
        end
    end)
    local v91 = p7:IsA("RemoteEvent")
    local v92 = v90
    local v93 = u34
    local v94 = 0
    while true do
        if u75 == true and (v91 and (p7 and tick() - v94 >= 0.05)) then
            p7:FireServer("updateCenter", u67.CFrame)
            v94 = tick()
        end
        task.wait()
        if p7 and p7:IsDescendantOf(game) == false then
            v93:Disconnect()
            v92:Disconnect()
            v70:Stop()
            _G.particleEnabled(u67, false)
            task.wait(0.1)
            u4:Create(u67, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                ["Transparency"] = 1,
                ["Size"] = u67.Size / 2
            }):Play()
            u4:Create(v68, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                ["Volume"] = 0
            }):Play()
            task.wait(0.45)
            _G.destroy(v66, 3.75)
            return
        end
    end
end
return v1