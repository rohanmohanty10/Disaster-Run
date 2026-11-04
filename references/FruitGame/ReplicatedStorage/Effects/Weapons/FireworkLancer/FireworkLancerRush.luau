 

game:GetService("Players")
local u1 = require(game:GetService("ReplicatedStorage").Modules.Client.WeaponVFXRecolor)
local u2 = script.Rush
local u3 = script.RushPrestige
local u4 = script.RushMain
local u5 = script.RushMainPrestige
local u6 = script.Blade
local u7 = script.BladePrestige
local u8 = {}
return {
    ["start"] = function(_, u9, p10, p11) --[[ Name: start, Line 16 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u1
            [4] = u8
            [5] = u5
            [6] = u4
            [7] = u3
            [8] = u2
        --]]
        local v12 = u9.HumanoidRootPart
        if _G.checkRenderDistance(v12.Position) == false then
            return
        else
            local v13
            if p11 == nil then
                v13 = u9:WaitForChild("Firework LancerSword", 1)
            else
                v13 = u9:WaitForChild("Prestige Firework LancerSword", 1)
            end
            if v13 ~= nil or not p10 then
                local u14 = nil
                if p10 and v13 then
                    if p11 then
                        u14 = u7.Firework:Clone()
                    else
                        u14 = u6.Firework:Clone()
                    end
                    u1.apply(u14, u9)
                    u14.Parent = v13.Blade
                elseif v13 and v13:FindFirstChild("Blade") then
                    u14 = v13.Blade:FindFirstChild("Firework")
                end
                u8[u9] = p10
                if p10 then
                    task.delay(0.4, function() --[[ Line: 45 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u9
                            [3] = u14
                        --]]
                        if u8[u9] and u14 then
                            for _, v15 in u14:GetDescendants() do
                                if v15:IsA("ParticleEmitter") then
                                    v15.Enabled = true
                                end
                            end
                        end
                    end)
                    if u14 then
                        _G.destroy(u14, 3)
                    end
                    local v16
                    if p11 then
                        v16 = u5:Clone()
                    else
                        v16 = u4:Clone()
                    end
                    u1.apply(v16, u9)
                    v16.Name = u4.Name
                    v16.Parent = u9
                    _G.destroy(v16, 10)
                    local v17 = Instance.new("Weld")
                    v17.Part0 = v12
                    v17.Part1 = v16
                    v17.C0 = CFrame.new(0.4, -0.15, -7)
                    v17.Parent = v16
                    for _, v18 in v16:GetDescendants() do
                        if v18:IsA("ParticleEmitter") then
                            v18.Enabled = true
                        end
                    end
                    _G.PlaySound(u9.PrimaryPart, script.fireworkFly).Parent = u9.PrimaryPart
                    task.delay(5, function() --[[ Line: 76 ]]
                        --[[
                        Upvalues:
                            [1] = u8
                            [2] = u9
                        --]]
                        u8[u9] = nil
                    end)
                    while u8[u9] do
                        task.wait(0.07692307692307693)
                        local v19
                        if p11 then
                            v19 = u3:Clone()
                        else
                            v19 = u2:Clone()
                        end
                        u1.apply(v19, u9)
                        local _ = v19.Main
                        v19:SetPrimaryPartCFrame(v12.CFrame * CFrame.new(0, 0, -4))
                        v19.Parent = workspace.Effects
                        local v20 = v19:GetPrimaryPartCFrame().LookVector
                        local v21 = math.random(1, 2)
                        for _, v22 in v19:GetChildren() do
                            local v23 = v22.Name
                            if v23 ~= "Main" then
                                if v23 == "BeanWind1" or v23 == "BeanWind2" then
                                    if v21 ~= 1 or v23 ~= "BeanWind1" then
                                        if v21 ~= 2 or v23 ~= "BeanWind2" then
                                            _G.tween(v22.Mesh, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                                                ["Scale"] = Vector3.new(2, 2, 2)
                                            })
                                            _G.tween(v22, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                                                ["CFrame"] = v22.CFrame * CFrame.Angles(0, 2.9670597283903604, 0)
                                            })
                                            _G.tween(v22.Decal, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                                                ["Transparency"] = 1
                                            })
                                        end
                                    end
                                elseif v23 == "Wind1" then
                                    local v24 = math.random(-90, 90)
                                    local v25 = v22.Orientation.Y
                                    local v26 = v22.Orientation.Z
                                    v22.Orientation = Vector3.new(v24, v25, v26)
                                    _G.tween(v22.Mesh, {
                                        0.23,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Scale"] = Vector3.new(0.45, 0.4, 0.4)
                                    })
                                    _G.tween(v22, {
                                        0.23,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Position"] = v22.Position - v20 * 5
                                    })
                                    _G.tween(v22.Decal, {
                                        0.2,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Transparency"] = 1
                                    })
                                elseif v23 == "Wind2" then
                                    local v27 = math.random(-90, 90)
                                    local v28 = v22.Orientation.Y
                                    local v29 = v22.Orientation.Z
                                    v22.Orientation = Vector3.new(v27, v28, v29)
                                    _G.tween(v22.Mesh, {
                                        0.2,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Scale"] = Vector3.new(0.05, 0.35, 0.35)
                                    })
                                    _G.tween(v22, {
                                        0.23,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Position"] = v22.Position - v20 * 5
                                    })
                                    _G.tween(v22.Decal, {
                                        0.2,
                                        "Linear",
                                        Enum.EasingDirection.Out,
                                        0,
                                        false,
                                        0
                                    }, {
                                        ["Transparency"] = 1
                                    })
                                end
                            end
                        end
                        _G.destroy(v19, 0.9)
                    end
                else
                    local u30 = u9:FindFirstChild("RushMain")
                    if u30 then
                        u30.Name = "done"
                        for _, v31 in u30:GetDescendants() do
                            if v31:IsA("ParticleEmitter") then
                                v31.Enabled = false
                            end
                        end
                        task.delay(1, function() --[[ Line: 141 ]]
                            --[[
                            Upvalues:
                                [1] = u30
                            --]]
                            u30:Destroy()
                        end)
                    end
                    if u14 then
                        u14.Name = "done"
                        for _, v32 in u14:GetDescendants() do
                            if v32:IsA("ParticleEmitter") then
                                v32.Enabled = false
                            end
                        end
                        _G.destroy(u14, 3)
                    end
                    local v33 = u9.HumanoidRootPart:FindFirstChild("fireworkFly")
                    if v33 then
                        warn("found sfx tweening")
                        _G.tween(v33, {
                            0.25,
                            "Quad",
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Volume"] = 0
                        })
                        v33.Name = "doner"
                    end
                    _G.PlaySound(u9.PrimaryPart, script.flyend).Parent = u9.PrimaryPart
                end
            end
        end
    end
}