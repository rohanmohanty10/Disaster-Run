 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = _G.customEmit
function v1.start(_, p4) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = Random.new()
    local v6 = p4:GetPivot() * CFrame.new(0, -0.2, 0)
    local v7 = script.particles:Clone()
    v7.CFrame = v6
    v7.Parent = workspace.Effects
    u3(v7)
    _G.destroy(v7, 2.5)
    _G.PlaySound(v7, script["Audio/PurificationGrip"])
    task.wait(0.35)
    local v8 = script.Sumon:Clone()
    v8.CFrame = v6
    v8.Parent = workspace.Effects
    for _, u9 in v8:GetDescendants() do
        if u9.Name == "c" then
            u2:Create(u9, TweenInfo.new(0.5), {
                ["Size"] = UDim2.fromScale(1, 1),
                ["Rotation"] = 0
            }):Play()
            task.delay(0.5, function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u9
                --]]
                u2:Create(u9, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    ["ImageTransparency"] = 1
                }):Play()
            end)
        end
    end
    task.wait(0.5)
    for v10 = 1, 10 do
        local v11 = script.sbeam:Clone()
        v11.CFrame = v6
        v11.Parent = workspace.Effects
        local v12 = 360 / (10 * v5:NextNumber(0.95, 1.05)) * v10
        local v13 = math.rad(v12)
        local v14 = v5:NextNumber(-1, 1)
        local v15 = math.cos(v13)
        local v16 = math.sin(v13)
        local v17 = Vector3.new(v14, v15, v16) * v5:NextNumber(5, 15)
        local v18 = v11.b
        v18.Position = Vector3.new(0, 0, 0)
        local u19 = v11.g
        u19.Width1 = v5:NextInteger(5, 10)
        u2:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            ["CFrame"] = v11.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(0, 1.2566370614359172, 0)
        }):Play()
        u2:Create(v18, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            ["Position"] = v17
        }):Play()
        u2:Create(u19, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
            ["Width0"] = u19.Width0 * 0.1,
            ["Width1"] = u19.Width1 * 0.1
        }):Play()
        task.delay(0.4, function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u19
            --]]
            u2:Create(u19, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
            _G.destroy(u19, 0.2)
        end)
    end
    local v20 = script.summonfx2:Clone()
    v20.CFrame = v6
    v20.Parent = workspace.Effects
    u3(v20)
    _G.destroy(v20, 2)
    local v21 = script.SpawnEffect:Clone()
    v21:PivotTo(v6 * CFrame.new(0, -1, 0) * CFrame.Angles(1.5707963267948966, 0, 0))
    v21.Parent = workspace.Effects
    local v22 = v21.particles.b
    v22.Position = v21.particles.a.Position
    u2:Create(v22, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
        ["Position"] = Vector3.new(0, 0, 3)
    }):Play()
    local v23 = v21.Part.Size
    v21.Part.Size = Vector3.new(0, 0, 0)
    u2:Create(v21.Part, TweenInfo.new(0.15), {
        ["Size"] = v23
    }):Play()
    task.wait(2.5)
    for _, v24 in v21.particles:GetChildren() do
        if v24:IsA("Beam") then
            u2:Create(v24, TweenInfo.new(0.75), {
                ["Width0"] = 0,
                ["Width1"] = 0
            }):Play()
        end
    end
    local v25 = { "Ring", "Inside" }
    for _, u26 in v21.particles.a:GetChildren() do
        task.delay(table.find(v25, u26.Name) and 0.75 or 0, function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u26
            --]]
            u26.Enabled = false
        end)
    end
    u2:Create(v21.Part, TweenInfo.new(0.75), {
        ["Size"] = Vector3.new(0, 0, 0)
    }):Play()
end
return v1