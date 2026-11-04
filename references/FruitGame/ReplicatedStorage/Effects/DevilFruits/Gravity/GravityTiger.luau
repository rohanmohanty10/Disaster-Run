 

local v1 = {}
game:GetService("RunService")
function v1.start(_, p2, p3, p4) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.Position) ~= false then
        local v5 = Ray.new(p2.Position, p2.UpVector * -4)
        local v6, v7 = _G.raycastWhitelist(v5, { workspace.Islands, workspace.Ships, workspace.Env })
        local v8 = p3 * CFrame.Angles(3.141592653589793, 0, 0)
        _G.PlayEffect("Shockwave2", nil, v8, v8, Color3.fromRGB(128, 91, 209), Vector3.new(25, 1, 25), Vector3.new(12.5, 0.5, 12.5), 0.1, -1, Enum.EasingStyle.Quad, Color3.fromRGB(128, 91, 209), Enum.Material.Neon, "Rings")
        if v6 then
            local v9 = script.dust:Clone()
            v9.CFrame = p4.cf * CFrame.new(0, -(p2.Position - v7).Magnitude, 0)
            v9.Attachment.sm2.Color = ColorSequence.new(v6.Color)
            v9.Attachment.Rocks.Color = ColorSequence.new(v6.Color)
            v9.Parent = workspace.Effects
            _G.customEmit(v9)
            _G.destroy(v9, 3)
        end
        for _ = 1, 35 do
            local v10 = script.sph:Clone()
            v10.CFrame = p3 * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
            if math.random(1, 2) == 1 then
                v10.Color = Color3.fromRGB(0, 0, 0)
            end
            local v11 = math.random(50, 120) / 200
            local v12 = math.random(5, 15)
            v10.Mesh.Scale = Vector3.new(v11, v12, v11)
            local v13 = math.random(100, 200) / 1000
            v10.Parent = workspace.Effects
            _G.tween(v10, {
                v13,
                "EntranceProductive",
                "Out",
                0,
                false,
                0
            }, {
                ["CFrame"] = v10.CFrame * CFrame.new(0, -math.random(15, 45), 0)
            })
            _G.tween(v10, {
                v13,
                "Smoother",
                "In",
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v10, v13)
        end
    end
end
return v1