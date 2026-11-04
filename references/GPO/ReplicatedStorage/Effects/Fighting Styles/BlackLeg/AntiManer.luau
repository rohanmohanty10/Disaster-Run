 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p2.HumanoidRootPart.Position) ~= false then
            local v3 = script.Twister:Clone()
            v3.CFrame = CFrame.new(p2.HumanoidRootPart.Position) * CFrame.Angles(0, 0, -3.141592653589793)
            v3.Mesh.Scale = Vector3.new(35, 5, 35)
            v3.Parent = workspace.Effects
            _G.tween(v3, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v3.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, -15, 0),
                ["Transparency"] = 1
            })
            _G.tween(v3.Mesh, {
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(15, 35, 15)
            })
            _G.destroy(v3, 5)
            local _ = CFrame.new(p2.HumanoidRootPart.Position) * CFrame.Angles(0, 0, -3.141592653589793) * CFrame.new(0, 5, 0)
            local _ = BrickColor.new("Steel blue").Color
            Color3.fromRGB(255, 255, 255)
            local v4 = CFrame.new((p2.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)).Position)
            local u5 = script.HumanoidRootPart.Attachment:Clone()
            u5.Parent = p2.HumanoidRootPart
            _G.customEmit(u5.Glow)
            local v6 = script.dust:Clone()
            v6.Anchored = true
            v6.CFrame = CFrame.new(p2.HumanoidRootPart.CFrame.Position) * CFrame.new(0, -p2.Humanoid.HipHeight - 1, 0)
            v6.Parent = workspace.Effects
            local v7 = Ray.new(p1.HumanoidRootPart.CFrame.Position, p1.HumanoidRootPart.CFrame.upVector * -(p1.Humanoid.HipHeight * 2))
            local v8, _, _ = _G.raycastIgnoreList(v7, {
                workspace.Effects,
                workspace.Projectiles,
                v6,
                workspace.PlayerCharacters,
                workspace.NPCs
            })
            if v8 then
                v6.Attachment.sm2.Color = ColorSequence.new(v8.Color)
                v6.Attachment.sm.Color = ColorSequence.new(v8.Color)
                v6.Attachment.Rocks.Color = ColorSequence.new(v8.Color)
                v6.Attachment.Rocks2.Color = ColorSequence.new(v8.Color)
                v6.Attachment.sm2.Size = NumberSequence.new(5, 35)
                _G.customEmit(v6)
            end
            _G.destroy(v6, 3)
            task.spawn(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                task.wait(0.3)
                if u5.Parent ~= nil then
                    u5.Glow.Enabled = false
                end
            end)
            local v9 = CFrame.new(p2.HumanoidRootPart.CFrame.Position)
            for _ = 1, 10 do
                local v10 = script.speedline:Clone()
                v10.Parent = workspace.Effects
                local v11 = math.random(10, 35) / 100
                local v12 = math.random(10, 300) / 10
                v10.Size = Vector3.new(v11, v12, v11)
                v10.CFrame = v9 * CFrame.new(math.random(-5, 5), math.random(-25, 10), math.random(-5, 5))
                _G.tween(v10, {
                    1,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = v10.CFrame * CFrame.new(0, math.random(10, 80), 0),
                    ["Transparency"] = 1
                })
                _G.destroy(v10, 1)
                if math.random(1, 2) == 1 then
                    v10.Color = Color3.fromRGB(0, 0, 0)
                end
            end
            local u13 = p2.HumanoidRootPart.CFrame * CFrame.new(0, -18, 0)
            task.spawn(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                for v14 = 1, 2 do
                    local v15 = u13 * CFrame.new(0, v14 * 15, 0)
                    _G.PlayEffect("Shockwave2", nil, v15 * CFrame.new(0, v14, 0), v15 * CFrame.Angles(0, -3.141592653589793, 0), BrickColor.new("White"), Vector3.new(55, 0, 55) / v14, Vector3.new(5, 10, 5), v14 / 10 + 0.5, 0, Enum.EasingStyle.Back, nil, Enum.Material.Neon, "Rings")
                end
            end)
            local _ = CFrame.new(p2.HumanoidRootPart.Position) * CFrame.Angles(0, 0, -3.141592653589793)
            local v16 = p2.HumanoidRootPart.CFrame
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = v4,
                ["ti"] = 0.25,
                ["ti2"] = 0.75,
                ["range"] = 25,
                ["minThick"] = 2,
                ["maxThick"] = 5,
                ["part"] = p2.HumanoidRootPart,
                ["color"] = Color3.fromRGB(255, 255, 255),
                ["am"] = 20
            })
            _G.PlayEffect("GroundRocks", nil, v16, 25, 4, 25, 4)
        end
    end
}