 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.PrimaryPart.Position) then
        local v4 = script
        local v5 = p3.HumanoidRootPart
        local v6 = v4.aimPart:Clone()
        v6.Anchored = true
        v6.Name = "aimShotOpePart" .. p3.Name
        v6.CFrame = v5.CFrame * CFrame.new(0, 0.5, -5) * CFrame.Angles(-1.5707963267948966, 0, 0)
        v6.Parent = workspace.Effects
        _G.customEmit(v6.centerAttach, true)
        _G.destroy(v6, 5)
        local u7 = {}
        local v8 = v4.handle:Clone()
        v8.Anchored = true
        v8.Name = "swordShotOpePart" .. p3.Name
        v8.Parent = workspace.Effects
        _G.destroy(v8, 6)
        _G.customWeld(v6, v5, CFrame.new(0, 0.5, -5) * CFrame.Angles(-1.5707963267948966, 0, 0), v8)
        v8.Destroying:Connect(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            for _, v9 in pairs(u7) do
                v9:Destroy()
            end
        end)
        v8.CFrame = v5.Parent.RightHand.CFrame * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(1.5707963267948966, 0, 0)
        _G.customEmit(v8.prepAttach, true)
        _G.customWeld(v8, v5.Parent.RightHand, CFrame.new(0, -0.2, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(1.5707963267948966, 0, 0), v8)
        task.wait(0.3)
        _G.customEmit(v8.burstAttach, true)
        v8.burstAttach.spikeGlow.Rate = 40
        v8.burstAttach.lightningShoot.Rate = 80
        v8.burstAttach.lightningSpikesCover.Rate = 40
        v8.burstAttach.lightningShoot.Enabled = true
        _G.customEmit(v6.indicatorBurstAttach, true)
        local v10 = u2.new(v8.bottomAttach, v8.middleAttach, 3)
        v10.MaxRadius = 0.1
        v10.PulseSpeed = 20
        v10.AnimationSpeed = 20
        v10.MinTransparency = 0.2
        v10.MaxTransparency = 0.3
        function v10.RadialProfileFunction(p11) --[[ Line: 70 ]]
            local v12 = -5000 * (p11 - 0.35) ^ 10
            return math.exp(v12)
        end
        v10.Thickness = 0.3
        v10.MinThicknessMultiplier = 0.3
        v10.MaxThicknessMultiplier = 1
        v10.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 135, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 145, 207)) })
        table.insert(u7, v10)
        local v13 = u2.new(v8.middleAttach, v8.pointAttach, 8)
        v13.MaxRadius = 0.5
        v13.PulseSpeed = 20
        v13.AnimationSpeed = 20
        v13.MinTransparency = 0.2
        v13.MaxTransparency = 0.3
        function v13.RadialProfileFunction(p14) --[[ Line: 88 ]]
            local v15 = -5000 * (p14 - 0.35) ^ 10
            return math.exp(v15)
        end
        v13.ContractFrom = 0.8
        v13.Thickness = 0.3
        v13.MinThicknessMultiplier = 0.3
        v13.MaxThicknessMultiplier = 1
        v13.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 135, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 145, 207)) })
        table.insert(u7, v13)
        for v16 = 1, 6 do
            local v17 = Instance.new("Attachment")
            v17.Parent = v8
            v17.WorldCFrame = v8.CFrame * CFrame.new(-0.5, 0, 0) * CFrame.Angles(0.5235987755982988 * v16, 0, 0) * CFrame.new(0, 0, 0.8)
            local v18 = v17.Position
            v17.Position = Vector3.new(-0.5, 0, 0)
            game:GetService("TweenService"):Create(v17, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Position"] = v18
            }, true):Play()
            local v19 = Instance.new("Attachment")
            v19.Parent = v8
            v19.WorldPosition = (v8.CFrame * CFrame.new(-0.5, 0, 0) * CFrame.Angles(0.5235987755982988 * v16, 0, 0) * CFrame.new(0, 0, -0.8)).Position
            local v20 = v19.Position
            v19.Position = Vector3.new(-0.5, 0, 0)
            game:GetService("TweenService"):Create(v19, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Position"] = v20
            }, true):Play()
            local v21 = u2.new(v17, v19, 4)
            v21.MaxRadius = 0.5
            v21.PulseSpeed = 20
            v21.AnimationSpeed = 20
            v21.MinTransparency = 0.2
            v21.MaxTransparency = 0.3
            function v21.RadialProfileFunction(p22) --[[ Line: 130 ]]
                local v23 = -5000 * (p22 - 0.35) ^ 10
                return math.exp(v23)
            end
            v21.Thickness = 0.3
            v21.MinThicknessMultiplier = 0.6
            v21.MaxThicknessMultiplier = 1
            v21.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 135, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 145, 207)) })
            table.insert(u7, v21)
        end
        game:GetService("TweenService"):Create(v8.pointAttach, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Position"] = Vector3.new(-8, 0, 0)
        }, true):Play()
        _G.customEmit(v6.centerAttach, true)
        task.wait(0.1)
        for _, v24 in pairs(v6:GetChildren()) do
            if v24.Name == "leftAttach2" or (v24.Name == "rightAttach2" or (v24.Name == "topAttach2" or v24.Name == "bottomAttach2")) then
                local v25 = game:GetService("TweenService")
                local v26 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v27 = {}
                local v28 = v24.Position.X * 4
                local v29 = v24.Position.Z * 4
                v27.Position = Vector3.new(v28, 0, v29)
                v25:Create(v24, v26, v27, true):Play()
            elseif v24.Name == "circleBeam" then
                game:GetService("TweenService"):Create(v24, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Width0"] = 0.5,
                    ["Width1"] = 0.5
                }, true):Play()
            elseif v24.Name == "circleBeam2" then
                game:GetService("TweenService"):Create(v24, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Width0"] = 8,
                    ["Width1"] = 8
                }, true):Play()
            end
        end
        task.wait(0.025)
        for _, v30 in pairs(v6:GetChildren()) do
            if v30.Name == "bottomBarAttach1" or (v30.Name == "bottomBarAttach2" or (v30.Name == "topBarAttach1" or v30.Name == "topBarAttach2")) then
                local v31 = game:GetService("TweenService")
                local v32 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v33 = {}
                local v34 = v30.Position.X
                local v35 = v30.Position.Z * 10
                v33.Position = Vector3.new(v34, 0, v35)
                v31:Create(v30, v32, v33, true):Play()
            elseif v30.Name == "leftBarAttach1" or (v30.Name == "leftBarAttach2" or (v30.Name == "rightBarAttach1" or v30.Name == "rightBarAttach2")) then
                local v36 = game:GetService("TweenService")
                local v37 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v38 = {}
                local v39 = v30.Position.X * 10
                local v40 = v30.Position.Z
                v38.Position = Vector3.new(v39, 0, v40)
                v36:Create(v30, v37, v38, true):Play()
            elseif v30.Name == "topBarBeam1" or (v30.Name == "bottomBarBeam1" or (v30.Name == "rightBarBeam1" or v30.Name == "leftBarBeam1")) then
                v30.Enabled = true
            end
        end
        task.wait(0.025)
        for _, v41 in pairs(v6:GetChildren()) do
            if v41.Name == "bottomBarAttach3" or (v41.Name == "bottomBarAttach4" or (v41.Name == "topBarAttach3" or v41.Name == "topBarAttach4")) then
                local v42 = game:GetService("TweenService")
                local v43 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v44 = {}
                local v45 = v41.Position.X
                local v46 = v41.Position.Z * 10
                v44.Position = Vector3.new(v45, 0, v46)
                v42:Create(v41, v43, v44, true):Play()
            elseif v41.Name == "leftBarAttach3" or (v41.Name == "leftBarAttach4" or (v41.Name == "rightBarAttach3" or v41.Name == "rightBarAttach4")) then
                local v47 = game:GetService("TweenService")
                local v48 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v49 = {}
                local v50 = v41.Position.X * 10
                local v51 = v41.Position.Z
                v49.Position = Vector3.new(v50, 0, v51)
                v47:Create(v41, v48, v49, true):Play()
            elseif v41.Name == "topBarBeam2" or (v41.Name == "bottomBarBeam2" or (v41.Name == "rightBarBeam2" or v41.Name == "leftBarBeam2")) then
                v41.Enabled = true
            end
        end
        task.wait(0.1)
        if v8.Parent ~= nil then
            game:GetService("TweenService"):Create(v8.pointAttach, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 100000, true), {
                ["Position"] = Vector3.new(-8, 0, 0)
            }, true):Play()
        end
        for _, v52 in pairs(v6:GetChildren()) do
            if v52.Name == "leftAttach2" or (v52.Name == "rightAttach2" or (v52.Name == "topAttach2" or v52.Name == "bottomAttach2")) then
                local v53 = game:GetService("TweenService")
                local v54 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local v55 = {}
                local v56 = v52.Position.X * 1.5
                local v57 = v52.Position.Z * 1.5
                v55.Position = Vector3.new(v56, 0, v57)
                v53:Create(v52, v54, v55, true):Play()
            end
        end
    end
end
return v1