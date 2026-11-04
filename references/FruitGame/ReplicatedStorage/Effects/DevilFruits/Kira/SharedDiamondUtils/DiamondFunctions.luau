 

local u1 = game:GetService("TweenService")
local u2 = workspace.Effects
local u3 = script.DiamondRockDebris
local u4 = Random.new()
local u128 = {
    ["DiamondDebris"] = function(p5, p6, p7, p8, p9, p10, p11, p12, p13) --[[ Name: DiamondDebris, Line 9 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v14 = u3
        local v15 = script.DebrisShine.Attachment
        if p13 == true then
            v14 = script.HakiDiamondRockDebris
            v15 = script.HakiDebrisShine.Attachment
        end
        if typeof(p7) == "number" then
            p7 = NumberRange.new(p7, p7)
        end
        if typeof(p8) == "number" then
            p8 = NumberRange.new(p8, p8)
        end
        for _ = 1, p5 do
            local v16 = Random.new():NextNumber(p8.Min, p8.Max)
            local v17 = v14:GetChildren()[math.random(1, #v14:GetChildren())]:Clone()
            v17.Anchored = false
            v17.CanCollide = false
            local v18 = p6.CFrame * CFrame.new(p6.Size.X / 2, p6.Size.Y / 2, p6.Size.Z / 2)
            local v19 = CFrame.Angles
            local v20 = Random.new():NextNumber(-180, 180)
            local v21 = math.rad(v20)
            local v22 = Random.new():NextNumber(-180, 180)
            local v23 = math.rad(v22)
            local v24 = Random.new():NextNumber(-180, 180)
            v17.CFrame = v18 * v19(v21, v23, (math.rad(v24)))
            v17.Size = Vector3.new(3, 2, 2.5) * v16
            local v25 = Random.new():NextNumber(p7.Min, p7.Max)
            local v26 = v15:Clone()
            local v27 = {}
            for v28 = 1, #v26.Star.Size.Keypoints do
                local v29 = v26.Star.Size.Keypoints[v28]
                local v30 = NumberSequenceKeypoint.new
                local v31 = v29.Time
                local v32 = v29.Value * v16
                local v33 = v29.Envelope
                table.insert(v27, v30(v31, v32, v33))
            end
            v26.Star.Size = NumberSequence.new(v27)
            v26.Star.Lifetime = NumberRange.new(v25, v25)
            v17.Parent = p11
            local v34 = Random.new():NextNumber(-p9, p9)
            local v35 = Random.new():NextNumber(p9, p9 * 1.5)
            local v36 = Random.new()
            local v37 = -p9
            v17.Velocity = Vector3.new(v34, v35, v36:NextNumber(v37, p9))
            local v38 = Random.new():NextNumber(-p10, p10)
            local v39 = Random.new():NextNumber(-p10, p10)
            local v40 = Random.new()
            local v41 = -p10
            v17.RotVelocity = Vector3.new(v38, v39, v40:NextNumber(v41, p10))
            v26.Parent = v17
            u1:Create(v17, TweenInfo.new(v25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
            v26.Star:Emit(1)
            if p12 then
                table.insert(p12, v17)
            else
                _G.destroy(v17, p7.Max)
                _G.destroy(v26, v26.Star.Lifetime.Max)
            end
        end
    end,
    ["BreakDiamond"] = function(u42, p43) --[[ Name: BreakDiamond, Line 64 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local u44 = script.DiamondBreak:Clone()
        if p43 == true then
            u44 = script.HakiDiamondBreak:Clone()
        end
        u44.Size = u42.Size
        u44.CFrame = u42.CFrame
        u44.Parent = u2
        _G.customEmit(u44)
        u42.Transparency = 1
        if u42:FindFirstChild("Weld") then
            u42.Weld:Destroy()
        end
        u42.Anchored = true
        for _, v45 in u42:GetChildren() do
            if v45:IsA("ParticleEmitter") then
                v45.Enabled = false
            end
        end
        task.delay(5, function() --[[ Line: 86 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u42
            --]]
            u44:Destroy()
            u42:Destroy()
        end)
    end,
    ["DiamondMorph"] = function(p46, p47, p48) --[[ Name: DiamondMorph, Line 92 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v49 = Instance.new("Folder")
        v49.Name = p48
        v49.Parent = p46
        _G.destroy(v49, 30)
        local u50 = Instance.new("ObjectValue")
        u50.Name = "currentDiamondMorph"
        u50.Value = v49
        u50.Parent = p46.Boosts
        v49.Destroying:Once(function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u50
            --]]
            u50:Destroy()
        end)
        local u51 = {}
        local v52 = script.DiamondRig
        local u53 = Color3.fromRGB(130, 170, 255)
        if p46:FindFirstChild("BusoMelee") then
            u53 = Color3.new(0, 0, 0)
            v52 = script.HakiDiamondRig
        end
        local function v55(p54) --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u53
            --]]
            if p54:IsA("BasePart") and (p54.Transparency ~= 1 and p54:GetAttribute("Diamond") == nil) then
                u51[p54] = {
                    ["Color"] = p54.Color,
                    ["Material"] = p54.Material,
                    ["MaterialVariant"] = p54.MaterialVariant
                }
                p54.Color = u53
                p54.Material = Enum.Material.Foil
                p54.MaterialVariant = "customDiamond2"
                p54:SetAttribute("Diamond", true)
            end
        end
        if typeof(p47) == "table" then
            for v56, v57 in p47 do
                local v58 = Color3.fromRGB(89, 107, 228)
                if v57 == true then
                    v52 = script.HakiDiamondRig
                    v58 = Color3.fromRGB(255, 255, 255)
                end
                local v59 = p46:FindFirstChild(v56)
                if v59 or string.find(v56, "PartialTorso") then
                    local v60 = v52:FindFirstChild(v56):Clone()
                    v60.CFrame = p46.HumanoidRootPart.CFrame
                    v60.Size = v60.Size * 1.01
                    if string.find(v56, "PartialTorso") then
                        v60.Weld.Part0 = p46.UpperTorso
                    else
                        v60.Weld.Part0 = p46:FindFirstChild(v56)
                    end
                    for _, v61 in v60:GetChildren() do
                        if v61:IsA("ParticleEmitter") then
                            v61:Emit(Random.new():NextNumber(2, 5))
                        end
                    end
                    v60.Color = u53
                    v60.Parent = v49
                    local v62 = v60:Clone()
                    v62.CastShadow = false
                    v62.Name = v60.Name .. "Glow"
                    v62.Size = v60.Size * 1.1
                    v62.Material = Enum.Material.Neon
                    v62.Color = v58
                    v62.Parent = v60.Parent
                    u1:Create(v62, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    }):Play()
                    task.delay(0.2, v62.Destroy, v62)
                    if v59 then
                        local v63 = _G.bodyGetSection(p46, v59)
                        for v64 = 1, #v63 do
                            v55(v63[v64])
                        end
                    end
                end
            end
        else
            local v65 = Color3.fromRGB(89, 107, 228)
            for _, v66 in v52:GetChildren() do
                if not string.find(v66.Name, "PartialTorso") then
                    local v67 = v66:Clone()
                    v67.CFrame = p46[v66.Name].CFrame
                    v67.Color = u53
                    v67.Size = v67.Size * 1.01
                    v67.Weld.Part0 = p46[v66.Name]
                    for _, v68 in v67:GetChildren() do
                        if v68:IsA("ParticleEmitter") then
                            v68:Emit(Random.new():NextNumber(2, 5))
                        end
                    end
                    v67.Parent = v49
                    local v69 = v67:Clone()
                    v69.CastShadow = false
                    v69.Name = v67.Name .. "Glow"
                    v69.Size = v67.Size * 1.1
                    v69.Material = Enum.Material.Neon
                    v69.Color = v65
                    u1:Create(v69, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1
                    }):Play()
                    v69.Parent = v67.Parent
                    task.delay(0.2, v69.Destroy, v69)
                end
            end
            local v70 = p46:GetDescendants()
            for v71 = 1, #v70 do
                v55(v70[v71])
            end
        end
        return v49, function() --[[ Name: revertFunction, Line 222 ]]
            --[[
            Upvalues:
                [1] = u51
            --]]
            for v72, v73 in pairs(u51) do
                if v72 and v73 then
                    v72.Color = v73.Color
                    v72.Material = v73.Material
                    v72.MaterialVariant = v73.MaterialVariant
                    v72:SetAttribute("Diamond", nil)
                end
            end
            table.clear(u51)
        end
    end,
    ["DiamondCrater"] = function(p74, p75, p76, p77, p78, p79, p80, _, p81, p82, p83, u84) --[[ Name: DiamondCrater, Line 239 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u1
            [4] = u128
        --]]
        local v85 = u3
        local v86 = script.Stars
        if u84 == true then
            v85 = script.HakiDiamondRockDebris
            v86 = script.HakiStars
        end
        if typeof(p77) == "number" then
            p77 = NumberRange.new(p77, p77)
        end
        local v87 = p82 or NumberRange.new(1, 1)
        local v88 = p78 or CFrame.new()
        local v89 = p83 or NumberRange.new(-0.25, 0.25)
        local v90 = RaycastParams.new()
        v90.FilterType = Enum.RaycastFilterType.Include
        v90.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
        local v91 = workspace:Raycast(p79, p80, v90)
        if v91 then
            local v92 = v91.Position
            local v93 = 360 / p75
            local v94 = 0
            for v95 = 1, p75 do
                if v95 % 1 == 0 then
                    local v96 = CFrame.new(v92 + Vector3.new(0, 1, 0))
                    local v97 = CFrame.Angles
                    local v98 = v94 + Random.new():NextNumber(-1, 1)
                    local v99 = v96 * v97(0, math.rad(v98), 0) * CFrame.new(0, 0, -p76 + Random.new():NextNumber(v89.Min, v89.Max))
                    local v100 = workspace:Raycast(v99.Position, Vector3.new(0, -3, 0), v90)
                    if v100 then
                        local v101 = u4:NextNumber(p77.Min, p77.Max)
                        local v102 = CFrame.new(v100.Position) * CFrame.Angles(u4:NextNumber(-360, 360), u4:NextNumber(-360, 360), u4:NextNumber(-360, 360))
                        local u103 = v85:GetChildren()[math.random(1, #v85:GetChildren())]:Clone()
                        u103.CanCollide = false
                        u103.CFrame = CFrame.lookAt(v102.Position, v92 + Vector3.new(0, 100, 0)) * v88 * CFrame.Angles(u4:NextNumber(-360, 360), u4:NextNumber(-360, 360), u4:NextNumber(-360, 360))
                        u103.CFrame = u103.CFrame * CFrame.new(0, -1, 0)
                        local v104 = u103.Size * v101
                        local v105 = Random.new():NextNumber(v87.Min, v87.Max)
                        u103.Size = v104 + Vector3.new(0, v105, 0)
                        u103.Parent = p74
                        u1:Create(u103, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            ["CFrame"] = CFrame.lookAt(v102.Position, v92 + Vector3.new(0, 100, 0)) * CFrame.Angles(-0.7853981633974483, 0, 0)
                        }):Play()
                        local v106 = v86:Clone()
                        local v107 = {}
                        for v108 = 1, #v106.Size.Keypoints do
                            local v109 = v106.Size.Keypoints[v108]
                            local v110 = NumberSequenceKeypoint.new
                            local v111 = v109.Time
                            local v112 = v109.Value * v101
                            local v113 = v109.Envelope * v101
                            table.insert(v107, v110(v111, v112, v113))
                        end
                        v106.Size = NumberSequence.new(v107)
                        v106.Parent = u103
                        if p81 then
                            table.insert(p81, u103)
                        else
                            task.delay(1, function() --[[ Line: 301 ]]
                                --[[
                                Upvalues:
                                    [1] = u128
                                    [2] = u103
                                    [3] = u84
                                --]]
                                u128.BreakDiamond(u103, u84)
                            end)
                        end
                    end
                end
                v94 = v94 + v93
            end
            return v91
        end
    end,
    ["PrismaticLiftExplode"] = function(p114) --[[ Name: PrismaticLiftExplode, Line 314 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u1
            [4] = u128
        --]]
        local u115 = p114.Parent
        local v116 = u115.ThrownDiamondBoulder
        local _ = u115.Crater
        local v117 = script.PrismaticLiftExplodeVFX.DiamondBoulderExplode
        local v118 = v116:GetAttribute("Haki")
        u115:SetAttribute("Explode", true)
        v116.Transparency = 1
        for _, v119 in u115:GetDescendants() do
            if v119:IsA("ParticleEmitter") then
                v119.Enabled = false
            end
        end
        local u120 = script.PrismaticLiftExplodeVFX.BigDiamondDebris:Clone()
        u120:PivotTo(v116.CFrame)
        u120.Parent = u2
        if v118 == true then
            v117 = script.PrismaticLiftExplodeVFX.HakiDiamondBoulderExplode
            for _, v121 in u120:GetChildren() do
                v121.Color = Color3.fromRGB(0, 0, 0)
            end
        end
        for _, u122 in u120:GetChildren() do
            u122.CanCollide = true
            u122.Velocity = (u122.Position - v116.Position) * u4:NextNumber(25, 50)
            local v123 = Random.new():NextNumber(-25, 25)
            local v124 = Random.new():NextNumber(-25, 25)
            local v125 = Random.new()
            u122.RotVelocity = Vector3.new(v123, v124, v125:NextNumber(-25, 25))
            task.delay(2, function() --[[ Line: 344 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u122
                --]]
                u1:Create(u122, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }):Play()
            end)
        end
        for _, v126 in u115.Crater:GetChildren() do
            u128.DiamondDebris(1, v126, NumberRange.new(2, 3), NumberRange.new(3, 5), 100, 10, u2, nil, v118)
            v126:Destroy()
        end
        local u127 = v117:Clone()
        _G.customEmit(u127)
        u127.CFrame = v116.CFrame
        u127.Parent = u2
        task.delay(5, function() --[[ Line: 361 ]]
            --[[
            Upvalues:
                [1] = u120
                [2] = u127
                [3] = u115
            --]]
            u120:Destroy()
            u127:Destroy()
            u115:Destroy()
        end)
    end
}
return u128