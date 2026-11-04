 

local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u2 = script
local v3 = {}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
function v3.start(_, p6) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u5
        [4] = u4
    --]]
    if p6 == nil then
        return
    elseif _G.checkRenderDistance(p6.PrimaryPart.Position) ~= false then
        local u7 = Instance.new("Folder")
        u7.Name = "EffectsFolder"
        u7.Parent = workspace.Effects
        local v8 = p6.PrimaryPart
        local v9 = v8.CFrame
        local v10 = u2.TekkaiParticles:Clone()
        v10.CFrame = v9
        v10.Parent = u7
        local v11 = workspace:Raycast(p6.HumanoidRootPart.Position, Vector3.new(0, -5, 0), u1)
        if v11 then
            local v12 = u2.FloorWind:Clone()
            v12.CFrame = CFrame.lookAt(v11.Position, v11.Position + v11.Normal)
            v12.Parent = u7
            _G.customEmit(v12)
        end
        local v13 = {}
        for _, u14 in pairs(p6:GetChildren()) do
            if u14:IsA("BasePart") and script.AfterImageClone:FindFirstChild(u14.Name) then
                for _, v15 in pairs(u2.Particles:GetChildren()) do
                    local v16 = v15:Clone()
                    v16.Rate = u5:NextNumber(0.2, 0.5)
                    local v17 = u5:NextNumber(0.06, 0.3)
                    v16.Lifetime = NumberRange.new(v17, v17 + u5:NextNumber(0.1, 0.3))
                    v16.Parent = u14
                    table.insert(v13, v16)
                end
                task.spawn(function() --[[ Line: 63 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u7
                        [3] = u4
                    --]]
                    local v18 = u14:Clone()
                    local v19 = u14.Size.X * 1.2
                    local v20 = u14.Size.Y
                    local v21 = u14.Size.Z * 1.2
                    v18.Size = Vector3.new(v19, v20, v21)
                    v18.Anchored = false
                    v18.Material = Enum.Material.Neon
                    v18.Color = Color3.new(0.411765, 0.568627, 1)
                    v18.CanQuery = false
                    v18.CanTouch = false
                    v18.Massless = true
                    v18:ClearAllChildren()
                    v18.CFrame = u14.CFrame
                    v18.Transparency = -5
                    v18.Parent = u7
                    local v22 = Instance.new("ManualWeld")
                    v22.Part1 = v18
                    v22.Part0 = u14
                    v22.Parent = v18
                    v22.C0 = CFrame.new(0, u14.Size.Y, 0)
                    u4:Create(v22, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["C0"] = CFrame.new(0, -u14.Size.Y / 2, 0)
                    }):Play()
                    local v23 = u14.Color
                    local v24 = u14.Material
                    u14.Material = Enum.Material.Neon
                    u14.Color = Color3.new(0.564706, 0.717647, 1)
                    u14.Color = v23
                    u14.Material = v24
                    local v25 = u4
                    local v26 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v27 = {}
                    local v28 = u14.Size.X
                    local v29 = u14.Size.Z
                    v27.Size = Vector3.new(v28, 0, v29)
                    v27.Transparency = 1
                    v25:Create(v18, v26, v27):Play()
                    _G.destroy(v18, 0.4)
                end)
                task.spawn(function() --[[ Line: 111 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u7
                        [3] = u4
                    --]]
                    local v30 = u14:Clone()
                    v30.Anchored = false
                    v30.CanCollide = false
                    v30.CanQuery = false
                    v30.CanTouch = false
                    v30.Massless = true
                    v30.Transparency = -1
                    v30:ClearAllChildren()
                    local v31 = Instance.new("Weld")
                    v31.Part1 = v30
                    v31.Part0 = u14
                    v31.Parent = v30
                    v30.Parent = u7
                    u4:Create(v30, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 1,
                        ["Size"] = v30.Size * 1.25
                    }):Play()
                    task.wait(0.1)
                    v30:Destroy()
                end)
            end
        end
        local v32 = Instance.new("Highlight")
        v32.FillTransparency = 0.5
        v32.FillColor = Color3.new(0.333333, 0.666667, 1)
        v32.OutlineColor = Color3.new(0.596078, 0.913725, 1)
        v32.DepthMode = Enum.HighlightDepthMode.Occluded
        v32.Parent = p6
        u4:Create(v32, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        }):Play()
        _G.destroy(v32, 1)
        _G.customEmit(v10)
        local v33 = u2.Wind:Clone()
        v33.CFrame = v8.CFrame
        v33.Parent = u7
        u4:Create(v33, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["CFrame"] = v8.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, -3.141592653589793, 0),
            ["Size"] = Vector3.new(12, 6, 12)
        }):Play()
        u4:Create(v33, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Transparency"] = 0.8
        }):Play()
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 12,
            ["Position"] = p6.PrimaryPart.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 1,
            ["TweenDuration"] = 1,
            ["Radius"] = 6,
            ["Direction"] = Vector3.new(0, -15, 0)
        })
        task.wait(0.15)
        u4:Create(v33, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Transparency"] = 1
        }):Play()
        repeat
            task.wait()
        until p6:GetAttribute("TekkaiV2Hold") == nil
        for _, v34 in pairs(v13) do
            v34.Enabled = false
            _G.destroy(v34, 2)
        end
        task.wait(3.5)
        u7:Destroy()
    end
end
return v3