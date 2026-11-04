 

local u1 = game:GetService("TweenService")
local u2 = workspace:WaitForChild("Effects")
local _ = workspace.CurrentCamera
local u3 = game.ReplicatedStorage.Refrences.Fishman
return function(p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
    --]]
    local v5 = p4 or {}
    local v6 = (v5.CFrame or CFrame.new()) * (v5.AngleOffset or CFrame.new())
    local v7 = v5.Scale or 1
    if _G.checkRenderDistance(v6.p) ~= false then
        local v8 = v5.Duration or 1
        local v9 = v5.Color or Color3.new(1, 1, 1)
        local v10 = v5.Offset or Vector3.new()
        local v11 = v5.ZInfluence
        local u12 = u3.Assets.Wind2:Clone()
        local v13 = u12.Mesh.Scale
        local v14 = v13.X
        local v15 = v13.Y
        local v16 = v11 or v13.Z
        local v17 = Vector3.new(v14, v15, v16)
        u12.Mesh.Scale = Vector3.new()
        local v18 = u12.Mesh
        local v19 = v9.r
        local v20 = v9.g
        local v21 = v9.b
        v18.VertexColor = Vector3.new(v19, v20, v21) * 2
        u12.CFrame = v6
        u12.Parent = u2
        local v22 = TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local v23 = TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local v24 = u1:Create(u12.Mesh, v22, {
            ["Scale"] = v17 * v7
        })
        local v25 = u1:Create(u12, v22, {
            ["Transparency"] = 1
        })
        local v26 = u1:Create(u12, v23, {
            ["CFrame"] = v6 * CFrame.new(v10)
        })
        v24.Completed:Connect(function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u12
            --]]
            u12:Destroy()
        end)
        v24:Play()
        v25:Play()
        v26:Play()
    end
end