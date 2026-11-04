 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
script:WaitForChild("Models")
script:WaitForChild("SFX")
script:WaitForChild("Other")
local u4 = workspace:WaitForChild("Effects")
local u5 = require(script.Parent:WaitForChild("SharedDiamondUtils"))
local u6 = require(game.ReplicatedStorage.Modules.BoatTween)
Random.new()
local u60 = {
    ["Start"] = function(p7) --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u6
            [4] = u2
        --]]
        local v8 = p7:FindFirstChild("BusoMelee") ~= nil
        local v9
        if v8 then
            v9 = script.VFX.Haki
        else
            v9 = script.VFX
        end
        local _, v10 = u5.DiamondFunctions.DiamondMorph(p7, {
            ["LowerTorso"] = v8,
            ["LeftUpperLeg"] = v8,
            ["LeftLowerLeg"] = v8,
            ["LeftFoot"] = v8,
            ["RightUpperLeg"] = v8,
            ["RightLowerLeg"] = v8,
            ["RightFoot"] = v8
        }, "CrystalDashDiamondRig")
        local v11 = {}
        local v12 = { p7, u4 }
        u5.DiamondFunctions.DiamondCrater(u4, 20, 5, NumberRange.new(1, 1.5), CFrame.Angles(-0.7853981633974483, 0, 0), p7.HumanoidRootPart.Position, Vector3.new(0, -10, 0), v12, v11, NumberRange.new(1.5, 5), NumberRange.new(1, 3), v8)
        local v13 = v9.DiamondCharge:Clone()
        v13.CFrame = p7.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
        v13.Parent = u4
        for _, v14 in v13:GetDescendants() do
            if v14:IsA("Beam") then
                local v15 = v14.Transparency
                local v16 = {}
                for v17 = 1, #v14.Transparency.Keypoints do
                    local v18 = NumberSequenceKeypoint.new
                    local v19 = v14.Transparency.Keypoints[v17].Time
                    table.insert(v16, v18(v19, 1))
                end
                v14.Transparency = NumberSequence.new(v16)
                u6:Create(v14, {
                    ["Time"] = 0.2,
                    ["EasingStyle"] = "Sine",
                    ["EasingDirection"] = "Out",
                    ["StepType"] = "RenderStepped",
                    ["Goal"] = {
                        ["Transparency"] = v15
                    }
                }):Play()
            elseif v14:IsA("ParticleEmitter") then
                v14:Emit(1)
            end
        end
        local v20 = v9.DiamondChargeSpawn:Clone()
        v20.CFrame = v13.CFrame
        u5.SharedFunctions.EmitAllParticles(v20)
        v20.Parent = u4
        task.delay(2, v20.Destroy, v20)
        while p7:GetAttribute("crystaldashHold") do
            task.wait()
        end
        if v10 then
            v10()
        end
        local v21 = v9.DiamondChargeBreak:Clone()
        v21.CFrame = v20.CFrame
        u5.SharedFunctions.EmitAllParticles(v21)
        v21.Parent = u4
        task.delay(1.5, v21.Destroy, v21)
        for _, v22 in v11 do
            v22.Massless = true
            v22.Anchored = false
            v22.CanCollide = false
            local v23 = -p7.HumanoidRootPart.CFrame.LookVector * Random.new():NextNumber(25, 100)
            local v24 = Random.new():NextNumber(-25, 25)
            local v25 = Random.new():NextNumber(25, 100)
            local v26 = Random.new()
            v22.Velocity = v23 + Vector3.new(v24, v25, v26:NextNumber(-25, 25))
            local v27 = Random.new():NextNumber(-10, 10)
            local v28 = Random.new():NextNumber(-10, 10)
            local v29 = Random.new()
            v22.RotVelocity = Vector3.new(v27, v28, v29:NextNumber(-10, 10))
            local v30 = Random.new():NextNumber(0.75, 1.5)
            u2:Create(v22, TweenInfo.new(v30, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
            task.delay(v30, v22.Destroy, v22)
            local v31 = v9.DebrisShine.Attachment:Clone()
            local v32 = {}
            for v33 = 1, #v31.Star.Size.Keypoints do
                local v34 = v31.Star.Size.Keypoints[v33]
                local v35 = NumberSequenceKeypoint.new
                local v36 = v34.Time
                local v37 = v34.Value * Random.new():NextNumber(1.5, 2.5)
                local v38 = v34.Envelope
                table.insert(v32, v35(v36, v37, v38))
            end
            v31.Star.Size = NumberSequence.new(v32)
            v31.Star.Lifetime = NumberRange.new(v30, v30)
            v31.Star:Emit(1)
            v31.Parent = v22
        end
        for _, v39 in v13:GetDescendants() do
            if v39:IsA("ParticleEmitter") then
                v39.Enabled = false
            elseif v39:IsA("Beam") then
                local v40 = {}
                for v41 = 1, #v39.Transparency.Keypoints do
                    local v42 = NumberSequenceKeypoint.new
                    local v43 = v39.Transparency.Keypoints[v41].Time
                    table.insert(v40, v42(v43, 1))
                end
                u6:Create(v39, {
                    ["Time"] = Random.new():NextNumber(1, 3),
                    ["EasingStyle"] = "Sine",
                    ["EasingDirection"] = "Out",
                    ["StepType"] = "RenderStepped",
                    ["Goal"] = {
                        ["Transparency"] = NumberSequence.new(v40),
                        ["TextureSpeed"] = v39.TextureSpeed * Random.new():NextNumber(0.25, 0.75),
                        ["TextureLength"] = v39.TextureLength * Random.new():NextNumber(0.25, 0.5)
                    }
                }):Play()
            end
        end
        task.wait(3)
        v13:Destroy()
    end,
    ["End"] = function(u44, p45) --[[ Line: 161 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u3
        --]]
        local v46 = u44:FindFirstChild("BusoMelee") ~= nil
        local v47
        if v46 then
            v47 = script.VFX.Haki
        else
            v47 = script.VFX
        end
        local u48 = u44.Boosts.currentDiamondMorph.Value
        pcall(function() --[[ Line: 174 ]]
            --[[
            Upvalues:
                [1] = u44
            --]]
            u44.Boosts.currentDiamondMorph:Destroy()
        end)
        local u49 = {}
        for _, v50 in u48:GetChildren() do
            u5.DiamondFunctions.BreakDiamond(v50, v46)
            u5.DiamondFunctions.DiamondDebris(math.random(2, 3), v50, NumberRange.new(0.75, 1.5), NumberRange.new(0.35, 0.75), 25, 25, u4, u49, v46)
        end
        u48.Name = "CrystalDashFirstRigDestroy"
        task.delay(1.5, function() --[[ Line: 184 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u49
            --]]
            u48:Destroy()
            for _, v51 in u49 do
                v51:Destroy()
            end
        end)
        local v52, v53 = u5.DiamondFunctions.DiamondMorph(u44, {
            ["PartialTorso2"] = v46,
            ["LeftUpperArm"] = v46,
            ["LeftLowerArm"] = v46,
            ["LeftHand"] = v46
        }, "PartialCrystalDashDiamondRig")
        _G.destroy(v52, 10)
        local v54 = v47.DashEffect:Clone()
        local v55 = Instance.new("Weld")
        v55.Part0 = u44.HumanoidRootPart
        v55.Part1 = v54
        v55.C0 = CFrame.new(0, 0, -2.5)
        v55.Parent = v54
        v54.Parent = u4
        local v56 = OverlapParams.new()
        v56.FilterType = Enum.RaycastFilterType.Exclude
        v56.FilterDescendantsInstances = { u4, u44 }
        local v57 = os.clock()
        repeat
            u3.RenderStepped:Wait()
        until p45 <= os.clock() - v57
        pcall(function() --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u44
            --]]
            u44.Boosts.currentDiamondMorph:Destroy()
        end)
        v55:Destroy()
        v54.Anchored = true
        if v53 then
            v53()
        end
        for _, v58 in v54:GetDescendants() do
            if v58:IsA("ParticleEmitter") then
                v58.Enabled = false
            end
        end
        for _, v59 in v52:GetChildren() do
            u5.DiamondFunctions.BreakDiamond(v59, v46)
        end
        v52.Name = "DiamondRigFolderDestroying"
        task.wait(1)
        v54:Destroy()
        task.wait(0.5)
        v52:Destroy()
    end
}
function v1.start(_, p61, p62, ...) --[[ Line: 248 ]]
    --[[
    Upvalues:
        [1] = u60
    --]]
    if u60[p62] then
        u60[p62](p61, ...)
    end
end
return v1