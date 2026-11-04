 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
require(script.Parent.SlashMesh)
local u4 = _G.customEmit
local u5 = RaycastParams.new()
local v6 = { workspace.Islands, workspace.Env, workspace.Ships }
local v7 = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = v6
u5.FilterType = v7
function v1.start(_, u8, u9) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
        [4] = u4
    --]]
    Random.new()
    local u10 = u8 == game.Players.LocalPlayer.Character
    local v11 = u8:FindFirstChild("DragonTailController", true)
    local u12 = {}
    local v13 = u8.Humanoid:LoadAnimation(script.Combo)
    v13:Play()
    table.insert(u12, v13)
    if v11 then
        local v14 = v11:LoadAnimation(script.Combo)
        v14:Play()
        table.insert(u12, v14)
    end
    _G.PlaySound(u8.PrimaryPart, script.DragonLightingSlashesStart).Parent = u8.PrimaryPart
    local u15 = {
        { 45, 0.7833333333333333, 30 },
        { -45, 1.1833333333333333, 25 },
        { 0, 1.5166666666666666, 10 }
    }
    local v16 = {
        0.46,
        35,
        1.1,
        1.5,
        45,
        0.2
    }
    local u17 = Instance.new("NumberValue")
    u17.Value = 0
    local u18 = nil
    local u19
    if u10 then
        u19 = Instance.new("BodyVelocity")
        u19.Velocity = u8:GetPivot().LookVector * u17.Value
        u19.MaxForce = Vector3.new(70000, 70000, 70000)
        u19.Parent = u8.PrimaryPart
    else
        u19 = nil
    end
    local _ = u8.Name .. "CharacterVelocityControlSlashCombo"
    if u19 then
        u18 = u3.RenderStepped:Connect(function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u8
                [3] = u17
            --]]
            u19.Velocity = u8:GetPivot().LookVector * u17.Value
        end)
    end
    for u20 = 1, #v16, 3 do
        local v21 = v16[u20]
        local u22 = v16[u20 + 1]
        local u23 = v16[u20 + 2]
        task.delay(v21, function() --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u8
                [3] = u17
                [4] = u22
                [5] = u2
                [6] = u23
            --]]
            if u20 == 1 then
                _G.PlaySound(u8.PrimaryPart, script.DragonLightingSlashesLeapForward)
            end
            u17.Value = u22
            u2:Create(u17, TweenInfo.new(u23, Enum.EasingStyle.Linear), {
                ["Value"] = 7
            }):Play()
        end)
    end
    local u24 = false
    local function u26() --[[ Line: 84 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u19
            [3] = u17
            [4] = u24
            [5] = u12
        --]]
        u18:Disconnect()
        u18 = nil
        u19:Destroy()
        u17:Destroy()
        u24 = true
        for v25 = 1, #u12 do
            u12[v25]:Stop()
        end
    end
    if u19 then
        task.delay(u15[#u15][2] + 0.2, function() --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u19
            --]]
            if u18 then
                u18:Disconnect()
                u18 = nil
                u19:Destroy()
            end
        end)
    end
    local v27 = u24
    for u28 = 1, #u15 do
        if v27 == true then
            break
        end
        task.delay(u15[u28][2], function() --[[ Line: 109 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u26
                [3] = u28
                [4] = u15
                [5] = u5
                [6] = u2
                [7] = u4
                [8] = u10
                [9] = u9
            --]]
            local v29 = u8:GetPivot()
            if u8:FindFirstChild("PB") then
                u26()
            else
                local u30 = script[u28 == 3 and "SlashFinal" or "Slash"]:Clone()
                local v31 = v29 * CFrame.new(0, 0.5, -1.5)
                local v32 = CFrame.Angles
                local v33 = u15[u28][1]
                u30.CFrame = v31 * v32(0, 0, (math.rad(v33)))
                u30.Parent = workspace.Effects
                task.delay(0.15, function() --[[ Line: 119 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u5
                        [3] = u2
                        [4] = u4
                    --]]
                    for _, v34 in u30:GetChildren() do
                        if v34:IsA("Attachment") then
                            local v35 = workspace:Raycast(v34.WorldPosition, v34.WorldCFrame.UpVector * -u30.Size.Y, u5)
                            if v35 and v35.Instance then
                                local u36 = script.ClawMark2:Clone()
                                local u37 = CFrame.lookAt(v35.Position, v35.Position + v34.WorldCFrame.LookVector, v35.Normal)
                                local u38 = u37 * CFrame.new(0, 0, -8)
                                u36:PivotTo(u38)
                                u36:ScaleTo(0.001)
                                _G.recolorParticles(u36, v35.Instance.Color)
                                u36.Parent = workspace.Effects
                                local v39 = Instance.new("NumberValue")
                                v39.Value = 0.001
                                v39.Changed:Connect(function(p40) --[[ Line: 138 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u36
                                        [2] = u38
                                        [3] = u37
                                    --]]
                                    u36:ScaleTo(p40 * 0.9)
                                    u36:PivotTo(u38:Lerp(u37, p40))
                                end)
                                u2:Create(v39, TweenInfo.new(0.125), {
                                    ["Value"] = 1
                                }):Play()
                                u4(u36.Part)
                                task.delay(1.75, function() --[[ Line: 150 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u36
                                        [2] = u2
                                    --]]
                                    for _, v41 in u36:GetDescendants() do
                                        if v41:IsA("Decal") then
                                            u2:Create(v41, TweenInfo.new(1), {
                                                ["Transparency"] = 1
                                            }):Play()
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end)
                u4(u30)
                _G.destroy(u30, 3)
                local v42 = script[u28 == 3 and "Extra" or "Basic"]:Clone()
                v42.CFrame = v29
                local v43, _, _ = _G.getRayFloor(CFrame.new(v29.Position), 7)
                if v43 == nil then
                    v42.GroundAttachment:Destroy()
                else
                    _G.recolorParticles(v42, v43.Color)
                end
                v42.Parent = workspace.Effects
                u4(v42)
                _G.destroy(v42, 3)
                _G.PlaySound(u8.PrimaryPart, script["DragonClawSlashW" .. u28]).Parent = u8.PrimaryPart
                if u10 then
                    u9:FireServer(u8.PrimaryPart.CFrame)
                end
            end
        end)
    end
end
return v1