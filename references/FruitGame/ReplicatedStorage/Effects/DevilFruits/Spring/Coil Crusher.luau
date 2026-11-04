 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = script:WaitForChild("Rocks"):GetChildren()
local _ = script.Animations
local u4 = _G.customEmit
local function u9(p5) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = script.ChargingWind:Clone()
    v6.CFrame = p5.PrimaryPart.CFrame * CFrame.new(0, -2, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v6.Parent = workspace.Effects
    local v7 = v6.Mesh
    v7.Scale = Vector3.new(0.078, 0.6126, 0.59220004)
    local u8 = v6.Decal
    u8.Transparency = 1
    u2:Create(u8, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
        ["Transparency"] = 0
    }):Play()
    task.delay(0.2, function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
        --]]
        u2:Create(u8, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            ["Transparency"] = 1
        }):Play()
    end)
    u2:Create(v7, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
        ["Scale"] = Vector3.new(0.1625, 0.22749999, 0.22749999)
    }):Play()
    u2:Create(v6, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
        ["CFrame"] = v6.CFrame * CFrame.new(-3.65, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
    }):Play()
    _G.destroy(v6, 1.1)
end
local function u14(p10) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v11 = script.InsideWave:Clone()
    v11.CFrame = p10.PrimaryPart.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v11.Parent = workspace.Effects
    local v12 = v11.Mesh
    v12.Scale = Vector3.new(0.326, 0.136, 0.129)
    local u13 = v11.Decal
    u13.Transparency = 1
    u2:Create(u13, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
        ["Transparency"] = 0.65
    }):Play()
    task.delay(0.15, function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u13
        --]]
        u2:Create(u13, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            ["Transparency"] = 1
        }):Play()
    end)
    u2:Create(v12, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        ["Scale"] = Vector3.new(0.198, 0.546, 0.535)
    }):Play()
    u2:Create(v11, TweenInfo.new(0.55, Enum.EasingStyle.Sine), {
        ["CFrame"] = v11.CFrame * CFrame.new(-7.65, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
    }):Play()
    _G.destroy(v11, 0.75)
end
local function u17(p15) --[[ Line: 89 ]]
    for _, v16 in p15:GetDescendants() do
        if v16:IsA("ParticleEmitter") then
            v16.Enabled = false
        end
    end
end
local function u20(p18) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v19 = script.Boost:Clone()
    v19.CFrame = p18 * CFrame.new(0, 0, -3.5) * CFrame.Angles(0, -1.5707963267948966, 0)
    v19.Parent = workspace.Effects
    v19.Mesh.Scale = Vector3.new(0.3872, 0.1991, 0.1837)
    u2:Create(v19, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
        ["CFrame"] = v19.CFrame * CFrame.new(-4, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
    }):Play()
    u2:Create(v19.Mesh, TweenInfo.new(0.325, Enum.EasingStyle.Cubic), {
        ["Scale"] = Vector3.new(0, 0, 0)
    }):Play()
    _G.destroy(v19, 0.6)
end
local function u23(p21) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v22 = script.MovingWave:Clone()
    v22.CFrame = p21 * CFrame.new(0, 0, -4) * CFrame.Angles(0, -1.5707963267948966, 0)
    v22.Parent = workspace.Effects
    u2:Create(v22, TweenInfo.new(0.7, Enum.EasingStyle.Cubic), {
        ["CFrame"] = v22.CFrame * CFrame.new(Random.new():NextNumber(5, 8), 0, 0)
    }):Play()
    u2:Create(v22.Decal, TweenInfo.new(0.6, Enum.EasingStyle.Cubic), {
        ["Transparency"] = 1
    }):Play()
    u2:Create(v22.Mesh, TweenInfo.new(0.7, Enum.EasingStyle.Cubic), {
        ["Scale"] = Vector3.new(0.554, 0.229, 0.211)
    }):Play()
    _G.destroy(v22, 0.7)
end
local function u26(p24) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v25 = script.FlashWave:Clone()
    v25.CFrame = p24 * CFrame.new(0, 0, -4) * CFrame.Angles(0, -1.5707963267948966, 0)
    v25.Parent = workspace.Effects
    u2:Create(v25, TweenInfo.new(0.5, Enum.EasingStyle.Cubic), {
        ["CFrame"] = v25.CFrame * CFrame.new(25, 0, 0) * CFrame.Angles(Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0, 0)
    }):Play()
    u2:Create(v25.Mesh, TweenInfo.new(0.4, Enum.EasingStyle.Cubic), {
        ["Scale"] = Vector3.new(0.815, 0, 0)
    }):Play()
    _G.destroy(v25, 0.5)
end
function v1.start(_, u27, p28, _, u29, u30, u31, u32, p33, u34) --[[ Line: 130 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u2
        [4] = u20
        [5] = u23
        [6] = u26
        [7] = u17
        [8] = u9
        [9] = u14
    --]]
    if _G.checkRenderDistance(u27.PrimaryPart.Position) then
        if p28 == "hit" then
            local v35 = script.Explode:Clone()
            v35.CFrame = u27:GetPivot() * CFrame.new(0, -1, 3.5)
            v35.Parent = workspace.Effects
            u4(v35)
            _G.destroy(v35, 1.15)
            local _ = u27:GetPivot() * CFrame.new(0, 0, -u29)
            local v36 = script.Moving:Clone()
            v36.Anchored = false
            local v37 = workspace.Effects
            local v38 = u27.PrimaryPart.CFrame
            v36.Parent = v37
            v36.CFrame = v38
            local v39 = Instance.new("WeldConstraint")
            local v40 = u27.PrimaryPart
            v39.Parent = v36
            v39.Part0 = v36
            v39.Part1 = v40
            local v41 = script.Dust:Clone()
            v41.Anchored = false
            local v42 = workspace.Effects
            local v43 = u27.PrimaryPart.CFrame
            v41.Parent = v42
            v41.CFrame = v43
            local v44 = Instance.new("WeldConstraint")
            local v45 = u27.PrimaryPart
            v44.Parent = v41
            v44.Part0 = v41
            v44.Part1 = v45
            local u46 = Random.new()
            task.spawn(function() --[[ Line: 170 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u29
                    [3] = u46
                    [4] = u3
                    [5] = u2
                --]]
                for v47 = 1, 10 do
                    for v48 = -1, 1, 2 do
                        local v49 = (u34 * CFrame.new(v48 * 5, 0, -v47 * u29 / 10)).Position
                        local v50 = RaycastParams.new()
                        local v51 = { workspace.Islands, workspace.Env, workspace.Ships }
                        local v52 = Enum.RaycastFilterType.Whitelist
                        v50.FilterDescendantsInstances = v51
                        v50.FilterType = v52
                        local v53 = workspace:Raycast(v49 + Vector3.new(0, 1, 0), Vector3.new(0, -5, 0), v50)
                        if v53 then
                            local v54 = CFrame.Angles(0, 0, u46:NextNumber(-0.5235987755982988, 0.5235987755982988))
                            local u55 = u3[math.random(1, #u3)]:Clone()
                            u55:PivotTo(CFrame.new(v53.Position - Vector3.new(0, 0.75, 0), (u34 * CFrame.new(0, -(v53.Distance + 1.5), -v47 * u29 / 10)).Position) * v54)
                            u55.Parent = workspace.Effects
                            _G.matchMaterial(u55.Land, v53.Instance)
                            task.delay(v47 / 50 + 1.5, function() --[[ Line: 187 ]]
                                --[[
                                Upvalues:
                                    [1] = u55
                                    [2] = u2
                                --]]
                                _G.destroy(u55, 0.75)
                                local v56 = next
                                local v57, v58 = u55:GetChildren()
                                for _, v59 in v56, v57, v58 do
                                    u2:Create(v59, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                                        ["Size"] = Vector3.new(),
                                        ["CFrame"] = v59.CFrame * CFrame.new(0, -1.25, 0)
                                    }):Play()
                                end
                            end)
                        end
                    end
                    task.wait(0.05)
                end
            end)
            u27:GetPivot()
            task.spawn(function() --[[ Line: 201 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u34
                    [3] = u27
                    [4] = u20
                    [5] = u23
                --]]
                for v60 = 1, u29 / 2 do
                    local v61 = (u34.Position - u27.PrimaryPart.Position).Magnitude
                    u20(u34 * CFrame.new(0, 0, -v61))
                    if v60 % 2.5 == 0 then
                        u23(u34 * CFrame.new(0, 0, v60 * -2))
                    end
                    task.wait(0.01)
                end
            end)
            task.spawn(function() --[[ Line: 215 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u27
                    [3] = u26
                --]]
                for _ = 1, 8 do
                    local v62 = (u34.Position - u27.PrimaryPart.Position).Magnitude
                    u26(u34 * CFrame.new(0, 0, -v62))
                    task.wait(0.025)
                end
            end)
            task.delay(0.25, u17, v36)
            _G.destroy(v36, 1.25)
            task.delay(0.25, u17, v41)
            _G.destroy(v41, 1.25)
            task.delay(p33, function() --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u31
                    [3] = u32
                    [4] = u4
                --]]
                if u30 ~= nil then
                    local u63 = script.CraterModel:Clone()
                    u63:PivotTo(CFrame.new(u31, u31 + u32))
                    u63.Parent = workspace.Effects
                    local v64 = script.CraterEffect:Clone()
                    v64.CFrame = CFrame.new(u31, u31 + u32)
                    v64.Parent = workspace.Effects
                    for _, v65 in v64:GetChildren() do
                        if v65:IsA("ParticleEmitter") and v65.Name:match("Smoke") then
                            v65.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u30.Color), ColorSequenceKeypoint.new(1, u30.Color) })
                        end
                    end
                    u4(v64)
                    _G.PlaySound(v64.CFrame, script.SpringUltWallHit)
                    task.delay(2.5, function() --[[ Line: 250 ]]
                        --[[
                        Upvalues:
                            [1] = u63
                        --]]
                        for _, v66 in u63:GetDescendants() do
                            if v66:IsA("MeshPart") then
                                _G.tween(v66, { Random.new():NextNumber(0.8, 1), "Quad", Enum.EasingDirection.Out }, {
                                    ["Size"] = Vector3.new(0, 0, 0)
                                })
                            elseif v66:IsA("Decal") then
                                _G.tween(v66, { Random.new():NextNumber(0.8, 1), "Quad", Enum.EasingDirection.Out }, {
                                    ["Transparency"] = 1
                                })
                            end
                        end
                    end)
                    _G.destroy(u63, 3.5)
                    _G.destroy(v64, 2.5)
                end
            end)
        else
            tick()
            local v67 = script.chargup:Clone()
            v67.CFrame = u27:GetPivot() * CFrame.new(0, -2, 0)
            v67.Parent = workspace.Effects
            warn("coil effect")
            local v68 = 0
            while p28 and p28:IsDescendantOf(game) do
                v68 = v68 + 1
                u9(u27)
                if v68 % 2 == 0 then
                    u14(u27)
                end
                task.wait(0.125)
            end
            u17(v67)
            _G.destroy(v67, 1.15)
            local v69 = script.SpringEffect:Clone()
            v69.CFrame = u27:GetPivot() * CFrame.new(0, -1, 3.5)
            v69.Parent = workspace.Effects
            u4(v69)
            _G.destroy(v69, 2)
        end
    else
        return
    end
end
return v1