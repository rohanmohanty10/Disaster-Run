 

local u1 = {
    13185958825,
    13186546897,
    13186550727,
    13186552848,
    13186554619,
    13186556816,
    13186559476,
    13186560752,
    13186563807,
    13186618440,
    13186621301
}
local u2 = {
    13139193192,
    13139201127,
    13139240485,
    13139213654,
    13139249540,
    13139267696,
    13139267696,
    13139276700,
    13139284498
}
local u3 = game:GetService("TweenService")
return function(p4, u5, p6, p7, u8) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
    --]]
    local v9 = Random.new()
    if p4 == 0 then
        local u10 = script.SlashMesh:Clone()
        u10.CFrame = p6
        u10.Parent = workspace.Effects
        task.spawn(function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u10
                [3] = u3
                [4] = u5
            --]]
            for v11 = 1, #u2 do
                local v12 = Instance.new("Decal")
                v12.Texture = "rbxassetid://" .. u2[v11]
                v12.Parent = u10
                v12.Transparency = -4
                v12.Color3 = Color3.fromRGB(2555, 200, 100)
                u3:Create(v12, TweenInfo.new(u5 / #u2 * 2), {
                    ["Transparency"] = 1
                }):Play()
                task.wait(u5 / #u2)
            end
        end)
        _G.destroy(u10, u5 + 0.25)
        return u10
    else
        local v13 = script.SlashModel:Clone()
        v13:PivotTo(p6)
        v13.Parent = workspace.Effects
        for _, u14 in v13:GetChildren() do
            if u14:IsA("BasePart") and u14:FindFirstChild("Mesh") then
                if p7 then
                    local v15 = u14.Mesh.Scale
                    local v16 = u14.Mesh
                    v16.Scale = v16.Scale * (p7[1] or 1)
                    u3:Create(u14.Mesh, TweenInfo.new(u5 / 2), {
                        ["Scale"] = v15 * (p7[2] or 1)
                    }):Play()
                end
                if u14.Name == "Inner" then
                    u3:Create(u14, TweenInfo.new(u5), {
                        ["CFrame"] = u14.CFrame * CFrame.Angles(0, 3.110487775831478, 0)
                    }):Play()
                    task.spawn(function() --[[ Line: 48 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u14
                            [3] = u8
                            [4] = u3
                            [5] = u5
                        --]]
                        for v17 = 1, #u1 do
                            local v18 = Instance.new("Decal")
                            v18.Texture = "rbxassetid://" .. u1[v17]
                            v18.Parent = u14
                            v18.Transparency = -2
                            v18.Color3 = u8 or Color3.fromRGB(2555, 200, 100)
                            u3:Create(v18, TweenInfo.new(u5 / #u1 * 2), {
                                ["Transparency"] = 1
                            }):Play()
                            task.wait(u5 / (#u1 * 2))
                        end
                    end)
                else
                    local u19 = u5 * v9:NextNumber(1.1, 1.25)
                    u3:Create(u14, TweenInfo.new(u5 * v9:NextNumber(1.25, 1.35)), {
                        ["CFrame"] = u14.CFrame * CFrame.Angles(0, 3.110487775831478, 0)
                    }):Play()
                    task.spawn(function() --[[ Line: 66 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u14
                            [3] = u3
                            [4] = u19
                        --]]
                        for v20 = 1, #u1 do
                            local v21 = Instance.new("Decal")
                            v21.Texture = "rbxassetid://" .. u1[v20]
                            v21.Parent = u14
                            v21.Transparency = v20 * 1 / (#u1 + 1)
                            v21.Color3 = Color3.fromRGB(109, 109, 109)
                            u3:Create(v21, TweenInfo.new(u19 / #u1 * 2), {
                                ["Transparency"] = 1
                            }):Play()
                            task.wait(u19 / (#u1 * 2))
                        end
                    end)
                end
            end
        end
        _G.destroy(v13, u5 + 0.25)
        return v13
    end
end