 

game:GetService("RunService")
game:GetService("VRService")
local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Whitelist
v1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u2 = workspace.Effects
local v3 = {}
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local function u10(p5, p6) --[[ Line: 13 ]]
    local v7 = { p5 }
    for _, v8 in p5:GetDescendants() do
        table.insert(v7, v8)
    end
    for _, v9 in v7 do
        if (v9:IsA("ParticleEmitter") or (v9:IsA("BasePart") or (v9:IsA("PointLight") or (v9:IsA("Trail") or v9:IsA("Highlight"))))) and v9:GetAttribute("recolorable") then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(p6)
            elseif v9:IsA("Highlight") then
                v9.FillColor = p6
                v9.OutlineColor = Color3.new(1, 1, 1)
            else
                v9.Color = p6
            end
        end
    end
    table.clear(v7)
end
function v3.start(_, u11, u12) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u4
        [3] = u2
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) == false then
        return
    end
    local function v18(p13) --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
            [3] = u4
            [4] = u11
        --]]
        local v14 = nil
        local v15 = nil
        for _, v16 in ipairs(script.trail:GetChildren()) do
            local v17 = v16:Clone()
            u10(v17, u12)
            u4.apply(v17, u11)
            if v17.Name == "A0" then
                v14 = v17.Trail
                v14.Attachment0 = v17
            else
                v15 = v17
            end
            v17.Parent = p13
        end
        v14.Attachment1 = v15
        return { v14, v15, v14.Parent }
    end
    local v19 = u11:WaitForChild("HumanoidRootPart", 5) or u11.PrimaryPart
    local v20 = {}
    local v21 = nil
    for v22 = 1, 2 do
        for _, v23 in script.BarrageEffects:GetChildren() do
            local v24 = v23:Clone()
            u10(v24, u12)
            u4.apply(v24, u11)
            v24.Parent = v22 == 1 and u11:FindFirstChild("RightHand") or u11:FindFirstChild("LeftHand")
            table.insert(v20, v24)
        end
    end
    for v25 = 1, 2 do
        local v26 = script.booster.cyborgBoosterEffects:Clone()
        u10(v26, u12)
        u4.apply(v26, u11)
        v26.Parent = v25 == 1 and u11:FindFirstChild("RightFoot") or u11:FindFirstChild("LeftFoot")
    end
    local u27 = v18(u11:FindFirstChild("RightFoot"))
    local u28 = v18(u11:FindFirstChild("LeftFoot"))
    local v29 = script.flurry:Clone()
    u10(v29, u12)
    u4.apply(v29, u11)
    v29.CFrame = v19.CFrame * CFrame.new(0, 0, -7)
    v29.Parent = u2
    local v30 = RaycastParams.new()
    v30.FilterType = Enum.RaycastFilterType.Blacklist
    v30.FilterDescendantsInstances = { u2, u11 }
    local v31 = workspace:Raycast(v19.Position, v19.CFrame.UpVector + Vector3.new(0, -10, 0), v30)
    if v31 then
        v21 = script.Smoke:Clone()
        v21.CFrame = CFrame.new(v31.Position, v19.CFrame.LookVector) * CFrame.new(0, 1, 0) * CFrame.Angles(0, -1.5707963267948966, 0)
        v21.Parent = u2
        v21.Smoke.Color = ColorSequence.new(v31.Instance.Color)
        u4.apply(v21, u11)
    end
    local v32 = tick()
    local v33, _, _ = _G.getRayFloor(u11.PrimaryPart.CFrame, 15)
    local v34 = 0
    while tick() - v32 < 2 do
        local v35 = script.att.LineAtt:Clone()
        u10(v35, u12)
        u4.apply(v35, u11)
        local v36 = v19.CFrame * CFrame.new(math.random(-400, 400) / 100, math.random(-100, 400) / 100, 1)
        local v37 = CFrame.Angles
        local v38 = math.random(-25, -10)
        v35.WorldCFrame = v36 * v37(math.rad(v38), 3.141592653589793, 0)
        v35.Parent = workspace.Terrain
        for _, v39 in v35:GetChildren() do
            _G.customEmit(v39)
        end
        _G.destroy(v35, 1.4)
        v29.CFrame = v19.CFrame * CFrame.new(0, 0, -7)
        local v40 = script.explosion:Clone()
        u10(v40, u12)
        u4.apply(v40, u11)
        local v41 = v19.CFrame * CFrame.new(math.random(-1100, 1100) / 100, math.random(-300, 750) / 100, math.random(-1100, -300) / 100)
        local v42 = CFrame.Angles
        local v43 = math.random(-360, 360)
        local v44 = math.rad(v43)
        local v45 = math.random(-360, 360)
        local v46 = math.rad(v45)
        local v47 = math.random(-360, 360)
        v40.CFrame = v41 * v42(v44, v46, (math.rad(v47)))
        v40.Parent = u2
        if v33 then
            v40.Attachment.rocks.Color = ColorSequence.new(v33.Color)
        end
        for _, v48 in v40:GetDescendants() do
            if v48:IsA("ParticleEmitter") then
                _G.customEmit(v48)
            end
        end
        _G.destroy(v40, 2)
        if tick() - v34 >= 0.05 then
            _G.PlaySound(v29, script["Audio/CyBarrageShot"], {
                ["Pitch"] = math.random(90, 110) / 100
            })
            v34 = tick()
        end
        if u11:FindFirstChild("PB") then
            break
        end
        task.wait()
    end
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
    u27[1].Enabled = false
    u28[1].Enabled = false
    task.delay(2, function() --[[ Line: 152 ]]
        --[[
        Upvalues:
            [1] = u28
            [2] = u27
        --]]
        for v52, v53 in u28 do
            v53:Destroy()
            u28[v52] = nil
        end
        for v54, v55 in u27 do
            v55:Destroy()
            u28[v54] = nil
        end
    end)
    for _, v56 in ipairs(v29:GetDescendants()) do
        if v56:IsA("ParticleEmitter") then
            v56.Enabled = false
        end
    end
    _G.destroy(v29, 4)
    if v21 then
        v21.Smoke.Enabled = false
        _G.destroy(v21, 5)
    end
    for v57, v58 in ipairs(v20) do
        if v58:IsA("ParticleEmitter") then
            v58.Enabled = false
        elseif v58:IsA("Attachment") then
            for _, v59 in v58:GetChildren() do
                v59.Enabled = false
            end
        end
        v20[v57] = nil
        _G.destroy(v58, 5)
    end
end
return v3