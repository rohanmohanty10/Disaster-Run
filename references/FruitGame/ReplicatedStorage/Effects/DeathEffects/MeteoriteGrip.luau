 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("ReplicatedStorage"):WaitForChild("Modules")
local u3 = Random.new()
local u4 = script:WaitForChild("Rocks")
function BeamFade(u5, p6)
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u7 = Instance.new("NumberValue")
    u7.Parent = u5.Parent
    u7:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u7
        --]]
        u5.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u7.Value), NumberSequenceKeypoint.new(0.625, u7.Value), NumberSequenceKeypoint.new(1, 1) })
    end)
    u7.Value = 0.9
    u2:Create(u7, TweenInfo.new(p6, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
        ["Value"] = 1
    }):Play()
    task.delay(p6, function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7:Destroy()
    end)
end
local u8 = {
    Enum.NormalId.Back,
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Top,
    Enum.NormalId.Bottom
}
function Apply(p9, p10)
    --[[
    Upvalues:
        [1] = u8
    --]]
    p9.Material = p10.Instance.Material
    p9.Color = p10.Instance.Color
    if p10.Instance:FindFirstChildWhichIsA("Texture") then
        local v11 = p10.Instance:FindFirstChildWhichIsA("Texture")
        for _, v12 in next, u8 do
            local v13 = v11:Clone()
            v13.Face = v12
            v13.Parent = p9
        end
    end
end
function v1.start(_, u14, p15) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    local u16 = script.Meteor:Clone()
    u16:SetPrimaryPartCFrame(CFrame.new(u14.HumanoidRootPart.Position + Vector3.new(350, 222, -350), u14.HumanoidRootPart.Position))
    u16.Parent = workspace.Effects
    _G.PlaySound(u14.PrimaryPart.CFrame, script.ZushiGripWhoosh).Parent = u16.PrimaryPart
    local v17 = (u16.PrimaryPart.Position - u14.HumanoidRootPart.Position).Magnitude
    u2:Create(u16.PrimaryPart, TweenInfo.new(v17 / 225, Enum.EasingStyle.Linear), {
        ["CFrame"] = u16.PrimaryPart.CFrame + u16.PrimaryPart.CFrame.LookVector * v17
    }):Play()
    local u18 = CFrame.new(u16.PrimaryPart.Position, u14.HumanoidRootPart.Position).LookVector
    local u19 = true
    task.spawn(function() --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u16
            [3] = u14
            [4] = u18
            [5] = u3
            [6] = u2
        --]]
        while u19 do
            local u20 = script.Circle:Clone()
            local v21 = CFrame.new(u16.PrimaryPart.Position, u14.HumanoidRootPart.Position) + u18 * 4
            local v22 = CFrame.Angles
            local v23 = u3:NextNumber(-360, 360)
            u20.CFrame = v21 * v22(1.5707963267948966, math.rad(v23), 0)
            u20.Parent = workspace.Effects
            local v24 = u2
            local v25 = TweenInfo.new(0.75)
            local v26 = {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(30.5, 1, 30.5)
            }
            local v27 = CFrame.new(u16.PrimaryPart.Position, u14.HumanoidRootPart.Position) + u18 * -4
            local v28 = CFrame.Angles
            local v29 = u3:NextNumber(-360, 360)
            v26.CFrame = v27 * v28(1.5707963267948966, math.rad(v29), 0)
            v24:Create(u20, v25, v26):Play()
            task.delay(0.75, function() --[[ Line: 81 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                u20:Destroy()
            end)
            task.wait(0.225)
        end
    end)
    task.wait(2.4)
    _G.PlaySound(u14.PrimaryPart.CFrame, script.ZushiGripBoom)
    local v30 = RaycastParams.new()
    v30.FilterType = Enum.RaycastFilterType.Blacklist
    v30.FilterDescendantsInstances = { workspace.Effects, u14, p15 }
    local v31 = workspace:Raycast(u16.PrimaryPart.Position, Vector3.new(0, -25, 0), v30)
    if v31 then
        for _ = 1, math.random(7, 13) do
            local u32 = u4:GetChildren()[math.random(1, #u4:GetChildren())]:Clone()
            u32.Position = u16.PrimaryPart.Position
            local v33 = u3:NextNumber(1, 3)
            u32.Size = u32.Size - Vector3.new(v33, v33, v33)
            local v34 = u3:NextNumber(0, 360)
            local v35 = u3:NextNumber(0, 360)
            local v36 = u3
            u32.Orientation = Vector3.new(v34, v35, v36:NextNumber(0, 360))
            u32.Anchored = false
            u32.CanCollide = false
            Apply(u32, v31)
            u32.Parent = workspace.Effects
            local u37 = Instance.new("BodyVelocity")
            u37.MaxForce = Vector3.new(inf, inf, inf)
            local v38 = u3:NextNumber(-11, 11)
            local v39 = u3:NextNumber(6.25, 10.5)
            local v40 = u3
            u37.Velocity = Vector3.new(v38, v39, v40:NextNumber(-11, 11)) * u3:NextNumber(1.75, 4)
            u37.Parent = u32
            local v41 = u2
            local v42 = TweenInfo.new(1)
            local v43 = {}
            local v44 = u3:NextNumber(0, 360)
            local v45 = u3:NextNumber(0, 360)
            local v46 = u3
            v43.Orientation = Vector3.new(v44, v45, v46:NextNumber(0, 360))
            v41:Create(u32, v42, v43):Play()
            task.delay(0.4, function() --[[ Line: 120 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u2
                    [3] = u32
                --]]
                u37:Destroy()
                task.wait(0.3)
                u2:Create(u32, TweenInfo.new(0.5), {
                    ["Size"] = Vector3.new(0, 0, 0),
                    ["Transparency"] = 1
                }):Play()
                task.wait(0.5)
                u32:Destroy()
            end)
        end
    end
    local v47 = next
    local v48, v49 = u16:GetChildren()
    for _, v50 in v47, v48, v49 do
        if v50:IsA("BasePart") then
            v50.Transparency = 1
        end
    end
    local v51 = next
    local v52, v53 = u16:GetDescendants()
    for _, v54 in v51, v52, v53 do
        if v54:IsA("ParticleEmitter") then
            v54.Enabled = false
        elseif v54:IsA("Beam") then
            BeamFade(v54, 0.5)
        end
    end
    _G.PlayEffect("GroundRocks", nil, CFrame.new(u16.PrimaryPart.Position), 15, 6, 20, 5)
    local v55 = script.Explosion:Clone()
    v55.Position = u16.PrimaryPart.Position
    v55.Parent = workspace.Effects
    _G.customEmit(v55)
    u19 = false
    _G.destroy({ u16, v55 }, 5)
end
return v1