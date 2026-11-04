 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
return {
    ["start"] = function(_, u2, _) --[[ Name: start, Line 19 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if u2 == nil then
            return
        elseif _G.checkRenderDistance(u2.PrimaryPart.Position) ~= false then
            local u3 = u2.PrimaryPart or u2:WaitForChild("HumanoidRootPart")
            task.delay(0.35, function() --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u3
                    [3] = u1
                --]]
                local u4 = Instance.new("Highlight")
                u4.Name = "PteraHighlight"
                u4.OutlineTransparency = 0.3
                u4.DepthMode = 1
                u4.FillColor = Color3.fromRGB(138, 146, 255)
                u4.Parent = u2
                _G.tween(u4, {
                    0.5,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["OutlineTransparency"] = 1,
                    ["FillTransparency"] = 0
                })
                task.delay(0.3, function() --[[ Line: 37 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    _G.tween(u4, {
                        0.35,
                        "Sine",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["OutlineTransparency"] = 0.6
                    })
                    task.wait(0.5)
                    _G.tween(u4, {
                        0.4,
                        "Sine",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["OutlineTransparency"] = 1,
                        ["FillTransparency"] = 1
                    })
                end)
                _G.destroy(u4, 3)
                local v5 = workspace:Raycast(u3.Position, u3.CFrame.UpVector * -15, u1)
                if v5 then
                    local v6 = script.Startup:Clone()
                    v6.CFrame = CFrame.new(v5.Position, v5.Position + v5.Normal)
                    v6.Parent = workspace.Effects
                    for _, v7 in v6:GetDescendants() do
                        if v7:IsA("ParticleEmitter") and v7:GetAttribute("Dust") then
                            v7.Color = ColorSequence.new(v5.Instance.Color)
                        end
                    end
                    _G.customEmit(v6)
                    _G.destroy(v6, 3)
                end
            end)
            task.delay(0.8, function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u2
                --]]
                local u8 = script.FullFormBurst.Enable:Clone()
                for _, v9 in u8:GetChildren() do
                    v9.Enabled = true
                end
                u8.Parent = u2.PrimaryPart
                _G.destroy(u8, 3)
                task.delay(0.2, function() --[[ Line: 74 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    for _, v10 in u8:GetChildren() do
                        v10.Enabled = false
                    end
                end)
            end)
            task.delay(1, function() --[[ Line: 81 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u1
                    [3] = u2
                --]]
                local v11 = workspace:Raycast(u3.Position, u3.CFrame.UpVector * -15, u1)
                if v11 then
                    local v12 = script.GroundDust:Clone()
                    v12.CFrame = CFrame.new(v11.Position, v11.Position + v11.Normal)
                    for _, v13 in v12:GetDescendants() do
                        if v13:IsA("ParticleEmitter") and v13:GetAttribute("Dust") then
                            v13.Color = ColorSequence.new(v11.Instance.Color)
                        end
                    end
                    v12.Parent = workspace.Effects
                    _G.customEmit(v12)
                    _G.destroy(v12, 3)
                end
                task.wait(0.2)
                local v14 = script.FullFormBurst:Clone()
                v14.CFrame = u2.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                v14.Parent = workspace.Effects
                _G.customEmit(v14)
                _G.destroy(v14, 3)
                local v15 = script.Part:Clone()
                v15.CFrame = u2.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                local v16 = Instance.new("Highlight")
                v16.Name = "PteraHighlight"
                v16.OutlineTransparency = 0.3
                v16.DepthMode = 1
                v16.FillTransparency = 0
                v16.FillColor = Color3.fromRGB(138, 146, 255)
                v16.Parent = v15
                v15.Parent = workspace.Effects
                _G.tween(v15.PteraHighlight, {
                    0.2,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["FillTransparency"] = 1
                })
                _G.tween(v15, {
                    0.2,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["Size"] = Vector3.new(162.68, 40.67, 81.34)
                })
                _G.destroy(v15, 3)
            end)
        end
    end
}