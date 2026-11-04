 

game:GetService("RunService")
local u1 = workspace:WaitForChild("Effects")
local u2 = game:GetService("ReplicatedStorage").Refrences:WaitForChild("Phoenix").Assets.Sphere
local u3 = workspace.CurrentCamera
local u4 = game:GetService("TweenService")
return function(p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u1
        [4] = u4
    --]]
    local v13 = p5 or CFrame.new()
    local v14 = p6 or Color3.new(1, 1, 1)
    local v15 = p7 or 10
    local v16 = p8 or 6
    local v17 = p9 or 1
    local v18 = p10 or 1
    local v19 = p11 or 0.5
    local u20 = p12 or 0.5
    local v21 = v13.p or Vector3.new()
    if (u3.CFrame.p - v21).Magnitude < 35 + v15 * 7 then
        for _ = 1, v16 do
            local u22 = u2:Clone()
            u22.Color = v14
            local v23 = v13 * CFrame.new(math.random(-v15, v15), math.random(-v15, v15), math.random(-v15, v15))
            u22.CFrame = CFrame.new(v13.p, v23.p) * CFrame.Angles(1.5707963267948966, 0, 0)
            local v24 = math.random(v17, v18)
            local u25 = (v23.p - v13.p).magnitude
            u22.Parent = u1
            local v26 = TweenInfo.new(v19, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v27 = u4:Create(u22, v26, {
                ["CFrame"] = CFrame.new(v23.p, v13.p) * CFrame.Angles(-1.5707963267948966, 0, 0),
                ["Size"] = Vector3.new(0, 1, 0)
            })
            local v28 = u4
            local v29 = u22.Mesh
            local v30 = {
                ["Scale"] = Vector3.new(v24, u25, v24)
            }
            local v31 = -u25 / 2
            v30.Offset = Vector3.new(0, v31, 0)
            local v32 = v28:Create(v29, v26, v30)
            v32.Completed:Connect(function() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u4
                    [3] = u22
                    [4] = u25
                --]]
                local v33 = TweenInfo.new(u20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local v34 = u4
                local v35 = u22.Mesh
                local v36 = {
                    ["Scale"] = Vector3.new(0, 0, 0)
                }
                local v37 = -u25
                v36.Offset = Vector3.new(0, v37, 0)
                local v38 = v34:Create(v35, v33, v36)
                v38.Completed:Connect(function() --[[ Line: 56 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                    --]]
                    u22:Destroy()
                end)
                v38:Play()
            end)
            v27:Play()
            v32:Play()
            _G.destroy(u22, v19 + u20 + 0.5)
        end
    end
end