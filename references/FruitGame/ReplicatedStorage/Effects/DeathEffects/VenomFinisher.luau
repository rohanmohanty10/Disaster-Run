 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = script:WaitForChild("Animations")
local u4 = require(script.Parent.BodyTransparency)
local u5 = _G.customEmit
function PlayAnim(p6, p7)
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v8 = (p6:FindFirstChild("Humanoid") or p6:FindFirstChild("AnimationController")).Animator:LoadAnimation(u3[p7])
    v8:Play(0, 1, 1)
    return v8
end
local function u28(p9, p10) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u11 = script.CylinderR:Clone()
    local v12 = next
    local v13, v14 = u11:GetChildren()
    for _, v15 in v12, v13, v14 do
        local v16 = (p10.Position - p9.Position).Magnitude * 1.5
        local v17 = v15.Size.Y
        local v18 = v15.Size.Z
        v15.Size = Vector3.new(v16, v17, v18)
    end
    u11:SetPrimaryPartCFrame(CFrame.new(p10.Position, p9.Position) * CFrame.new(0, 0, -(p10.Position - p9.Position).Magnitude / 2) * CFrame.Angles(0, 0, Random.new():NextNumber(-3.141592653589793, 3.141592653589793)))
    u11.Parent = workspace.Effects
    _G.destroy(u11, 0.4)
    local v19 = next
    local v20, v21 = u11:GetChildren()
    for _, u22 in v19, v20, v21 do
        task.delay(0.125, function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u22
                [3] = u11
            --]]
            local v23 = u2
            local v24 = u22
            local v25 = TweenInfo.new(u11.Name == "Glass" and 0.3 or 0.25, Enum.EasingStyle.Linear)
            local v26 = {}
            local v27 = u22.Size.X
            v26.Size = Vector3.new(v27, 0, 0)
            v23:Create(v24, v25, v26):Play()
        end)
    end
end
function v1.start(_, p29) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u28
        [2] = u4
        [3] = u5
        [4] = u2
    --]]
    local v30 = Random.new()
    local v31 = p29:GetPivot()
    local v32 = script.DokuDragonR:Clone()
    local v33 = v31 * CFrame.new(v30:NextNumber(-35, 35), v30:NextNumber(15, 25), v30:NextNumber(-35, 35))
    local v34 = (CFrame.new(v33.Position, v31.Position) * CFrame.new(v30:NextNumber(-45, 45), v30:NextNumber(-45, 45), -(v33.Position - v31.Position).Magnitude / 2)).Position
    v32:PivotTo(v33)
    v32.Parent = workspace.Effects
    PlayAnim(v32, "Idle")
    local v35 = tick()
    while tick() - v35 < 0.5 do
        local v36 = (tick() - v35) / 0.5
        local v37 = math.clamp(v36, 0, 1)
        local v38 = v33.Position
        local v39 = v31.Position
        local v40 = (1 - v37) ^ 2 * v38 + 2 * (1 - v37) * v37 * v34 + v37 ^ 2 * v39
        local v41 = v33.Position
        local v42 = v31.Position
        local v43 = v37 + 0.001
        local v44 = (1 - v43) ^ 2 * v41 + 2 * (1 - v43) * v43 * v34 + v43 ^ 2 * v42
        local v45 = v32:GetPivot()
        local v46 = CFrame.new(v40, v44)
        v32:PivotTo(v46)
        u28(v46, v45)
        task.wait()
    end
    v32:Destroy()
    u4:start(p29)
    local v47 = script.VenomExplosion:Clone()
    v47.CFrame = v31
    v47.Parent = workspace.Effects
    local v48 = script.Melt:Clone()
    v48.CFrame = v31
    v48.Parent = workspace.Effects
    u5(v47)
    u5(v48)
    local v49 = script.Puddle:Clone()
    v49:PivotTo(v31 * CFrame.new(0, -3, 0) * CFrame.Angles(0, v30:NextNumber(-3.141592653589793, 3.141592653589793), 0))
    v49.Parent = workspace.Effects
    for _, v50 in v49:GetChildren() do
        if v50.Name == "Out" or v50.Name == "Inner" then
            local v51 = v50.Size
            local v52 = v50.CFrame
            v50.Size = Vector3.new(0, 0, 0)
            v50.CFrame = v50.CFrame * CFrame.new(0, -v51.Y / 2, 0)
            u2:Create(v50, TweenInfo.new(v30:NextNumber(0.15, 0.3)), {
                ["Size"] = v51,
                ["CFrame"] = v52
            }):Play()
        end
    end
    task.wait(2)
    for _, v53 in v49:GetDescendants() do
        if v53:IsA("ParticleEmitter") then
            v53.Enabled = false
        else
            u2:Create(v53, TweenInfo.new(v30:NextNumber(0.6, 0.9)), {
                ["Size"] = Vector3.new(0, 0, 0)
            }):Play()
        end
    end
    _G.destroy(v48, 1.5)
    _G.destroy(v47, 4.5)
    _G.destroy(v49, 2.5)
end
return v1