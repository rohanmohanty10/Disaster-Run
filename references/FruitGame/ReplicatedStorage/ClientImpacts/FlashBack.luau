 

local v1 = {}
game:GetService("PhysicsService")
function v1.start(_, p2) --[[ Line: 5 ]]
    local u3 = p2.char
    if u3 == nil then
        return
    elseif u3.PrimaryPart ~= nil then
        if _G.checkRenderDistance(u3.HumanoidRootPart.CFrame.p) ~= false then
            local u4 = {}
            local function u21(p5, p6) --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u4
                --]]
                local v7 = p5 ~= 1
                local v8 = u3:GetDescendants()
                if #u4 == 0 then
                    for v9 = 1, #v8 do
                        if (v8[v9]:IsA("BasePart") or v8[v9]:IsA("Decal")) and v8[v9].Transparency ~= p5 then
                            local v10 = u4
                            local v11 = v8[v9]
                            table.insert(v10, v11)
                            if p6 == true and v8[v9]:IsA("BasePart") then
                                local v12 = v8[v9]:Clone()
                                v12:BreakJoints()
                                v12.Anchored = true
                                v12.CanCollide = false
                                v12.Material = Enum.Material.Glass
                                _G.setCollisionGroup(v12, "noclip")
                                local v13 = v12:GetDescendants()
                                for v14 = 1, #v13 do
                                    local v15 = v13[v14]
                                    if v15:IsA("Script") or (v15:IsA("LocalScript") or (v15:IsA("Weld") or (v15:IsA("Motor6D") or v15:IsA("Beam")))) then
                                        v15:Destroy()
                                    end
                                end
                                v12.Parent = workspace.Effects
                                local v16 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
                                game:GetService("TweenService"):Create(v12, v16, {
                                    ["Transparency"] = 1
                                }):Play()
                                _G.destroy(v12, 0.25)
                            end
                            v8[v9].Transparency = p5
                        elseif v8[v9]:IsA("BillboardGui") and v8[v9].Enabled ~= v7 then
                            local v17 = u4
                            local v18 = v8[v9]
                            table.insert(v17, v18)
                            v8[v9].Enabled = v7
                        end
                    end
                else
                    for v19 = 1, #u4 do
                        local v20 = u4[v19]
                        if v20:IsA("BillboardGui") == false and v20.Transparency ~= p5 then
                            v20.Transparency = p5
                        elseif v20:IsA("BillboardGui") and v20.Enabled ~= v7 then
                            v20.Enabled = v7
                        end
                    end
                    u4 = {}
                end
            end
            local v22 = script.sorun:Clone()
            v22.CFrame = u3.HumanoidRootPart.CFrame
            v22.Parent = workspace.Effects
            v22.ParticleEmitter:Emit(20)
            local _ = u3.HumanoidRootPart
            if game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u3.Name) then
                game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u3.Name).Enabled = false
            end
            _G.destroy(v22, 0.5)
            u21(1, true)
            return function() --[[ Line: 87 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u21
                --]]
                if game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u3.Name) then
                    game.Players.LocalPlayer.PlayerGui.HealthBars:FindFirstChild(u3.Name).Enabled = true
                end
                u21(0)
            end
        end
    end
end
return v1