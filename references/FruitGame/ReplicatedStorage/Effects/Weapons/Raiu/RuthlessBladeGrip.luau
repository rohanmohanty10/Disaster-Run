 

local v1 = {}
local u2 = script.Auras:GetChildren()
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Whitelist
u3.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local function u8(p4) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    for _, v5 in p4:GetChildren() do
        if v5:IsA("BasePart") and v5 ~= p4.PrimaryPart then
            for _, v6 in u2 do
                local u7 = v6:Clone()
                u7:SetAttribute("RaiuAura", true)
                u7.Parent = v5
                task.delay(math.random(0, 40) / 100, function() --[[ Line: 24 ]]
                    --[[
                    Upvalues:
                        [1] = u7
                    --]]
                    u7.Enabled = true
                end)
            end
        end
    end
end
local function u12(p9) --[[ Line: 31 ]]
    for _, v10 in p9:GetChildren() do
        if v10:IsA("BasePart") and v10 ~= p9.PrimaryPart then
            for _, v11 in v10:GetDescendants() do
                if v11:IsA("ParticleEmitter") and v11:GetAttribute("RaiuAura") then
                    v11:Destroy()
                end
            end
        end
    end
end
local function u18(p13) --[[ Line: 47 ]]
    local v14 = p13.HumanoidRootPart
    local u15 = script.RedMesh:Clone()
    u15.CFrame = v14.CFrame * CFrame.new(0, -3.2, 0) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(math.random(-6.283185307179586, 6.283185307179586), 0, 0)
    u15.Parent = workspace.Effects
    local v16 = math.random(0, 5) / 100
    local v17 = math.random(25, 29) / 100
    u15.Mesh.Scale = Vector3.new(0.12, v16, v16)
    _G.tween(u15, { 0.26, "Circular", "Out" }, {
        ["CFrame"] = u15.CFrame * CFrame.new(-0.7, 0, 0) * CFrame.Angles(-1.7453292519943295, 0, 0)
    })
    _G.tween(u15.Mesh, { 0.26, "Circular", "Out" }, {
        ["Scale"] = Vector3.new(0.12, v17, v17)
    })
    _G.tween(u15.Decal, { 0.26, "Quad", "Out" }, {
        ["Transparency"] = 1
    })
    task.delay(0.3, function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u15
        --]]
        u15:Destroy()
    end)
end
local function u33(p19) --[[ Line: 68 ]]
    local v20 = p19.HumanoidRootPart
    local v21 = Random.new()
    local v22 = v21:NextInteger(1, 2)
    local u23
    if v22 == 1 then
        u23 = script.WhiteMesh:Clone()
    else
        u23 = script.WhiteMesh2:Clone()
    end
    u23.CFrame = v20.CFrame * CFrame.new(0, -3.1, 0) * CFrame.Angles(0, 0, 1.5707963267948966) * CFrame.Angles(math.random(-6.283185307179586, 6.283185307179586), 0, 0)
    u23.Parent = workspace.Effects
    local v24 = v21:NextNumber(0.07, 0.14)
    local v25
    if v22 == 1 then
        v25 = v21:NextNumber(0.29, 0.34)
    else
        v25 = v21:NextNumber(0.29, 0.36)
    end
    u23.Mesh.Scale = Vector3.new(0.09, v24, v24)
    u23.Decal.Transparency = 1
    _G.tween(u23.Decal, { 0.1, "Linear", "Out" }, {
        ["Transparency"] = math.random(35, 60) / 100
    })
    task.delay(0.1, function() --[[ Line: 86 ]]
        --[[
        Upvalues:
            [1] = u23
        --]]
        _G.tween(u23.Decal, { 0.26, "Linear", "Out" }, {
            ["Transparency"] = 1
        })
    end)
    local v26
    if v22 == 1 then
        local v27 = u23.CFrame * CFrame.new(-math.random(70, 75) / 100, 0, 0)
        local v28 = CFrame.Angles
        local v29 = math.random(80, 110)
        v26 = v27 * v28(-math.rad(v29), 0, 0)
    else
        local v30 = u23.CFrame * CFrame.new(-math.random(70, 75) / 100, 0, 0)
        local v31 = CFrame.Angles
        local v32 = math.random(-100, 100)
        v26 = v30 * v31(-math.rad(v32), 0, 0)
    end
    _G.tween(u23, { 0.36, "Circular", "Out" }, {
        ["CFrame"] = v26
    })
    _G.tween(u23.Mesh, { 0.36, "Circular", "Out" }, {
        ["Scale"] = Vector3.new(0.12, v25, v25)
    })
    task.delay(0.4, function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u23
        --]]
        u23:Destroy()
    end)
end
function v1.start(_, u34, p35, p36) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u18
        [3] = u33
        [4] = u12
        [5] = u3
    --]]
    if _G.checkRenderDistance(u34.PrimaryPart.Position) == false then
        return
    end
    local v37 = u34.HumanoidRootPart
    local v38 = u34.LowerTorso
    if p35 then
        local u39 = script.RaiuMove1Emitter:Clone()
        u39.CFrame = v37.CFrame
        u39.Weld.Part0 = u39
        u39.Weld.Part1 = v37
        u39.Name = "RaiuMove1Emitter" .. u34.Name
        u39.Parent = workspace.Effects
        local v40 = script.RaiuMove1TorsoEmitter:Clone()
        v40.CFrame = v37.CFrame
        v40.Weld.Part0 = v40
        v40.Weld.Part1 = v38
        v40.Name = "RaiuMove1TorsoEmitter" .. u34.Name
        v40.Parent = workspace.Effects
        for _, v41 in u39.Enable:GetChildren() do
            v41.Enabled = true
        end
        for _, v42 in v40.Enable:GetChildren() do
            v42.Enabled = true
        end
        task.delay(0.03, function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u8
                [3] = u34
            --]]
            for _, v43 in u39.Emit:GetChildren() do
                _G.customEmit(v43)
            end
            for _, v44 in u39.Emit2:GetChildren() do
                _G.customEmit(v44)
            end
            u8(u34)
        end)
        task.defer(function() --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u34
            --]]
            repeat
                u18(u34)
                task.wait(0.09090909090909091)
            until u34:GetAttribute("ruthlessBladeHold") == nil
        end)
        task.defer(function() --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u34
                [3] = u12
            --]]
            repeat
                u33(u34)
                task.wait(0.03333333333333333)
            until u34:GetAttribute("ruthlessBladeHold") == nil
            local u45 = workspace.Effects:FindFirstChild("RaiuMove1Emitter" .. u34.Name)
            local u46 = workspace.Effects:FindFirstChild("RaiuMove1TorsoEmitter" .. u34.Name)
            if u45 then
                u45.Name = "_"
                u46.Name = "_"
            end
            if u45 then
                for _, v47 in u45:GetDescendants() do
                    if v47:IsA("ParticleEmitter") then
                        v47.Enabled = false
                    end
                end
                task.delay(1, function() --[[ Line: 180 ]]
                    --[[
                    Upvalues:
                        [1] = u45
                    --]]
                    u45:Destroy()
                end)
            end
            if u46 then
                for _, v48 in u46:GetDescendants() do
                    if v48:IsA("ParticleEmitter") then
                        v48.Enabled = false
                    end
                end
                task.delay(1, function() --[[ Line: 192 ]]
                    --[[
                    Upvalues:
                        [1] = u46
                    --]]
                    u46:Destroy()
                end)
            end
            u12(u34)
        end)
        local u49 = script.BeanWind:Clone()
        local u50 = script.BeanWind2:Clone()
        u49.CFrame = v37.CFrame * CFrame.new(0, -4, 0)
        u49.Parent = workspace.Effects
        u50.CFrame = v37.CFrame * CFrame.new(0, 0, 0)
        u50.Parent = workspace.Effects
        _G.tween(u49, { 0.38, "Cubic", "Out" }, {
            ["CFrame"] = u49.CFrame * CFrame.new(0, 1, 0) * CFrame.Angles(0, -2.9670597283903604, 0)
        })
        _G.tween(u49.Mesh, { 0.38, "Cubic", "Out" }, {
            ["Scale"] = Vector3.new(3, 7, 3)
        })
        _G.tween(u49.Decal, { 0.39, "Linear", "In" }, {
            ["Transparency"] = 1
        })
        _G.tween(u50, { 0.39, "Cubic", "Out" }, {
            ["CFrame"] = u50.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, -2.9670597283903604, 0)
        })
        _G.tween(u50.Mesh, { 0.39, "Cubic", "Out" }, {
            ["Scale"] = Vector3.new(3.6, 8, 3.6)
        })
        _G.tween(u50.Decal, { 0.4, "Linear", "In" }, {
            ["Transparency"] = 1
        })
        task.delay(0.4, function() --[[ Line: 217 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u50
            --]]
            u49:Destroy()
            u50:Destroy()
        end)
        return
    end
    local u51 = script.Dash:Clone()
    u51.CFrame = p36 * CFrame.new(0, 0, 0)
    u51.Parent = workspace.Effects
    for _, v52 in u51:GetDescendants() do
        if v52:IsA("ParticleEmitter") then
            _G.customEmit(v52)
        end
    end
    task.delay(0.5, function() --[[ Line: 232 ]]
        --[[
        Upvalues:
            [1] = u51
        --]]
        u51:Destroy()
    end)
    local u53 = script.DashMesh1:Clone()
    local u54 = script.DashMesh2:Clone()
    local v55 = u53.Mesh.Scale
    local v56 = u54.Mesh.Scale
    u53.Mesh.Scale = Vector3.new(0, 0, 0)
    u54.Mesh.Scale = Vector3.new(3, 0, 0)
    u53.CFrame = p36 * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966) * CFrame.new(-22, 0, 0)
    u54.CFrame = p36 * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966) * CFrame.new(-22, 0, 0)
    u53.Parent = workspace.Effects
    u54.Parent = workspace.Effects
    task.wait(0.03)
    _G.tween(u53.Mesh, { 0.29, "Cubic", "Out" }, {
        ["Scale"] = v55
    })
    _G.tween(u54.Mesh, { 0.23, "Cubic", "Out" }, {
        ["Scale"] = v56
    })
    _G.tween(u53, { 0.29, "Cubic", "Out" }, {
        ["CFrame"] = u53.CFrame * CFrame.new(24, 0, 0)
    })
    _G.tween(u54, { 0.23, "Cubic", "Out" }, {
        ["CFrame"] = u54.CFrame * CFrame.new(21, 0, 0)
    })
    _G.tween(u53.Decal, { 0.29, "Cubic", "Out" }, {
        ["Transparency"] = 1
    })
    _G.tween(u54.Decal, { 0.23, "Cubic", "Out" }, {
        ["Transparency"] = 1
    })
    task.delay(0.3, function() --[[ Line: 262 ]]
        --[[
        Upvalues:
            [1] = u53
            [2] = u54
        --]]
        u53:Destroy()
        u54:Destroy()
    end)
    local u57 = script.Slashes:Clone()
    u57.CFrame = p36 * CFrame.new(0, 0, -5)
    u57.Parent = workspace.Effects
    for _, v58 in u57:GetDescendants() do
        if v58:IsA("ParticleEmitter") then
            v58.Enabled = true
        end
    end
    task.delay(0.5, function() --[[ Line: 277 ]]
        --[[
        Upvalues:
            [1] = u57
        --]]
        for _, v59 in u57:GetDescendants() do
            if v59:IsA("ParticleEmitter") then
                v59.Enabled = false
            end
        end
        task.wait(0.8)
        u57:Destroy()
    end)
    local v60 = script.Dust:Clone()
    v60.CFrame = p36 * CFrame.new(0, -4, 0) * CFrame.Angles(0, 3.141592653589793, 0)
    v60.Parent = workspace.Effects
    for _, v61 in v60:GetDescendants() do
        if v61:IsA("ParticleEmitter") then
            v61.Enabled = true
        end
    end
    local v62 = tick()
    while true do
        local v63 = workspace:Raycast(v37.Position, Vector3.new(0, -15, 0), u3)
        if v63 then
            v60.Position = v63.Position
            for _, v64 in v60:GetDescendants() do
                if v64:IsA("ParticleEmitter") then
                    v64.Enabled = true
                    if v63.Instance then
                        v64.Color = ColorSequence.new(v63.Instance.Color)
                    end
                    v64:Emit(1)
                end
            end
        else
            for _, v65 in v60:GetDescendants() do
                if v65:IsA("ParticleEmitter") then
                    v65.Enabled = false
                end
            end
        end
        task.wait()
        if tick() - v62 > 0.23 then
            for _, v66 in v60:GetDescendants() do
                if v66:IsA("ParticleEmitter") then
                    v66.Enabled = false
                end
            end
            task.wait(0.8)
            v60:Destroy()
            return
        end
    end
end
return v1