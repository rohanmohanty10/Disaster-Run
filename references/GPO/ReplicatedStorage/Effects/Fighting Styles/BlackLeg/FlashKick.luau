 

local v1 = {}
Color3.fromRGB(255, 81, 0)
function v1.start(_, p2) --[[ Line: 6 ]]
    if _G.checkRenderDistance(p2.HumanoidRootPart.Position) ~= false then
        local v3 = script.sphere:Clone()
        v3.CFrame = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -15) * CFrame.Angles(1.5707963267948966, 0, 3.141592653589793)
        v3.Mesh.Scale = Vector3.new(12, 30, 12)
        v3.Parent = workspace.Effects
        local v4 = _G.tween
        local v5 = v3.Mesh
        local v6 = {
            0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v7 = {}
        local v8 = v3.Mesh.Scale.Y + 15
        v7.Scale = Vector3.new(0, v8, 0)
        v7.Offset = Vector3.new(0, 22.5, 0)
        v4(v5, v6, v7)
        _G.destroy(v3, 0.15)
        local v9 = p2.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) * CFrame.Angles(-1.5707963267948966, 0, 0)
        _G.PlayEffect("Spheres", nil, {
            ["startSize"] = Vector3.new(0, 0, 0),
            ["xrange"] = 10,
            ["yrange"] = 16,
            ["zrange"] = 10,
            ["cf"] = v9,
            ["ti"] = 0.2,
            ["ti2"] = 0.1,
            ["range"] = 0,
            ["minThick"] = 3,
            ["maxThick"] = 10,
            ["part"] = nil,
            ["color"] = script.sphere.Color,
            ["am"] = 15
        })
        _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, 10, 0), v9, BrickColor.new("Pastel Blue"), Vector3.new(20, 1, 20), Vector3.new(5, 1, 5), 0.25, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        _G.PlayEffect("Shockwave2", nil, v9 * CFrame.new(0, 20, 0), v9, BrickColor.new("Pastel Blue"), Vector3.new(35, 1, 35), Vector3.new(5, 1, 5), 0.25, -1, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
        local v10 = script.Part:Clone()
        v10.CFrame = v9
        v10.Mesh.Offset = Vector3.new(0, 12.5, 0)
        v10.Mesh.Scale = Vector3.new(20, 25, 20)
        v10.Parent = workspace.Effects
        _G.tween(v10.Mesh, {
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
        _G.tween(v10, {
            0.25,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v10, 0.25)
        local v11 = script.MeshPart:Clone()
        local v12 = CFrame.Angles
        local v13 = math.random(-360, 360)
        v11.CFrame = v9 * v12(0, math.rad(v13), 1.5707963267948966)
        v11.Parent = workspace.Effects
        local v14 = _G.tween
        local v15 = {
            0.25,
            "Smooth",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v16 = {}
        local v17 = v11.CFrame * CFrame.new(15, 0, 0)
        local v18 = CFrame.Angles
        local v19 = math.random(-360, 360)
        v16.CFrame = v17 * v18(math.rad(v19), 0, 0)
        v16.Size = v11.Size * 2 + Vector3.new(10, 0, 0)
        v16.Transparency = 1
        v14(v11, v15, v16)
        _G.destroy(v11, 0.25)
        local v20 = script.PunchedParticle:Clone()
        v20.CFrame = v9
        v20.Parent = workspace.Effects
        _G.customEmit(v20)
        _G.destroy(v20, 0.5)
        _G.PlayEffect("PhoenixSlash", nil, 6, {
            ["CFrame"] = v9,
            ["Scale"] = 45,
            ["Accent"] = Color3.fromRGB(255, 170, 0),
            ["Offset"] = CFrame.new(0, 40, 0),
            ["Color"] = Color3.fromRGB(255, 81, 0),
            ["Transparency"] = -1,
            ["Duration"] = 0.25,
            ["RotationDirection"] = 3
        })
        _G.PlayEffect("PhoenixSlash", nil, 6, {
            ["CFrame"] = v9,
            ["Scale"] = 15,
            ["Accent"] = Color3.fromRGB(255, 170, 0),
            ["Offset"] = CFrame.new(0, 50, 0),
            ["Color"] = Color3.fromRGB(255, 81, 0),
            ["Transparency"] = -1,
            ["Duration"] = 0.4,
            ["RotationDirection"] = 3
        })
    end
end
return v1