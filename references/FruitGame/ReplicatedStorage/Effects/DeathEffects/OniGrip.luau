 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = {
    CFrame.new(0, 0, 6.25),
    CFrame.new(6.25, 0, 0),
    CFrame.new(0, 0, -6.25),
    CFrame.new(-6.25, 0, 0)
}
local u5 = Random.new()
function BeamFade(u6, p7)
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v8 = u6.Transparency.Keypoints
    local u9 = {}
    for u10 = 1, #v8 do
        local u11 = Instance.new("NumberValue")
        u11.Value = v8[u10].Time
        u11.Parent = u6
        local u12 = Instance.new("NumberValue")
        u12.Value = v8[u10].Value
        u12.Parent = u6
        local u13 = Instance.new("NumberValue")
        u13.Value = v8[u10].Envelope
        u13.Parent = u6
        u9[u10] = { u11.Value, u12.Value, u13.Value }
        u2:Create(u12, TweenInfo.new(p7), {
            ["Value"] = 1
        }):Play()
        u2:Create(u13, TweenInfo.new(p7), {
            ["Value"] = 1
        }):Play()
        u12:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u10
                [3] = u11
                [4] = u12
                [5] = u13
            --]]
            u9[u10] = { u11.Value, u12.Value, u13.Value }
        end)
    end
    local u17 = u3.Heartbeat:Connect(function() --[[ Line: 56 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u6
        --]]
        local v14 = {}
        for v15 = 1, #u9 do
            local v16 = u9[v15]
            v14[#v14 + 1] = NumberSequenceKeypoint.new(v16[1], v16[2], v16[3])
        end
        u6.Transparency = NumberSequence.new(v14)
    end)
    task.delay(p7, function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        u17:Disconnect()
    end)
end
function v1.start(_, u18, _) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u5
    --]]
    _G.PlaySound(u18.PrimaryPart, script.OniSealGrip)
    local u19 = script.Emit:Clone()
    u19.Position = u18.PrimaryPart.Position
    u19.Parent = workspace.Effects
    _G.customEmit(u19)
    u18.Archivable = true
    local u20 = u18:GetPivot()
    local u21 = u18:Clone()
    u21:PivotTo(CFrame.new(0, 100000, 0))
    u21.PrimaryPart.Anchored = true
    local v22 = Instance.new("AnimationController")
    u21.Humanoid:Destroy()
    v22.Name = "Humanoid"
    v22.Parent = u21
    local v23 = u21:GetDescendants()
    for _, u24 in v23 do
        if u24:IsA("BodyVelocity") then
            u24:Destroy()
        elseif u24:IsA("BaseScript") and u24.Name ~= "Script" then
            u24:Destroy()
        elseif u24:IsA("Weld") or u24:IsA("Motor6D") then
            if u24.Part1 and u24.Part1:IsDescendantOf(u21) == false then
                u24:Destroy()
            end
        elseif u24:IsA("Decal") then
            u24:Destroy()
        elseif u24:IsA("BasePart") and u24.Transparency ~= 1 then
            u24.Transparency = 0.5
            u24.Material = Enum.Material.Neon
            u24.Color = Color3.fromRGB(78, 229, 108)
            u24.CanTouch = false
            u24.CanQuery = false
            u24.CastShadow = false
            if u24:IsA("MeshPart") then
                u24.TextureID = ""
            end
            task.delay(7, function() --[[ Line: 119 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u24
                --]]
                u2:Create(u24, TweenInfo.new(1), {
                    ["Transparency"] = 1
                }):Play()
            end)
        end
    end
    u21.Parent = workspace.Effects
    v22:LoadAnimation(script.Animation):Play()
    task.delay(0.825, function() --[[ Line: 127 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u20
        --]]
        u21:PivotTo(u20)
    end)
    task.delay(2, function() --[[ Line: 131 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        u19:Destroy()
    end)
    for v25 = 1, 4 do
        local v26 = CFrame.Angles
        local v27 = v25 * 90 + u18.PrimaryPart.Orientation.Y
        local v28 = v26(0, 0, (math.rad(v27)))
        local u29 = script.Sword:Clone()
        local v30 = u18.PrimaryPart.CFrame
        local v31 = CFrame.Angles
        local v32 = u18.PrimaryPart.Orientation.Y
        u29:SetPrimaryPartCFrame(v30 * v31(0, 0, (math.rad(v32))))
        u29.Parent = workspace.Effects
        u29.Name = tostring(v25)
        local u33 = u18.PrimaryPart.CFrame * u4[v25] * CFrame.new(0, 7.5, 0) * v28
        u2:Create(u29.PrimaryPart, TweenInfo.new(0.5), {
            ["CFrame"] = CFrame.new(u33.Position, u33.Position - Vector3.new(0, 10, 0)) * v28
        }):Play()
        task.delay(0.6, function() --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u29
                [3] = u33
                [4] = u18
                [5] = u5
            --]]
            u2:Create(u29.PrimaryPart, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = u29.PrimaryPart.CFrame * CFrame.new(0, 0, 1)
            }):Play()
            task.wait(0.15)
            u2:Create(u29.PrimaryPart, TweenInfo.new(0.075, Enum.EasingStyle.Exponential), {
                ["CFrame"] = u29.PrimaryPart.CFrame * CFrame.new(0, 0, -7.75)
            }):Play()
            task.wait(0.075)
            local v34 = script.Hit:Clone()
            v34.Position = u33.Position - Vector3.new(0, 10.5, 0)
            v34.Parent = workspace.Effects
            _G.customEmit(v34)
            for v35 = 1, 3 do
                local u36 = script.Start:Clone()
                u36.CFrame = CFrame.new(u29.PrimaryPart.Position, u18.PrimaryPart.Position) * CFrame.Angles(0, 3.141592653589793, 0)
                u36.Parent = workspace.Effects
                local v37 = CFrame.new(u18.PrimaryPart.Position, u29.PrimaryPart.Position) * CFrame.new(0, 1.35, 0)
                local u38 = script.End:Clone()
                u38.CFrame = v37
                u38.Parent = workspace.Effects
                u38.Position = u36.Position
                if v35 == 2 then
                    u36.Position = u36.Position - Vector3.new(0, 0.75, 0)
                    u2:Create(u38, TweenInfo.new(0.5), {
                        ["Position"] = v37.Position - Vector3.new(0, 2.5, 0)
                    }):Play()
                elseif v35 == 3 then
                    u36.Position = u36.Position - Vector3.new(0, 1, 0)
                    u2:Create(u38, TweenInfo.new(0.5), {
                        ["Position"] = v37.Position - Vector3.new(0, 5.5, 0)
                    }):Play()
                else
                    u2:Create(u38, TweenInfo.new(0.5), {
                        ["Position"] = v37.Position
                    }):Play()
                end
                local u39 = u36.Attachment.Beam
                u39.Attachment0 = u36.Attachment
                u39.Attachment1 = u38.Attachment
                u39.TextureSpeed = u5:NextNumber(1, 4)
                u2:Create(u39, TweenInfo.new(u5:NextNumber(0.75, 2)), {
                    ["LightInfluence"] = 0,
                    ["TextureSpeed"] = 0
                }):Play()
                task.delay(7.825, function() --[[ Line: 199 ]]
                    --[[
                    Upvalues:
                        [1] = u39
                        [2] = u36
                        [3] = u38
                    --]]
                    BeamFade(u39, 0.5)
                    task.wait(0.5)
                    u36:Destroy()
                    u38:Destroy()
                end)
            end
            local v40 = script.SwordAfter:Clone()
            v40.Position = u33.Position - Vector3.new(0, 11.5, 0)
            v40.Parent = workspace.Effects
            task.wait(8.25)
            v34:Destroy()
            local v41 = next
            local v42, v43 = u29:GetDescendants()
            for _, v44 in v41, v42, v43 do
                if v44:IsA("BasePart") then
                    u2:Create(v44, TweenInfo.new(0.5), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            local v45 = next
            local v46, v47 = v40:GetDescendants()
            for _, v48 in v45, v46, v47 do
                if v48:isA("ParticleEmitter") then
                    v48.Enabled = false
                end
            end
            task.wait(0.5)
            u29:Destroy()
            task.wait(4.5)
            v40:Destroy()
        end)
    end
    task.wait(0.825)
    local _, v49, _ = _G.getRayFloor(u18.PrimaryPart.CFrame, 5)
    local v50 = script.Floor:Clone()
    v50.Size = Vector3.new(17.5, 0.1, 17.5)
    v50.CFrame = u18.HumanoidRootPart.CFrame * CFrame.new(0, -(u18.PrimaryPart.Position - v49).Magnitude, 0)
    v50.Transparency = 1
    v50.Parent = workspace.Effects
    u2:Create(v50, TweenInfo.new(0.1), {
        ["Transparency"] = 0.345
    }):Play()
    local v51 = script.Shine:Clone()
    v51.Position = u18.HumanoidRootPart.Position
    v51.Parent = workspace.Effects
    _G.customEmit(v51)
    _G.destroy(v23, 7)
    task.wait(1)
    local v52 = script.After:Clone()
    v52.Position = u18.PrimaryPart.Position + Vector3.new(0, 9, 0)
    v52.Size = Vector3.new(9.375, 2, 9.375)
    v52.Parent = workspace.Effects
    task.wait(6)
    u2:Create(v50, TweenInfo.new(1), {
        ["Transparency"] = 1
    }):Play()
    local v53 = next
    local v54, v55 = v52:GetDescendants()
    for _, v56 in v53, v54, v55 do
        if v56:isA("ParticleEmitter") then
            v56.Enabled = false
        end
    end
    task.wait(1)
    v50:Destroy()
    task.wait(7)
    v51:Destroy()
    v52:Destroy()
end
return v1