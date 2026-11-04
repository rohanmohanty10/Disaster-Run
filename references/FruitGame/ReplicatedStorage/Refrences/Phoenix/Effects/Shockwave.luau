 

local u1 = game:GetService("TweenService")
local u2 = workspace:WaitForChild("Effects")
local u3 = workspace.CurrentCamera
local u4 = game:GetService("ReplicatedStorage").Phoenix
return function(p5) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u2
        [4] = u1
    --]]
    local v6 = p5 or {}
    local v7 = (v6.CFrame or CFrame.new()) * (v6.AngleOffset or CFrame.new())
    local v8 = v6.Scale or 1
    if (u3.CFrame.p - v7.p).Magnitude <= 50 + v8 * 7 then
        local v9 = v6.Duration or 1
        local v10 = v6.Color or Color3.new(1, 1, 1)
        local v11 = v6.Offset or Vector3.new()
        local v12 = v6.YInfluence
        local u13 = u4.Assets.Ring:Clone()
        local v14 = u13.Mesh.Scale
        local v15 = v14.X
        local v16 = v12 or v14.Y
        local v17 = v14.Z
        local v18 = Vector3.new(v15, v16, v17)
        u13.Mesh.Scale = Vector3.new()
        local v19 = u13.Mesh
        local v20 = v10.r
        local v21 = v10.g
        local v22 = v10.b
        v19.VertexColor = Vector3.new(v20, v21, v22) * 2
        u13.CFrame = v7
        u13.Parent = u2
        local v23 = TweenInfo.new(v9, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
        local v24 = TweenInfo.new(v9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v25 = TweenInfo.new(v9, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local v26 = u1:Create(u13.Mesh, v24, {
            ["Scale"] = v18 * v8
        })
        local v27 = u1:Create(u13, v23, {
            ["Transparency"] = 1
        })
        local v28 = u1:Create(u13, v25, {
            ["CFrame"] = v7 * CFrame.new(v11)
        })
        v26.Completed:Connect(function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            u13:Destroy()
        end)
        v26:Play()
        v27:Play()
        v28:Play()
    end
end