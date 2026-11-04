 

return {
    ["impact"] = function(p1, p2, p3, p4, _) --[[ Line: 4 ]]
        if p2 then
            p1.Water:Emit(25)
            p1.WaterBlobs:Emit(25)
            local v5 = script.sphere:Clone()
            v5.Parent = workspace.Effects
            v5.Material = Enum.Material.SmoothPlastic
            v5.CFrame = p1.CFrame
            v5.Transparency = 0
            v5.Mesh.Scale = Vector3.new(5, 5, 5)
            _G.tween(v5.Mesh, {
                0.35,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(15, 15, 15)
            })
            _G.tween(v5, {
                0.35,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Color"] = Color3.fromRGB(255, 255, 255)
            })
            _G.destroy(v5, 0.35)
            for v6 = 1, 10 do
                local v7 = script.sphere:Clone()
                v7.Parent = workspace.Effects
                local v8 = p1.CFrame
                local v9 = CFrame.Angles
                local v10 = math.random(-360, 360)
                local v11 = math.rad(v10)
                local v12 = math.random(-360, 360)
                local v13 = math.rad(v12)
                local v14 = math.random(-360, 360)
                v7.CFrame = v8 * v9(v11, v13, (math.rad(v14))) * CFrame.new(0, 0, 5)
                v7.Color = p1.Color
                v7.Material = Enum.Material.Glass
                local v15 = math.random(100, 500) / 100
                v7.Mesh.Scale = Vector3.new(v15, v15, v15)
                local v16 = math.random(200, 600) / 1000
                if v6 % 2 == 1 then
                    v7.Color = Color3.fromRGB(255, 255, 255)
                end
                _G.tween(v7.Mesh, {
                    v16,
                    "EntranceExpressive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
                _G.tween(v7, {
                    v16,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v7.CFrame * CFrame.new(0, 0, math.random(10, 20))
                })
                _G.destroy(v7, v16)
            end
            _G.PlaySound(p1, script.fishhit)
            local v17 = CFrame.new(p3, p3 + p4) * CFrame.Angles(-1.5707963267948966, 0, 0)
            _G.PlayEffect("Shockwave2", nil, v17, v17, BrickColor.new("White"), Vector3.new(25, 0, 25), Vector3.new(5, 1, 5), 0.45, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        end
        local v18 = p1:GetChildren()
        for v19 = 1, #v18 do
            if v18[v19]:IsA("ParticleEmitter") == false then
                v18[v19]:Destroy()
            end
        end
        p1.Transparency = 1
        _G.destroy(p1, 1)
    end,
    ["splash"] = function(p20, p21) --[[ Line: 53 ]]
        _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
            ["obj"] = p20,
            ["Strength"] = 25,
            ["Size"] = 7,
            ["cf"] = p21,
            ["PSize"] = NumberSequence.new(2, 0)
        })
    end,
    ["Fire"] = function(_, _, p22) --[[ Name: Fire, Line 58 ]]
        local v23 = p22.CFrame * CFrame.Angles(0, 0, 1.5707963267948966)
        _G.PlayEffect("Shockwave2", nil, v23, v23, BrickColor.new("White"), Vector3.new(5, 0, 5), Vector3.new(0, 1, 0), 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        _G.PlaySound(p22, script.FishThrow)
    end
}