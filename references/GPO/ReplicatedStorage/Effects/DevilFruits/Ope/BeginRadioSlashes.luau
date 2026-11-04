 

local v1 = {}
require(game.ReplicatedStorage.Modules.LightningBolt)
function v1.start(_, u2, _) --[[ Line: 5 ]]
    if _G.checkRenderDistance(u2.PrimaryPart.Position) then
        local v3 = script.VFXModel
        local v4 = u2.HumanoidRootPart
        local v5 = Instance.new("BoolValue")
        v5.Name = "holdingRadioKnife"
        v5.Parent = u2.PrimaryPart
        _G.destroy(v5, 6)
        local v6 = Instance.new("Part")
        v6.Size = Vector3.new(2, 2, 2)
        v6.Anchored = true
        v6.CanCollide = false
        v6.Transparency = 1
        v6.CFrame = v4.CFrame * CFrame.new(0, 0, -10)
        v6.Parent = workspace.Effects
        _G.customWeld(v6, u2.PrimaryPart, CFrame.new(0, 0, -10), v6)
        _G.destroy(v6, 6)
        local v7 = nil
        local v8 = nil
        local v9 = nil
        local v10 = 1
        local v11 = {}
        local v12 = nil
        while v5.Parent == u2.PrimaryPart do
            if v6 ~= nil then
                if v7 == nil then
                    v7 = Instance.new("Highlight")
                    v7.OutlineTransparency = 1
                    v7.DepthMode = Enum.HighlightDepthMode.Occluded
                    v7.FillTransparency = 1
                    v7.FillColor = Color3.fromRGB(237, 145, 255)
                    v7.Parent = v6
                end
                v7.FillTransparency = v7.FillTransparency - 0.04
                if v12 == nil then
                    v12 = v3.hitPart:Clone()
                    v12.CFrame = v6.CFrame
                    v12.Parent = v6
                    _G.customWeld(v12, v6, CFrame.new(), v12)
                    _G.destroy(v12, 6)
                end
                for _, v13 in pairs(v12:GetChildren()) do
                    if v13.Name ~= "electricitySurroundAura" and (v13.Name ~= "shineGrowAura" and v13:IsA("ParticleEmitter")) then
                        _G.customEmit(v13, true)
                    end
                end
                v12.electricitySurroundAura.Rate = v12.electricitySurroundAura.Rate + 10
                v12.shineGrowAura.Rate = v12.shineGrowAura.Rate + 3
            end
            if v8 == nil then
                v8 = v3.effectsPart:Clone()
                v8.CFrame = v4.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, -3.141592653589793, 0)
                v8.Parent = workspace.Effects
                _G.destroy(v8, 6)
            end
            v8.CFrame = v4.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, -3.141592653589793, 0)
            v8.Parent = workspace.Effects
            _G.customEmit(v8, true)
            local v14 = RaycastParams.new()
            v14.FilterType = Enum.RaycastFilterType.Whitelist
            v14.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
            v14.IgnoreWater = true
            local v15, v16, v17 = _G.getRayFloor(v4.CFrame * CFrame.new(0, 0, -3), 15)
            if v15 ~= nil then
                if v9 == nil then
                    v9 = v3.floorPart:Clone()
                    v9.Parent = workspace.Effects
                    _G.destroy(v9, 1.2)
                end
                v9.CFrame = CFrame.lookAt(v16, v16 + v17, -v4.CFrame.LookVector)
                for _, v18 in pairs(v9:GetChildren()) do
                    if v18.Name ~= "lineBurst" then
                        v18.Color = ColorSequence.new(v15.Color)
                    end
                end
                _G.customEmit(v9, true)
            end
            local v19 = Random.new():NextNumber(0, 7)
            local v20 = Random.new():NextNumber(-2, 2)
            local u21 = v3.turnPart:Clone()
            u21.CFrame = v4.CFrame * CFrame.new(0, v20, -Random.new():NextNumber(0, 5)) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(0, 0, -0.2617993877991494 + 0.039269908169872414 * v19) * CFrame.Angles(0, 1.5707963267948966 * v10, 0) * CFrame.Angles(-0.19634954084936207 * v10 * Random.new():NextNumber(0.8, 1.2), 0, 0)
            u21.Parent = workspace.Effects
            _G.destroy(u21, 0.9)
            table.insert(v11, u21)
            local v22 = v3.slashMesh:Clone()
            v22.CFrame = v4.CFrame * CFrame.new(0, v20, 0) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(0, 0, -0.2617993877991494 + 0.039269908169872414 * v19) * CFrame.Angles(-0.19634954084936207 * v10, 0, 0) * CFrame.new(10, 0, 0)
            v22.Parent = workspace.Effects
            _G.destroy(v22, 0.3)
            game:GetService("TweenService"):Create(v22, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["CFrame"] = v22.CFrame * CFrame.new(-20, 0, 0)
            }, true):Play()
            game:GetService("TweenService"):Create(v22.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {}, true):Play()
            game:GetService("TweenService"):Create(v22.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            }, true):Play()
            if v10 == 1 then
                game:GetService("TweenService"):Create(u21, TweenInfo.new(0.125, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["CFrame"] = u21.CFrame * CFrame.Angles(0, -3.1101767270538954, 0, 0)
                }, true):Play()
            else
                game:GetService("TweenService"):Create(u21, TweenInfo.new(0.125, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["CFrame"] = u21.CFrame * CFrame.Angles(0, 3.1101767270538954, 0, 0)
                }, true):Play()
                u21.tipPart.lineBurst.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
                u21.tipPart.orbSurround.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
                u21.tipPart.lineSurround.ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward
            end
            game:GetService("TweenService"):Create(u21.tipPart.lastingTrail, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 10000, true), {
                ["TextureLength"] = 3
            }, true):Play()
            v10 = v10 * -1
            task.delay(0.1, function() --[[ Line: 148 ]]
                --[[
                Upvalues:
                    [1] = u21
                --]]
                u21.tipPart.electricitySurround.Enabled = false
                u21.tipPart.lightningLine.Enabled = false
                u21.tipPart.glowSurround.Enabled = false
                u21.tipPart.orbSurround.Enabled = false
                u21.tipPart.lineSurround.Enabled = false
                u21.tipPart.lightningLineCenter.Enabled = false
            end)
            if _G.cameraShakeEnabled == true then
                task.spawn(function() --[[ Line: 164 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    for v23 = 10, 0, -1 do
                        local v24 = v23 / 30
                        local v25 = u2.Humanoid
                        local v26 = Random.new():NextNumber(-2, 2) * v24
                        local v27 = Random.new():NextNumber(-2, 2) * v24
                        local v28 = Random.new():NextNumber(-2, 2) * v24
                        v25.CameraOffset = Vector3.new(v26, v27, v28)
                        task.wait(0.025)
                    end
                    u2.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                end)
            end
            task.wait(0.125)
        end
        task.delay(0.7, function() --[[ Line: 189 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            game.Workspace.Effects["swordRadioKnife" .. u2.Name]:Destroy()
        end)
        if v12 then
            game:GetService("TweenService"):Create(v12.shineGrowAura, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Rate"] = v12.shineGrowAura.Rate * 2
            }, true):Play()
            game:GetService("TweenService"):Create(v12.swirlAbsorb, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Rate"] = 300
            }, true):Play()
            game:GetService("TweenService"):Create(v7, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["FillTransparency"] = 1
            }, true):Play()
            task.wait(0.2)
            v12.swirlAbsorb.Enabled = false
            task.wait(0.2)
            for _ = 1, 7 do
                local u29 = v3.beamPart:Clone()
                u29.CFrame = v6.CFrame * CFrame.new(Random.new():NextNumber(-3, 3), Random.new():NextNumber(-3, 3), Random.new():NextNumber(-3, 3)) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793), Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                u29.Parent = workspace.Effects
                _G.destroy(u29, 3)
                local v30 = Random.new():NextNumber(19, 23)
                game:GetService("TweenService"):Create(u29.attach1, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Position"] = Vector3.new(0, 0, v30)
                }, true):Play()
                local v31 = game:GetService("TweenService")
                local v32 = u29.attach2
                local v33 = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local v34 = {}
                local v35 = -v30
                v34.Position = Vector3.new(0, 0, v35)
                v31:Create(v32, v33, v34, true):Play()
                local v36 = Random.new():NextNumber(8, 16)
                game:GetService("TweenService"):Create(u29.Beam, TweenInfo.new(Random.new():NextNumber(0.25, 0.35), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Width0"] = v36,
                    ["Width1"] = v36
                }, true):Play()
                game:GetService("TweenService"):Create(u29.Beam, TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["TextureSpeed"] = 0
                }, true):Play()
                task.delay(0.15, function() --[[ Line: 241 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                    --]]
                    game:GetService("TweenService"):Create(u29.Beam, TweenInfo.new(Random.new():NextNumber(0.2, 0.3), Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }, true):Play()
                end)
            end
            if v12 then
                game.Lighting.BlurF.Size = 20
                game:GetService("TweenService"):Create(game.Lighting.BlurF, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    ["Size"] = 0
                }, true):Play()
                if _G.cameraShakeEnabled == true then
                    task.spawn(function() --[[ Line: 260 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                        --]]
                        for v37 = 10, 0, -1 do
                            local v38 = v37 / 30
                            local v39 = u2.Humanoid
                            local v40 = Random.new():NextNumber(-2, 2) * v38
                            local v41 = Random.new():NextNumber(-2, 2) * v38
                            local v42 = Random.new():NextNumber(-2, 2) * v38
                            v39.CameraOffset = Vector3.new(v40, v41, v42)
                            task.wait(0.025)
                        end
                        u2.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                    end)
                end
                v12.electricitySurroundAura:Destroy()
                v12.shineGrowAura:Destroy()
                v7:Destroy()
                _G.customEmit(v12.burstAttach, true)
                for _, v43 in pairs(v11) do
                    v43:Destroy()
                end
                local v44, v45, v46 = _G.getRayFloor(v6.CFrame, 15)
                if v44 ~= nil then
                    local v47 = v3.outFloorPart:Clone()
                    v47.CFrame = CFrame.new(v45, v45 + v46)
                    v47.Parent = workspace.Effects
                    _G.destroy(v47, 2)
                    for _, v48 in pairs(v47:GetChildren()) do
                        if v48.Name ~= "lineBurst" then
                            v48.Color = ColorSequence.new(v44.Color)
                        end
                    end
                    _G.customEmit(v47, true)
                end
            end
        end
    end
end
return v1