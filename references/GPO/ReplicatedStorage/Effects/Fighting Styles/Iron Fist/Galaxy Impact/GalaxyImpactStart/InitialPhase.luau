 

local u1 = game:GetService("TweenService")
local u2 = Random.new()
return {
    ["Initialize"] = function(_, p3, p4) --[[ Name: Initialize, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local u5 = script.Spheres:Clone()
        local u6 = u5.Sphere4
        local v7 = u6.Size
        local u8 = u6.Size
        local u9 = {}
        for _, v10 in u5:GetChildren() do
            if v10 ~= u6 then
                u9[v10] = {
                    ["InitialSize"] = v10.Size,
                    ["Ratio"] = v10.Size.Magnitude / u6.Size.Magnitude,
                    ["Offset"] = v10.Position - u6.Position
                }
            end
        end
        u6:GetPropertyChangedSignal("Size"):Connect(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u8
                [3] = u9
            --]]
            task.defer(function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u8
                    [3] = u9
                --]]
                local v11 = u6.Size / u8
                for v12, v13 in pairs(u9) do
                    v12.Size = v13.Ratio * u6.Size
                    v12.Position = u6.Position + v13.Offset * v11
                end
            end)
        end)
        for _, v14 in u5:GetDescendants() do
            if v14:IsA("ParticleEmitter") and v14:GetAttribute("hakiColor") then
                v14.Color = ColorSequence.new(p4)
            end
        end
        local v15, v16, v17 = p4:ToHSV()
        for _, v18 in { u5.Sphere2, u5.Sphere3, u5.Sphere4 } do
            v18.Color = Color3.fromHSV(v15, v16, v17)
            v17 = v17 * 0.85
        end
        u5.Sphere1.Color = Color3.new(1, 1, 1)
        u5:PivotTo(CFrame.new(p3))
        u6.Size = Vector3.new(60, 60, 60)
        u5.Parent = workspace.Effects
        local v19 = Instance.new("Model")
        Instance.new("Highlight", v19).Enabled = false
        v19.Parent = workspace.Effects
        local v20 = script.glass:Clone()
        v20.Size = Vector3.new(60, 60, 60)
        v20.CFrame = u6.CFrame
        v20.Parent = v19
        _G.tween(v20, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1,
            ["Size"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(v19, 0.25)
        u1:Create(u6, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            ["Size"] = v7
        }):Play()
        _G.PlaySound(v20, script.GalaxyImpactGroundHit)
        task.wait(0.1)
        u6.Size = v7
        task.wait(1)
        task.spawn(function() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            task.wait(0.5)
            u5:Destroy()
        end)
        local v21 = script.Impact:Clone()
        v21.Position = p3
        v21.Size = Vector3.new(0, 2000, 0)
        v21.Parent = workspace.Effects
        u1:Create(v21, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            ["Size"] = Vector3.new(100, 2000, 100),
            ["Transparency"] = 1
        }):Play()
        _G.destroy(v21, 0.3)
        local v22 = Instance.new("Model")
        v22.Name = "Pillar"
        local v23 = Instance.new("Highlight")
        v23.Parent = v22
        v23.FillColor = Color3.fromRGB(255, 255, 255)
        v23.FillTransparency = -0.5
        v23.OutlineTransparency = 1
        v23.DepthMode = Enum.HighlightDepthMode.Occluded
        v22.Parent = workspace.Effects
        local v24 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 1, 0))
        for _ = 0, 15 do
            local v25 = math.random(-50, 50)
            local v26 = (v24 * CFrame.Angles(0, 1.5707963267948966, 0) + v24.LookVector * v25 + p3 + u2:NextUnitVector() * math.random(45, 75)).Position
            local v27 = script.Star:Clone()
            v27.Size = Vector3.new(10, 10, 35) * u2:NextNumber(5, 10) + u2:NextUnitVector():Abs() * 50
            v27.CFrame = CFrame.new(v26, workspace.Camera.CFrame.Position)
            v27.Color = Color3.new(1, 1, 1)
            v27.Parent = v22
            local v28 = u2:NextNumber(0.1, 0.25)
            u1:Create(v27, TweenInfo.new(v28), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
            _G.destroy(v27, v28)
        end
        _G.destroy(v22, 0.25)
    end
}