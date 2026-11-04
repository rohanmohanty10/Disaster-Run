 

local v1 = {}
local u2 = game:GetService("TweenService")
script:WaitForChild("Rocks"):GetChildren()
local _ = script.Animations
local u3 = _G.customEmit
local function u6(p4) --[[ Line: 36 ]]
    for _, v5 in p4:GetDescendants() do
        if v5:IsA("ParticleEmitter") then
            v5.Enabled = false
        end
    end
end
local function u9(p7) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = script.MovingWave:Clone()
    v8.CFrame = p7 * CFrame.new(0, 0, -4) * CFrame.Angles(0, -1.5707963267948966, 0)
    v8.Parent = workspace.Effects
    u2:Create(v8, TweenInfo.new(0.7, Enum.EasingStyle.Cubic), {
        ["CFrame"] = v8.CFrame * CFrame.new(6, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
    }):Play()
    u2:Create(v8.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Cubic), {
        ["Transparency"] = 1
    }):Play()
    u2:Create(v8.Mesh, TweenInfo.new(0.7, Enum.EasingStyle.Cubic), {
        ["Scale"] = Vector3.new(0.554, 0.229, 0.211)
    }):Play()
    _G.destroy(v8, 0.7)
end
function v1.start(_, u10, p11, p12) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u6
        [4] = u9
    --]]
    if _G.checkRenderDistance(u10.PrimaryPart.Position) then
        local u13 = u10:GetPivot()
        if p11 == "swish" then
            local v14 = script.Missed:Clone()
            v14.CFrame = u10:GetPivot() * CFrame.new(0, -3, -1.5)
            v14.Parent = workspace.Effects
            u3(v14)
            _G.destroy(v14, 1.5)
        else
            local u15 = script.Dust:Clone()
            u15.Anchored = false
            local v16 = workspace.Effects
            local v17 = u10.PrimaryPart.CFrame
            u15.Parent = v16
            u15.CFrame = v17
            local v18 = Instance.new("WeldConstraint")
            local v19 = u10.PrimaryPart
            v18.Parent = u15
            v18.Part0 = u15
            v18.Part1 = v19
            local v20 = script.Moving:Clone()
            v20.CFrame = u10:GetPivot()
            v20.Parent = workspace.Effects
            u2:Create(v20, TweenInfo.new(p12, Enum.EasingStyle.Linear), {
                ["CFrame"] = u10:GetPivot() * CFrame.new(0, 0, -p11)
            }):Play()
            task.delay(p12, u6, v20)
            _G.destroy(v20, 1 + p12)
            _G.PlayEffect("RockFollow", nil, v20, 2, 2, nil, nil, nil, CFrame.new(0, 0, 1))
            task.spawn(function() --[[ Line: 149 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u13
                    [3] = u2
                --]]
                for _ = 1, 15 do
                    for v21 = -1, 1, 2 do
                        local u22 = script.Shockwave:Clone()
                        local v23 = (u10.PrimaryPart.Position - u13.Position).Magnitude
                        u22.CFrame = u13 * CFrame.new(v21 * 2, -1, -v23) * CFrame.Angles(0, -1.5707963267948966, 0)
                        u22.Transparency = 1
                        u22.Parent = workspace.Effects
                        u2:Create(u22, TweenInfo.new(0.1), {
                            ["Transparency"] = 0.7
                        }):Play()
                        task.delay(0.1, function() --[[ Line: 160 ]]
                            --[[
                            Upvalues:
                                [1] = u2
                                [2] = u22
                            --]]
                            u2:Create(u22, TweenInfo.new(0.35), {
                                ["Transparency"] = 1,
                                ["CFrame"] = u22.CFrame * CFrame.new(4, -2, 0),
                                ["Size"] = Vector3.new(18.009, 1.356, 0.05)
                            }):Play()
                        end)
                        _G.destroy(u22, 0.6)
                    end
                    task.wait(0.05)
                end
            end)
            local v24 = tick()
            local v25 = tick()
            local function v29(p26, p27) --[[ Line: 178 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                u15.Attachment.Rocks.Enabled = p26
                u15.Attachment.Smoke.Enabled = p26
                u15.Attachment2.Rocks.Enabled = p26
                u15.Attachment2.Smoke.Enabled = p26
                if p27 then
                    local v28 = ColorSequence.new(p27)
                    u15.Attachment.Rocks.Color = v28
                    u15.Attachment.Smoke.Color = v28
                    u15.Attachment2.Rocks.Color = v28
                    u15.Attachment2.Smoke.Color = v28
                end
            end
            while tick() - v24 < p12 do
                if v25 - tick() > 0.08333333333333333 then
                    v25 = tick()
                    u9(u10.PrimaryPart.CFrame * CFrame.new(0, 0, -2))
                end
                local v30 = _G.getRayFloor(u10.PrimaryPart.CFrame, 10)
                if v30 == nil then
                    u15.Attachment.Rocks.Enabled = false
                    u15.Attachment.Smoke.Enabled = false
                    u15.Attachment2.Rocks.Enabled = false
                    u15.Attachment2.Smoke.Enabled = false
                else
                    v29(true, v30.Color)
                end
                task.wait()
            end
            u6(u15)
            _G.destroy(u15, 2)
            task.wait(0.35)
            local v31 = script.Hiteffect:Clone()
            v31.CFrame = u10:GetPivot() * CFrame.new(2.25, -1.5, -1.25)
            v31.Parent = workspace.Effects
            u3(v31)
            _G.destroy(v31, 1.15)
            task.wait(0.1)
            local v32 = script.SlashHit:Clone()
            v32.CFrame = u10:GetPivot() * CFrame.new(0, 0, -2.5)
            v32.Parent = workspace.Effects
            u3(v32)
            _G.destroy(v32, 1.15)
            local u33 = script.Slash:Clone()
            u33.CFrame = u10.PrimaryPart.CFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(-1.5707963267948966, 3.141592653589793, 1.5707963267948966)
            u33.Parent = workspace.Effects
            u2:Create(u33, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {
                ["Position"] = (u33.CFrame * CFrame.new(-1, 0, 0)).Position
            }):Play()
            u2:Create(u33.Decal, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
                ["Transparency"] = 1
            }):Play()
            local u34 = script.WindSlash:Clone()
            u34.CFrame = u10.PrimaryPart.CFrame * CFrame.new(0, 0, -2.5) * CFrame.Angles(-1.5707963267948966, 3.141592653589793, 1.5707963267948966)
            u34.Parent = workspace.Effects
            u2:Create(u34, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {
                ["Position"] = (u34.CFrame * CFrame.new(-2, 0, 0)).Position
            }):Play()
            u2:Create(u34.Decal, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
                ["Transparency"] = 1
            }):Play()
            _G.destroy(u34, 0.8)
            _G.destroy(u33, 0.5)
            task.spawn(function() --[[ Line: 249 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u34
                --]]
                local v35 = tick()
                while tick() - v35 < 0.45 do
                    local v36 = u33
                    v36.CFrame = v36.CFrame * CFrame.Angles(0, -0.3665191429188092, 0)
                    local v37 = u34
                    v37.CFrame = v37.CFrame * CFrame.Angles(0, -0.20943951023931956, 0)
                    task.wait()
                end
            end)
        end
    else
        return
    end
end
return v1