 

local u1 = game:GetService("RunService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local _ = _G.Ess
local u2 = require(game.ReplicatedStorage.Modules.Bezier)
return {
    ["start"] = function(_, u3, p4, p5, u6) --[[ Name: start, Line 15 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if _G.checkRenderDistance(u3.PrimaryPart.Position) ~= false then
            local u7 = Random.new()
            local u8 = u3.PrimaryPart
            local v9 = u3.Humanoid
            local v10 = v9.Animator:LoadAnimation(script.Anims.Travel)
            local u11 = v9.Animator:LoadAnimation(script.Anims.TravelEnd)
            _G.transparentCharacter(u3)
            v10:Play()
            local u12 = CFrame.new(p4, p5)
            local u13 = CFrame.new(p5, p4) * CFrame.Angles(0, 3.141592653589793, 0)
            local u14 = (p5 - p4).Magnitude
            local u15 = 0
            local v16 = script.StartBurst:Clone()
            local u17 = script.EndBurst:Clone()
            v16.CFrame = u12 - Vector3.new(0, 2, 0)
            u17.Position = u13.Position - Vector3.new(0, 3, 0)
            v16.Parent = workspace.Effects
            u17.Parent = workspace.Effects
            Emit(v16:GetDescendants(), false, 0.9)
            _G.destroy(v16, 1.7000000000000002)
            if u3 == game.Players.LocalPlayer.Character then
                u3:PivotTo(u12)
                u8.Anchored = true
            end
            _G.PlaySound(u3.PrimaryPart, script.YukiFlyStart, {
                ["Pitch"] = math.random(90, 110) / 100
            })
            task.delay(0.9, function() --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u8
                    [3] = u6
                    [4] = u13
                    [5] = u11
                --]]
                if u3 == game.Players.LocalPlayer.Character then
                    TweenCreate(u8, TweenInfo.new(u6, Enum.EasingStyle.Linear), {
                        ["CFrame"] = u13 - Vector3.new(0, 0.6, 0)
                    })
                end
                task.wait(u6)
                u11:Play()
                task.delay(0.3, function() --[[ Line: 84 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    u8.Anchored = false
                end)
                _G.transparentCharacter(u3, true)
            end)
            task.spawn(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u13
                    [3] = u7
                    [4] = u14
                    [5] = u2
                    [6] = u1
                    [7] = u6
                    [8] = u15
                    [9] = u17
                --]]
                for _ = 1, 6 do
                    local u18 = script.Snow:Clone()
                    u18.CFrame = u12
                    u18.Parent = workspace.Effects
                    _G.PlaySound(u18, script.YukiFlyBodySplit, {
                        ["Pitch"] = math.random(90, 150) / 100
                    })
                    local v19 = u13
                    local v20 = u12
                    local v21 = u12:Lerp(v19, 0.5) * CFrame.Angles(0, u7:NextInteger(45, 135), 0)
                    local v22 = CFrame.new
                    local v23 = (u14 * 1.5 + 20) ^ 0.5
                    local v24 = (u14 / 150 * 2) ^ 4 / 2
                    local v25 = v22(v23, math.abs(v24), 0)
                    local v26 = u14 ^ 0.5 / 1.5 + 5
                    local v27 = math.clamp(v26, 0, 30)
                    local v28 = v21 * (v25 + Vector3.new(0, v27, 0))
                    local v29 = v28 * CFrame.new(0, u7:NextNumber(-10, 10) * 0, 0) + u7:NextUnitVector() * 10
                    local u30 = nil
                    local u31 = u2.new(v20.Position, v28.Position, v29.Position, v19.Position)
                    local u32 = v20.Position
                    local u33 = nil
                    u18.CFrame = u12
                    local u34 = tick()
                    u30 = u1.Heartbeat:Connect(function() --[[ Line: 126 ]]
                        --[[
                        Upvalues:
                            [1] = u34
                            [2] = u6
                            [3] = u33
                            [4] = u31
                            [5] = u32
                            [6] = u18
                            [7] = u15
                            [8] = u30
                            [9] = u17
                        --]]
                        local v35 = (tick() - u34) / u6
                        u33 = u31:Get(v35, 1)
                        u18.CFrame = CFrame.new(u32, u33)
                        if v35 >= 1 then
                            u15 = u15 + 1
                            u30:Disconnect()
                            u30 = nil
                            Emit(u17:GetDescendants(), true)
                            Emit(u18:GetDescendants(), false)
                            _G.PlaySound(u18, script.YukiFlyBodyReform, {
                                ["Pitch"] = math.random(90, 150) / 100
                            })
                            _G.destroy(u18, 0.8)
                        end
                        u32 = u33
                    end)
                    task.wait(0.15)
                end
            end)
            repeat
                task.wait()
            until u15 >= 1
            task.wait(0.25)
            Emit(u17:GetDescendants(), false, 0.9)
            _G.destroy(u17, u6 + 1.5)
        end
    end
}