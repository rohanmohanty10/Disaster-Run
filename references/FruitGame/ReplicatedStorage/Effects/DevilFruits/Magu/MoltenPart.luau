 

local v1 = {}
game:GetService("RunService")
local function u30(u2, u3) --[[ Line: 4 ]]
    for _ = 1, 5 do
        task.spawn(function() --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            local v4 = script.Parent.MaguBalls["Ball" .. math.random(1, 4)]:Clone()
            v4.Name = "moltenBall"
            v4.Size = Vector3.new(1, 1, 1)
            v4.Size = v4.Size * math.random(500, 700) / 1000
            local v5 = u2.Size.X / 2
            local v6 = u2.Size.Y / 2
            local v7 = u2.Size.Z / 2
            local v8 = v5 * 200
            local v9 = v6 * 100
            local v10 = v7 * 200
            local v11 = u2.CFrame * CFrame.new(math.random(-v8, v8) / 400, math.random(-v9, v9) / 100, math.random(-v10, v10) / 400)
            local v12 = CFrame.Angles
            local v13 = math.random(-360, 360)
            local v14 = math.rad(v13)
            local v15 = math.random(-360, 360)
            local v16 = math.rad(v15)
            local v17 = math.random(-360, 360)
            v4.CFrame = v11 * v12(v14, v16, (math.rad(v17)))
            local v18 = Instance.new("CFrameValue")
            v18.Value = u2.CFrame:Inverse() * v4.CFrame
            v18.Parent = v4
            v4.Anchored = true
            v4.Parent = workspace.Effects
            _G.customWeld(v4, u2, v18, v4)
            local v19 = u2.CFrame:Inverse() * (CFrame.new(v4.CFrame.Position) * CFrame.new(math.random(-1000, 1000) / 2250, 0, math.random(-1000, 1000) / 2250))
            local v20 = u2.CFrame:Inverse() * v4.CFrame
            local v21 = _G.tween
            local v22 = {
                5,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v23 = {}
            local v24 = CFrame.Angles
            local v25 = math.random(-360, 360)
            local v26 = math.rad(v25)
            local v27 = math.random(-360, 360)
            local v28 = math.rad(v27)
            local v29 = math.random(-360, 360)
            v23.Value = v19 * v24(v26, v28, (math.rad(v29)))
            v21(v18, v22, v23)
            _G.tween(v4, {
                3,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = v4.Size * math.random(150, 260) / 100
            })
            u3.Event:Wait()
            task.wait(math.random(10, 300) / 1000)
            _G.tween(v4, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0, 0, 0)
            })
            _G.tween(v18, {
                1,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Value"] = v20
            })
            _G.destroy({ v4, v18 }, 1)
        end)
    end
end
local u31 = require(script.Parent.Drip)
function v1.start(_, p32, u33, u34, u35) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u30
        [2] = u31
    --]]
    if p32 == nil then
        return
    elseif _G.checkRenderDistance(p32.PrimaryPart.Position, 300) ~= false then
        task.spawn(function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u33
                [3] = u30
                [4] = u35
                [5] = u31
            --]]
            local v36 = Instance.new("BindableEvent")
            v36.Parent = script
            if u34 == nil then
                u34 = Instance.new("NumberValue")
                u34.Parent = workspace.Effects
                _G.destroy(u34, 3)
            end
            for v37 = 1, #u33 do
                u30(u33[v37], v36)
            end
            local _ = u34.Parent
            local u38 = 0
            local u39 = 0
            repeat
                task.spawn(function() --[[ Line: 69 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u39
                        [3] = u35
                        [4] = u33
                        [5] = u31
                    --]]
                    if u39 <= tick() - u38 and (u35 == nil and u33) then
                        local v40 = u33
                        if typeof(v40) == "table" and #u33 > 0 then
                            local v41 = u33[math.random(1, #u33)]
                            u38 = tick()
                            u31:start(v41, { 100, 150 }, { 25, 35 }, 4)
                            u39 = math.random(300, 900) / 800
                        end
                    end
                end)
                task.wait(0.4)
            until u34 == nil or u34:IsDescendantOf(game) == false
            v36:Fire()
            v36:Destroy()
        end)
    end
end
return v1