 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = {
    Enum.NormalId.Back,
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Top,
    Enum.NormalId.Bottom
}
function Apply(p4, p5)
    --[[
    Upvalues:
        [1] = u3
    --]]
    p4.Material = p5.Instance.Material
    p4.Color = p5.Instance.Color
    if p5.Instance:FindFirstChildWhichIsA("Texture") then
        local v6 = p5.Instance:FindFirstChildWhichIsA("Texture")
        for _, v7 in next, u3 do
            local v8 = v6:Clone()
            v8.Face = v7
            v8.Parent = p4
        end
    end
end
local u9 = Random.new()
function ReturnBigPlanet()
    local v10 = Instance.new("Model")
    v10.Name = "Planet"
    v10.Parent = workspace.Effects
    for v11 = 1, 5 do
        local v12 = script.Planet:Clone()
        v12.Name = tostring(v11)
        v12.Parent = v10
        local v13 = v12:GetPivot().Position
        local v14 = next
        local v15, v16 = v12:GetChildren()
        for _, v17 in v14, v15, v16 do
            if v17:IsA("BasePart") then
                local v18 = v17.Size
                local v19 = v11 * 5
                local v20 = v11 * 5
                local v21 = v11 * 5
                v17.Size = v18 + Vector3.new(v19, v20, v21)
                v17.Position = (v17.CFrame - CFrame.new(v17.Position, v13).LookVector * (v11 * 5 / 2)).Position
            end
        end
    end
    return v10
end
function v1.start(_, p22, p23) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
    --]]
    _G.PlaySound(p22.PrimaryPart.CFrame * CFrame.new(0, 55, 0), script.PlanetaryGrip)
    local v24 = CFrame.new(p22.HumanoidRootPart.Position) * CFrame.new(0, 55, 0) * CFrame.Angles(u9:NextNumber(-360, 360), u9:NextNumber(-360, 360), u9:NextNumber(-360, 360))
    local u25 = v24.Position
    local v26 = RaycastParams.new()
    v26.FilterDescendantsInstances = { workspace.Effects, p22, p23 }
    v26.FilterType = Enum.RaycastFilterType.Blacklist
    local v27 = script.BlackHole:Clone()
    v27.Position = p22.PrimaryPart.Position
    v27.Parent = workspace.Effects
    u2:Create(v27, TweenInfo.new(1.45), {
        ["Position"] = u25
    }):Play()
    task.wait(1.9)
    p22.PrimaryPart.Anchored = true
    local v28 = u2
    local v29 = p22.PrimaryPart
    local v30 = TweenInfo.new(1.85)
    local v31 = {}
    local v32 = p22.PrimaryPart.CFrame * CFrame.new(0, 55, 0)
    local v33 = CFrame.Angles
    local v34 = u9:NextNumber(-360, 360)
    local v35 = math.rad(v34)
    local v36 = u9:NextNumber(-360, 360)
    local v37 = math.rad(v36)
    local v38 = u9:NextNumber(-360, 360)
    v31.CFrame = v32 * v33(v35, v37, (math.rad(v38)))
    v28:Create(v29, v30, v31):Play()
    task.wait(0.6)
    local v39 = ReturnBigPlanet()
    v39:PivotTo(v24)
    local v40 = #v39["1"]:GetChildren() * 0.035
    local v41 = 0
    for v42 = 1, #v39:GetChildren() do
        local v43 = next
        local v44, v45 = v39[tostring(v42)]:GetChildren()
        for _, u46 in v43, v44, v45 do
            if u46:IsA("BasePart") then
                local v47 = workspace
                local v48 = u46.Position
                local v49 = u9:NextNumber(-2000, 2000)
                local v50 = u9
                local u51 = v47:Raycast(v48, Vector3.new(v49, -1000, v50:NextNumber(-2000, 2000)), v26)
                if u51 then
                    Apply(u46, u51)
                end
                local u52 = u46.CFrame
                local v53 = u9:NextNumber(-2000, 2000)
                local v54 = u9:NextNumber(-200, -100)
                local v55 = u9
                local v56 = Vector3.new(v53, v54, v55:NextNumber(-2000, 2000))
                if not u51 then
                    ::l9::
                    v59 = u46.Position + v56
                    goto l10
                end
                local v57 = u51.Position
                local v58 = u9:NextNumber(200, 100)
                local v59 = v57 - Vector3.new(0, v58, 0)
                if not v59 then
                    goto l9
                end
                ::l10::
                u46.Position = v59
                local v60 = u9:NextNumber(-360, 360)
                local v61 = u9:NextNumber(-360, 360)
                local v62 = u9
                u46.Orientation = Vector3.new(v60, v61, v62:NextNumber(-360, 360))
                task.delay(v41 * 0.035, function() --[[ Line: 107 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u52
                        [3] = u2
                        [4] = u46
                        [5] = u9
                    --]]
                    if u51 then
                        local u63 = script.Launch:Clone()
                        u63.CFrame = CFrame.new(u51.Position, u52.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                        local v64 = next
                        local v65, v66 = u63:GetDescendants()
                        for _, v67 in v64, v65, v66 do
                            if v67:IsA("ParticleEmitter") then
                                v67.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u51.Instance.Color), ColorSequenceKeypoint.new(1, u51.Instance.Color) })
                            end
                        end
                        u63.Parent = workspace.Effects
                        _G.customEmit(u63)
                        task.delay(4.65, function() --[[ Line: 124 ]]
                            --[[
                            Upvalues:
                                [1] = u63
                            --]]
                            u63:Destroy()
                        end)
                    end
                    local v68 = {
                        ["CFrame"] = u52
                    }
                    u2:Create(u46, TweenInfo.new(u9:NextNumber(0.5, 0.8), Enum.EasingStyle.Linear), v68):Play()
                end)
                v41 = v41 + 1
                if v42 == #v39:GetChildren() then
                    task.delay(8.5, function() --[[ Line: 136 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u46
                            [3] = u25
                            [4] = u9
                        --]]
                        u2:Create(u46, TweenInfo.new(0.35), {
                            ["Size"] = u46.Size - Vector3.new(5, 5, 5),
                            ["Position"] = (u46.CFrame + CFrame.new(u46.Position, u25).LookVector * 2.5).Position
                        }):Play()
                        task.wait(0.4)
                        u46.Anchored = false
                        local u69 = Instance.new("BodyVelocity")
                        u69.MaxForce = Vector3.new(inf, inf, inf)
                        local v70 = CFrame.new(u25, u46.Position).LookVector
                        local v71 = u9:NextNumber(-25, 25)
                        local v72 = u9:NextNumber(-15, 15)
                        local v73 = u9
                        u69.Velocity = (v70 + Vector3.new(v71, v72, v73:NextNumber(-25, 25))) * u9:NextNumber(4.35, 10.5)
                        u69.Parent = u46
                        local v74 = u2
                        local v75 = u46
                        local v76 = TweenInfo.new(1)
                        local v77 = {}
                        local v78 = u9:NextNumber(0, 360)
                        local v79 = u9:NextNumber(0, 360)
                        local v80 = u9
                        v77.Orientation = Vector3.new(v78, v79, v80:NextNumber(0, 360))
                        v74:Create(v75, v76, v77):Play()
                        task.delay(u9:NextNumber(0.25, 0.45), function() --[[ Line: 150 ]]
                            --[[
                            Upvalues:
                                [1] = u69
                                [2] = u9
                                [3] = u46
                                [4] = u2
                            --]]
                            u69:Destroy()
                            task.wait(u9:NextNumber(0.45, 0.95))
                            local u81 = nil
                            u81 = u46.Touched:Once(function(p82) --[[ Line: 156 ]]
                                --[[
                                Upvalues:
                                    [1] = u46
                                    [2] = u2
                                    [3] = u81
                                --]]
                                local u83 = script.Smoke:Clone()
                                local v84 = u46.Size.X
                                local v85 = u46.Size.Y
                                local v86 = u46.Size.Z
                                local v87 = math.max(v84, v85, v86)
                                local v88 = u46.Position
                                local v89 = v87 / 2
                                u83.Position = v88 - Vector3.new(0, v89, 0)
                                local v90 = v87 * 1.5
                                local v91 = next
                                local v92, v93 = u83:GetDescendants()
                                for _, v94 in v91, v92, v93 do
                                    if v94:IsA("ParticleEmitter") then
                                        v94.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p82.Color), ColorSequenceKeypoint.new(1, p82.Color) })
                                        v94.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, v90 - 5), NumberSequenceKeypoint.new(1, v90) })
                                    end
                                end
                                u83.Parent = workspace.Effects
                                _G.customEmit(u83)
                                u2:Create(u46, TweenInfo.new(0.2), {
                                    ["Size"] = Vector3.new(0, 0, 0),
                                    ["Transparency"] = 1
                                }):Play()
                                task.delay(0.2, function() --[[ Line: 184 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u81
                                        [2] = u46
                                        [3] = u83
                                    --]]
                                    u81:Disconnect()
                                    u81 = nil
                                    u46:Destroy()
                                    task.wait(4.45)
                                    u83:Destroy()
                                end)
                            end)
                            task.delay(3, function() --[[ Line: 194 ]]
                                --[[
                                Upvalues:
                                    [1] = u81
                                    [2] = u2
                                    [3] = u46
                                --]]
                                if u81 then
                                    u81:Disconnect()
                                    u81 = nil
                                    u2:Create(u46, TweenInfo.new(0.2), {
                                        ["Size"] = Vector3.new(0, 0, 0),
                                        ["Transparency"] = 1
                                    }):Play()
                                    task.wait(0.2)
                                    u46:Destroy()
                                end
                            end)
                        end)
                    end)
                else
                    task.delay(v40 * (v42 + 1) + 0.8, function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u46
                        --]]
                        u46:Destroy()
                    end)
                end
            end
        end
    end
    v39.Parent = workspace.Effects
    task.wait(8.9)
    p22:Destroy()
    v27:Destroy()
    local v95 = script.Explosion:Clone()
    v95.Position = u25
    v95.Parent = workspace.Effects
    _G.customEmit(v95)
    task.wait(5)
    v95:Destroy()
    v39:Destroy()
end
return v1