 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
function v1.start(_, u4, _) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    u4.HumanoidRootPart.Anchored = true
    _G.PlaySound(u4.PrimaryPart, script.StringGrip)
    task.delay(1, function() --[[ Line: 9 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        local v5 = script.Spiderman:Clone()
        v5.Position = u4.HumanoidRootPart.Position
        v5.Parent = workspace.Effects
        _G.customEmit(v5)
        _G.destroy(v5, 2.65)
    end)
    local v6 = next
    local v7, v8 = u4:GetChildren()
    for _, v9 in v6, v7, v8 do
        if v9:IsA("BasePart") and v9.Name ~= "HumanoidRootPart" then
            for _ = 1, math.random(1, 3) do
                local v10 = v9.Position
                local v11 = u3:NextNumber(-15, 15)
                local v12 = u3:NextNumber(2, 11)
                local v13 = u3
                local v14 = v10 + Vector3.new(v11, v12, v13:NextNumber(-15, 15))
                local u15 = script.Beam:Clone()
                local v16 = u3:NextNumber(5, 15)
                u15.Start.Beam.CurveSize0 = v16
                u15.Start.Beam.CurveSize1 = -v16
                u15.CFrame = CFrame.new(v14, v9.Position)
                u15.Parent = workspace.Effects
                local v17 = v9.Size.X / 2
                local v18 = u3:NextNumber(-v17, v17)
                local v19 = v9.Size.Y / 2
                local v20 = u3:NextNumber(-v19, v19)
                local v21 = v9.Size.Z / 2
                local v22 = u3:NextNumber(-v21, v21)
                u2:Create(u15.End, TweenInfo.new(u3:NextNumber(0.15, 0.3)), {
                    ["WorldPosition"] = v9.Position + Vector3.new(v18, v20, v22)
                }):Play()
                u2:Create(u15.Start.Beam, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                    ["CurveSize0"] = 0,
                    ["CurveSize1"] = 0
                }):Play()
                task.delay(1, function() --[[ Line: 47 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u15
                        [3] = u3
                    --]]
                    u2:Create(u15.End, TweenInfo.new(u3:NextNumber(0.15, 0.3)), {
                        ["Position"] = Vector3.new(0, 0, 0)
                    }):Play()
                    u2:Create(u15.Start.Beam, TweenInfo.new(u3:NextNumber(0.15, 0.3)), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                    _G.destroy(u15, 0.3)
                end)
            end
        end
    end
end
return v1