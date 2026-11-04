 

game:GetService("RunService")
return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 14 ]]
        local v4 = p1.PrimaryPart or p1:WaitForChild("HumanoidRootPart")
        p1:FindFirstChildOfClass("Humanoid")
        if _G.checkRenderDistance(p1.PrimaryPart.Position) == false then
            return
        else
            local v5 = script.Regular
            if p3 == true then
                v5 = script.Mera
            end
            _G.PlaySound(p1.PrimaryPart, v5.woosh)
            if p3 == true then
                local v6 = script.Mera.Hit.Attachment:Clone()
                v6.Parent = p2.Head
                _G.destroy(v6, 3)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.35)
                local v7 = script.Mera.PipeSpin:Clone()
                v7.CFrame = v4.CFrame * CFrame.new(-0.049987793, 1.74999428, 0.0500030518, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v7.Parent = workspace.Effects
                _G.particleEnabled(v7, true)
                _G.destroy(v7, 3)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.2)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.15)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.15)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                _G.particleEnabled(v7, false)
                task.wait(0.1)
                local v8 = script.Mera.PipeSpin2:Clone()
                v8.CFrame = v4.CFrame * CFrame.new(0.200012207, 1.49999428, -1.44999695, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v8.Parent = workspace.Effects
                _G.particleEnabled(v8, true)
                _G.destroy(v8, 3)
                task.wait(0.24)
                _G.particleEnabled(v8, false)
                _G.customEmit(v6)
                _G.PlaySound(p2.PrimaryPart, v5.finalhit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.07)
                local v9 = script.Mera.swirltwo:Clone()
                v9.CFrame = v4.CFrame
                v9.Parent = workspace.Effects
                _G.tween(v9, {
                    0.6,
                    "Exponential",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(25, 0.5, 25),
                    ["CFrame"] = v4.CFrame * CFrame.Angles(0, 2.181661564992912, 0),
                    ["Transparency"] = 1
                })
                _G.destroy(v9, 0.6)
                local v10 = script.Mera.PipeSlash2:Clone()
                v10.CFrame = v4.CFrame * CFrame.new(-0.049987793, -5.7220459e-6, -1.07499695, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v10.Parent = workspace.Effects
                _G.customEmit(v10)
                _G.tween(v10.PointLight, {
                    0.6,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 45,
                    ["Brightness"] = 0
                })
                _G.destroy(v10, 3)
            else
                local v11 = script.Regular.Hit.Attachment:Clone()
                v11.Parent = p2.Head
                _G.destroy(v11, 3)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.35)
                local v12 = script.Regular.PipeSpin:Clone()
                v12.CFrame = v4.CFrame * CFrame.new(-0.049987793, 1.74999428, 0.0500030518, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v12.Parent = workspace.Effects
                _G.particleEnabled(v12, true)
                _G.destroy(v12, 3)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.2)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.15)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.15)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.hit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                _G.particleEnabled(v12, false)
                task.wait(0.1)
                local v13 = script.Regular.PipeSpin2:Clone()
                v13.CFrame = v4.CFrame * CFrame.new(0.200012207, 1.49999428, -1.44999695, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v13.Parent = workspace.Effects
                _G.particleEnabled(v13, true)
                _G.destroy(v13, 3)
                task.wait(0.24)
                _G.particleEnabled(v13, false)
                _G.customEmit(v11)
                _G.PlaySound(p2.PrimaryPart, v5.finalhit, {
                    ["Pitch"] = math.random(80, 110) / 100
                })
                task.wait(0.07)
                local v14 = script.Regular.swirltwo:Clone()
                v14.CFrame = v4.CFrame
                v14.Parent = workspace.Effects
                _G.tween(v14, {
                    0.6,
                    "Exponential",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(25, 0.5, 25),
                    ["CFrame"] = v4.CFrame * CFrame.Angles(0, 2.181661564992912, 0),
                    ["Transparency"] = 1
                })
                _G.destroy(v14, 0.6)
                local v15 = script.Regular.PipeSlash2:Clone()
                v15.CFrame = v4.CFrame * CFrame.new(-0.049987793, -5.7220459e-6, -1.07499695, 1, 0, 0, 0, 0, -1, 0, 1, 0)
                v15.Parent = workspace.Effects
                _G.customEmit(v15)
                _G.destroy(v15, 3)
            end
        end
    end
}