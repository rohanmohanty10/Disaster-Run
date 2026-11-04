 

game:GetService("ReplicatedStorage")
local u1 = game:GetService("TweenService")
local u2 = game:GetService("Debris")
local u3 = game:GetService("RunService")
local v4 = {}
local function u18(p5, p6, p7, p8, p9) --[[ Line: 9 ]]
    local v10 = 1 - p5
    local v11 = v10 * v10
    local v12 = v11 * v10
    local v13 = p5 * p5
    local v14 = v13 * p5
    local v15 = p6.Position * v12 + p7.Position * (v11 * 3 * p5) + p8.Position * (v10 * 3 * v13) + p9.Position * v14
    local v16 = (p7.Position - p6.Position) * (v11 * 3) + (p8.Position - p7.Position) * (v10 * 6 * p5) + (p9.Position - p8.Position) * (v13 * 3)
    if v16.Magnitude < 0.001 then
        if p5 < 0.5 then
            v16 = (p7.Position - p6.Position).Unit
        else
            v16 = (p9.Position - p8.Position).Unit
        end
        if v16.Magnitude < 0.001 then
            local v17 = p9.Position - p6.Position
            v16 = v17.Magnitude < 0.001 and Vector3.new(0, 0, -1) or v17
        end
    end
    return CFrame.lookAt(v15, v15 + v16)
end
function v4.Create(u19, p20) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u18
        [4] = u2
    --]]
    local v21 = p20 or {}
    if typeof(u19) == "CFrame" then
        local v22 = v21.Count or 30
        local u23 = v21.SpawnRadius or 20
        local u24 = v21.MinDuration or 0.8
        local u25 = v21.MaxDuration or 1.5
        local u26 = v21.Lifetime or 2
        local u27 = v21.ParticleTemplate
        local u28 = v21.ControlPointHeight or 15
        local u29 = v21.RandomControlOffset or 8
        local u30 = v21.Parent or workspace.Effects
        local u31 = v21.EasingStyle or Enum.EasingStyle.Quart
        local u32 = v21.EasingDirection or Enum.EasingDirection.Out
        local u33 = v21.SpawnDelay or 0.05
        local u34 = v21.ColorSequence
        local u35 = v21.TransparencySequence
        local u36 = v21.SwirlStrength or 0
        if u27 and u27:IsA("BasePart") then
            for u37 = 1, v22 do
                task.spawn(function() --[[ Line: 89 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u37
                        [3] = u27
                        [4] = u30
                        [5] = u23
                        [6] = u19
                        [7] = u24
                        [8] = u25
                        [9] = u29
                        [10] = u36
                        [11] = u28
                        [12] = u31
                        [13] = u32
                        [14] = u1
                        [15] = u3
                        [16] = u18
                        [17] = u34
                        [18] = u35
                        [19] = u2
                        [20] = u26
                    --]]
                    if u33 > 0 then
                        task.wait(u37 * u33)
                    end
                    local u38 = u27:Clone()
                    u38.Anchored = false
                    u38.CanCollide = false
                    u38.CanTouch = false
                    u38.Massless = true
                    u38.Parent = u30
                    local v39 = math.random() * 2 - 1
                    local v40 = math.random() * 2 - 1
                    local v41 = math.random() * 2 - 1
                    local v42 = Vector3.new(v39, v40, v41).Unit * math.random(0, u23)
                    local u43 = CFrame.new(u19.Position + v42)
                    u38.CFrame = u43
                    local v44 = math.random(u24 * 100, u25 * 100) / 100
                    local u45 = u19
                    local v46 = u43:Lerp(u45, 0.5)
                    local v47 = u29
                    local v48 = math.abs(v47)
                    local v49 = math.random() * 2 - 1
                    local v50 = math.random() * 2 - 1
                    local v51 = math.random() * 2 - 1
                    local v52 = Vector3.new(v49, v50, v51).Unit * (math.random() * v48)
                    local v53 = math.random() * 2 - 1
                    local v54 = math.random() * 2 - 1
                    local v55 = math.random() * 2 - 1
                    local v56 = Vector3.new(v53, v54, v55).Unit * (math.random() * v48)
                    local v57 = (u45.Position - u43.Position).Unit
                    local v58 = v57:Cross(Vector3.new(0, 1, 0))
                    if v58.Magnitude < 0.001 then
                        v58 = v57:Cross(Vector3.new(0, 0, -1))
                    end
                    local v59 = v58.Unit
                    local v60 = v59 * (math.random() * 2 - 1) * u36
                    local v61 = v59 * (math.random() * 2 - 1) * u36
                    local v62 = u28
                    local v63 = u43.Position:Lerp(v46.Position, 0.3) + Vector3.new(0, v62, 0) + v52 + v60
                    local v64 = u28
                    local v65 = v46.Position:Lerp(u45.Position, 0.7) + Vector3.new(0, v64, 0) + v56 + v61
                    local u66 = CFrame.new(v63)
                    local u67 = CFrame.new(v65)
                    local u68 = Instance.new("NumberValue")
                    u68.Value = 0
                    u68.Parent = nil
                    local u69 = u1:Create(u68, TweenInfo.new(v44, u31, u32, 0, false, 0), {
                        ["Value"] = 1
                    })
                    local u70 = nil
                    u70 = u3.Heartbeat:Connect(function() --[[ Line: 169 ]]
                        --[[
                        Upvalues:
                            [1] = u38
                            [2] = u69
                            [3] = u18
                            [4] = u68
                            [5] = u43
                            [6] = u66
                            [7] = u67
                            [8] = u45
                            [9] = u70
                        --]]
                        if u38 and (u38.Parent and u69.PlaybackState == Enum.PlaybackState.Playing) then
                            u38.CFrame = u18(u68.Value, u43, u66, u67, u45)
                        elseif u70 then
                            u70:Disconnect()
                            u70 = nil
                        end
                    end)
                    local v71 = u34 and u38:FindFirstChildOfClass("Trail")
                    if v71 then
                        v71.Color = u34
                    end
                    local v72 = u35 and u38:FindFirstChildOfClass("Trail")
                    if v72 then
                        v72.Transparency = u35
                    end
                    u69:Play()
                    u69.Completed:Connect(function() --[[ Line: 195 ]]
                        --[[
                        Upvalues:
                            [1] = u70
                            [2] = u68
                        --]]
                        if u70 then
                            u70:Disconnect()
                            u70 = nil
                        end
                        u68:Destroy()
                    end)
                    u2:AddItem(u38, u26)
                end)
            end
        else
            warn("BezierChargeEffect.Create: ParticleTemplate is required and must be a BasePart.")
        end
    else
        warn("BezierChargeEffect.Create: \'targetCFrame\' must be a CFrame value, but received an " .. typeof(u19) .. ". Did you pass a Part/Instance instead of Part.CFrame?")
        return
    end
end
return v4