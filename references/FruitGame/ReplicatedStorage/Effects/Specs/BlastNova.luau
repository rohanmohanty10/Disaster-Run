 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = v1.LocalPlayer
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v4 = script.Assets
        local v5 = Color3.new(1, 1, 1)
        local u6 = Color3.fromRGB(255, 41, 162)
        local v7 = p3.ChargeTime or 3
        local _ = p3.AnchorPoint
        local v8 = p3.Hitbox
        local v9 = p3.Character:WaitForChild("HumanoidRootPart")
        local function v12(p10) --[[ Line: 50 ]]
            for _, v11 in ipairs(p10) do
                if v11:IsA("BasePart") then
                    v11.Anchored = false
                end
            end
        end
        local v13 = v4.Beam:Clone()
        v12(v13:GetDescendants())
        v13:PivotTo(v8.CFrame)
        _G.destroy(v13, 10)
        local u14 = v4.BeamCharge:Clone()
        v12(u14:GetDescendants())
        u14:PivotTo(v9.CFrame * CFrame.new(0, 0, -4))
        _G.destroy(u14, 10)
        local v15 = v4.Burst:Clone()
        v15.Anchored = false
        v15.CFrame = u14.PrimaryPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
        (function(p16) --[[ Name: ParticlesOff, Line 58 ]]
            for _, v17 in p16:GetDescendants() do
                if v17:IsA("ParticleEmitter") or (v17:IsA("Trail") or v17:IsA("Beam")) then
                    v17.Enabled = false
                end
            end
        end)(v15)
        v15.Parent = u14
        local v18 = {}
        local function v22(p19) --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            local v20 = u6
            for _, v21 in p19:GetDescendants() do
                if v21:GetAttribute("Color") then
                    v21.Color = ColorSequence.new(v20)
                elseif v21:GetAttribute("ColorDark") then
                    v21.Color = ColorSequence.new(Color3.fromRGB(v20.R * 0.5, v20.G * 0.5, v20.B * 0.5))
                elseif v21:GetAttribute("ColorSpecs") then
                    v21.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, v20),
                        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 0, 0)),
                        ColorSequenceKeypoint.new(0.45, v20),
                        ColorSequenceKeypoint.new(0.525, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    })
                elseif v21:IsA("PointLight") then
                    v21.Color = v20
                    v21.Range = 0
                end
                if v21:IsA("ParticleEmitter") then
                    v21.Enabled = false
                end
            end
        end
        for _, v23 in v13:GetChildren() do
            if v23:IsA("BasePart") then
                local v24 = Instance.new("WeldConstraint")
                v24.Part0 = v8
                v24.Part1 = v23
                v24.Parent = v8
                v18[v23] = v23.Size
                v23.Size = Vector3.new(0, 0, 0)
            end
        end
        for _, v25 in u14:GetChildren() do
            if v25:IsA("BasePart") then
                local v26 = Instance.new("WeldConstraint")
                v26.Part0 = v8
                v26.Part1 = v25
                v26.Parent = v8
            end
        end
        v22(u14.ChargeEffect)
        v13.Inner.Color = v5
        v13.Outter.Color = u6
        v13.Parent = workspace.Effects
        u14.Parent = workspace.Effects
        for _, v27 in u14:GetChildren() do
            if v27:IsA("BasePart") and v27.Name ~= "ChargeEffect" then
                u2:Create(v27, TweenInfo.new(1.4), {
                    ["Size"] = v27.Size * 1.5
                }):Play()
            end
        end
        for _, v28 in u14.ChargeEffect:GetChildren() do
            if v28.Name ~= "Flame" and (v28.Name ~= "FlameCharged" and v28:IsA("ParticleEmitter")) then
                v28.Enabled = true
            end
        end
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Charge)
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Charge2)
        task.wait(v7)
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Ready)
        for _, v29 in u14.ChargeEffect:GetDescendants() do
            if v29.Name == "SparkReady" or v29.Name == "Flame" then
                v29.Enabled = true
            elseif v29:IsA("ParticleEmitter") then
                v29.Enabled = false
            end
        end
        for _, v30 in u14.ChargeEffect.Emit:GetChildren() do
            v30:Emit(1)
        end
        task.wait(1)
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Explode)
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Explode2)
        _G.PlaySound(u14.Inner.Sounds, u14.Inner.Sounds.Explode3)
        u14.ChargeEffect.FlameCharged.Enabled = true
        for _, u31 in v15:GetDescendants() do
            if u31:IsA("ParticleEmitter") then
                u31.Enabled = true
                task.delay(2.5, function() --[[ Line: 159 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                    --]]
                    u31.Enabled = false
                end)
            elseif u31:IsA("PointLight") then
                u2:Create(u31, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    ["Range"] = 60
                }):Play()
                task.delay(2.5, function() --[[ Line: 166 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u31
                    --]]
                    u2:Create(u31, TweenInfo.new(1), {
                        ["Brightness"] = 0
                    }):Play()
                end)
            end
        end
        for _, u32 in u14.ChargeEffect:GetDescendants() do
            if u32.Name == "Flame" or (u32.Name == "FlameCharged" or u32.Name == "Spark") then
                u32.Enabled = true
                task.delay(1.5, function() --[[ Line: 178 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                    --]]
                    u32.Enabled = false
                    u32.LockedToPart = false
                end)
            end
        end
        task.delay(1.5, function() --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            for _, v33 in u14:GetDescendants() do
                if v33:IsA("ParticleEmitter") then
                    v33.Enabled = false
                    v33.LockedToPart = false
                end
            end
        end)
        for u34, u35 in v18 do
            local v36 = u2
            local v37 = TweenInfo.new(0.3)
            local v38 = {}
            local v39 = u35.X * 3
            local v40 = u35.Y * 3
            local v41 = u35.Z
            v38.Size = Vector3.new(v39, v40, v41)
            v38.CFrame = u34.CFrame * CFrame.new(0, 0, -u35.Z / 2)
            v36:Create(u34, v37, v38):Play()
            task.delay(0.3, function() --[[ Line: 201 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u34
                    [3] = u35
                --]]
                local v42 = u2
                local v43 = u34
                local v44 = TweenInfo.new(2)
                local v45 = {}
                local v46 = u35.Z
                v45.Size = Vector3.new(0, 0, v46)
                v45.Transparency = 1
                v42:Create(v43, v44, v45):Play()
            end)
        end
    end
}