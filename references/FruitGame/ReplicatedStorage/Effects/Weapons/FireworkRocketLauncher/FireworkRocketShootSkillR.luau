 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("RunService")
game:GetService("TweenService")
local u2 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u3 = script.Parent["Rocket Launcher Firework Assets"]
return {
    ["start"] = function(_, _, _, p4, p5, p6) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        if _G.checkRenderDistance(p4.Position) ~= false then
            local v7 = OverlapParams.new()
            v7.FilterType = Enum.RaycastFilterType.Exclude
            v7.FilterDescendantsInstances = { workspace.Effects, p5.Character }
            local v8 = Instance.new("Part")
            v8.CanCollide = false
            v8.Anchored = true
            v8.Transparency = 0.5
            v8.Color = Color3.fromRGB(255, 100, 100)
            v8.Name = "GrabHitbox"
            v8.Size = Vector3.new(5, 5, 5)
            v8.CFrame = p5.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.5)
            v8.Parent = workspace.Effects
            _G.destroy(v8, 1)
            local v9 = workspace:GetPartsInPart(v8, v7)
            if #v9 > 0 then
                for _, v10 in v9 do
                    if v10.Parent:FindFirstChild("Humanoid") then
                        local u11 = v10.Parent
                        local v12 = Instance.new("Part")
                        v12.Name = "MiddlePart"
                        v12.Anchored = false
                        v12.CanCollide = false
                        v12.Size = Vector3.new(1, 1, 1)
                        v12.Transparency = 1
                        v12.CFrame = p5.Character.HumanoidRootPart.CFrame
                        v12.Parent = p5.Character.HumanoidRootPart
                        p5.Character.Humanoid.AutoRotate = false
                        p5.Character.Humanoid.WalkSpeed = 0
                        p5.Character.Humanoid.JumpPower = 0
                        local v13 = Instance.new("Weld")
                        v13.Name = "MiddleWeld"
                        v13.Part0 = p5.Character.HumanoidRootPart
                        v13.Part1 = v12
                        v13.Parent = v12
                        local v14 = Instance.new("Motor6D")
                        v14.Name = "GrabWeld"
                        v14.Part0 = v12
                        v14.Part1 = u11:FindFirstChild("HumanoidRootPart")
                        v14.C0 = CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0)
                        v14.Parent = v12
                        task.wait(0.5)
                        _G.customEmit(p4)
                        local v15
                        if p6 == false then
                            v15 = u3.RocketExplosion:Clone()
                        else
                            v15 = u3.PrestigeRocketExplosion:Clone()
                        end
                        u2.apply(v15, p5.Character)
                        v15.CFrame = u11.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
                        v15.Parent = workspace.Effects
                        _G.customEmit(v15)
                        _G.destroy(v15, 5)
                        _G.destroy(v12)
                        p5.Character.Humanoid.AutoRotate = true
                        p5.Character.Humanoid.WalkSpeed = 16
                        p5.Character.Humanoid.JumpPower = 50
                        u11.Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
                        local v16 = Instance.new("BodyAngularVelocity")
                        v16.P = 50000
                        local v17 = math.random(20, 50)
                        local v18 = math.random
                        v16.AngularVelocity = Vector3.new(v17, v18(20, 50))
                        v16.MaxTorque = Vector3.new(50000, 50000, 50000)
                        v16.Parent = u11.HumanoidRootPart
                        _G.destroy(v16, 0.25)
                        local v19 = Instance.new("BodyVelocity")
                        v19.MaxForce = Vector3.new(500000, 50000, 500000)
                        v19.P = 50000
                        v19.Velocity = p5.Character.HumanoidRootPart.CFrame.LookVector * 100 + Vector3.new(0, 50, 0)
                        v19.Parent = u11.HumanoidRootPart
                        _G.destroy(v19, 0.1)
                        local u20
                        if p6 == false then
                            u20 = u3.SmokeTrail:Clone()
                        else
                            u20 = u3.PrestigeSmokeTrail:Clone()
                        end
                        u2.apply(u20, p5.Character)
                        u20.CFrame = u11.UpperTorso.CFrame
                        u20.BlackSmoke.Enabled = true
                        u20.FireSpecs.Enabled = true
                        u20.Fire.Enabled = true
                        u20.Parent = workspace.Effects
                        local v21 = Instance.new("Weld")
                        v21.Part0 = u11.UpperTorso
                        v21.Part1 = u20
                        v21.Parent = u20
                        task.wait(0.5)
                        local u22 = nil
                        u22 = u1.RenderStepped:Connect(function() --[[ Line: 121 ]]
                            --[[
                            Upvalues:
                                [1] = u11
                                [2] = u20
                                [3] = u22
                                [4] = u1
                            --]]
                            if u11.HumanoidRootPart.AssemblyLinearVelocity.Magnitude <= 25 then
                                u20.BlackSmoke.Enabled = false
                                u20.FireSpecs.Enabled = false
                                u20.Fire.Enabled = false
                                _G.destroy(u20, 5)
                                u22:Disconnect()
                            end
                            u1.RenderStepped:Wait()
                        end)
                        return
                    end
                end
            end
        end
    end
}