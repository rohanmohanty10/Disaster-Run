 

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
    local v6 = v5.CFrame or CFrame.new()
    local v7 = v5.AngleOffset or CFrame.Angles(0, 0, 0)
    local v8 = v6 * v7
    local v9 = v5.Scale or 1
    if _G.checkRenderDistance(v8.p) ~= false then
        local v10 = v5.Duration or 1
        local v11 = v5.Color or Color3.new(1, 1, 1)
        local v12 = v5.Offset or Vector3.new()
        local v13 = v5.YInfluence
        local u14 = u3.Assets.Wind:Clone()
        local v15 = u14.Size
        local v16 = v15.X
        local v17 = v13 or v15.Y
        local v18 = v15.Z
        local v19 = Vector3.new(v16, v17, v18)
        u14.Size = Vector3.new()
        u14.Color = Color3.new(v11.r, v11.g, v11.b)
        u14.CFrame = v8
        u14.Parent = u2
        TweenInfo.new(v10, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
        TweenInfo.new(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v20 = u1:Create(u14, TweenInfo.new(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Size"] = v19 * v9,
            ["Transparency"] = 1,
            ["Color"] = Color3.new(1, 1, 1),
            ["CFrame"] = v8 * CFrame.new(v12) * CFrame.Angles(0, 3.141592653589793, 0) * v7
        })
        v20.Completed:Connect(function() --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            u14:Destroy()
        end)
        v20:Play()
    end
end