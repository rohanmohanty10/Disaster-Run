 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
require(script.Parent.Parent.SlashMesh)
local u4 = _G.customEmit
local u5 = RaycastParams.new()
local v6 = { workspace.Islands, workspace.Env, workspace.Ships }
local v7 = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = v6
u5.FilterType = v7
function v1.start(_, u8, u9, u10) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
        [4] = u4
    --]]
    Random.new()
    local u11 = u8 == game.Players.LocalPlayer.Character
    local v12 = u8:FindFirstChild("DragonTailController", true)
    local u13 = {}
    local v14 = u8.Humanoid:LoadAnimation(script.Combo)
    v14:Play()
    v14:AdjustSpeed(u10)
    table.insert(u13, v14)
    if v12 then
        local v15 = v12:LoadAnimation(script.Combo)
        v15:Play()
        v15:AdjustSpeed(u10)
        table.insert(u13, v15)
    end
    _G.PlaySound(u8.PrimaryPart, script.DragonLightingSlashesStart).Parent = u8.PrimaryPart
    local u16 = false
    local u17 = {
        { 45, 0.7833333333333333, 30 },
        { -45, 1.1833333333333333, 25 },
        { 0, 1.5166666666666666, 10 }
    }
    local v18 = {
        0.46,
        35,
        1.1,
        1.5,
        55,
        0.2
    }
    local u19 = Instance.new("NumberValue")
    u19.Value = 0
    local u20 = nil
    local u21 = nil
    local function u23() --[[ Line: 60 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u20
            [3] = u19
            [4] = u16
            [5] = u13
        --]]
        if u21 then
            u21:Disconnect()
            u21 = nil
        end
        if u20 then
            u20:Destroy()
        end
        u19:Destroy()
        u16 = true
        for v22 = 1, #u13 do
            u13[v22]:Stop()
        end
    end
    local u24, u25
    if u11 then
        local u26 = Instance.new("BodyVelocity")
        u26.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        u26.Velocity = Vector3.new()
        u26.Parent = u8.PrimaryPart
        local u27 = u8.PrimaryPart
        u21 = u3.Heartbeat:Connect(function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u21
                [3] = u23
                [4] = u27
                [5] = u19
                [6] = u26
            --]]
            if _G.check:inspect(u8) == false then
                u21:Disconnect()
                u23()
            else
                u27.AssemblyAngularVelocity = Vector3.new()
                local v28 = u27.CFrame.LookVector
                local v29 = v28.X
                local v30 = v28.Z
                u26.Velocity = Vector3.new(v29, 0, v30).Unit * (u19.Value * 1.3)
            end
        end)
        u20 = u26
        u24 = u21
        u25 = u20
    else
        u24 = u21
        u25 = u20
    end
    local u31 = u16
    for u32 = 1, #v18, 3 do
        local v33 = v18[u32]
        local u34 = v18[u32 + 1]
        local u35 = v18[u32 + 2]
        task.delay(v33 / u10, function() --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u35
                [3] = u10
                [4] = u32
                [5] = u8
                [6] = u19
                [7] = u34
                [8] = u2
            --]]
            if u31 ~= true then
                u35 = u35 / u10
                if u32 == 1 then
                    _G.PlaySound(u8.PrimaryPart, script.DragonLightingSlashesLeapForward).Parent = u8.PrimaryPart
                end
                u19.Value = u34
                u2:Create(u19, TweenInfo.new(u35, Enum.EasingStyle.Linear), {
                    ["Value"] = 7
                }):Play()
            end
        end)
    end
    if u25 then
        task.delay(u17[#u17][2] + 0.2, function() --[[ Line: 178 ]]
            --[[
            Upvalues:
                [1] = u24
                [2] = u25
                [3] = u19
            --]]
            if u24 then
                u24:Disconnect()
                u24 = nil
            end
            if u25 then
                u25:Destroy()
            end
            u19:Destroy()
        end)
    end
    for u36 = 1, #u17 do
        if u31 == true then
            break
        end
        task.delay(u17[u36][2] / u10, function() --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u8
                [3] = u23
                [4] = u36
                [5] = u17
                [6] = u5
                [7] = u2
                [8] = u4
                [9] = u11
                [10] = u9
            --]]
            if u31 == true then
                return
            else
                local v37 = u8:GetPivot()
                if _G.check:inspect(u8) == false then
                    u23()
                else
                    local u38 = script[u36 == 3 and "SlashFinal" or "Slash"]:Clone()
                    local v39 = v37 * CFrame.new(0, 0.5, -1.5)
                    local v40 = CFrame.Angles
                    local v41 = u17[u36][1]
                    u38.CFrame = v39 * v40(0, 0, (math.rad(v41)))
                    u38.Parent = workspace.Effects
                    task.delay(0.15, function() --[[ Line: 211 ]]
                        --[[
                        Upvalues:
                            [1] = u38
                            [2] = u5
                            [3] = u2
                            [4] = u4
                        --]]
                        for _, v42 in u38:GetChildren() do
                            if v42:IsA("Attachment") then
                                local v43 = workspace:Raycast(v42.WorldPosition, v42.WorldCFrame.UpVector * -u38.Size.Y, u5)
                                if v43 and v43.Instance then
                                    local u44 = script.ClawMark2:Clone()
                                    local u45 = CFrame.lookAt(v43.Position, v43.Position + v42.WorldCFrame.LookVector, v43.Normal)
                                    local u46 = u45 * CFrame.new(0, 0, -8)
                                    u44:PivotTo(u46)
                                    u44:ScaleTo(0.001)
                                    _G.recolorParticles(u44, v43.Instance.Color)
                                    u44.Parent = workspace.Effects
                                    local v47 = Instance.new("NumberValue")
                                    v47.Value = 0.001
                                    v47.Changed:Connect(function(p48) --[[ Line: 230 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u44
                                            [2] = u46
                                            [3] = u45
                                        --]]
                                        u44:ScaleTo(p48 * 0.9)
                                        u44:PivotTo(u46:Lerp(u45, p48))
                                    end)
                                    u2:Create(v47, TweenInfo.new(0.125), {
                                        ["Value"] = 1
                                    }):Play()
                                    _G.destroy(v47, 0.2)
                                    u4(u44.ClawPart)
                                    u2:Create(u44.ClawPart.Glow, TweenInfo.new(0.25), {
                                        ["Transparency"] = 1
                                    }):Play()
                                    task.delay(1.75, function() --[[ Line: 243 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u44
                                            [2] = u2
                                        --]]
                                        for _, v49 in u44:GetDescendants() do
                                            if v49:IsA("Decal") and v49.Name ~= "Glow" then
                                                u2:Create(v49, TweenInfo.new(1), {
                                                    ["Transparency"] = 1
                                                }):Play()
                                            end
                                        end
                                        _G.destroy(u44, 1)
                                    end)
                                end
                            end
                        end
                    end)
                    u4(u38)
                    _G.destroy(u38, 3)
                    local v50 = script[u36 == 3 and "Extra" or "Basic"]:Clone()
                    v50.CFrame = v37
                    local v51, v52, _ = _G.getRayFloor(CFrame.new(v37.Position), 7)
                    if v51 == nil then
                        v50.GroundAttachment:Destroy()
                    else
                        v50.GroundAttachment.WorldPosition = v52 + Vector3.new(0, 0.3, 0)
                        _G.recolorParticles(v50, v51.Color)
                    end
                    v50.Parent = workspace.Effects
                    u4(v50)
                    _G.destroy(v50, 3)
                    _G.PlaySound(u8.PrimaryPart, script["DragonClawSlashW" .. u36]).Parent = u8.PrimaryPart
                    if u11 then
                        u9:FireServer(u8.PrimaryPart.CFrame)
                    end
                end
            end
        end)
    end
end
return v1