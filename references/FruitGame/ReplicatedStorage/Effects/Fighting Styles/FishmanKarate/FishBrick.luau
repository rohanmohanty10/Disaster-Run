 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            _G.PlayEffect("Shockwave2", nil, p1 * CFrame.new(0, 10, 0), p1, BrickColor.new("Pastel Blue"), Vector3.new(20, 1, 20), Vector3.new(5, 1, 5), 0.25, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            _G.PlayEffect("Shockwave2", nil, p1 * CFrame.new(0, 20, 0), p1, BrickColor.new("Pastel Blue"), Vector3.new(35, 1, 35), Vector3.new(5, 1, 5), 0.25, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            local v2 = script.Part:Clone()
            v2.CFrame = p1
            v2.Mesh.Offset = Vector3.new(0, 12.5, 0)
            v2.Mesh.Scale = Vector3.new(20, 25, 20)
            v2.Parent = workspace.Effects
            _G.tween(v2.Mesh, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, 0, 0),
                ["Offset"] = Vector3.new(0, 25, 0)
            })
            _G.tween(v2, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(v2, 0.25)
            local v3 = script.MeshPart:Clone()
            local v4 = CFrame.Angles
            local v5 = math.random(-360, 360)
            v3.CFrame = p1 * v4(3.141592653589793, math.rad(v5), 0)
            v3.Parent = workspace.Effects
            _G.tween(v3, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v3.CFrame * CFrame.new(0, -15, 0),
                ["Size"] = v3.Size * 2 + Vector3.new(0, 10, 0),
                ["Transparency"] = 1
            })
            _G.destroy(v3, 0.25)
            local v6 = script.PunchedParticle:Clone()
            v6.Parent = workspace.Effects
            v6.CFrame = p1
            _G.customEmit(v6)
            _G.destroy(v6, 1)
        end
    end
}