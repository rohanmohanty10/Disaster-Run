 

local u1 = game:GetService("ReplicatedStorage")
local v2 = {}
game:GetService("Debris")
local u3 = game:GetService("TweenService")
local u4 = game:GetService("RunService")
local u5 = script:WaitForChild("VFX")
script:WaitForChild("Other")
workspace:WaitForChild("Effects")
require(script.Parent:WaitForChild("Shared"))
require(u1.Modules.BoatTween)
Charges = {}
local u6 = Random.new()
function cubicBezier(p7, p8, p9, p10, p11)
    local v12 = p8 + (p9 - p8) * p7
    local v13 = p9 + (p10 - p9) * p7
    local v14 = p10 + (p11 - p10) * p7
    local v15 = v12 + (v13 - v12) * p7
    return v15 + (v13 + (v14 - v13) * p7 - v15) * p7
end
function v2.start(_, u16, p17) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u3
        [3] = u6
        [4] = u4
        [5] = u1
    --]]
    local v18 = p17.State
    local u19 = script.SFX
    if v18 == "Hold" then
        local v20 = u16:FindFirstChild(script.Parent.Name .. "Sword")
        if v20 and v20:FindFirstChild("RootPart") then
            local v21 = v20:GetScale()
            local u22 = u5.FireEnvelopePartial:Clone()
            u22:ScaleTo(v21)
            u22.PrimaryPart.CFrame = v20.RootPart.CFrame
            u22.PrimaryPart.FireEnvelopeWeld.Part0 = v20.RootPart
            u22.PrimaryPart.PointLight.Range = 0
            u22.Parent = workspace.Effects
            local u23 = nil
            task.delay(0.5, function() --[[ Line: 64 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u19
                    [3] = u16
                    [4] = u22
                    [5] = u5
                --]]
                u23 = u19.NapoleonFlameEruptionChargeLoop:Clone()
                u23.Parent = u16.PrimaryPart
                u23:Play()
                local v24 = u22:FindFirstChild("PointLight")
                if v24 then
                    _G.tween(v24, { 0.25, "Linear", "Out" }, {
                        ["Range"] = u5.FireEnvelopePartial.PointLight.Range
                    })
                end
            end)
            _G.PlaySound(u16.PrimaryPart, u19.NapoleonFlameEruptionStart)
            local v25 = u23
            repeat
                task.wait()
            until u16:GetAttribute("NapBlazeHold") == nil
            if v25 then
                u3:Create(v25, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Volume"] = 0
                }):Play()
                _G.destroy(v25, 0.25)
            end
            _G.particleEnabled(u22, false)
            _G.destroy(u22, 3)
            local v26 = u22:FindFirstChild("PointLight")
            if v26 then
                _G.tween(v26, { 0.25, "Linear", "Out" }, {
                    ["Brightness"] = 0
                })
            end
        end
    elseif v18 == "BlazeMode" then
        local v27 = u16:FindFirstChild(script.Parent.Name .. "Sword")
        if not v27 then
            return
        end
        if p17.SkipVFX == nil then
            local v28 = p17.Target.PrimaryPart
            if v28 then
                _G.PlaySound(v27.PrimaryPart, u19.NapoleonFlameEruptionOrbsBuff).Parent = v27.PrimaryPart
                local u29 = v27:FindFirstChild("RootPart")
                if u29 then
                    for _ = 1, 10 do
                        local u30 = u5.FireTrail:Clone()
                        u30.CFrame = v28.CFrame
                        u30.Parent = workspace.Effects
                        local u31 = u30.CFrame
                        local u32 = u16.HumanoidRootPart.CFrame * CFrame.new(u6:NextNumber(-25, 25), u6:NextNumber(-5, 25), u6:NextNumber(-25, 25))
                        local u33
                        if math.random(1, 2) == 1 then
                            u33 = u16.HumanoidRootPart.CFrame * CFrame.new(u6:NextNumber(-25, 25), u6:NextNumber(-5, 25), u6:NextNumber(-25, 25))
                        else
                            u33 = nil
                        end
                        for _, v34 in u30:QueryDescendants("Trail") do
                            local v35 = {}
                            for v36 = 1, #v34.WidthScale.Keypoints do
                                local v37 = NumberSequenceKeypoint.new
                                local v38 = v34.WidthScale.Keypoints[v36].Time
                                table.insert(v35, v37(v38, 0))
                            end
                            local v39 = {
                                ["WidthScale"] = NumberSequence.new(v35)
                            }
                            _G.tween(v34, { 0.75, "Linear", "Out" }, v39)
                        end
                        task.spawn(function() --[[ Line: 136 ]]
                            --[[
                            Upvalues:
                                [1] = u33
                                [2] = u31
                                [3] = u32
                                [4] = u29
                                [5] = u30
                                [6] = u4
                            --]]
                            local v40 = os.clock()
                            if u33 then
                                repeat
                                    local v41 = (os.clock() - v40) / 0.75
                                    local v42 = math.clamp(v41, 0, 1)
                                    u30.Position = cubicBezier(v42, u31.Position, u32.Position, u33.Position, u29.CFrame * CFrame.new(0.05, 1.25, 0).Position)
                                    u4.RenderStepped:Wait()
                                until os.clock() - v40 > 0.75
                            else
                                repeat
                                    local v43 = (os.clock() - v40) / 0.75
                                    local v44 = math.clamp(v43, 0, 1)
                                    local v45 = u31.Position
                                    local v46 = u32.Position
                                    local v47 = u29.CFrame * CFrame.new(0.05, 1.25, 0).Position
                                    local v48 = v45 + (v46 - v45) * v44
                                    u30.Position = v48 + (v46 + (v47 - v46) * v44 - v48) * v44
                                    u4.RenderStepped:Wait()
                                until os.clock() - v40 > 0.75
                            end
                            for _, v49 in u30:GetDescendants() do
                                if v49:IsA("ParticleEmitter") then
                                    v49.Enabled = false
                                    if string.find(v49.Name, "Star") then
                                        v49:Clear()
                                    end
                                end
                            end
                            u30.Attachment.PointLight.Enabled = false
                            task.delay(1, u30.Destroy, u30)
                        end)
                    end
                end
            end
            task.wait(0.75)
        end
        if v27:FindFirstChild("RootPart") then
            local v50 = u5.FireEnvelopeTransition:Clone()
            v50:ScaleTo(v27:GetScale())
            v50.PrimaryPart.FireEnvelopeWeld.Part0 = v27.RootPart
            v50.Parent = v27
            _G.customEmit(v50)
            _G.destroy(v50, 3)
            local u51 = u1.Assets.SoulHomies.FireEnvelopeFull:Clone()
            u51:ScaleTo(v27:GetScale())
            u51.PrimaryPart.FireEnvelopeWeld.Part0 = v27.RootPart
            u51.Parent = v27
            u51.PrimaryPart.AuraSFX:Play()
            local u52 = u16:GetAttributeChangedSignal("SoulCleaverBlazed"):Once(function() --[[ Line: 201 ]]
                --[[
                Upvalues:
                    [1] = u51
                --]]
                _G.particleEnabled(u51, false)
                _G.destroy(u51, 3)
                _G.tween(u51.PrimaryPart.PointLight, { 0.25, "Linear", "Out" }, {
                    ["Brightness"] = 0
                })
                _G.tween(u51.PrimaryPart.AuraSFX, { 0.25, "Linear", "Out" }, {
                    ["Volume"] = 0
                })
            end)
            u51.Destroying:Once(function() --[[ Line: 208 ]]
                --[[
                Upvalues:
                    [1] = u52
                --]]
                u52:Disconnect()
                u52 = nil
            end)
            if p17.SkipVFX == nil then
                _G.PlaySound(v27.PrimaryPart, script.FlameModeSFX, {
                    ["RandomSound"] = true
                }).Parent = v27.PrimaryPart
            end
            return
        end
    else
        local v53 = u16.PrimaryPart.CFrame
        _G.PlaySound(u16.PrimaryPart, u19.NapoleonFlameEruptionWhoosh)
        local v54 = u5.FireSlash:Clone()
        v54.CFrame = v53 * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966)
        v54.Parent = workspace.Effects
        _G.customEmit(v54)
        _G.destroy(v54, 2)
        local u55 = u5.FireSwingAmber:Clone()
        u55.CFrame = v53 * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(0, 1.5707963267948966, 0)
        _G.particleEnabled(u55, true)
        u55.Parent = workspace.Effects
        _G.customEmit(u55)
        u3:Create(u55, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            ["CFrame"] = u55.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
        }):Play()
        task.delay(0.1, function() --[[ Line: 238 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            _G.particleEnabled(u55, false)
            _G.destroy(u55, 3)
        end)
        local u56 = 0
        for _, u57 in p17.PillarData do
            local v58 = u57.SpawnTime - workspace:GetServerTimeNow()
            local v59 = v58 < 0 and 0 or v58
            if u57.Type == "FirePillar" then
                u56 = u56 + 1
            end
            task.delay(v59, function() --[[ Line: 253 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u5
                    [3] = u19
                    [4] = u56
                    [5] = u3
                --]]
                if u57.Type ~= "SwordSlam" then
                    if u57.Type == "FirePillar" then
                        local u60 = u5.FirePillar:Clone()
                        u60.CFrame = u57.CFrame
                        local v61 = u60.Attachment.PointLight.Range * u57.Scale
                        u60.Attachment.PointLight.Brightness = 0
                        u60.Attachment.PointLight.Range = 0
                        u60.Parent = workspace.Effects
                        _G.PlaySound(u60, u19["NapoleonFlameEruptionBoom" .. u56])
                        for _, v62 in u60:QueryDescendants("ParticleEmitter") do
                            if u57.Scale > 1 then
                                v62.Speed = NumberRange.new(v62.Speed.Min * u57.Scale, v62.Speed.Max * u57.Scale)
                                v62.SpreadAngle = Vector2.new(v62.SpreadAngle.X * u57.Scale, v62.SpreadAngle.Y * u57.Scale)
                                local v63 = {}
                                for v64 = 1, #v62.Size.Keypoints do
                                    local v65 = v62.Size.Keypoints[v64]
                                    local v66 = NumberSequenceKeypoint.new
                                    local v67 = v65.Time
                                    local v68 = v65.Value * u57.Scale
                                    local v69 = v65.Envelope * u57.Scale
                                    table.insert(v63, v66(v67, v68, v69))
                                end
                                v62.Size = NumberSequence.new(v63)
                            end
                            if v62.Name ~= "HandFire" then
                                _G.customEmit(v62)
                            end
                            if v62.Parent.Name ~= "Burst" then
                                v62.Enabled = true
                            end
                        end
                        local u70 = u57.Scale
                        local u71 = u57.CFrame + Vector3.new(0, 1, 0)
                        local u72 = u57.CFrame.upVector
                        u3:Create(u60.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ["Range"] = v61,
                            ["Brightness"] = 15
                        }):Play()
                        task.delay(0.1, function() --[[ Line: 304 ]]
                            --[[
                            Upvalues:
                                [1] = u71
                                [2] = u70
                                [3] = u72
                            --]]
                            _G.PlayEffect("GroundRocks4", nil, {
                                ["Segments"] = 15,
                                ["Position"] = u71.Position,
                                ["DistanceRandomness"] = Vector2.new(0.3, 1),
                                ["Duration"] = 4,
                                ["TweenDuration"] = 1,
                                ["Radius"] = 2 + 5 * u70,
                                ["Direction"] = -u72 * 15,
                                ["Angle"] = -0.7853981633974483
                            })
                        end)
                        task.delay(0.75, function() --[[ Line: 317 ]]
                            --[[
                            Upvalues:
                                [1] = u60
                                [2] = u3
                                [3] = u70
                                [4] = u71
                                [5] = u72
                                [6] = u19
                                [7] = u56
                            --]]
                            _G.particleEnabled(u60, false)
                            u3:Create(u60.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                ["Brightness"] = 0,
                                ["Range"] = u60.Attachment.PointLight.Range * 1.35
                            }):Play()
                            _G.PlayEffect("RockDebris", nil, {
                                ["PartCount"] = 3,
                                ["RandomVelocityMagnitude"] = Vector2.new(-35, 35) * u70,
                                ["Position"] = u71.Position,
                                ["Direction"] = u72 * (25 * u70),
                                ["RaycastDirection"] = -u72 * 15,
                                ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                                ["TrailEnabled"] = true
                            })
                            _G.customEmit(u60)
                            _G.destroy(u60, 3.5)
                            _G.PlaySound(u60, u19["NapoleonFlameLineEndBurst" .. u56])
                            _G.shakenear(u71.Position, 100, 75, 35, -0.6)
                        end)
                    end
                end
            end)
        end
    end
end
return v2