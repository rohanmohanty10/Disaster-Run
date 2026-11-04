 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u4 = RaycastParams.new()
u4.FilterDescendantsInstances = { workspace.Effects }
u4.FilterType = Enum.RaycastFilterType.Exclude
local u5 = Random.new()
function v1.start(_, u6) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u5
        [4] = u2
    --]]
    local u7 = script.PresentMesh:Clone()
    u7:ScaleTo(Random.new():NextNumber(3, 5))
    u7.Parent = workspace.Effects
    local v8 = Color3.new(math.random(), math.random(), math.random())
    for _, v9 in pairs(u7:GetDescendants()) do
        if v9:IsA("BasePart") then
            v9.Color = v8
        end
    end
    local u10 = u6.AnimationDuration or 1
    local u11 = 0
    local u12 = math.random() * 3 * 3.141592653589793
    local u13 = math.random() * 3 * 3.141592653589793
    local u14 = math.random() * 3 * 3.141592653589793
    local v15 = -game.Workspace.Gravity
    local u16 = Vector3.new(0, v15, 0)
    local u17 = u6.StartCFrame * Vector3.new(0, 2, -2)
    local v18 = u6.EndPosition
    local v19 = u7.PrimaryPart.Size.Y / 2
    local u20 = v18 + Vector3.new(0, v19, 0) - u17 - u16 * 0.5
    local v21 = workspace:Raycast(u6.EndPosition + Vector3.new(0, 1, 0), Vector3.new(0, -100, 0), u4)
    local u22, u23, u24
    if v21 then
        local v25 = CFrame.new(v21.Position, v21.Position + v21.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
        u22, u23, u24 = (v25 - v25.Position):ToEulerAnglesXYZ()
    else
        u22 = 0
        u23 = 0
        u24 = 0
    end
    local u26 = nil
    u26 = u3.Heartbeat:Connect(function(p27) --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u10
            [3] = u16
            [4] = u20
            [5] = u17
            [6] = u12
            [7] = u14
            [8] = u7
            [9] = u22
            [10] = u13
            [11] = u23
            [12] = u24
            [13] = u26
            [14] = u6
            [15] = u5
            [16] = u2
        --]]
        local v28 = u11 / u10
        local v29 = math.min(v28, 1)
        local v30 = u16 * 0.5 * v29 * v29 + u20 * v29 + u17
        local v31 = v30 - (u16 * v29 * v29 + u20 * v29) / 3
        local v32 = (u16 * 0.125 * v29 * v29 + 0.5 * u20 * v29 + u17 - 0.125 * (u17 + v30)) / 0.375 - v31
        local v33 = v32 + (v31 - v32) * v29
        local v34 = v31 + (v30 - v31) * v29
        local v35 = u12 * (1 - v29) * (1 - v29)
        local v36 = math.max(v35, 0)
        local v37 = u14 * (1 - v29) * (1 - v29)
        local v38 = math.max(v37, 0)
        u7:PivotTo(CFrame.new(v33 + (v34 - v33) * v29) * CFrame.Angles(v36 + u22, u13 + u23, v38 + u24))
        u11 = u11 + p27
        if v29 >= 1 then
            u26:Disconnect()
            u26 = nil
            local v39 = script.Dust:Clone()
            v39.CFrame = u7:GetPivot()
            v39.Parent = workspace.Effects
            v39.Middle.Dust:Emit(v39.Middle.Dust:GetAttribute("EmitCount"))
            v39.Middle["Dust 2"]:Emit(v39.Middle["Dust 2"]:GetAttribute("EmitCount"))
            _G.destroy(v39, 3)
            _G.PlayEffect("PresentLandEffect", nil, {
                ["CFrame"] = u7:GetPivot() * CFrame.new(0, -u7.PrimaryPart.Size.Y / 2, 0),
                ["Scale"] = u7:GetScale()
            })
            task.wait(u6.PresentDuration or 1)
            _G.PlayEffect("PresentExplosion", nil, {
                ["Scale"] = u7:GetScale(),
                ["CFrame"] = u7.PrimaryPart.CFrame * CFrame.new(0, u7.PrimaryPart.Size.Y / 2, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
            })
            u7.Top.PrimaryPart.Anchored = false
            u7.Bottom.BottomMiddle.TopMiddleWeld:Destroy()
            local v40 = u7.Top.PrimaryPart
            local v41 = u5:NextInteger(-35, 35)
            local v42 = u5:NextInteger(100, 125)
            local v43 = u5
            v40.Velocity = Vector3.new(v41, v42, v43:NextInteger(-35, 35))
            local v44 = u7.Top.PrimaryPart
            local v45 = u5:NextInteger(-35, 35)
            local v46 = u5:NextInteger(-35, 35)
            local v47 = u5
            v44.RotVelocity = Vector3.new(v45, v46, v47:NextInteger(-35, 35))
            task.wait(2)
            for _, v48 in pairs(u7:GetDescendants()) do
                if v48:IsA("BasePart") then
                    u2:Create(v48, TweenInfo.new(1), {
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            _G.destroy(u7, 1)
        end
    end)
end
return v1