 

local v1 = {}
game:GetService("RunService")
function v1.start(_, p2, _, _, p3, p4) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Position) ~= false then
        for _ = 1, 35 do
            local v5 = script.sph:Clone()
            v5.CFrame = p2 * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
            local v6 = v5.CFrame
            v5.CFrame = v5.CFrame * CFrame.new(0, -math.random(p3 / 2, p3), 0)
            if math.random(1, 2) == 1 then
                v5.Color = Color3.fromRGB(0, 0, 0)
            end
            local v7 = math.random(50, 120) / 200
            local v8 = math.random(5, 15)
            v5.Mesh.Scale = Vector3.new(v7, v8, v7)
            local v9 = math.random(100, 200) / 1000
            v5.Parent = workspace.Effects
            _G.tween(v5, {
                v9,
                "EntranceProductive",
                "Out",
                0,
                false,
                0
            }, {
                ["CFrame"] = v6
            })
            _G.tween(v5, {
                v9,
                "Smoother",
                "In",
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v5, v9)
        end
        if p4 == game.Players.LocalPlayer.Character then
            _G.tween(workspace.CurrentCamera, {
                0.25,
                "Quad",
                "Out",
                0,
                true,
                0
            }, {
                ["FieldOfView"] = 85
            })
        end
    end
end
return v1