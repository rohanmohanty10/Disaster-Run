 

local u1 = game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = workspace.Effects
function v2.start(_, p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    if _G.checkRenderDistance(p4.PrimaryPart.Position) then
        local v5, v6, v7 = _G.getRayFloor(p4.PrimaryPart.CFrame, 10)
        local v8 = v7:Dot(Vector3.new(0, 1, 0))
        local v9 = math.acos(v8)
        local v10 = math.rad(v9)
        local v11 = v7:Dot(p4.PrimaryPart.CFrame.LookVector)
        local v12 = math.sign(v11)
        local v13 = CFrame.new(v6, v6 + p4.PrimaryPart.CFrame.LookVector) * CFrame.Angles(1.5707963267948966 - v12 * v10, 0, 0)
        if v5 then
            local v14 = script:FindFirstChild("DustPart"):Clone()
            v14.CFrame = v13 * CFrame.new(0, 0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
            v14.Dust.Color = ColorSequence.new(v5.Color)
            v14.Parent = u3
            _G.customEmit(v14.Dust)
            _G.destroy(v14, 1.2)
        end
        local v15 = script:FindFirstChild("Blast"):Clone()
        v15.CFrame = p4.PrimaryPart.CFrame * CFrame.new(0, 0, -2)
        v15.Parent = u3
        _G.customEmit(v15)
        _G.destroy(v15, 2)
        for v16 = 1, 3 do
            local u17 = script:FindFirstChild("Wave"):Clone()
            u17.CFrame = v15.CFrame
            u17.Parent = u3
            local v18 = TweenInfo.new(0.45, Enum.EasingStyle.Quint)
            local v19 = {
                ["CFrame"] = u17.CFrame * CFrame.new(0, 0, v16 * -10)
            }
            local v20 = v16 * 8
            local v21 = v16 * 12
            v19.Size = Vector3.new(v20, 0, v21)
            u1:Create(u17, v18, v19):Play()
            u1:Create(u17.Top, v18, {
                ["Transparency"] = 1
            }):Play()
            u1:Create(u17.Bottom, v18, {
                ["Transparency"] = 1
            }):Play()
            task.delay(0.25, function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                _G.particleEnabled(u17, false)
                _G.destroy(u17, 2)
            end)
            task.wait(0.01)
        end
    end
end
return v2