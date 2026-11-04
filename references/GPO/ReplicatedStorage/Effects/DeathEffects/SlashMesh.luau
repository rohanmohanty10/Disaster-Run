 

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
return function(p4, u5, p6, p7) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
    --]]
    local v8 = Random.new()
    if p4 == 0 then
        local u9 = script.SlashMesh:Clone()
        u9.CFrame = p6
        u9.Parent = workspace.Effects
        task.spawn(function() --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u9
                [3] = u3
                [4] = u5
            --]]
            for v10 = 1, #u2 do
                local v11 = Instance.new("Decal")
                v11.Texture = "rbxassetid://" .. u2[v10]
                v11.Parent = u9
                v11.Transparency = -4
                v11.Color3 = Color3.fromRGB(230, 280, 2555)
                u3:Create(v11, TweenInfo.new(u5 / #u2 * 2), {
                    ["Transparency"] = 1
                }):Play()
                task.wait(u5 / #u2)
            end
        end)
        _G.destroy(u9, u5 + 0.25)
        return u9
    else
        local v12 = script.SlashModel:Clone()
        v12:PivotTo(p6)
        v12.Parent = workspace.Effects
        for _, u13 in v12:GetChildren() do
            if u13:IsA("BasePart") and u13:FindFirstChild("Mesh") then
                if p7 then
                    local v14 = u13.Mesh.Scale
                    local v15 = u13.Mesh
                    v15.Scale = v15.Scale * (p7[1] or 1)
                    u3:Create(u13.Mesh, TweenInfo.new(u5 / 2), {
                        ["Scale"] = v14 * (p7[2] or 1)
                    }):Play()
                end
                if u13.Name == "Inner" then
                    u3:Create(u13, TweenInfo.new(u5), {
                        ["CFrame"] = u13.CFrame * CFrame.Angles(0, 3.110487775831478, 0)
                    }):Play()
                    task.spawn(function() --[[ Line: 49 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u13
                            [3] = u3
                            [4] = u5
                        --]]
                        for v16 = 1, #u1 do
                            local v17 = Instance.new("Decal")
                            v17.Texture = "rbxassetid://" .. u1[v16]
                            v17.Parent = u13
                            v17.Transparency = -2
                            v17.Color3 = Color3.fromRGB(230, 280, 2555)
                            u3:Create(v17, TweenInfo.new(u5 / #u1 * 2), {
                                ["Transparency"] = 1
                            }):Play()
                            task.wait(u5 / (#u1 * 2))
                        end
                    end)
                else
                    local u18 = u5 * v8:NextNumber(1.1, 1.4)
                    u3:Create(u13, TweenInfo.new(u5 * v8:NextNumber(1.1, 1.4)), {
                        ["CFrame"] = u13.CFrame * CFrame.Angles(0, 3.110487775831478, 0)
                    }):Play()
                    task.spawn(function() --[[ Line: 67 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u13
                            [3] = u3
                            [4] = u18
                        --]]
                        for v19 = 1, #u1 do
                            local v20 = Instance.new("Decal")
                            v20.Texture = "rbxassetid://" .. u1[v19]
                            v20.Parent = u13
                            v20.Transparency = v19 * 1 / (#u1 + 1)
                            v20.Color3 = Color3.fromRGB(167, 167, 167)
                            u3:Create(v20, TweenInfo.new(u18 / #u1 * 2), {
                                ["Transparency"] = 1
                            }):Play()
                            task.wait(u18 / (#u1 * 2))
                        end
                    end)
                end
            end
        end
        _G.destroy(v12, u5 + 0.25)
        return v12
    end
end