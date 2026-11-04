 

local v1 = {}
local u2 = script.Parent.Assets
local _ = u2.Z
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local u5 = game["Run Service"]
local u6 = RaycastParams.new()
u6.FilterType = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, p7, p8) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u6
        [4] = u5
        [5] = u4
    --]]
    local u9 = p7.PrimaryPart
    local v10 = p7.Humanoid
    local u11 = u2.C
    if _G.checkRenderDistance(p7.PrimaryPart.Position) == false then
        return
    end
    if p8 == "hold" then
        local v12 = Instance.new("Model")
        v12.Parent = workspace.Effects
        local v13 = u11.Charge:Clone()
        v13.Parent = v12
        local v14 = Instance.new("Weld")
        v14.Part0 = p7.RightHand
        v14.Part1 = v13
        v14.Parent = v13
        _G.particleEnabled(v13, true)
        local u15 = u11.Charge2:Clone()
        u15.CFrame = u9.CFrame * CFrame.new(0, -(u9.Size.Y / 2 + v10.HipHeight), 0)
        local v16 = Instance.new("WeldConstraint")
        v16.Part0 = u9
        v16.Part1 = u15
        v16.Parent = u15
        u15.Parent = v12
        _G.PlaySound(u9, script["Audio/FishKSlashWaveStart"])
        local v17 = script["Audio/FishKSlashWaveChargeLoop"]:Clone()
        v17.Parent = v13
        v17:Play()
        if p7:GetAttribute("SplittingSea") then
            p7:GetAttributeChangedSignal("SplittingSea"):Wait()
        end
        _G.tween(v17, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.particleEnabled(v13, false)
        _G.destroy(v12, 5)
        task.delay(0.3, function() --[[ Line: 85 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            _G.particleEnabled(u15, false)
        end)
        return
    end
    if p8 ~= "shoot" then
        ::l8::
        return
    end
    local u18 = u3.new()
    local v19 = u3.new()
    local v20 = Instance.new("Model")
    v20.Parent = workspace.Effects
    local u21 = u11.Spike_Trail:Clone()
    u18:AddTask(u21)
    u21.Parent = v20
    local u22 = u21.GroundPart
    local u23 = 0
    local u24 = u9.CFrame * CFrame.new(0, -3, -65).Position
    local u25 = u9.CFrame * CFrame.new(0, 0, -7).Position
    local u26 = tick()
    local u27 = nil
    local u28 = 0
    local u29 = nil
    local v30 = workspace:Raycast(u24 + Vector3.new(0, 3, 0), Vector3.new(0, -35, 0), u6)
    if v30 then
        u24 = v30.Position
    end
    local v31 = u25.X
    local v32 = u24.Y
    local v33 = u25.Z
    u21.Position = Vector3.new(v31, v32, v33)
    local v34 = workspace:Raycast(u25 + Vector3.new(0, 3, 0), Vector3.new(0, -30, 0), u6)
    local u35 = u11.Slash:Clone()
    if v34 then
        local v36 = CFrame.lookAt
        local v37 = v34.Position
        local v38 = v34.Position + v34.Normal
        local v39 = CFrame.new
        local v40 = u9.Position.X
        local v41 = u9.Position.Z
        local v42 = Vector3.new(v40, 0, v41)
        local v43 = u21.Position.X
        local v44 = u21.Position.Z
        v78 = v36(v37, v38, -v39(v42, (Vector3.new(v43, 0, v44))).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -1, -u35.Size.Z / 2)
        if v78 then
            ::l13::
            u35.CFrame = v78
            u35.Parent = v20
            _G.destroy(u35, 5)
            _G.PlaySound(u35, script["Audio/FishKSlashWaveShoot"]).Parent = u35
            task.delay(0.1, function() --[[ Line: 139 ]]
                --[[
                Upvalues:
                    [1] = u35
                --]]
                _G.particleEnabled(u35, false)
            end)
            v19:AddTask(u5.RenderStepped:Connect(function(_) --[[ Line: 143 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u6
                    [3] = u26
                    [4] = u23
                    [5] = u11
                    [6] = u18
                    [7] = u4
                    [8] = u9
                    [9] = u25
                    [10] = u24
                    [11] = u28
                    [12] = u29
                    [13] = u22
                    [14] = u27
                --]]
                local v45 = workspace:Raycast(u21.Position + Vector3.new(0, 25, 0), Vector3.new(0, -40, 0), u6)
                local v46 = tick() - u26
                if tick() - u23 >= 0.02 and v45 then
                    u23 = tick()
                    local v47 = u11.GroundSmokeTrail_Beam.Origin:Clone()
                    v47.Parent = workspace.Terrain
                    u18:AddTask(v47)
                    for _, u48 in v47:GetDescendants() do
                        if u48:IsA("Beam") then
                            local v49 = u48.Width0
                            local v50 = u48.Width1
                            u48.Width0 = 0
                            u48.Width1 = 0
                            u4:Create(u48, TweenInfo.new(Random.new():NextNumber(0.4, 0.8)), {
                                ["Width0"] = v49,
                                ["Width1"] = v50
                            }):Play()
                            task.spawn(function() --[[ Line: 166 ]]
                                --[[
                                Upvalues:
                                    [1] = u48
                                --]]
                                local v51 = tick()
                                while true do
                                    local v52 = (tick() - v51) * 2
                                    u48.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4, v52), NumberSequenceKeypoint.new(1, 1) })
                                    if v52 >= 1 then
                                        break
                                    end
                                    task.wait()
                                end
                            end)
                        elseif u48:IsA("Attachment") then
                            if u48.Name == "A" or u48.Name == "B" then
                                u4:Create(u48, TweenInfo.new(1), {
                                    ["Position"] = u48.Position * 1.25
                                }):Play()
                            elseif u48.Name == "L" or u48.Name == "R" then
                                u4:Create(u48, TweenInfo.new(1), {
                                    ["Position"] = u48.Position * 2.5
                                }):Play()
                            end
                        end
                    end
                    local v53 = CFrame.lookAt
                    local v54 = v45.Position
                    local v55 = v45.Position + v45.Normal
                    local v56 = CFrame.new
                    local v57 = u9.Position.X
                    local v58 = u9.Position.Z
                    local v59 = Vector3.new(v57, 0, v58)
                    local v60 = u21.Position.X
                    local v61 = u21.Position.Z
                    v47.WorldCFrame = v53(v54, v55, -v56(v59, (Vector3.new(v60, 0, v61))).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -1, 0)
                    for _, v62 in v47:GetChildren() do
                        local v63 = workspace:Raycast(v62.WorldPosition + Vector3.new(0, 4, 0), Vector3.new(0, -45, 0), u6)
                        if v63 then
                            local v64 = v63.Position.X
                            local v65 = v63.Position.Y
                            local v66 = v63.Position.Z
                            v62.WorldPosition = Vector3.new(v64, v65, v66) + Vector3.new(0, 2, 0)
                        end
                    end
                end
                local v67 = v45 and CFrame.lookAt(v45.Position, v45.Position + v45.Normal, CFrame.new(u25, u24).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) or CFrame.new(u24, u25) * CFrame.Angles(0, 3.141592653589793, 0)
                local v68 = u21.Position:Lerp(u24, v46 * 5)
                local v69 = v68.X
                local v70 = v67.Position.Y
                local v71 = v68.Z
                local v72 = Vector3.new(v69, v70, v71)
                local v73 = u21
                local v74 = u21.Position
                local v75 = v46 * 2
                v73.Position = v74:Lerp(v72, (math.clamp(v75, 0, 1)))
                local _ = tick() - u28 >= 0.0033333333333333335
                if not u29 and v45 then
                    u22.CFrame = CFrame.lookAt(v45.Position, v45.Position + v45.Normal, CFrame.new(u25, u21.Position).LookVector) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                    if not u27 then
                        u27 = true
                        local v76 = u22.Position + Vector3.new(0, 1, 0)
                        local v77 = workspace:Raycast(v76, u21.CFrame.LookVector * 25, u6)
                        if v77 then
                            local _ = v77.Position
                        end
                    end
                end
            end))
            task.wait(0.28)
            v19:Destroy()
            local _ = true
            _G.destroy(u22, 3)
            task.wait(0.05)
            _G.particleEnabled(u21, false)
            _G.particleEnabled(u22, false)
            task.wait(3)
            u18:Destroy()
            goto l8
        end
    end
    local v78 = u9.CFrame * CFrame.new(0, 0, -u35.Size.Z / 2)
    goto l13
end
return v1