 

local v1 = {}
local u2 = {}
require(game.ReplicatedStorage.Modules.BindToRender)
local u3 = require(game.ReplicatedStorage.Modules.TaskScheduler):CreateScheduler(25)
local u4 = CFrame.Angles(0, 0.08726646259971647, 0)
local u5 = CFrame.new(0, 75, 0)
function v1.start(_, _, p6, p7) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u8 = _G.awaitObject(p6)
    local v9 = u8:WaitForChild("Fist", 10)
    if _G.checkRenderDistance(v9.Position) ~= false then
        local v10 = u2
        table.insert(v10, { v9, u8, p7 })
        task.spawn(function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            local v11 = 0
            for _ = 1, 500 do
                if not u8 or (u8.Fist:FindFirstChild("BurningPart") == nil or u8.Fist.BurningPart.Enabled ~= true) then
                    break
                end
                if tick() - v11 >= 0.1 then
                    if u8.Fist2.Rocks.Color ~= ColorSequence.new(Color3.fromRGB(74, 99, 56)) then
                        u8.Fist2.Rocks:Emit(5)
                    end
                    u8.Fist2.sm2:SetAttribute("EmitCount", 10)
                    u8.Fist2.BurningPart:SetAttribute("EmitCount", 10)
                    _G.customEmit(u8.Fist2)
                    v11 = tick()
                end
                game["Run Service"].Heartbeat:Wait()
            end
        end)
    end
end
game["Run Service"].Heartbeat:Connect(function() --[[ Name: renderFunction, Line 41 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u5
    --]]
    for u12 = 1, #u2 do
        if u2[u12] and u2[u12] ~= nil then
            local v13 = u2[u12]
            if typeof(v13) == "table" then
                u3:QueueTask(function() --[[ Line: 44 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u12
                        [3] = u4
                        [4] = u5
                    --]]
                    if u2[u12] == nil then
                        return
                    else
                        local v14 = u2[u12]
                        local v15, v16, v17 = unpack(v14)
                        if v15 == nil or (v16 == nil or (not v15.Parent or (not v16.Parent or (not v16:FindFirstChild("Fist") or v16.Fist.BurningPart.Enabled ~= true)))) then
                            table.clear(u2[u12])
                            table.remove(u2, u12)
                            return
                        elseif _G.fastmodee ~= true or math.random(1, 2) ~= 1 then
                            v16:PivotTo(v16.PrimaryPart.CFrame * u4)
                            local v18 = Instance.new("Attachment")
                            v18.Parent = v15
                            local v19 = v18:Clone()
                            v19.Parent = v15
                            local v20 = script.Beam:Clone()
                            if v17 then
                                _G.PlayEffect("3SSRecolor", nil, v20, v17, "isRed")
                            end
                            v20.Parent = v15
                            local v21 = (v15.CFrame * u5).Position
                            local v22 = math.random(-50, 50)
                            local v23 = math.random(-50, 50)
                            local v24 = math.random
                            local v25 = v21 + Vector3.new(v22, v23, v24(-50, 50))
                            v20.Width0 = math.random(30, 40)
                            v20.Attachment0 = v18
                            v20.Attachment1 = v19
                            _G.tween(v19, {
                                0.25,
                                Enum.EasingStyle.Exponential,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["WorldPosition"] = v25
                            })
                            _G.tween(v20, {
                                0.25,
                                Enum.EasingStyle.Quad,
                                Enum.EasingDirection.Out,
                                0,
                                false,
                                0
                            }, {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            })
                            _G.destroy(v20, 0.25)
                        end
                    end
                end)
            end
        end
    end
end)
return v1