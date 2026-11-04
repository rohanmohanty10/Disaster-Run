 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
return {
    ["start"] = function(_, u2, _) --[[ Name: start, Line 12 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(u2.PrimaryPart.Position) == false then
            return
        else
            local u3 = Random.new()
            u2:FindFirstChild("Humanoid")
            local u4 = u2.PrimaryPart
            local v5 = u4.CFrame
            local v6 = u2:FindFirstChild("RightLowerLeg")
            u2:FindFirstChild("RightFoot")
            local u7 = script.Transform.Flame:Clone()
            local u8 = script.Transform.TalonRF:Clone()
            u7.RigidConstraint.Attachment1 = v6:FindFirstChild("RightAnkleRigAttachment")
            u7.CFrame = v6.CFrame * CFrame.new(0, -1, 0)
            u7.Parent = workspace.Effects
            u8.Parent = workspace.Effects
            tick()
            local u9 = tick()
            local u10 = nil
            local u11 = {}
            local u12 = script["Wind Rush"]:Clone()
            u12.CFrame = v5 * CFrame.new(0, -2.8, -5)
            u12.Parent = workspace.Effects
            local u13 = script["Rush Big"]:Clone()
            u13.CFrame = v5 * CFrame.new(0, 0, 1.75)
            local u14 = script.Kick:Clone()
            u14.Parent = workspace.Effects
            _G.PlaySound(u2.PrimaryPart, script.TalonBarrageStart)
            task.wait(0.1)
            local u15 = script.TalonBarrageLoop:Clone()
            u15.Parent = u2.PrimaryPart
            u15:Play()
            task.wait(0.166)
            Emit(u13, false)
            Emit(u12, false)
            local function u20() --[[ Line: 90 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u13
                    [3] = u12
                    [4] = u14
                    [5] = u10
                    [6] = u8
                    [7] = u7
                    [8] = u11
                    [9] = u15
                --]]
                if u2:GetAttribute("HoldingE") ~= true then
                    Emit(u13, false)
                    Emit(u12, false)
                    Emit(u14:GetDescendants(), false)
                    _G.destroy(u12, 3)
                    local v16 = { u10, u8, u7 }
                    Ess.Destroy(v16, 0)
                    local v17 = Ess.Destroy
                    local v18 = {}
                    local v19 = u11
                    __set_list(v18, 1, {u13, unpack(v19), u14})
                    v17(v18, 0.6)
                    u15:Destroy()
                end
            end
            u10 = u1.Stepped:Connect(function() --[[ Line: 104 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u20
                    [3] = u4
                    [4] = u12
                    [5] = u9
                    [6] = u14
                    [7] = u3
                --]]
                if u2.PrimaryPart == nil then
                    u20()
                else
                    tick()
                    local v21 = tick()
                    local v22 = (u4.CFrame + u4.CFrame.LookVector * 2) * CFrame.new(-0.3, -0.7, 0)
                    local v23 = v22.LookVector + u4.CFrame.LookVector * 4
                    u12.CFrame = u4.CFrame * CFrame.new(0, -2.8, -1)
                    if v21 - u9 > 0.01 then
                        u9 = tick()
                        local v24, _, _ = _G.getRayFloor(u2.PrimaryPart.CFrame, 9)
                        if v24 == nil then
                            u12.Debris.Transparency = NumberSequence.new(1)
                        else
                            u12.Debris.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0) })
                            u12.Debris.Color = ColorSequence.new(v24.Color)
                        end
                        u14.CFrame = CFrame.new(v22.Position, v22.Position + v23 + u3:NextUnitVector() * 3) * CFrame.Angles(0.08726646259971647, 0, 0)
                        local _ = u14.CFrame
                    end
                end
            end)
            if u2:GetAttribute("HoldingE") == nil then
                u20()
            else
                u2:GetAttributeChangedSignal("HoldingE"):Once(u20)
            end
        end
    end
}