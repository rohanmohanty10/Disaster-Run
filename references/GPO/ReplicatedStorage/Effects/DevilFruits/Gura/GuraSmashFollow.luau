 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p2.Position) == false then
            return
        end
        _G.PlayEffect("BallTrail", nil, p1, p1, 4, Color3.fromRGB(102, 207, 255), 0.5, 0.2)
        _G.PlayEffect("SurfaceTrail", nil, p1, nil, nil, 15, 25, 100, 40, 3, { "rock" })
        _G.PlayEffect("RockFollow", nil, p1, 4, 3.5)
        local v3 = Vector3.new()
        local v4 = Vector3.new()
        local _ = p1.CFrame
        while true do
            if (p1.Position - v4).Magnitude >= 1 then
                local v5 = script.Part2:Clone()
                v5.CFrame = p1.CFrame
                local v6 = (p1.Position - v4).Magnitude
                local v7 = v6 >= 20 and 4 or v6
                v5.Mesh.Scale = Vector3.new(2, 25, v7)
                local v8 = v5.Mesh
                local v9 = v5.Mesh.Scale.Y / 2
                v8.Offset = Vector3.new(0, v9, 0)
                v5.Parent = workspace.Effects
                local v10 = _G.tween
                local v11 = v5.Mesh
                local v12 = {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v13 = {}
                local v14 = v5.Mesh.Scale.X
                local v15 = v5.Mesh.Scale.Z
                v13.Scale = Vector3.new(v14, 0, v15)
                v13.Offset = Vector3.new()
                v10(v11, v12, v13)
                _G.tween(v5, {
                    0.1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = Color3.fromRGB(102, 207, 255)
                })
                _G.destroy(v5, 0.25)
                local v16 = script.Part2:Clone()
                v16.CFrame = p1.CFrame
                v16.Transparency = 1
                v16.Parent = workspace.Effects
                _G.customEmit(v16.Attachment.ParticleEmitter)
                _G.destroy(v16, 1)
                v4 = p1.Position
            end
            if (p1.Position - v3).Magnitude >= 20 then
                v3 = p1.Position
                local v17 = p1.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
                _G.PlayEffect("Shockwave2", nil, v17 * CFrame.new(0, 0, 0), v17, BrickColor.new("White"), Vector3.new(35, 2, 35), Vector3.new(5, 2, 5), 0.35, 0, Enum.EasingStyle.Quad, Color3.fromRGB(102, 207, 255), Enum.Material.Neon, "Rings")
            end
            local v18 = p1.CFrame
            game["Run Service"].RenderStepped:Wait()
            if p1:IsDescendantOf(workspace) == false then
                _G.PlayEffect("Spheres", nil, {
                    ["cf"] = v18,
                    ["ti"] = 0.25,
                    ["ti2"] = 0.25,
                    ["range"] = 25,
                    ["minThick"] = 10,
                    ["maxThick"] = 20,
                    ["part"] = nil,
                    ["color"] = Color3.fromRGB(255, 255, 255),
                    ["am"] = 15
                })
                return
            end
        end
    end
}