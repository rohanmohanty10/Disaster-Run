 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local u3 = require(v1.Modules.CurveLibrary).Bezier.QuadBezier
local u4 = script.Auras:GetChildren()
local v5 = {}
local u6 = {}
local u7 = RaycastParams.new()
u7.FilterType = Enum.RaycastFilterType.Whitelist
u7.FilterDescendantsInstances = { workspace.Env }
local function u10(p8, p9) --[[ Line: 19 ]]
    return Random.new():NextNumber(p8, p9)
end
local function u15(p11) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _, v12 in p11:GetChildren() do
        if v12:IsA("BasePart") and v12 ~= p11.PrimaryPart then
            for _, v13 in u4 do
                local u14 = v13:Clone()
                u14:SetAttribute("RaiuAura", true)
                u14.Parent = v12
                task.delay(math.random(0, 40) / 100, function() --[[ Line: 36 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                    --]]
                    u14.Enabled = true
                end)
            end
        end
    end
end
local function u19(p16) --[[ Line: 43 ]]
    for _, v17 in p16:GetChildren() do
        if v17:IsA("BasePart") and v17 ~= p16.PrimaryPart then
            for _, v18 in v17:GetDescendants() do
                if v18:IsA("ParticleEmitter") and v18:GetAttribute("RaiuAura") then
                    v18:Destroy()
                end
            end
        end
    end
end
local function u25(p20) --[[ Line: 59 ]]
    local v21 = p20.HumanoidRootPart
    local u22 = script.RedMesh:Clone()
    u22.CFrame = v21.CFrame * CFrame.new(0, -3.2, 0) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(math.random(-6.283185307179586, 6.283185307179586), 0, 0)
    u22.Parent = workspace.Effects
    local v23 = math.random(0, 5) / 100
    local v24 = math.random(25, 29) / 100
    u22.Mesh.Scale = Vector3.new(0.12, v23, v23)
    _G.tween(u22, { 0.26, "Circular", "Out" }, {
        ["CFrame"] = u22.CFrame * CFrame.new(-0.7, 0, 0) * CFrame.Angles(-1.7453292519943295, 0, 0)
    })
    _G.tween(u22.Mesh, { 0.26, "Circular", "Out" }, {
        ["Scale"] = Vector3.new(0.12, v24, v24)
    })
    _G.tween(u22.Decal, { 0.26, "Quad", "Out" }, {
        ["Transparency"] = 1
    })
    task.delay(0.3, function() --[[ Line: 75 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        u22:Destroy()
    end)
end
local function u40(p26) --[[ Line: 80 ]]
    local v27 = p26.HumanoidRootPart
    local v28 = Random.new()
    local v29 = v28:NextInteger(1, 2)
    local u30
    if v29 == 1 then
        u30 = script.WhiteMesh:Clone()
    else
        u30 = script.WhiteMesh2:Clone()
    end
    u30.CFrame = v27.CFrame * CFrame.new(0, -3.1, 0) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(math.random(-6.283185307179586, 6.283185307179586), 0, 0)
    u30.Parent = workspace.Effects
    local v31 = v28:NextNumber(0.07, 0.14)
    local v32
    if v29 == 1 then
        v32 = v28:NextNumber(0.29, 0.34)
    else
        v32 = v28:NextNumber(0.29, 0.36)
    end
    u30.Mesh.Scale = Vector3.new(0.09, v31, v31)
    u30.Decal.Transparency = 1
    _G.tween(u30.Decal, { 0.1, "Linear", "Out" }, {
        ["Transparency"] = math.random(35, 60) / 100
    })
    task.delay(0.1, function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        _G.tween(u30.Decal, { 0.26, "Linear", "Out" }, {
            ["Transparency"] = 1
        })
    end)
    local v33
    if v29 == 1 then
        local v34 = u30.CFrame * CFrame.new(-math.random(70, 75) / 100, 0, 0)
        local v35 = CFrame.Angles
        local v36 = math.random(80, 110)
        v33 = v34 * v35(-math.rad(v36), 0, 0)
    else
        local v37 = u30.CFrame * CFrame.new(-math.random(70, 75) / 100, 0, 0)
        local v38 = CFrame.Angles
        local v39 = math.random(-100, 100)
        v33 = v37 * v38(-math.rad(v39), 0, 0)
    end
    _G.tween(u30, { 0.36, "Circular", "Out" }, {
        ["CFrame"] = v33
    })
    _G.tween(u30.Mesh, { 0.36, "Circular", "Out" }, {
        ["Scale"] = Vector3.new(0.12, v32, v32)
    })
    task.delay(0.4, function() --[[ Line: 110 ]]
        --[[
        Upvalues:
            [1] = u30
        --]]
        u30:Destroy()
    end)
end
function v5.start(_, u41, p42) --[[ Line: 115 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
        [3] = u2
        [4] = u3
        [5] = u25
        [6] = u40
        [7] = u15
        [8] = u19
        [9] = u7
    --]]
    if _G.checkRenderDistance(u41.PrimaryPart.Position) == false then
        return
    end
    local v43 = u41.HumanoidRootPart
    local v44 = u41.LowerTorso
    local u45 = u41.RightHand
    local v46 = u41:FindFirstChild("RaiuiSword")
    local v47
    if v46 then
        v47 = v46:FindFirstChild("Middle")
    else
        v47 = nil
    end
    u6[u41] = p42
    if p42 == "Hold" then
        local v48 = tick()
        local v49 = 0
        local v50 = 0
        while true do
            if true then
                task.wait()
                local v51 = nil
                local u52 = nil
                if tick() - v49 > 0.04 then
                    v49 = tick()
                    u52 = 0.27
                    v51 = 2
                elseif tick() - v50 > 0.03 then
                    v50 = tick()
                    u52 = 0.36
                    v51 = 1
                end
            end
            if v51 then
                local v53 = Random.new():NextNumber(-8, 8)
                local v54 = Random.new():NextNumber(-8, 8)
                local v55 = u10
                local u56 = Vector3.new(v53, v54, v55(-8, 8))
                local v57 = Random.new():NextNumber(-11.5, 11.5)
                local v58 = Random.new():NextNumber(-11.5, 11.5) / 1.4
                local v59 = u10
                local v60 = Vector3.new(v57, v58, v59(-11.5, 11.5))
                local u61 = u45.CFrame
                local u62 = u61 + v60
                local u63 = u62.Position:Lerp(u61.Position, 0.45) + u56
                local u64
                if v51 == 2 then
                    u64 = script.Trail2:Clone()
                else
                    u64 = script.Trail:Clone()
                end
                u64.CFrame = u62
                for _, v65 in u64:GetDescendants() do
                    if v65:IsA("Trail") then
                        v65.Enabled = true
                    end
                end
                u64.Parent = workspace.Effects
                local u66 = tick()
                local u67 = 0
                local u68 = nil
                u68 = u2.Heartbeat:Connect(function(_) --[[ Line: 176 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                        [2] = u68
                        [3] = u64
                        [4] = u61
                        [5] = u45
                        [6] = u63
                        [7] = u62
                        [8] = u56
                        [9] = u66
                        [10] = u52
                        [11] = u3
                    --]]
                    if u67 == 1 then
                        u68:Disconnect()
                        task.delay(0.8, u64.Destroy, u64)
                    else
                        u61 = u45.CFrame * CFrame.new(0, 0.1, -1.1)
                        u63 = u62.Position:Lerp(u61.Position, 0.8) + u56
                        local v69 = (tick() - u66) / u52
                        u67 = math.min(v69, 1)
                        u64.Position = u3(u67, u62.Position, u63, u61.Position)
                    end
                end)
            end
            if u6[u41] ~= "Hold" or tick() - v48 > 0.3 then
                task.defer(function() --[[ Line: 194 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u41
                    --]]
                    repeat
                        u25(u41)
                        task.wait(0.09090909090909091)
                    until u41:GetAttribute("dragonFlashHold") == nil
                end)
                task.defer(function() --[[ Line: 203 ]]
                    --[[
                    Upvalues:
                        [1] = u40
                        [2] = u41
                    --]]
                    repeat
                        u40(u41)
                        task.wait(0.03333333333333333)
                    until u41:GetAttribute("dragonFlashHold") == nil
                end)
                u15(u41)
                local v70 = script.RaiuMove2Emitter:Clone()
                v70.CFrame = v43.CFrame
                v70.Weld.Part0 = v70
                v70.Weld.Part1 = v43
                v70.Name = "RaiuMove2Emitter" .. u41.Name
                v70.Parent = workspace.Effects
                local v71 = script.RaiuMove2TorsoEmitter:Clone()
                v71.CFrame = v43.CFrame
                v71.Weld.Part0 = v71
                v71.Weld.Part1 = v44
                v71.Name = "RaiuMove2TorsoEmitter" .. u41.Name
                v71.Parent = workspace.Effects
                for _, v72 in v70.Enable:GetChildren() do
                    v72.Enabled = true
                end
                for _, v73 in v71.Enable:GetChildren() do
                    v73.Enabled = true
                end
                for _, v74 in v70.Emit2:GetChildren() do
                    _G.customEmit(v74)
                end
                task.wait(0.1)
                if v47 then
                    local u75 = Instance.new("Attachment")
                    u75.Position = Vector3.new(0, 0.73, -5.524)
                    u75.Parent = v47
                    for _, v76 in script.SwordEmit:GetChildren() do
                        local v77 = v76:Clone()
                        v77.Parent = u75
                        _G.customEmit(v77)
                    end
                    task.delay(1, function() --[[ Line: 254 ]]
                        --[[
                        Upvalues:
                            [1] = u75
                        --]]
                        u75:Destroy()
                    end)
                    return
                end
                ::l34::
                return
            end
        end
    else
        if p42 == "Slash" then
            u19(u41)
            local u78 = workspace.Effects:FindFirstChild("RaiuMove2Emitter" .. u41.Name)
            local u79 = workspace.Effects:FindFirstChild("RaiuMove2TorsoEmitter" .. u41.Name)
            u78.Name = "_"
            u79.Name = "_"
            if u78 then
                for _, v80 in u78:GetDescendants() do
                    if v80:IsA("ParticleEmitter") then
                        v80.Enabled = false
                    end
                end
                task.delay(1, function() --[[ Line: 276 ]]
                    --[[
                    Upvalues:
                        [1] = u78
                    --]]
                    u78:Destroy()
                end)
            end
            if u79 then
                for _, v81 in u79:GetDescendants() do
                    if v81:IsA("ParticleEmitter") then
                        v81.Enabled = false
                    end
                end
                task.delay(1, function() --[[ Line: 288 ]]
                    --[[
                    Upvalues:
                        [1] = u79
                    --]]
                    u79:Destroy()
                end)
            end
            local u82 = script.Shoot:Clone()
            u82.CFrame = v43.CFrame * CFrame.new(0.5, 0.2, -1)
            u82.Parent = workspace.Effects
            for _, v83 in u82:GetDescendants() do
                if v83:IsA("ParticleEmitter") then
                    _G.customEmit(v83)
                end
            end
            task.delay(1.6, function() --[[ Line: 303 ]]
                --[[
                Upvalues:
                    [1] = u82
                --]]
                u82:Destroy()
            end)
            local u84 = script.UnleashSlash:Clone()
            u84.CFrame = v43.CFrame * CFrame.new(0, 0, -2)
            u84.Parent = workspace.Effects
            for _, v85 in u84:GetDescendants() do
                if v85:IsA("ParticleEmitter") then
                    _G.customEmit(v85)
                end
            end
            task.delay(1, function() --[[ Line: 317 ]]
                --[[
                Upvalues:
                    [1] = u84
                --]]
                u84:Destroy()
            end)
            local v86 = script.SlashMesh:Clone()
            v86.CFrame = v43.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, 1.5707963267948966)
            workspace:Raycast(v43.Position, Vector3.new(0, -15, 0), u7)
            v86.Parent = workspace.Effects
            _G.PlaySound(v86, script.RaiuSlashShoot).Parent = v86
            for _, v87 in v86:GetDescendants() do
                if v87:IsA("Beam") then
                    local v88 = v87.Transparency
                    v87.Transparency = NumberSequence.new(1)
                    v87.Enabled = true
                    _G.tween(v87, { 0.1, "Cubic", "Out" }, {
                        ["Transparency"] = v88
                    })
                elseif v87:IsA("ParticleEmitter") then
                    v87.Enabled = true
                end
            end
            local v89 = _G.getRayFloor(v43.CFrame, 15)
            if v89 == nil then
                v86.GroundTrail.Enabled = false
                _G.particleEnabled(v86.Rocks, false)
            else
                local v90 = v86.Rocks:GetChildren()
                for v91 = 1, #v90 do
                    v90[v91].Color = ColorSequence.new(v89.Color)
                end
                warn("ghas floor new color")
            end
            _G.tween(v86, { 0.32, "Linear", "Out" }, {
                ["CFrame"] = v86.CFrame * CFrame.new(0, 0, -45)
            })
            task.wait(0.35)
            for _, v92 in v86:GetDescendants() do
                if v92:IsA("Beam") then
                    _G.tween(v92, { 0.1, "Cubic", "Out" }, {
                        ["Transparency"] = NumberSequence.new(1)
                    })
                elseif v92:IsA("ParticleEmitter") then
                    v92.Enabled = false
                end
            end
            _G.tween(v86.Decal, { 0.2, "Linear", "Out" }, {
                ["Transparency"] = 1
            })
            task.wait(3)
            v86:Destroy()
        end
        goto l34
    end
end
return v5