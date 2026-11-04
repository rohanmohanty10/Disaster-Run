 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function v1.start(_, p2) --[[ Line: 5 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) == false then
        return
    elseif p2:findFirstChild("LeftLowerLeg") ~= nil then
        local v3 = script:WaitForChild("Legs"):GetChildren()
        local u4 = Random.new()
        local v5
        if p2.Humanoid:findFirstChild("BodyHeightScale") then
            local v6 = p2.Humanoid.BodyWidthScale.Value
            local v7 = p2.Humanoid.BodyHeightScale.Value
            local v8 = p2.Humanoid.BodyDepthScale.Value
            v5 = Vector3.new(v6, v7, v8)
        else
            v5 = 1
        end
        for _, v9 in next, v3 do
            local u10 = v9:Clone()
            _G.scaleModel(u10, v5)
            u10:PivotTo(p2[u10.Name .. "LowerLeg"].CFrame * CFrame.new(0, 0.5, 0))
            u10.Parent = workspace.Effects
            _G.customWeld(u10.PrimaryPart, p2[u10.Name .. "LowerLeg"], CFrame.new(), u10)
            _G.destroy(u10, 5)
            task.spawn(function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u4
                --]]
                local v11 = next
                local v12, v13 = u10:GetChildren()
                for v14, u15 in v11, v12, v13 do
                    if u15:IsA("BasePart") then
                        local v16 = u15.Size
                        u15.Size = Vector3.new(0, 0, 0)
                        local v17 = u15:Clone()
                        v17.Parent = workspace.Effects
                        v17.Material = Enum.Material.Neon
                        v17.Transparency = -1.5
                        _G.tween(v17, { 0.125, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = v16 * 1.05,
                            ["Transparency"] = 1
                        })
                        _G.tween(u15, { 0.125, "Cubic", Enum.EasingDirection.Out }, {
                            ["Size"] = v16
                        })
                        _G.destroy(v17, 0.125)
                        task.delay(1.5 + 0.35 * v14, function() --[[ Line: 47 ]]
                            --[[
                            Upvalues:
                                [1] = u15
                                [2] = u4
                            --]]
                            local v18 = script:WaitForChild("UnFreeze"):Clone()
                            v18.Parent = u15
                            _G.customEmit(v18)
                            _G.destroy(v18, 0.75)
                            local v19 = Instance.new("BodyAngularVelocity")
                            local v20 = Instance.new("BodyVelocity")
                            local v21 = u4:NextUnitVector() * 10
                            v19.MaxTorque = Vector3.new(25000000, 25000000, 25000000)
                            v19.AngularVelocity = v21
                            v19.P = 1250
                            local v22 = u4:NextNumber(-1, 1)
                            local v23 = u4:NextNumber(0.25, 1)
                            local v24 = u4
                            v20.Velocity = Vector3.new(v22, v23, v24:NextNumber(-1, 1)) * 12.5
                            v20.MaxForce = Vector3.new(50000000, 50000000, 50000000)
                            local v25 = u15
                            v20.Parent = u15
                            v19.Parent = v25
                            _G.destroy(v20, 0.075)
                            _G.tween(u15, { 0.75, "Cubic", Enum.EasingDirection.Out }, {
                                ["Size"] = Vector3.new(0, 0, 0)
                            })
                        end)
                    end
                end
            end)
        end
    end
end
return v1