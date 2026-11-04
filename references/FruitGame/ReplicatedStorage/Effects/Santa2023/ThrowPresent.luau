 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
local u4 = game:GetService("ReplicatedStorage")
local u5 = game:GetService("Players").LocalPlayer
local u6 = RaycastParams.new()
u6.FilterDescendantsInstances = { workspace.Effects }
u6.FilterType = Enum.RaycastFilterType.Exclude
local function u24(p7, p8) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
    --]]
    local v9 = script.OpeningEffect:Clone()
    v9.CFrame = p7:GetPivot() * CFrame.new(0, v9.Size.Y / 2, 0)
    _G.scaleParticle(v9, p7:GetScale())
    v9.Parent = workspace.Effects
    for _, v10 in pairs(v9:GetDescendants()) do
        if v10:IsA("ParticleEmitter") then
            v10:Emit(v10:GetAttribute("EmitCount"))
        end
    end
    _G.destroy(v9, 2)
    local v11 = p8:WaitForChild("Item").Value
    local v12 = u4.Tools:FindFirstChild(v11)
    if v12 then
        local u13 = v12:Clone()
        local v14 = v9.CFrame
        local v15 = u13:GetExtentsSize().Y / 2
        u13:PivotTo(v14 + Vector3.new(0, v15, 0))
        for _, v16 in pairs(u13:GetDescendants()) do
            if v16:IsA("BasePart") then
                v16.Anchored = true
            end
        end
        u13.Parent = workspace.Effects
        _G.destroy(u13, 3)
        local u17 = u13:GetPivot()
        local u18 = nil
        u18 = u3.Heartbeat:Connect(function(_) --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u18
                [3] = u17
            --]]
            if u13.Parent then
                local v19 = u13
                local v20 = u17 * CFrame.Angles(0, tick() % 6.283185307179586, 0)
                local v21 = tick()
                local v22 = math.sin(v21)
                v19:PivotTo(v20 + Vector3.new(0, v22, 0))
            else
                u18:Disconnect()
                u18 = nil
            end
        end)
        task.delay(1.5, function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u2
            --]]
            for _, v23 in pairs(u13:GetDescendants()) do
                if v23:IsA("BasePart") then
                    u2:Create(v23, TweenInfo.new(1.5), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
        end)
        _G.destroy(u13, 3)
    end
end
local u25 = Random.new()
function v1.start(_, u26, u27, p28, p29) --[[ Line: 86 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u24
        [3] = u25
        [4] = u2
        [5] = u6
        [6] = u3
        [7] = u4
    --]]
    local u30 = script.ChristmasGift:Clone()
    u30:ScaleTo(Random.new():NextNumber(1.5, 2))
    u30:PivotTo(u26.StartCFrame)
    if p29 then
        local v31 = u30:GetDescendants()
        for v32 = 1, #v31 do
            if v31[v32].Name == "ColorStrip" and v31[v32]:IsA("BasePart") then
                v31[v32].Color = p29
            end
        end
    end
    if p28 == u5 then
        local v33 = Instance.new("Highlight")
        v33.FillColor = Color3.fromRGB(255, 255, 255)
        v33.FillTransparency = 0.5
        v33.OutlineColor = Color3.fromRGB(255, 255, 255)
        v33.OutlineTransparency = 1
        v33.FillColor = u30.Top.ColorStrip.Color
        v33.Parent = u30
    end
    u30.Parent = workspace.Effects
    local u34 = u26.Part
    local u35 = u34.ProximityPrompt
    local u36 = u30.Bottom.BottomMiddle
    u35:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u35
            [2] = u24
            [3] = u30
            [4] = u34
            [5] = u25
            [6] = u2
        --]]
        if not u35.Enabled then
            u24(u30, u34)
            u30.Top.TopMiddle.Weld:Destroy()
            local v37 = u30.Top.PrimaryPart
            local v38 = u25:NextInteger(-10, 10)
            local v39 = u25:NextInteger(100, 125)
            local v40 = u25
            v37.Velocity = Vector3.new(v38, v39, v40:NextInteger(-10, 10))
            local v41 = u30.Top.PrimaryPart
            local v42 = u25:NextInteger(-10, 10)
            local v43 = u25:NextInteger(-10, 10)
            local v44 = u25
            v41.RotVelocity = Vector3.new(v42, v43, v44:NextInteger(-10, 10))
            task.wait(2.5)
            for _, v45 in pairs(u30:GetDescendants()) do
                if v45:IsA("BasePart") then
                    u2:Create(v45, TweenInfo.new(2.5), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            task.wait(2.5)
            u30:Destroy()
        end
    end)
    local v46 = Color3.new(math.random(), math.random(), math.random())
    for _, v47 in pairs(u30:GetChildren()) do
        if v47:GetAttribute("Colourable") then
            v47.Color = v46
        end
    end
    local u48 = 0
    local u49 = math.random() * 3 * 3.141592653589793
    local u50 = math.random() * 3 * 3.141592653589793
    local u51 = math.random() * 3 * 3.141592653589793
    local v52 = -game.Workspace.Gravity
    local u53 = Vector3.new(0, v52, 0)
    local u54 = u26.StartCFrame * Vector3.new(0, 2, -2)
    local u55 = u26.EndPosition - u54 - u53 * 0.5
    local v56 = workspace:Raycast(u26.EndPosition + Vector3.new(0, 1, 0), Vector3.new(0, -100, 0), u6)
    local u57, u58, u59
    if v56 then
        local v60 = CFrame.new(v56.Position, v56.Position + v56.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
        u57, u58, u59 = (v60 - v60.Position):ToEulerAnglesXYZ()
    else
        u57 = 0
        u58 = 0
        u59 = 0
    end
    local u61 = nil
    u61 = u3.Heartbeat:Connect(function(p62) --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u27
            [3] = u53
            [4] = u55
            [5] = u54
            [6] = u49
            [7] = u51
            [8] = u30
            [9] = u57
            [10] = u50
            [11] = u58
            [12] = u59
            [13] = u36
            [14] = u61
            [15] = u26
            [16] = u4
        --]]
        local v63 = u48 / u27
        local v64 = math.min(v63, 1)
        local v65 = u53 * 0.5 * v64 * v64 + u55 * v64 + u54
        local v66 = v65 - (u53 * v64 * v64 + u55 * v64) / 3
        local v67 = (u53 * 0.125 * v64 * v64 + 0.5 * u55 * v64 + u54 - 0.125 * (u54 + v65)) / 0.375 - v66
        local v68 = v67 + (v66 - v67) * v64
        local v69 = v66 + (v65 - v66) * v64
        local v70 = u49 * (1 - v64) * (1 - v64)
        local v71 = math.max(v70, 0)
        local v72 = u51 * (1 - v64) * (1 - v64)
        local v73 = math.max(v72, 0)
        u30:PivotTo(CFrame.new(v68 + (v69 - v68) * v64) * CFrame.Angles(v71 + u57, u50 + u58, v73 + u59) * CFrame.new(0, u36.Size.Y / 2, 0))
        u48 = u48 + p62
        if v64 >= 1 then
            u61:Disconnect()
            u61 = nil
            local v74 = u30
            local v75 = CFrame.new(v68 + (v69 - v68) * 1) * CFrame.Angles(u57, u58, u59) * CFrame.new(0, u36.Size.Y / 2, 0)
            local v76 = CFrame.Angles
            local v77 = math.random(0, 360)
            v74:PivotTo(v75 * v76(0, math.rad(v77), 0))
            local v78 = script.Dust:Clone()
            v78.CFrame = u30:GetPivot()
            v78.Parent = workspace.Effects
            v78.Middle.Dust:Emit(v78.Middle.Dust:GetAttribute("EmitCount"))
            v78.Middle["Dust 2"]:Emit(v78.Middle["Dust 2"]:GetAttribute("EmitCount"))
            local v79 = (u26.OnWater and script.waterSplash or script.LandingEffect):Clone()
            v79.CFrame = u30:GetPivot() * CFrame.new(0, -u36.Size.Y / 2, 0)
            v79.Parent = workspace.Effects
            local v80 = u4.Assets.FootstepSounds.Water.Falls:GetChildren()
            _G.PlaySound(v79, u26.OnWater and v80[math.random(#v80)] or script["Audio/PresentHitGround"], {
                ["Pitch"] = math.random(90, 110) / 100
            })
            for _, v81 in pairs(v79:GetDescendants()) do
                if v81:IsA("ParticleEmitter") then
                    v81:Emit(v81:GetAttribute("EmitCount"))
                end
            end
            _G.destroy(v79, 5)
            _G.destroy(v78, 3)
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 14,
                ["Position"] = v78.Position + Vector3.new(0, 5, 0),
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 8,
                ["Direction"] = Vector3.new(0, -35, 0)
            })
        end
    end)
    u34.Destroying:Connect(function() --[[ Line: 229 ]]
        --[[
        Upvalues:
            [1] = u61
            [2] = u30
        --]]
        if u61 then
            u61:Disconnect()
            u61 = nil
        end
        if u30 then
            u30:Destroy()
        end
    end)
end
return v1