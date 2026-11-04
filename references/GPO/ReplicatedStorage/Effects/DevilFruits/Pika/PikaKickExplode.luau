 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1) == false then
            return
        elseif p2 ~= nil then
            local v3 = script.dust:Clone()
            v3.CFrame = CFrame.new(p1)
            v3.Parent = workspace.Effects
            v3.Attachment.ParticleEmitter2.Size = NumberSequence.new(10, 0)
            v3.Attachment.Flare.Size = NumberSequence.new(25, 35)
            v3.Attachment.sm2.Color = ColorSequence.new(p2.Color)
            v3.Attachment.Rocks.Color = ColorSequence.new(p2.Color)
            _G.customEmit(v3.Attachment)
            _G.tween(v3.Attachment.star, {
                0.2,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["Size"] = NumberSequence.new(125)
            })
            _G.tween(v3.Attachment.Ring, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = NumberSequence.new(100),
                ["Transparency"] = NumberSequence.new(1)
            })
            _G.tween(v3.Attachment.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = 100,
                ["Brightness"] = 0
            })
            _G.destroy(v3.Attachment.star, 0.7)
            _G.destroy(v3, 5)
            local v4 = script.Part:Clone()
            v4.CFrame = CFrame.new(p1)
            v4.Parent = workspace.Effects
            _G.tween(v4, {
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Color"] = Color3.fromRGB(255, 85, 29),
                ["Size"] = Vector3.new(25, 25, 25)
            })
            _G.PlayEffect("GroundRocksExpand", nil, v4.CFrame, 8, 5, 15, 2, v4)
            _G.destroy(v4, 0.4)
            local v5 = script.Part:Clone()
            v5.CFrame = CFrame.new(p1)
            v5.Color = Color3.fromRGB(255, 255, 255)
            v5.Material = Enum.Material.ForceField
            v5.Transparency = -5
            v5.Parent = workspace.Effects
            _G.tween(v5, {
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1,
                ["Size"] = Vector3.new(45, 45, 45),
                ["Color"] = Color3.fromRGB(218, 133, 65)
            })
            _G.destroy(v5, 0.35)
            _G.PlayEffect("Spheres", nil, {
                ["cf"] = CFrame.new(p1),
                ["ti"] = 0.25,
                ["ti2"] = 0.25,
                ["range"] = 45,
                ["minThick"] = 10,
                ["maxThick"] = 40,
                ["part"] = v5,
                ["color"] = Color3.fromRGB(218, 133, 65),
                ["am"] = 15
            })
            _G.PlaySound(v5, script.explosion1)
        end
    end
}