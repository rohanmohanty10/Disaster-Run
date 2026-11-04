 

local u1 = game:GetService("RunService")
game:GetService("VRService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = RaycastParams.new()
u4.FilterType = Enum.RaycastFilterType.Whitelist
u4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u10(p5, p6) --[[ Line: 9 ]]
    local v7 = { p5 }
    for _, v8 in p5:GetDescendants() do
        table.insert(v7, v8)
    end
    for _, v9 in v7 do
        if (v9:IsA("ParticleEmitter") or (v9:IsA("BasePart") or (v9:IsA("PointLight") or (v9:IsA("Trail") or (v9:IsA("Highlight") or v9:IsA("Decal")))))) and v9:GetAttribute("recolorable") then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(p6)
            elseif v9:IsA("Highlight") then
                v9.FillColor = p6
                v9.OutlineColor = Color3.new(1, 1, 1)
            elseif v9:IsA("Decal") then
                v9.Color3 = p6
            else
                v9.Color = p6
            end
        end
    end
    table.clear(v7)
end
function v3.start(_, u11, p12, p13, u14, p15) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u4
        [4] = u1
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) == false then
        return
    end
    local v16 = u11:FindFirstChildOfClass("Humanoid")
    local v17 = u11.PrimaryPart
    local v18 = p12.PrimaryPart
    local function v24(p19) --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u14
            [3] = u2
            [4] = u11
        --]]
        local v20 = nil
        local v21 = nil
        for _, v22 in ipairs(script.trail:GetChildren()) do
            local v23 = v22:Clone()
            u10(v23, u14)
            u2.apply(v23, u11)
            if v23.Name == "A0" then
                v20 = v23.Trail
                v20.Attachment0 = v23
            else
                v21 = v23
            end
            v23.Parent = p19
        end
        v20.Attachment1 = v21
        return { v20, v21, v20.Parent }
    end
    local v25, _, _ = _G.getRayFloor(u11.PrimaryPart.CFrame, 15)
    local v26 = tick()
    v17.Anchored = true
    v16.AutoRotate = false
    local v27 = 0
    for v28 = 1, 2 do
        local v29 = script.booster.cyborgBoosterEffects:Clone()
        u10(v29, u14)
        u2.apply(v29, u11)
        v29.Parent = v28 == 1 and u11:FindFirstChild("RightFoot") or u11:FindFirstChild("LeftFoot")
    end
    local u30 = v24(u11:FindFirstChild("RightFoot"))
    local u31 = v24(u11:FindFirstChild("LeftFoot"))
    local v32 = script.tings:Clone()
    u10(v32, u14)
    u2.apply(v32, u11)
    if v25 then
        v32.center2.Smoke.Color = ColorSequence.new(v25.Color)
    else
        v32.center2.Smoke:Destroy()
    end
    v32.Parent = workspace.Effects
    local v33 = Instance.new("ObjectValue")
    v33.Name = "CyborgRushing"
    v33.Parent = u11
    local v34 = script.stars:Clone()
    u10(v34, u14)
    u2.apply(v34, u11)
    if v25 then
        v34.Attachment.Smoke.Color = ColorSequence.new(v25.Color)
        v34.Attachment.rocks.Color = ColorSequence.new(v25.Color)
    else
        v34.Attachment.rocks:Destroy()
        v34.Attachment.Smoke:Destroy()
    end
    v34.CFrame = v17.CFrame * CFrame.new(0, 0, 1.5)
    v34.Parent = workspace.Effects
    _G.tween(v34.PointLight, {
        0.4,
        "Quad",
        Enum.EasingDirection.In,
        0,
        false,
        0
    }, {
        ["Brightness"] = 0
    })
    local v35 = workspace:Raycast(v17.Position, v17.CFrame.UpVector * Vector3.new(0, -10, 0), u4)
    if v35 then
        local u36 = script.bigfloorFire:Clone()
        u10(u36, u14)
        u2.apply(u36, u11)
        local v37 = CFrame.new(v35.Position, v35.Position + v35.Normal)
        local v38 = CFrame.Angles
        local v39 = math.random(0, 360)
        u36.CFrame = v37 * v38(-1.5707963267948966, math.rad(v39), 0)
        u36.Parent = workspace.Effects
        task.delay(2 + math.random(100, 140) / 100, function() --[[ Line: 112 ]]
            --[[
            Upvalues:
                [1] = u36
            --]]
            for _, v40 in ipairs(u36:GetChildren()) do
                v40.Enabled = false
            end
            _G.destroy(u36, 4)
        end)
    end
    _G.customEmit(v34)
    _G.destroy(v34, 5)
    local v41 = u11.Humanoid:LoadAnimation(script.attemptAirLoop)
    v41:Play()
    local v42 = 0
    local v43 = false
    local v44 = 0
    local v45 = false
    while tick() - v26 < p13 do
        v42 = v42 + v44
        while v42 >= 0.016666666666666666 do
            v27 = v27 + 0.05
            local v46 = (v17.Position - v18.Position).Magnitude
            local v47 = v27 / v46
            local v48 = math.clamp(v47, 0, 1)
            if v46 <= 8 then
                p15:FireServer(u11.PrimaryPart.CFrame)
                v45 = true
                v43 = true
                break
            end
            u11:PivotTo(CFrame.new(v17.CFrame:Lerp(v18.CFrame * CFrame.new(0, 0, -2), v48).Position, v18.Position))
            v32.CFrame = v17.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
            v42 = v42 - 0.016666666666666666
        end
        if v45 == true then
            break
        end
        v44 = u1.Heartbeat:Wait()
    end
    if v43 == true then
        p15:FireServer("finished")
    end
    v41:Stop()
    v33.Value = p12
    _G.destroy(v33, 0.4)
    for v49 = 1, 2 do
        local v50 = u11:FindFirstChild(v49 == 1 and "RightFoot" or "LeftFoot"):FindFirstChild("cyborgBoosterEffects")
        for _, v51 in ipairs(v50:GetChildren()) do
            if v51:IsA("ParticleEmitter") then
                v51.Enabled = false
            end
        end
        v50.Name = "d"
        _G.destroy(v50, 4)
    end
    u30[1].Enabled = false
    u31[1].Enabled = false
    task.delay(2, function() --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u30
        --]]
        for v52, v53 in u31 do
            v53:Destroy()
            u31[v52] = nil
        end
        for v54, v55 in u30 do
            v55:Destroy()
            u31[v54] = nil
        end
    end)
    for _, v56 in ipairs(v32:GetDescendants()) do
        if v56:IsA("ParticleEmitter") or (v56:IsA("Trail") or v56:IsA("PointLight")) then
            v56.Enabled = false
        end
    end
    _G.destroy(v32, 4)
    v17.Anchored = false
    v16.AutoRotate = true
end
return v3