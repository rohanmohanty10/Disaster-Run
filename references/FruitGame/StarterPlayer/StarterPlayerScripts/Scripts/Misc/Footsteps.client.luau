 

local function u7(p1, p2, _) --[[ Line: 2 ]]
    local v3 = p1.p
    local v4 = p1.LookVector:Cross(p2).Unit
    local v5 = (v4.Magnitude > 0.001 and v4 and v4 or p1.RightVector).Unit
    local v6 = v5:Cross(p2).Unit.Unit
    return CFrame.fromMatrix(v3, v5, p2, v6)
end
local u8 = 0
local u9 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("FootstepSounds")
local v10 = game:GetService("Players")
local v11 = game:GetService("ReplicatedStorage")
local u12 = v10.LocalPlayer
local u13 = v11.Events.footstep
local u14 = workspace.Effects
local u15 = workspace.Terrain
local u16 = Enum.Material.Air
function _G.footstep(p17, _, p18, p19, p20) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u8
        [3] = u14
        [4] = u16
        [5] = u9
        [6] = u13
        [7] = u15
        [8] = u7
    --]]
    local v21 = u12.Character
    local v22 = p18 or v21
    if v22 then
        local v23 = v22 == v21
        if v23 and tick() - u8 <= 0.05 then
            return
        elseif v22.Parent == u14 and not p19 then
            return
        else
            local v24 = v22:FindFirstChild("Humanoid")
            local v25
            if p20 == nil then
                if v24 then
                    v25 = v24:IsA("Humanoid")
                else
                    v25 = v24
                end
            else
                v25 = false
            end
            local v26 = v22:FindFirstChild("HumanoidRootPart")
            if v26 then
                local v27 = nil
                if v25 and (v24.FloorMaterial == u16 and p17 ~= "land") then
                    return
                else
                    if p17 == "land" then
                        local v28, v29
                        v27, v28, v29 = _G.getRayFloor(CFrame.new(v26.Position), 13)
                        if not v27 then
                            return
                        end
                    end
                    local v30 = v22:FindFirstChild("LeftFoot")
                    local v31 = v22:FindFirstChild("RightFoot")
                    if v30 and v31 then
                        local v32 = nil
                        if v25 then
                            v32 = v24.FloorMaterial
                        elseif p20 then
                            v32 = p20
                        else
                            local v33, v34
                            v27, v33, v34 = _G.getRayFloor(CFrame.new(v26.Position), 6)
                        end
                        if v27 then
                            v32 = v27.Material
                        end
                        local v35 = tostring(v32)
                        local v36 = string.sub(v35, 15)
                        local v37 = string.gsub(v36, "%s+", "")
                        if v37 == "SmoothPlastic" or v37 == "Plastic" then
                            local v38, v39
                            v27, v38, v39 = _G.getRayFloor(CFrame.new(v26.Position), 6)
                        end
                        local v40 = v27 and (v27.MaterialVariant and v27.MaterialVariant:match("Water") ~= nil) and "Water" or v37
                        local v41 = v27 and v27:GetAttribute("isWaterMaterial") and "Water" or v40
                        local v42 = u9:FindFirstChild(v41)
                        if v42 then
                            local v43 = _G.SeaLevel
                            if v43 then
                                local v44 = v43 - 4
                                local v45 = v30.Position.Y
                                if (v45 <= v43 or v31.Position.Y <= v43) and v44 < v45 then
                                    v41 = "Water"
                                    v42 = u9:FindFirstChild(v41)
                                end
                            end
                            local v46 = v22.PrimaryPart
                            if p17 == "land" then
                                if v23 then
                                    u13:FireServer("land")
                                end
                                local v47 = v42:FindFirstChild("Falls")
                                if v47 then
                                    local v48 = v47:GetChildren()
                                    _G.PlaySound(v46, v48[math.random(1, #v48)], {
                                        ["Pitch"] = math.random(90, 110) / 100
                                    }).Parent = v46
                                else
                                    _G.PlaySound(v46, v42:FindFirstChildWhichIsA("Sound"), {
                                        ["Pitch"] = math.random(90, 110) / 100
                                    }).Parent = v46
                                end
                            else
                                local v49 = v42.Steps:GetChildren()
                                local v50 = v49[math.random(1, #v49)]:Clone()
                                local v51 = 16
                                local v52
                                if v25 then
                                    v52 = v24.WalkSpeed
                                else
                                    v52 = v22:GetAttribute("WalkSpeed") or v51
                                end
                                if p18 and not v46.Anchored then
                                    v52 = v46.Velocity.Magnitude
                                end
                                v50.Pitch = v50.Pitch / (16 / (v52 / 4 + 10))
                                v50.Volume = 0.2
                                v50.RollOffMaxDistance = 300
                                local v53 = Instance.new("Attachment")
                                if v23 then
                                    v50.Volume = 0.095
                                    v53.Parent = v46
                                else
                                    v53.WorldCFrame = v46.CFrame
                                    v50.RollOffMinDistance = 25
                                    v50.Volume = 0.1
                                    v53.Parent = u15
                                end
                                v50.Parent = v53
                                v50:Play()
                                _G.destroy(v53, 3)
                                if v23 then
                                    u8 = tick()
                                end
                                if p17 ~= "step1" then
                                    v30 = v31
                                end
                                if v41 == "Sand" then
                                    local v54 = Ray.new(v30.Position, Vector3.new(0, -3, 0))
                                    local v55, v56, v57 = _G.raycastWhitelist(v54, { workspace.Islands, workspace.Env, workspace.Ships })
                                    if v55 then
                                        local v58 = script.FootStep:Clone()
                                        v58.CFrame = u7(CFrame.new(Vector3.new(), v30.CFrame.LookVector) + v56, v57)
                                        v58.Color = v55.Color
                                        v58.Attachment.sm2.Color = ColorSequence.new(v55.Color)
                                        v58.Parent = u14
                                        _G.customEmit(v58)
                                        _G.destroy(v58, 2)
                                    end
                                elseif v41 == "Water" then
                                    local v59 = script.waterSplash:Clone()
                                    v59.CFrame = CFrame.new(v30.Position)
                                    if v27 then
                                        _G.recolorParticles(v59, v27.Color)
                                    end
                                    v59.Parent = u14
                                    _G.customEmit(v59)
                                    _G.destroy(v59, 2)
                                end
                                if v23 then
                                    u13:FireServer()
                                end
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end
            else
                return
            end
        end
    else
        return
    end
end