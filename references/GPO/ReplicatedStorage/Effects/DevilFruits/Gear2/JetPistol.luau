 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        local v7
        if p2:FindFirstChild((tostring(v6))) then
            v7 = v6
        else
            v7 = v6 + 1
        end
        p1.Texture = p2[tostring(v7)].Texture
        task.wait(p3)
    end
end
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
return {
    ["start"] = function(_, p8, p9, p10, p11) --[[ Name: start, Line 16 ]]
        if _G.checkRenderDistance(p8.PrimaryPart.Position) then
            local v12 = Random.new()
            local _ = p8.Humanoid.RootPart
            local v13 = p11.Position
            local v14 = CFrame.new(v13, p9) * CFrame.new(0, -1.5, 0)
            local v15 = (v13 - p9).Magnitude
            local v16 = math.clamp(v15, 0, 125) + 3
            local v17 = Ray.new(v13, (v13 - p9).unit * -v16)
            local u18, u19 = _G.raycastWhitelist(v17, p10)
            local v20 = v14 * CFrame.new(0, 0, -v16)
            _G.PlaySound(p8.PrimaryPart, script["Audio/JetPistolShoot"])
            local v21 = {
                ["White"] = {
                    ["Lifetime"] = 0.35,
                    ["SizeMultiplier"] = Vector3.new(1.5, 0.5, 1.5),
                    ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                },
                ["MeshPart"] = {
                    ["Lifetime"] = 0.25,
                    ["SizeMultiplier"] = Vector3.new(3, 1, 3),
                    ["CFrameOffset"] = CFrame.new(0, 10, 0) * CFrame.Angles(0, 2.6179938779914944, 0)
                },
                ["Shock"] = {
                    ["Lifetime"] = 0.45,
                    ["SizeMultiplier"] = Vector3.new(2, 2, 2),
                    ["CFrameOffset"] = CFrame.new(0, 5, 0) * CFrame.Angles(0, 2.0943951023931953, 0)
                },
                ["Shock2"] = {
                    ["Lifetime"] = 0.2,
                    ["SizeMultiplier"] = Vector3.new(3, 0.8, 3),
                    ["CFrameOffset"] = CFrame.new(0, 8, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                },
                ["Shock3"] = {
                    ["Lifetime"] = 0.15,
                    ["SizeMultiplier"] = Vector3.new(2, 0.8, 2),
                    ["CFrameOffset"] = CFrame.new(0, 6, 0)
                },
                ["Shock4"] = {
                    ["EaseDir"] = Enum.EasingDirection.Out,
                    ["Lifetime"] = 0.45,
                    ["SizeMultiplier"] = Vector3.new(1.25, 0.25, 1.25),
                    ["CFrameOffset"] = CFrame.new(0, 6, 0) * CFrame.Angles(0, 2.5132741228718345, 0)
                }
            }
            local v22 = script.ProjMeshes:Clone()
            local v23 = v22.Particles
            v22:PivotTo(v14 * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0))
            v22.Parent = workspace.Effects
            Emit(v23.Start:GetChildren(), true)
            Emit(v23:GetChildren(), false, 0.1)
            task.delay(0.01, function() --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u19
                --]]
                if u18 then
                    local v24 = script.hitPart:Clone()
                    if u18:IsDescendantOf(workspace.PlayerCharacters) or (u18:IsDescendantOf(workspace.NPCs) or u18:IsDescendantOf(workspace.Ragdolls)) then
                        v24.Hit.Debris.Transparency = NumberSequence.new(1)
                    end
                    v24.Hit.Debris.Color = ColorSequence.new(u18.Color)
                    v24.CFrame = CFrame.new(u19)
                    v24.Parent = workspace.Effects
                    _G.destroy(v24, 2)
                    _G.PlaySound(v24, script["Audio/JetPistolHitSurface"])
                    _G.customEmit(v24)
                end
            end)
            local v25 = script.ExtraMeshes.Flash:Clone()
            v25.CFrame = v14:Lerp(v20, 0.12) * CFrame.Angles(-0, 1.5707963267948966, 0)
            v25.Parent = workspace.Effects
            TweenCreate(v25, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = v25.CFrame * CFrame.Angles(0, 0, 0) * CFrame.new(v16 / 2, 0, 0),
                ["Size"] = (v25.Size + Vector3.new(v16, 0, 0)) * Vector3.new(1, 0, 0)
            })
            TweenCreate(v25, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            })
            Emit(v25, false, 0.1)
            _G.destroy(v25, 0.6)
            local v26 = script.ExtraMeshes.Long:Clone()
            v26.CFrame = v14:Lerp(v20, 0.12) * CFrame.Angles(0, 0, v12:NextNumber(0, 3.142))
            v26.Parent = workspace.Effects
            TweenCreate(v26, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["CFrame"] = v26.CFrame * CFrame.new(0, 0, -v16 / 2),
                ["Size"] = v26.Size * Vector3.new(0.3, 0.3, v16)
            })
            TweenCreate(v26, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Transparency"] = 1
            })
            _G.destroy(v26, 0.2)
            local v27 = script.ExtraMeshes.Shockwave:Clone()
            v27.CFrame = v14:Lerp(v20, 0.12) * CFrame.Angles(-0, 0, 0)
            v27.Parent = workspace.Effects
            TweenCreate(v27, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = v27.CFrame * CFrame.Angles(0, 0, 0) * CFrame.new(0, -0, -v16 / 2),
                ["Size"] = v27.Size * Vector3.new(0.3, 0.3, v16)
            })
            TweenCreate(v27, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                ["Transparency"] = 1
            })
            Emit(v27.slash, false, 0.15)
            _G.destroy(v27, 1)
            _G.destroy(v22, 1)
            for _, v28 in pairs(v22:GetChildren()) do
                local v29 = v21[v28.Name]
                if v29 then
                    local v30 = Enum.EasingDirection.Out
                    if v29.EaseDir then
                        v30 = v29.EaseDir
                    end
                    local v31 = v28.Size
                    v28.Size = v28.Size / 3
                    TweenCreate(v28, TweenInfo.new(v29.Lifetime, Enum.EasingStyle.Quad, v30), {
                        ["CFrame"] = v28.CFrame * v29.CFrameOffset * CFrame.new(0, -0, 0),
                        ["Size"] = v31 * v29.SizeMultiplier,
                        ["Color"] = v29.Color
                    })
                    TweenCreate(v28, TweenInfo.new(v29.Lifetime, Enum.EasingStyle.Quad, v30), {
                        ["Transparency"] = 1
                    })
                end
            end
            local v32 = script.WindMeshes:Clone()
            v32:PivotTo(v14:Lerp(v20, 0.5) * CFrame.new(0, 0, -3) * CFrame.Angles(1.5707963267948966, 0, 0))
            v32.Parent = workspace.Effects
            _G.destroy(v32, 0.4)
            for _, v33 in pairs(v32:GetChildren()) do
                local v34 = v21[v33.Name]
                local v35 = v33.Size
                v33.Size = v33.Size / 3
                TweenCreate(v33, TweenInfo.new(v34.Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["CFrame"] = v33.CFrame * v34.CFrameOffset,
                    ["Size"] = v35 * v34.SizeMultiplier,
                    ["Color"] = v34.Color
                })
                TweenCreate(v33, TweenInfo.new(v34.Lifetime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ["Transparency"] = 1
                })
            end
        end
    end
}