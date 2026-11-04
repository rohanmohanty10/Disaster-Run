 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = script:WaitForChild("Rocks"):GetChildren()
local _ = script.Animations
local u4 = _G.customEmit
local function u10(p5) --[[ Line: 22 ]]
    local v6 = RaycastParams.new()
    local v7 = { workspace.Islands, workspace.Env, workspace.Ships }
    local v8 = Enum.RaycastFilterType.Whitelist
    v6.FilterDescendantsInstances = v7
    v6.FilterType = v8
    local v9 = workspace:Raycast(p5, Vector3.new(0, -500, 0), v6) or {
        ["Position"] = Vector3.new(0, 0, 0),
        ["Normal"] = Vector3.new(1, 1, 1)
    }
    return v9.Position, v9.Normal
end
local function u35(p11) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u2
    --]]
    local v12, v13 = u10(p11.Position)
    local v14 = Random.new()
    local v15 = v14:NextInteger(8, 9)
    for v16 = 1, v15 do
        local v17 = 360 / v15 * v16
        local v18 = math.rad(v17)
        local v19 = v14:NextNumber(6, 9)
        local v20 = (CFrame.new(v12, v12 + v13) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.cos(v18) * v19, 0, math.sin(v18) * v19)).Position
        if p11.LookVector:Dot(CFrame.new(p11.Position, v20).LookVector) < 0.5 then
            local v21 = RaycastParams.new()
            local v22 = { workspace }
            local v23 = Enum.RaycastFilterType.Whitelist
            v21.FilterDescendantsInstances = v22
            v21.FilterType = v23
            local v24 = workspace:Raycast(v20 + Vector3.new(0, 1, 0), v13 * -5, v21)
            if v24 then
                local v25 = v24.Position
                local v26 = Vector3.new(0, v14:NextNumber(-0.6, -0.3))
                local v27 = CFrame.Angles(0, v14:NextNumber(-0.5235987755982988, 0.5235987755982988), 0)
                local v28 = CFrame.new(v25 + v26, v12 - Vector3.new(0, 3, 0)) * v27
                local u29 = u3[math.random(1, #u3)]:Clone()
                u29:PivotTo(v28)
                local v30 = next
                local v31, v32 = u29:GetChildren()
                for _, v33 in v30, v31, v32 do
                    u2:Create(v33, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["CFrame"] = v33.CFrame
                    }):Play()
                end
                u29:PivotTo(CFrame.new(v12, v12 - Vector3.new(0, 25, 0)) * v27)
                u29.Parent = workspace.Effects
                _G.matchMaterial(u29.Land, v24.Instance)
                task.delay(1.75 + v14:NextNumber(-0.1, 0.1), function() --[[ Line: 62 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u2
                    --]]
                    for _, v34 in u29:GetChildren() do
                        u2:Create(v34, TweenInfo.new(0.5), {
                            ["Position"] = v34.Position - Vector3.new(0, 6, 0),
                            ["Size"] = Vector3.new(0, 0, 0)
                        }):Play()
                    end
                    _G.destroy(u29, 0.5)
                end)
            end
        end
    end
end
function v1.start(_, u36, p37) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u35
    --]]
    if _G.checkRenderDistance(u36.PrimaryPart.Position) then
        if p37 then
            task.spawn(function() --[[ Line: 99 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u2
                --]]
                for _ = 1, 2 do
                    local v38 = script.RingMesh:Clone()
                    v38.CFrame = u36.PrimaryPart.CFrame * CFrame.new(0, 0, -9) * CFrame.Angles(0, -1.5707963267948966, 0)
                    v38.Parent = workspace.Effects
                    u2:Create(v38, TweenInfo.new(0.55, Enum.EasingStyle.Cubic), {
                        ["CFrame"] = v38.CFrame * CFrame.new(6, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                    }):Play()
                    u2:Create(v38.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
                        ["Transparency"] = 1
                    }):Play()
                    u2:Create(v38.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Cubic), {
                        ["Scale"] = Vector3.new(0.54, 0.39, 0.376)
                    }):Play()
                    _G.destroy(v38, 0.6)
                    task.wait(0.05)
                end
            end)
            local v39 = script.HitMesh:Clone()
            v39.CFrame = u36.PrimaryPart.CFrame * CFrame.new(0, 0, 4) * CFrame.Angles(0, -1.5707963267948966, 0)
            v39.Parent = workspace.Effects
            u2:Create(v39, TweenInfo.new(0.55, Enum.EasingStyle.Cubic), {
                ["CFrame"] = v39.CFrame * CFrame.new(4, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
            }):Play()
            u2:Create(v39.Decal, TweenInfo.new(0.45, Enum.EasingStyle.Cubic), {
                ["Transparency"] = 1
            }):Play()
            u2:Create(v39.Mesh, TweenInfo.new(0.45, Enum.EasingStyle.Cubic), {
                ["Scale"] = Vector3.new(0.68640006, 0.1683, 0.11880001)
            }):Play()
            _G.destroy(v39, 0.6)
            local v40 = script.HitEffect:Clone()
            v40.CFrame = p37.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            v40.Parent = workspace.Effects
            u4(v40)
            _G.destroy(v40, 2)
        else
            local u41 = script.Trail:Clone()
            u41.Parent = workspace.Effects
            u41.CFrame = u36:GetPivot()
            _G.customWeld(u41, u36.PrimaryPart, CFrame.new(), u41)
            task.delay(0.3, function() --[[ Line: 143 ]]
                --[[
                Upvalues:
                    [1] = u41
                --]]
                for _, v42 in u41:GetDescendants() do
                    if v42:IsA("Trail") or v42:IsA("ParticleEmitter") then
                        v42.Enabled = false
                    end
                end
                _G.destroy(u41, 1)
            end)
            local v43 = script.SpringEffect:Clone()
            v43.CFrame = u36.PrimaryPart.CFrame * CFrame.new(0, -1, 3.5)
            v43.Parent = workspace.Effects
            u4(v43)
            local v44 = script.Ground:Clone()
            v44.CFrame = u36.PrimaryPart.CFrame * CFrame.new(0, -3, 3.5)
            v44.Parent = workspace.Effects
            u4(v44)
            _G.destroy(v44, 3)
            _G.destroy(v43, 3)
            u35(u36.PrimaryPart.CFrame * CFrame.new(0, 0, 3.5))
            local v45 = RaycastParams.new()
            local v46 = Enum.RaycastFilterType.Whitelist
            local v47 = { workspace.Islands, workspace.Env, workspace.Ships }
            v45.FilterType = v46
            v45.FilterDescendantsInstances = v47
            local v48 = workspace:Raycast((u36.PrimaryPart.CFrame * CFrame.new(0, 0, 3.5)).Position, Vector3.new(0, -5, 0), v45)
            if v48 then
                local u49 = script.Groundeffect:Clone()
                u49.CFrame = CFrame.new(v48.Position, v48.Position + v48.Normal) * CFrame.Angles(0, 0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793))
                u49.Parent = workspace.Effects
                u49.Size = Vector3.new()
                u2:Create(u49, TweenInfo.new(0.3, Enum.EasingStyle.Cubic), {
                    ["Size"] = script.Groundeffect.Size
                }):Play()
                print(u49:FindFirstChildOfClass("Decal"))
                task.delay(1.4, function() --[[ Line: 184 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u49
                    --]]
                    u2:Create(u49:FindFirstChild("Decal"), TweenInfo.new(0.9), {
                        ["Transparency"] = 1
                    }):Play()
                    _G.destroy(u49, 0.9)
                end)
            end
        end
    else
        return
    end
end
return v1