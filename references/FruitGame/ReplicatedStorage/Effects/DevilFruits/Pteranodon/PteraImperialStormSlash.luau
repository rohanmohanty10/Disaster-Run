 

local u1 = game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u2 = game:GetService("TweenService")
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
return {
    ["start"] = function(_, p4) --[[ Name: start, Line 24 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local u5 = p4.Character
        local _ = u5.HumanoidRootPart
        if u5 == nil then
            return
        elseif _G.checkRenderDistance(u5.PrimaryPart.Position) ~= false then
            local u6 = RaycastParams.new()
            u6.FilterDescendantsInstances = _G.getTargetsWithENV(u5)
            u6.FilterType = Enum.RaycastFilterType.Include
            local v7 = p4.Int
            local u8 = u5:GetAttribute("FlameMode") and script.Flame or script.Base
            local u9 = u3.new()
            local u10 = u3.new()
            tick()
            local v11 = CFrame.Angles
            local v12 = v7 % 2 == 0 and Random.new():NextNumber(28, 45) or -Random.new():NextNumber(28, 45)
            local u13 = v11(0, 0, (math.rad(v12)))
            local u14 = u8.Slash:Clone()
            local u15 = u14.PrimaryPart
            u14:PivotTo(p4.StartCFrame)
            local u16 = nil
            for _, v17 in u14:GetDescendants() do
                if v17:IsA("ParticleEmitter") or v17:IsA("Trail") then
                    v17.Enabled = true
                end
            end
            local u18 = _G.PlaySound(u14.PrimaryPart, u8["PteranWingSlashesShoot" .. math.random(1, 3)], {
                ["Pitch"] = math.random(90, 110) / 100
            })
            u18.Parent = u14.PrimaryPart
            u14:ScaleTo(0.01)
            task.spawn(function() --[[ Line: 62 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                local v19 = tick()
                while true do
                    local v20 = (tick() - v19) * 4
                    u14:ScaleTo((math.clamp(v20, 0.01, 1)))
                    if v20 >= 1 then
                        break
                    end
                    task.wait()
                end
            end)
            u14.Parent = workspace.Effects
            _G.PlaySound(u14.PrimaryPart, u8["PteranWingSlashesShoot" .. math.random(1, 3)], {
                ["Pitch"] = math.random(90, 110) / 100,
                ["Volume"] = 0.25
            })
            _G.destroy(u14, 3)
            local v21 = u8.Emit:Clone()
            v21.CFrame = u15.CFrame
            v21.CFrame = v21.CFrame:Lerp(CFrame.new(v21.Position, u15.CFrame * CFrame.new(0, 0, -15).Position), 0.2) * CFrame.new(0, 0, -7)
            v21.Parent = workspace.Effects
            _G.destroy(v21, 5)
            _G.customEmit(v21)
            _G.particleEnabled(v21, false)
            local u22 = {
                ["Part"] = u15,
                ["Part2"] = u15.Extra_Fx,
                ["Acceleration"] = Vector3.new(0, 0, 0),
                ["VelocityThreshold"] = 10,
                ["Gravity"] = Vector3.new(0, -1, 0),
                ["Duration"] = 10,
                ["Velocity"] = u15.CFrame.LookVector * 250
            }
            local u23 = nil
            local function u28(p24) --[[ Line: 105 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u15
                    [3] = u14
                    [4] = u2
                    [5] = u8
                    [6] = u16
                    [7] = u18
                    [8] = u9
                    [9] = u10
                --]]
                if not u23 then
                    u23 = true
                    u15.CFrame = CFrame.new(p24.Position, u15.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    for _, v25 in u14:GetDescendants() do
                        if v25:IsA("ParticleEmitter") or v25:IsA("Trail") then
                            v25.Enabled = false
                        elseif v25:IsA("BasePart") then
                            u2:Create(v25, TweenInfo.new(0.5), {
                                ["Size"] = v25.Size * 1.25,
                                ["Transparency"] = 1
                            }):Play()
                        elseif v25:IsA("Beam") then
                            v25.Width0 = 0
                            v25.Width1 = 0
                        elseif v25:IsA("PointLight") then
                            u2:Create(v25, TweenInfo.new(1), {
                                ["Brightness"] = 0
                            }):Play()
                        end
                    end
                    local v26 = u8.Explode:Clone()
                    v26.CFrame = p24 and CFrame.new(p24.Position, p24.Position + p24.Normal) * CFrame.new(0, v26.Size.Y / 2 + 0.02, 0) or CFrame.new(u15.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                    if p24.HitPart ~= nil then
                        _G.recolorParticles(v26, p24.HitPart.Color)
                    end
                    v26.Parent = workspace.Effects
                    _G.destroy(v26, 5)
                    _G.customEmit(v26)
                    for _, v27 in v26:GetDescendants() do
                        if v27:IsA("ParticleEmitter") then
                            v27.Enabled = false
                        elseif v27:IsA("PointLight") then
                            u2:Create(v27, TweenInfo.new(1.4), {
                                ["Range"] = 0
                            }):Play()
                        end
                    end
                    u16 = true
                    _G.PlaySound(v26, u8["PteranWingSlashesBoom" .. math.random(1, 3)])
                    if u18 then
                        _G.tween(u18, {
                            0.1,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                    end
                    u9:Destroy()
                    task.wait(3)
                    u10:Destroy()
                end
            end
            u9:AddTask(u1.Heartbeat:Connect(function(p29) --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u22
                    [3] = u6
                    [4] = u28
                    [5] = u15
                    [6] = u5
                    [7] = u13
                --]]
                if u23 then
                    return
                else
                    local v30 = u22
                    v30.Duration = v30.Duration - p29
                    local v31 = u22
                    v31.Acceleration = v31.Acceleration + u22.Gravity * p29
                    local v32 = u22
                    v32.Velocity = v32.Velocity + u22.Acceleration * p29
                    local v33 = u22.Velocity.Unit
                    local v34 = u22.Velocity.Magnitude
                    local v35 = u22.VelocityThreshold
                    local v36 = math.max(v34, v35) * p29
                    local v37 = workspace:Raycast(u22.Part.Position, v33 * v36, u6)
                    if u22.Duration <= 0 then
                        u28({
                            ["HitPart"] = u15,
                            ["Position"] = u15.Position,
                            ["Normal"] = Vector3.new(0, 1, 0)
                        })
                        return
                    elseif v37 then
                        if not v37.Instance:IsDescendantOf(u5) then
                            u28({
                                ["HitPart"] = v37.Instance,
                                ["Position"] = v37.Position,
                                ["Normal"] = v37.Normal
                            })
                        end
                    else
                        local v38 = u22.Part.Position
                        local v39 = CFrame.new(v38, v38 + v33) * u13
                        u22.Part.CFrame = v39 * CFrame.new(0, 0, -v36)
                    end
                end
            end))
        end
    end
}