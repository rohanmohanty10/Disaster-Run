 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
script:WaitForChild("Models")
script:WaitForChild("SFX")
script:WaitForChild("VFX")
script:WaitForChild("Other")
local u4 = workspace:WaitForChild("Effects")
local u5 = require(script.Parent:WaitForChild("SharedDiamondUtils"))
Charges = {}
require(game.ReplicatedStorage.Modules.BoatTween)
local u6 = Random.new()
local u93 = {
    ["Start"] = function(u7) --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u4
        --]]
        local v8 = u7:FindFirstChild("BusoMelee") ~= nil
        local u9 = nil
        local u10 = nil
        local u11, u12
        if v8 then
            u11 = script.VFX.Haki
            u12 = "Haki"
        else
            u11 = script.VFX
            u12 = nil
        end
        local v13 = {}
        task.delay(0.1, function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u7
                [3] = u9
                [4] = u10
                [5] = u5
                [6] = u12
            --]]
            local v14 = u11.Scream:Clone()
            local v15 = Instance.new("Weld")
            v15.Part0 = u7.Head
            v15.Part1 = v14
            v15.Parent = v14
            for _, v16 in v14.Attachment:GetChildren() do
                v16.Enabled = true
            end
            v14.Parent = workspace.Effects
            local _ = { u7, workspace.Effects }
            local v17, v18 = u5.DiamondFunctions.DiamondMorph(u7, u12, "SheerPrismaticLiftDiamondRig")
            u9 = v17
            u10 = v18
            task.wait(0.5)
            for _, v19 in v14.Attachment:GetChildren() do
                v19.Enabled = false
            end
            task.wait(1)
            v14:Destroy()
        end)
        task.wait(1)
        local v20 = RaycastParams.new()
        v20.FilterType = Enum.RaycastFilterType.Exclude
        v20.FilterDescendantsInstances = { u7, workspace.Effects }
        local v21 = workspace:Raycast(u7.HumanoidRootPart.CFrame.Position, Vector3.new(0, -12.5, 0), v20)
        if v21 then
            local v22 = u11.RockPull:Clone()
            v22.Position = v21.Position + Vector3.new(0, 0.15, 0)
            _G.recolorParticles(v22, v21.Instance.Color)
            _G.customEmit(v22)
            v22.Parent = workspace.Effects
            task.delay(4, v22.Destroy, v22)
        end
        local v23 = u11.RockBoulder:Clone()
        local v24 = Instance.new("Weld")
        v24.Part0 = u7.LeftHand
        v24.Part1 = v23
        local v25 = CFrame.new(0.1, -13, 7)
        local v26 = CFrame.Angles
        local v27 = u6:NextNumber(-180, 180)
        local v28 = math.rad(v27)
        local v29 = u6:NextNumber(-180, 180)
        local v30 = math.rad(v29)
        local v31 = u6:NextNumber(-180, 180)
        v24.C0 = v25 * v26(v28, v30, (math.rad(v31)))
        v24.Parent = v23
        if v21 and v21.Instance then
            _G.matchMaterial(v23, v21.Instance)
            _G.recolorParticles(v23, v21.Instance.Color)
        end
        v23.Name = "RockBoulder" .. u7.Name
        v23.Parent = workspace.Effects
        while u7:GetAttribute("PrismaticLiftHold") do
            task.wait()
        end
        task.wait(0.25)
        if u10 then
            u10()
        end
        for _, v32 in v13 do
            u5.DiamondFunctions.BreakDiamond(v32)
            for _, v33 in v32:GetChildren() do
                if v33:IsA("Decal") then
                    v33:Destroy()
                end
            end
            u5.DiamondFunctions.DiamondDebris(2, v32, NumberRange.new(0.75, 1.5), NumberRange.new(0.35, 0.75), 25, 25, u4, nil, v8)
        end
    end,
    ["End"] = function(u34, p35, p36, p37, p38, p39, p40, p41) --[[ Line: 133 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u5
        --]]
        local u42 = u34:FindFirstChild("BusoMelee") ~= nil
        Color3.fromRGB(130, 170, 255)
        local u43, v44
        if u42 then
            u43 = script.VFX.Haki
            v44 = Color3.fromRGB(255, 255, 255)
        else
            u43 = script.VFX
            v44 = Color3.fromRGB(130, 170, 255)
        end
        local v45 = u34.Boosts.currentDiamondMorph.Value
        pcall(function() --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u34
            --]]
            u34.Boosts.currentDiamondMorph:Destroy()
        end)
        v45.Name = "SheerPrismaticLiftRigDestroying"
        local u46 = Instance.new("Folder")
        u46.Name = u34.Name .. "DiamondBoulder"
        u46.Parent = workspace.Effects
        local v47 = workspace.Effects:FindFirstChild("RockBoulder" .. u34.Name)
        v47.Name = "done"
        local v48 = v47.Weld.C0
        local v49 = v47:Clone()
        v49.CastShadow = false
        v49.Name = v47.Name .. "Glow"
        v49.Size = v47.Size * 1.01
        v49.Material = Enum.Material.Neon
        v49.Color = v44
        v49.Parent = workspace.Effects
        u2:Create(v49, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Transparency"] = 1
        }):Play()
        task.delay(0.25, v49.Destroy, v49)
        v47.Weld:Destroy()
        v47.Anchored = true
        v47.Transparency = 1
        for _, v50 in v47:GetDescendants() do
            if v50:IsA("ParticleEmitter") then
                v50.Enabled = false
            end
        end
        task.delay(2, v47.Destroy, v47)
        local v51 = u43.DiamondBoulder:Clone()
        v51.Name = "ThrownDiamondBoulder"
        local v52 = Instance.new("Weld")
        v52.Part0 = u34.LeftHand
        v52.Part1 = v51
        v52.C0 = v48
        v52.Parent = v51
        v51.Parent = workspace.Effects
        local v53 = u43.BoulderShine:Clone()
        v53.CFrame = v51.CFrame
        _G.customEmit(v53)
        v53.Parent = workspace.Effects
        task.delay(1.5, v53.Destroy, v53)
        _G.PlaySound(v51, script.DiamondUltThrow).Parent = v51
        task.wait(p39 - workspace:GetServerTimeNow())
        game.Players.LocalPlayer:GetMouse()
        v51.Weld:Destroy()
        v51.Anchored = true
        v51.Transparency = 1
        for _, v54 in v51:GetDescendants() do
            if v54:IsA("ParticleEmitter") then
                v54.Enabled = false
            end
        end
        task.delay(2, v51.Destroy, v51)
        local u55 = u43.DiamondBoulder:Clone()
        u55.CFrame = v51.CFrame
        u55.Anchored = true
        u55.Name = "ThrownDiamondBoulder"
        u55.Parent = u46
        if u42 then
            u55:SetAttribute("Haki", true)
        end
        local v56 = u55.Position
        local v57 = p36.Position
        local v58 = u55.Size.Y / 3
        local v59 = v57 + Vector3.new(0, v58, 0)
        local v60 = (v59 + v56) / 2
        local v61 = (v59 - v56).Magnitude / 2
        local v62 = math.clamp(v61, 0, 150)
        local v63 = v60 + Vector3.new(0, v62, 0)
        local u64 = u43.ThrownEffect:Clone()
        u64.CFrame = CFrame.lookAt(u55.Position, v63)
        u64.Parent = workspace.Effects
        local u65 = { u34, workspace.Effects }
        local u66 = {}
        local u67 = false
        local u68 = nil
        local u69 = 0
        local v70 = p35.Position + p35.LookVector * 5
        local u71 = (p36.Position - v70).Unit * 300
        local u72 = v51.Size.X / 3.5
        local v73 = -workspace.Gravity
        local u74 = Vector3.new(0, v73, 0)
        local u75 = Random.new():NextUnitVector()
        local u76 = RaycastParams.new()
        u76.FilterDescendantsInstances = p37
        u76.FilterType = Enum.RaycastFilterType.Include
        local u77 = p41.Position
        u55.Position = p41.Position
        u68 = u3.PostSimulation:Connect(function(p78) --[[ Line: 256 ]]
            --[[
            Upvalues:
                [1] = u69
                [2] = u71
                [3] = u74
                [4] = u55
                [5] = u75
                [6] = u64
                [7] = u77
                [8] = u72
                [9] = u76
                [10] = u68
                [11] = u67
                [12] = u46
                [13] = u5
                [14] = u65
                [15] = u66
                [16] = u42
                [17] = u43
            --]]
            u69 = u69 + p78
            u71 = u71 + u74 * p78
            local v79 = u55.Position + u71 * p78
            u55.Position = v79
            local v80 = p78 * 3
            local v81 = u55
            v81.CFrame = v81.CFrame * CFrame.Angles(u75.X * v80, u75.Y * v80, u75.Z * v80)
            u64.CFrame = CFrame.lookAt(v79, v79 + u71)
            local v82 = v79 - u77
            local v83 = v82.Unit * v82.Magnitude
            local v84 = workspace:Spherecast(u77, u72, v83, u76)
            if v84 and v84.Instance then
                u68:Disconnect()
                u68 = nil
                u67 = true
                _G.particleEnabled(u64, false)
                local v85 = Instance.new("Folder")
                v85.Name = "Crater"
                v85.Parent = u46
                local v86 = u5.DiamondFunctions.DiamondCrater(v85, 25, 15, NumberRange.new(1, 5), CFrame.Angles(-0.7853981633974483, 0, 0), v79, Vector3.new(0, -20, 0), u65, u66, NumberRange.new(10, 20), NumberRange.new(-0.25, 0.25), u42 and true or false)
                if v86 == nil then
                    v86 = v84
                end
                if v86 then
                    local v87 = u43.DiamondCrack:Clone()
                    v87.CFrame = CFrame.new(v86.Position, v86.Position + v86.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.15, 0)
                    _G.customEmit(v87)
                    v87.Parent = workspace.Effects
                    task.delay(5, v87.Destroy, v87)
                end
                _G.destroy(u64, 3)
            else
                u77 = v79
            end
        end)
        if p38 then
            local u88 = nil
            u88 = p38.OnClientEvent:Connect(function() --[[ Line: 303 ]]
                --[[
                Upvalues:
                    [1] = u88
                    [2] = u55
                    [3] = u5
                    [4] = u42
                --]]
                u88:Disconnect()
                u88 = nil
                _G.PlaySound(u55, script.DiamondUlt2ndExplosion)
                u5.DiamondFunctions.PrismaticLiftExplode(u55, u42)
            end)
        end
        for _, v89 in v45:GetChildren() do
            u5.DiamondFunctions.BreakDiamond(v89, u42)
        end
        _G.destroy(v45, 1.5)
        repeat
            u3.PostSimulation:Wait()
        until u67 == true
        task.wait(p40)
        if u46 and u46:GetAttribute("Explode") == nil then
            u46.Parent = workspace.Effects
            u46:SetAttribute("Disappearing", true)
            table.insert(u66, u55)
            for _, v90 in u66 do
                u2:Create(v90, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    ["Transparency"] = 1
                }):Play()
                for _, v91 in v90:GetDescendants() do
                    if v91:IsA("ParticleEmitter") then
                        v91.Enabled = false
                    end
                end
            end
            task.wait(3)
            for _, v92 in u66 do
                if v92 == u55 then
                    u55:Destroy()
                    u46:Destroy()
                else
                    v92:Destroy()
                end
            end
        end
    end
}
function v1.start(_, p94, p95, ...) --[[ Line: 354 ]]
    --[[
    Upvalues:
        [1] = u93
    --]]
    if not Charges[p94] then
        Charges[p94] = {}
    end
    if u93[p95] then
        u93[p95](p94, ...)
    end
end
return v1