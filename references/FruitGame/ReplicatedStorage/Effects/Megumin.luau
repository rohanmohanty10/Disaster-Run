 

local v1 = {}
require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, p2, p3, p4) --[[ Line: 4 ]]
    local v5 = p4 == nil and 1 or p4
    if p2 == "explosion" then
        _G.PlayEffect("GroundRocks2", nil, p3, 25 * v5, 45, 8, 0.25, 10)
        if v5 == 1 then
            local v6 = _G.PlaySound(p3, script.nuke)
            _G.tween(v6, {
                5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
        else
            _G.PlaySound(p3, script.TitanNukes:GetChildren()[math.random(1, 3)])
        end
        for v7 = 1, 15 do
            local v8 = script.exploson:Clone()
            v8.CFrame = p3
            v8.Size = Vector3.new(0, 0, 0)
            v8.Parent = workspace.Effects
            local v9 = 15 * v5
            local v10 = math.random(50, 80) * v5
            local v11 = v8.Color
            local v12, v13
            if v7 % 2 == 1 then
                v11 = BrickColor.new("Black").Color
                v12 = 200 * v5
                v13 = 1.25
            else
                v13 = 0.75
                v12 = 200
            end
            local v14 = _G.tween
            local v15 = {
                v13 * 4,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v16 = {}
            local v17 = v8.CFrame * CFrame.new(math.random(-v9, v9), math.random(0, v12), math.random(-v9, v9))
            local v18 = CFrame.Angles
            local v19 = math.random(-360, 900)
            local v20 = math.rad(v19)
            local v21 = math.random(-360, 900)
            local v22 = math.rad(v21)
            local v23 = math.random(-360, 900)
            v16.CFrame = v17 * v18(v20, v22, (math.rad(v23)))
            v14(v8, v15, v16)
            _G.tween(v8, {
                v13 * 1,
                "Smoother",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = v11
            })
            _G.tween(v8, {
                v13 * 1.5,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Size"] = Vector3.new(v10, v10, v10)
            })
            _G.destroy(v8, v13 * 4)
        end
        local v24 = script.Part:Clone()
        v24.CFrame = p3
        local v25 = v24.Mesh
        local v26 = 25 * v5
        local v27 = 25 * v5
        v25.Scale = Vector3.new(v26, 10000, v27)
        v24.Parent = workspace.Effects
        _G.tween(v24.Mesh, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 10000, 0)
        })
        _G.tween(v24.PointLight, {
            0.2,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 500,
            ["Brightness"] = 0
        })
        _G.destroy(v24, 0.2)
        _G.PlayEffect("Shockwave2", nil, p3 * CFrame.new(0, 120 * v5, 0), p3, BrickColor.new("White"), Vector3.new(125, 10, 125) * v5, Vector3.new(5, 10, 5) * v5, 1, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        _G.PlayEffect("Shockwave2", nil, p3 * CFrame.new(0, 10 * v5, 0), p3, BrickColor.new("White"), Vector3.new(250, 10, 250) * v5, Vector3.new(75, 10, 75) * v5, 2, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        goto l8
    else
        local v28 = tick()
        local v29 = 0
        while true do
            if tick() - v29 >= 0.02 then
                local v30 = Instance.new("Attachment")
                v30.Parent = p2.MeguminStaff.Orb
                local v31 = Instance.new("Attachment")
                local v32 = math.random(-5, 5)
                local v33 = math.random(-5, 5)
                local v34 = math.random
                v31.Position = Vector3.new(v32, v33, v34(-5, 5))
                v31.Parent = p2.MeguminStaff.Orb
                local v35 = script.Beam:Clone()
                v35.Parent = v30.Parent
                v35.Attachment0 = v30
                v35.Attachment1 = v31
                _G.tween(v31, {
                    0.25,
                    "Smoother",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Position"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(v35, 0.25)
                _G.destroy(v30, 0.25)
                _G.destroy(v31, 0.25)
                v29 = tick()
            end
            game["Run Service"].Heartbeat:Wait()
            if tick() - v28 >= 5 then
                ::l8::
                return
            end
        end
    end
end
return v1