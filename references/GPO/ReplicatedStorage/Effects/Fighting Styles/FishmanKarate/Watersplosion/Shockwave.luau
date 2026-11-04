 

local u1 = game:GetService("TweenService")
local u2 = workspace:WaitForChild("Effects")
local u3 = game.ReplicatedStorage.Refrences.Fishman.Assets
return function(p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
    --]]
    local v5 = p4.CFrame or CFrame.new()
    if _G.checkRenderDistance(v5.p) ~= false then
        local v6 = p4.Scale or 1
        local v7 = p4.Duration or 1
        local u8 = u3.InvertedWave:Clone()
        u8.CFrame = v5
        u8.Parent = u2
        local u9 = u3.Wave3:Clone()
        u9.CFrame = v5 * CFrame.Angles(-1.5707963267948966, 0, 0.7853981633974483)
        u9.Parent = u2
        local v10 = u8.Mesh.Scale
        u8.Mesh.Scale = Vector3.new()
        local v11 = TweenInfo.new(v7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        local v12 = u1:Create(u8, v11, {
            ["Transparency"] = 1
        })
        local v13 = u1:Create(u8.Mesh, v11, {
            ["Scale"] = v10 * v6
        })
        v12.Completed:Connect(function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8:Destroy()
        end)
        v12:Play()
        v13:Play()
        local v14 = u9.Mesh.Scale
        local v15 = u9.CFrame
        u9.Mesh.Scale = Vector3.new()
        local v16 = TweenInfo.new(v7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        local v17 = u1:Create(u9, v16, {
            ["CFrame"] = v15 * CFrame.new(0, 0, v6 * 0.1),
            ["Transparency"] = 1
        })
        local v18 = u1:Create(u9.Mesh, v16, {
            ["Scale"] = v14 * v6 * Vector3.new(1.5, 1.5, 0.75)
        })
        v17.Completed:Connect(function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            u9:Destroy()
        end)
        v17:Play()
        v18:Play()
    end
end