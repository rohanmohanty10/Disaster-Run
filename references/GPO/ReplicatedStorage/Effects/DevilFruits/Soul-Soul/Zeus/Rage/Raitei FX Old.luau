 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
local u2 = game:GetService("RunService")
local u3 = Random.new()
require(script.Parent.Shared)
local u4 = script.VFX
local v5 = RaycastParams.new()
v5.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v5.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p6) --[[ Name: start, Line 20 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u3
            [4] = u1
        --]]
        local v7 = p6.Zeus
        local v8 = p6.Character
        local v9 = p6.Detect
        local v10 = p6.StartPosition
        local v11 = p6.Speed
        local v12 = p6.Modifier
        local v13 = v8.HumanoidRootPart
        local v14 = v8:FindFirstChild("Humanoid")
        local v15 = v8.PrimaryPart
        local v16 = not (v14 and v15) and 3 or v14.HipHeight + v15.Size.Y / 2
        local v17 = v9.Position + v9.Normal * v16
        local v18 = u4.Trail:Clone()
        v18:PivotTo(v13.CFrame)
        v18.Parent = workspace.Effects
        local v19 = Instance.new("BodyVelocity")
        v19.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
        v19.Parent = v13
        _G.PlaySound(v8.PrimaryPart, script.SoulZeusLeapSlamJump).Parent = v8.PrimaryPart
        local v20 = false
        local v21 = 0
        while true do
            if v20 == false and v21 >= 0.95 then
                v8.Humanoid:LoadAnimation(script.charLand):Play(0)
                v7.RageModel.AnimationController:LoadAnimation(script.soulLand):Play(0)
                v20 = true
            end
            if v21 >= 1 then
                v19:Destroy()
                _G.particleEnabled(v18, false)
                _G.destroy(v18, 3)
                local u22 = u4.Strike:Clone()
                u22.CFrame = v9 and CFrame.new(v9.Position, v9.Position + v9.Normal) * CFrame.Angles(-1.5707963267948966, 0.00017453292519943296, 0.00017453292519943296) * CFrame.new(0, 0.01, 0) or CFrame.new(v13.Position)
                u22.CFrame = u22.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
                if v9 and v9.HitPart ~= nil then
                    _G.recolorParticles(u22, v9.Color)
                else
                    u22.Attachment.Rocks:Destroy()
                    u22.Attachment.Realistic:Destroy()
                    u22.Attachment.Realistic2:Destroy()
                end
                u22.Parent = workspace.Effects
                _G.PlaySound(u22.CFrame, script.SoulZeusLeapSlamBoom)
                if v9.HitPart ~= nil then
                    local v23 = CFrame.new(v9.Position, v9.Position + v9.Normal) * CFrame.new(0, 0, -1.1) * CFrame.Angles(-1.5690509975429023, 0, 0)
                    local v24 = v23.Position
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 20,
                        ["Position"] = v24 + Vector3.new(0, 2, 0),
                        ["DistanceRandomness"] = Vector2.new(0.5, 1),
                        ["Duration"] = 4,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 25,
                        ["Direction"] = -v9.Normal * 45,
                        ["Angle"] = -0.6108652381980153
                    })
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 10,
                        ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
                        ["Position"] = v24,
                        ["Direction"] = Vector3.new(0, 15, 0),
                        ["RaycastDirection"] = -v9.Normal * 15,
                        ["Size"] = Vector3.new(0.8, 0.8, 0.8),
                        ["TrailEnabled"] = true
                    })
                    _G.shakenear(v23.Position, 175, 100, 75, -1)
                end
                task.spawn(function() --[[ Line: 136 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u3
                    --]]
                    local v25 = u22.CFrame
                    local v26 = 25
                    for _ = 1, 6 do
                        local v27 = _G.PlayEffect
                        local v28 = {
                            ["StartPosition"] = v25.Position
                        }
                        local v29 = v25.Position
                        local v30 = u3:NextNumber(-v26, v26)
                        local v31 = u3:NextNumber(v26 / 4, v26 / 2)
                        local v32 = u3
                        local v33 = -v26
                        v28.EndPosition = v29 + Vector3.new(v30, v31, v32:NextNumber(v33, v26))
                        v28.Points = 5
                        v28.Size = u3:NextNumber(1.5, 3)
                        v28.Branches = true
                        v28.RandomSize = NumberRange.new(0.15, 1)
                        v28.Offset = NumberRange.new(15, 25)
                        v28.MainColor = Color3.fromRGB(255, 255, 255)
                        v28.GlowColor = Color3.fromRGB(151, 65, 255)
                        v28.LightningDuration = math.random(100, 200) / 2000
                        function v28.WaitFunction(p34, _) --[[ Line: 154 ]]
                            if p34 % 2 == 0 then
                                task.wait(math.random(100, 300) / 10000)
                            end
                        end
                        v27("DeadLightning", nil, v28)
                        v26 = v26 + 3
                        task.wait(0.05)
                    end
                end)
                u1:Create(u22.PointLight, TweenInfo.new(1), {
                    ["Range"] = 100,
                    ["Brightness"] = 0
                }):Play()
                _G.customEmit(u22)
                _G.destroy(u22, 5)
                return
            end
            local _, v35 = u2.Stepped:Wait()
            local v36 = v21 + v35 * v11
            v21 = math.clamp(v36, 0, 1)
            local v37 = (1 - v21) * (1 - v21) * v10 + 2 * (1 - v21) * v21 * v12 + v21 * v21 * v17
            local v38 = v21 + 0.01
            local v39 = (1 - v38) * (1 - v38) * v10 + 2 * (1 - v38) * v38 * v12 + v38 * v38 * v17
            v8.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            v8:PivotTo(CFrame.new(v37, v39))
            v13.Velocity = Vector3.new(0, 0, 0)
            v18:PivotTo(v13.CFrame)
        end
    end
}