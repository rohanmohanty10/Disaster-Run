 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Maid)
local u3 = game:GetService("TweenService")
local u4 = game["Run Service"]
function v1.start(_, p5, p6, p7) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if p5 == nil then
        return
    elseif _G.checkRenderDistance(p5.PrimaryPart.Position) ~= false then
        local _ = p5.PrimaryPart
        local _ = p5.Humanoid.Animator
        local u8 = RaycastParams.new()
        u8.FilterDescendantsInstances = _G.getTargetsWithENV(p5)
        u8.FilterType = Enum.RaycastFilterType.Include
        if p6 == "shoot" then
            local u9 = Instance.new("Model")
            u9.Parent = workspace.Effects
            local u10 = p5:GetAttribute("FlameMode") and script.Flame or script.Base
            local u11 = u2.new()
            local u12 = u2.new()
            tick()
            local u13 = u10.Meteor:Clone()
            u13:PivotTo(p7)
            local u14 = u13.PrimaryPart
            local u15 = nil
            local u16 = 0
            local u17 = {}
            local u18 = {}
            for _, v19 in u13:GetDescendants() do
                if v19:IsA("ParticleEmitter") then
                    v19.Enabled = true
                end
            end
            u13.Parent = u9
            _G.PlaySound(u13.PrimaryPart, u10["PteranMeteorShoot" .. math.random(1, 3)]).Parent = u13.PrimaryPart
            local v20 = u10.Emit:Clone()
            v20.CFrame = u14.CFrame
            v20.Parent = u9
            _G.destroy(v20, 5)
            _G.particleEnabled(v20, false)
            _G.customEmit(v20)
            local u21 = {
                ["Part"] = u14,
                ["Acceleration"] = Vector3.new(0, 0, 0),
                ["VelocityThreshold"] = 10,
                ["Gravity"] = Vector3.new(0, -65, 0),
                ["Duration"] = 10,
                ["Velocity"] = u14.CFrame.LookVector * 225
            }
            local u22 = nil
            local function u27(p23) --[[ Line: 121 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u14
                    [3] = u13
                    [4] = u3
                    [5] = u10
                    [6] = u9
                    [7] = u18
                    [8] = u11
                    [9] = u12
                    [10] = u15
                --]]
                if not u22 then
                    u22 = true
                    u14.CFrame = CFrame.new(p23.Position, u14.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                    for _, v24 in u13:GetDescendants() do
                        if v24:IsA("ParticleEmitter") or v24:IsA("Trail") then
                            v24.Enabled = false
                        elseif v24:IsA("BasePart") then
                            v24.Transparency = 1
                        elseif v24:IsA("Beam") then
                            u3:Create(v24, TweenInfo.new(0.5), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        elseif v24:IsA("PointLight") then
                            u3:Create(v24, TweenInfo.new(0.5), {
                                ["Brightness"] = 0
                            }):Play()
                        end
                    end
                    local v25 = u10.Explode:Clone()
                    v25.CFrame = p23 and CFrame.new(p23.Position, p23.Position + p23.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v25.Size.Y / 2 + 0.02, 0) or CFrame.new(u14.Position)
                    v25.CFrame = v25.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
                    v25.Parent = u9
                    _G.destroy(v25, 5)
                    for _, v26 in v25:GetDescendants() do
                        if v26:IsA("ParticleEmitter") then
                            _G.customEmit(v26)
                            v26.Enabled = false
                        elseif v26:IsA("PointLight") then
                            u3:Create(v26, TweenInfo.new(1.4), {
                                ["Range"] = v26.Range * 1.3,
                                ["Brightness"] = 0
                            }):Play()
                        end
                    end
                    _G.PlaySound(v25, u10["PteranMeteorBoom" .. math.random(1, 3)])
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 2,
                        ["RandomVelocityMagnitude"] = Vector2.new(-75, 75),
                        ["Position"] = v25.Position + Vector3.new(0, 1, 0),
                        ["Direction"] = v25.CFrame.UpVector * 15,
                        ["RaycastDirection"] = v25.CFrame.UpVector * -30,
                        ["Size"] = Vector3.new(0.7, 0.7, 0.7),
                        ["TrailEnabled"] = true,
                        ["Color"] = Color3.fromRGB(51, 58, 67),
                        ["Material"] = Enum.Material.Slate
                    }, true)
                    for _, _ in u18 do
                        _G.particleEnabled(u18, false)
                    end
                    u11:Destroy()
                    u12:Destroy()
                    u15 = true
                    task.wait(3)
                    _G.destroy(u9, 4)
                end
            end
            u12:AddTask(u4.Heartbeat:Connect(function(p28) --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u17
                    [3] = u15
                    [4] = u18
                    [5] = u14
                    [6] = u13
                --]]
                u16 = u16 + 1 * p28
                for _, v29 in u17 do
                    local v30 = v29.CFrame
                    local v31 = CFrame.Angles
                    local v32 = 1650 * p28
                    v29.CFrame = v30 * v31(0, math.rad(v32), 0)
                end
                if not u15 then
                    for v33, v34 in u18 do
                        local v35 = u14.CFrame
                        local v36 = CFrame.Angles
                        local v37 = v33 * 180 + u16 * 450
                        v34.CFrame = v35 * v36(1.5707963267948966, math.rad(v37), 0) * CFrame.new(0, 15, -3)
                    end
                    local v38 = u13.PrimaryPart.Meteor
                    local v39 = u14.CFrame
                    local v40 = CFrame.Angles
                    local v41 = u16 * 800
                    local v42 = math.rad(v41)
                    local v43 = u16 * 450
                    local v44 = math.rad(v43)
                    local v45 = u16 * 450
                    v38.CFrame = v39 * v40(v42, v44, (math.rad(v45)))
                end
            end))
            u11:AddTask(u4.Heartbeat:Connect(function(p46) --[[ Line: 222 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u8
                    [3] = u27
                    [4] = u14
                --]]
                local v47 = u21
                v47.Duration = v47.Duration - p46
                local v48 = u21
                v48.Acceleration = v48.Acceleration + u21.Gravity * p46
                local v49 = u21
                v49.Velocity = v49.Velocity + u21.Acceleration * p46
                local v50 = u21.Velocity.Unit
                local v51 = u21.Velocity.Magnitude
                local v52 = u21.VelocityThreshold
                local v53 = math.max(v51, v52) * p46
                local v54 = workspace:Raycast(u21.Part.Position, v50 * v53, u8)
                if u21.Duration <= 0 then
                    u27({
                        ["HitPart"] = u14,
                        ["Position"] = u14.Position,
                        ["Normal"] = Vector3.new(0, 1, 0)
                    })
                    return
                elseif v54 then
                    u27({
                        ["HitPart"] = v54.Instance,
                        ["Position"] = v54.Position,
                        ["Normal"] = v54.Normal
                    })
                else
                    u21.Part:PivotTo(CFrame.new(u21.Part.Position, u21.Part.Position + v50) + v50 * v53)
                end
            end))
        end
    end
end
return v1