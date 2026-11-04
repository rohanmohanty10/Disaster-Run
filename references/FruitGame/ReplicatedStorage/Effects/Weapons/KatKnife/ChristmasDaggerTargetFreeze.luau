 

game:GetService("ReplicatedStorage")
local u1 = script.BaseIce
local u2 = script.BaseIceShatter
local u3 = script.Shatter
local u4 = u1.Size
return {
    ["start"] = function(_, p5, p6) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u4
            [3] = u2
            [4] = u3
        --]]
        if _G.checkRenderDistance(p5.PrimaryPart.Position) == false then
            return
        else
            local v7 = p5.HumanoidRootPart
            if p6 then
                local v8 = u1:Clone()
                v8.Name = u1.Name .. p5.Name
                v8.Weld.Part1 = v7
                v8.Size = Vector3.new(0, 0, 0)
                v8.Parent = workspace.Effects
                local v9 = v8:Clone()
                v9.Name = "NeonIce"
                v9.Material = Enum.Material.Neon
                v9.Transparency = 0
                v9.Parent = workspace.Effects
                _G.tween(v9, { 0.3, "Linear", "Out" }, {
                    ["Transparency"] = 1
                })
                local v10 = {
                    ["Size"] = u4
                }
                _G.tween(v8, { 0.15, "Quint", "Out" }, v10)
                local v11 = {
                    ["Size"] = u4
                }
                _G.tween(v9, { 0.15, "Quint", "Out" }, v11)
                for _, v12 in v8:GetDescendants() do
                    if v12:IsA("ParticleEmitter") then
                        v12.Enabled = true
                    end
                end
                task.wait(0.4)
                v9:Destroy()
            else
                local v13 = workspace.Effects:FindFirstChild(u1.Name .. p5.Name)
                if v13 then
                    local v14 = u2:Clone()
                    v14:PivotTo(v7.CFrame)
                    v14.Parent = workspace.Effects
                    v13:Destroy()
                    local u15 = u3:Clone()
                    u15.CFrame = v7.CFrame
                    u15.Parent = workspace.Effects
                    for _, v16 in u15:GetDescendants() do
                        if v16:IsA("ParticleEmitter") then
                            _G.customEmit(v16)
                        end
                    end
                    task.delay(1, function() --[[ Line: 70 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                        --]]
                        u15:Destroy()
                    end)
                    for _, u17 in v14:GetChildren() do
                        local u18 = Instance.new("BodyForce")
                        local v19 = u17:GetMass() * workspace.Gravity * -0.05
                        u18.Force = Vector3.new(0, v19, 0)
                        u18.Parent = u17
                        u17:ApplyImpulse((u17.Position - v7.Position) * math.random(40, 50) + Vector3.new(0, 110, 0))
                        local v20 = Random.new()
                        local v21 = _G.tween
                        local v22 = {
                            ["Size"] = Vector3.new(0, 0, 0)
                        }
                        local v23 = u17.Orientation
                        local v24 = v20:NextNumber(-100, 100)
                        local v25 = v20:NextNumber(-100, 100)
                        v22.Orientation = v23 + Vector3.new(v24, v25, v20:NextNumber(-100, 100))
                        v21(u17, { 0.6, "Linear", "In" }, v22)
                        task.delay(1, function() --[[ Line: 92 ]]
                            --[[
                            Upvalues:
                                [1] = u17
                                [2] = u18
                            --]]
                            u17:Destroy()
                            u18:Destroy()
                        end)
                    end
                end
            end
        end
    end
}