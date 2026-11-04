 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
require(v3.Modules.LightningBolt)
local v4 = {
    ["Radius"] = 45,
    ["TornadoSpeed"] = 200,
    ["RotSpeed"] = 300
}
local u5 = Random.new()
function Toggle(p6, p7)
    for _, v8 in p6:GetDescendants() do
        if v8:IsA("ParticleEmitter") or v8:IsA("Trail") then
            v8.Enabled = p7
        end
    end
end
local u9 = RaycastParams.new()
local v10 = { workspace.Islands, workspace.Env, workspace.Ships }
local v11 = Enum.RaycastFilterType.Include
u9.FilterDescendantsInstances = v10
u9.FilterType = v11
function CreateCrater(p12, p13)
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u2
    --]]
    local v14 = script.Parent:WaitForChild("Rocks"):GetChildren()
    local v15 = u5:NextInteger(19, 25)
    local v16 = p12.Position
    local v17 = p13.Normal
    for v18 = 1, v15 do
        local v19 = 360 / v15 * v18
        local v20 = math.rad(v19)
        local v21 = u5:NextNumber(-5, 5)
        local v22 = v20 + math.rad(v21)
        local v23 = u5:NextNumber(49, 62.5)
        local v24 = (p12 * CFrame.new(math.cos(v22) * v23, math.sin(v22) * v23, 0)).Position
        local v25 = workspace:Raycast(v24 + v17, v17 * -25, u9)
        if v25 then
            local v26 = v25.Position
            local v27 = v16 - v17 * u5:NextNumber(17.5, 22.5)
            local v28 = -v17 * u5:NextNumber(1, 2)
            local v29 = CFrame.Angles(0, u5:NextNumber(-0.39269908169872414, 0.39269908169872414), 0)
            local v30 = CFrame.lookAt(v26 + v28, v27, v17) * v29
            local v31 = CFrame.lookAt(v16, v27 + v30.LookVector) * v29
            local u32 = v14[math.random(1, #v14)]:Clone()
            u32:PivotTo(v30)
            u32:ScaleTo(u5:NextNumber(1, 1.675))
            u32.Parent = workspace.Effects
            for _, v33 in u32:GetChildren() do
                if v33.Name == "Land" then
                    _G.matchMaterial(v33, v25.Instance)
                end
                local v34 = v33.Size
                local v35 = {
                    ["CFrame"] = v33.CFrame,
                    ["Size"] = v34
                }
                u2:Create(v33, TweenInfo.new(1.25, Enum.EasingStyle.Cubic), v35):Play()
            end
            u32:PivotTo(v31)
            task.delay(v18 / 50 + 2.5, function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u2
                --]]
                _G.destroy(u32, 0.75)
                local u36 = Instance.new("NumberValue")
                u36.Value = u32:GetScale()
                u2:Create(u36, TweenInfo.new(0.3), {
                    ["Value"] = 0.001
                }):Play()
                u36.Changed:Connect(function() --[[ Line: 75 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                        [2] = u36
                    --]]
                    u32:ScaleTo(u36.Value)
                end)
                _G.destroy(u36, 0.5)
            end)
        end
    end
end
function SpawnRock(u37, p38, u39)
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
        [3] = u9
        [4] = u1
    --]]
    local u40 = u5:NextNumber(35, 50)
    local v41 = u5:NextNumber(0, 360)
    local u42 = math.rad(v41)
    local v43 = script.Rocks:GetChildren()
    local u44 = v43[math.random(1, #v43)]:Clone()
    local u45 = CFrame.Angles(0, u5:NextNumber(-3.141592653589793, 3.141592653589793), u5:NextNumber(-3.141592653589793, 3.141592653589793))
    u44:PivotTo(u37.CFrame * CFrame.new(math.cos(u42) * u40, 0, (math.sin(u42))) * u45)
    u44:ScaleTo(u5:NextNumber(1.325, 2.65))
    u44.Parent = workspace.Effects
    local u46 = Instance.new("NumberValue")
    u46.Value = 0
    u2:Create(u46, TweenInfo.new(u5:NextNumber(0.85, 1.1)), {
        ["Value"] = u5:NextNumber(35, 100)
    }):Play()
    local u47 = u5:NextNumber(170, 300)
    local u48 = u5:NextNumber(0.85, 1.1)
    local u49 = os.clock()
    local u50 = u5:NextNumber(9, 18)
    Toggle(u44, p38)
    local v51 = workspace:Raycast(u44:GetPivot().Position + Vector3.new(0, 2, 0), Vector3.new(0, -50, 0), u9)
    task.delay(u48 * 0.8, function() --[[ Line: 110 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u2
        --]]
        local u52 = Instance.new("NumberValue")
        u52.Value = u44:GetScale()
        u2:Create(u52, TweenInfo.new(0.3), {
            ["Value"] = 0.001
        }):Play()
        u52.Changed:Connect(function() --[[ Line: 115 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u52
            --]]
            u44:ScaleTo(u52.Value)
        end)
        _G.destroy(u52, 0.5)
    end)
    for _, v53 in u44:GetChildren() do
        if v51 and v53.Name == "Land" then
            v53.Material = v51.Material
            v53.Color = v51.Instance.Color
        end
    end
    local u54 = false
    local u55 = nil
    u55 = u1.Heartbeat:Connect(function(p56) --[[ Line: 129 ]]
        --[[
        Upvalues:
            [1] = u49
            [2] = u48
            [3] = u55
            [4] = u46
            [5] = u44
            [6] = u54
            [7] = u39
            [8] = u40
            [9] = u50
            [10] = u42
            [11] = u47
            [12] = u37
            [13] = u45
        --]]
        if u48 <= os.clock() - u49 then
            u55:Disconnect()
            u46:Destroy()
            _G.destroy(u44, 0.75)
        else
            if u54 == false and u39 - tick() <= 0 then
                u40 = u40 + 20
                u54 = true
            end
            u40 = u40 + p56 * u50
            local v57 = u47
            u42 = u42 - p56 * math.rad(v57)
            local v58 = u42
            local v59 = u42
            u44:PivotTo(u37.CFrame * CFrame.new(math.cos(v58) * u40, u46.Value, math.sin(v59) * u40) * u45)
        end
    end)
end
function SpawnWind(p60, p61)
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
    --]]
    local u62 = script.BeanWind:Clone()
    u62.CFrame = p60:GetPivot() * CFrame.new(0, u5:NextNumber(-p60.Size.Y / 2, p60.Size.Y / 2), 0)
    u62.Parent = workspace.Effects
    u62.Decal.Transparency = u5:NextNumber(0.5, 0.85)
    u62.Decal.Color3 = p61 and Color3.fromRGB(2500, 500, 0) or u62.Decal.Color3
    if p61 == true then
        local v63 = u62.Decal
        v63.Transparency = v63.Transparency / 2
    end
    local u64 = u2:Create(u62.Decal, TweenInfo.new(u5:NextNumber(0.35, 0.425)), {
        ["Transparency"] = 1
    })
    local u65 = u2:Create(u62, TweenInfo.new(u5:NextNumber(0.375, 0.475)), {
        ["CFrame"] = u62.CFrame * CFrame.Angles(0, u5:NextNumber(-3.141592653589793, 3.141592653589793), 0)
    })
    local v66 = {
        ["Scale"] = u62.Mesh.Scale * u5:NextNumber(1.2, 1.75)
    }
    local u67 = u2:Create(u62.Mesh, TweenInfo.new(u5:NextNumber(0.425, 0.525), Enum.EasingStyle.Quint), v66)
    u65:Play()
    u64:Play()
    u67:Play()
    local v68 = u62.Mesh
    v68.Scale = v68.Scale * u5:NextNumber(0.15, 0.25)
    u64.Completed:Once(function() --[[ Line: 185 ]]
        --[[
        Upvalues:
            [1] = u64
            [2] = u67
            [3] = u65
            [4] = u62
        --]]
        u64:Destroy()
        u67:Destroy()
        u65:Destroy()
        _G.destroy(u62, 1.5)
    end)
end
function SpawnTrail(u69, p70)
    --[[
    Upvalues:
        [1] = u5
        [2] = u1
    --]]
    local u71 = u5:NextNumber(25, 50)
    local v72 = u5:NextNumber(0, 360)
    local u73 = math.rad(v72)
    local v74 = { (p70 and "F" or "") .. "Trail", (p70 and "F" or "") .. "WindTrail", "OrangeTrail" }
    if p70 ~= true then
        table.remove(v74, 3)
    end
    local v75 = v74[math.random(1, #v74)]
    local u76 = script[v75]:Clone()
    local u77 = CFrame.new(0, u5:NextNumber(-u69.Size.Y / 3.5, u69.Size.Y / 2), 0)
    u76.CFrame = u69.CFrame * u77 * CFrame.new(math.cos(u73) * u71, 0, math.sin(u73) * u71)
    u76.Parent = workspace.Effects
    local u78 = u5:NextNumber(25, 50)
    local u79 = u5:NextNumber(460, 750)
    local u80 = u5:NextNumber(0.45, 0.75)
    local u81 = os.clock()
    local u82 = u5:NextNumber(9, 32.5)
    local u83 = nil
    u83 = u1.Heartbeat:Connect(function(p84) --[[ Line: 214 ]]
        --[[
        Upvalues:
            [1] = u81
            [2] = u80
            [3] = u83
            [4] = u76
            [5] = u77
            [6] = u78
            [7] = u71
            [8] = u82
            [9] = u73
            [10] = u79
            [11] = u69
        --]]
        if u80 <= os.clock() - u81 then
            u83:Disconnect()
            u83 = nil
            _G.destroy(u76, 0.75)
            Toggle(u76, false)
        else
            u77 = u77 * CFrame.new(0, u78 * p84, 0)
            u71 = u71 + p84 * u82
            local v85 = u79
            u73 = u73 - p84 * math.rad(v85)
            local v86 = u73
            local v87 = u73
            u76.CFrame = u69.CFrame * u77 * CFrame.new(math.cos(v86) * u71, u77, math.sin(v87) * u71)
        end
    end)
end
require(script.Parent.Parent.SharedForms.DragonLightningStrikeEffect)
function v4.start(_, p88, u89, p90) --[[ Line: 232 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u2
    --]]
    p88:GetPivot()
    os.clock()
    local v91 = p88:GetAttribute("FireMode")
    local v92 = script[v91 and "FireDash" or "Dash"]:Clone()
    v92.CFrame = p88.PrimaryPart.CFrame * CFrame.new(0, 0, v92.Size.Z / 2)
    v92.Parent = workspace.Effects
    local v93 = Instance.new("WeldConstraint")
    local v94 = p88.PrimaryPart
    v93.Parent = v92
    v93.Part0 = v92
    v93.Part1 = v94
    local v95 = os.clock()
    local u96 = script.Normal
    if v91 == true then
        u96 = script.Fire
    end
    _G.PlaySound(p88.PrimaryPart, u96.Start).Parent = p88.PrimaryPart
    local function v104(p97, p98) --[[ Line: 256 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u89
            [3] = u2
        --]]
        local u99 = script["DashWind" .. u5:NextInteger(1, 2)]:Clone()
        u99.CFrame = p97 * CFrame.Angles(1.5707963267948966, 0, 0)
        u99.Decal.Color3 = p98 and Color3.fromRGB(255, 86, 34) or u89.DragonHead.Color
        u99.Parent = workspace.Effects
        local u100 = u2:Create(u99.Decal, TweenInfo.new(u5:NextNumber(0.25, 0.425)), {
            ["Transparency"] = 1
        })
        local u101 = u2:Create(u99, TweenInfo.new(u5:NextNumber(0.375, 0.475)), {
            ["CFrame"] = u99.CFrame * CFrame.Angles(0, u5:NextNumber(-3.141592653589793, 3.141592653589793), 0)
        })
        local u102 = u2:Create(u99.Mesh, TweenInfo.new(u5:NextNumber(0.425, 0.525), Enum.EasingStyle.Quint), {
            ["Scale"] = u99.Mesh.Scale * u5:NextNumber(0.8, 1.5)
        })
        u101:Play()
        u100:Play()
        u102:Play()
        local v103 = u99.Mesh
        v103.Scale = v103.Scale * u5:NextNumber(0.05, 0.15)
        u100.Completed:Once(function() --[[ Line: 279 ]]
            --[[
            Upvalues:
                [1] = u100
                [2] = u102
                [3] = u101
                [4] = u99
            --]]
            u100:Destroy()
            u102:Destroy()
            u101:Destroy()
            _G.destroy(u99, 1.5)
        end)
    end
    local function v108(p105) --[[ Line: 288 ]]
        --[[
        Upvalues:
            [1] = u89
            [2] = u5
            [3] = u2
        --]]
        local v106 = script.DashShockwave:Clone()
        v106.CFrame = p105 * CFrame.Angles(-1.5707963267948966, 0, 0)
        v106.Color = u89.DragonHead.Color
        v106.Parent = workspace.Effects
        local v107 = u5:NextNumber(0.15, 0.3)
        u2:Create(v106, TweenInfo.new(v107), {
            ["Transparency"] = 1
        }):Play()
        u2:Create(v106, TweenInfo.new(u5:NextNumber(0.3, 0.45)), {
            ["Size"] = v106.Size * u5:NextNumber(0.9, 1.8),
            ["CFrame"] = v106.CFrame * CFrame.new(0, u5:NextNumber(3, 15), 0) * CFrame.Angles(0, 3.141592653589793, 0)
        }):Play()
        v106.Size = v106.Size * u5:NextNumber(0.35, 0.45)
        _G.destroy(v106, v107)
    end
    while true do
        if os.clock() - v95 > 0.03333333333333333 then
            v108(p88:GetPivot() * CFrame.new(0, 0, -15))
            v95 = os.clock()
        end
        v104(p88:GetPivot() * CFrame.new(0, 0, u5:NextNumber(0, 50)), v91)
        task.wait()
        if p88:GetAttribute("DragonSpiralBaseCFrame" .. p90) ~= nil or p88:IsDescendantOf(workspace) == false then
            Toggle(v92, false)
            _G.destroy(v92, 1.5)
            local u109 = p88:GetAttribute("DragonSpiralBaseCFrame" .. p90)
            if u109 ~= "None" then
                local u110 = script[v91 and "FireWhirl" or "Whirlwind"]:Clone()
                local v111 = u110:GetScale()
                u110:PivotTo(u109)
                u110:ScaleTo(0.001)
                local v112, _, _ = _G.getRayFloor(u109, 25)
                if v112 then
                    _G.recolorParticles(u110, v112.Color)
                end
                u110.Parent = workspace.Effects
                _G.PlaySound(u109, u96["Hit" .. math.random(1, 2)])
                _G.shakenear(u109.Position, 300, 125, 100, -0.5)
                local v113 = _G.PlaySound(u109, u96.Tornado)
                local u114 = Instance.new("NumberValue")
                u114.Value = 0.001
                u2:Create(u114, TweenInfo.new(0.325), {
                    ["Value"] = v111
                }):Play()
                u114.Changed:Connect(function() --[[ Line: 349 ]]
                    --[[
                    Upvalues:
                        [1] = u110
                        [2] = u114
                    --]]
                    u110:ScaleTo(u114.Value)
                end)
                _G.destroy(u114, 0.325)
                os.clock()
                local v115 = os.clock()
                local v116 = tick() + 2.65
                local v117 = v115
                local v118 = v117
                local v119 = v118
                local v120 = v117
                v117 = v119
                v120 = v118
                v118 = v117
                v120 = v119
                while os.clock() - v115 < 2.5 do
                    local v121 = os.clock()
                    if v119 <= v121 then
                        SpawnWind(u110.Outer, v91)
                        v119 = v121 + 0.026000000000000002
                    end
                    if v118 <= v121 then
                        SpawnTrail(u110.Outer, v91)
                        v118 = v121 + 0.04
                    end
                    if v117 <= v121 then
                        SpawnRock(u110.Center, v91, v116)
                        v117 = v121 + 0.05
                    end
                    task.wait()
                end
                u2:Create(v113, TweenInfo.new(1), {
                    ["Volume"] = 0
                }):Play()
                _G.particleEnabled(u110, false)
                _G.customEmit(u110)
                _G.destroy(u110, 5)
                task.delay(0.175, function() --[[ Line: 396 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                        [2] = u96
                    --]]
                    _G.PlaySound(u109, u96.Release)
                end)
            end
        end
    end
end
return v4