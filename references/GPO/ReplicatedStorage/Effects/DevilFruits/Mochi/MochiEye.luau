 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            local v2 = 1 - p1.Humanoid.BodyWidthScale.Value
            local v3 = 1 - p1.Humanoid.BodyDepthScale.Value
            local _ = 1 - p1.Humanoid.BodyHeightScale.Value
            local _ = v2 < v3
            local v4 = script.DarkenEyeBg:Clone()
            v4.root.Weld.Part1 = p1.HumanoidRootPart
            v4.root.Weld.C0 = CFrame.new(0, -50, 0)
            v4.eye1.Size = Vector3.new(0.2, 0, 0)
            v4.eye2.Size = v4.eye1.Size
            v4.eye1.Transparency = 0.8
            v4.eye2.Transparency = 0.8
            v4.eye1.Size = Vector3.new(0.4, 0.001, 0)
            v4.eye2.Size = Vector3.new(0.4, 0.001, 0)
            v4.Parent = workspace.Effects
            task.wait(0.2)
            _G.tween(v4.eye1, {
                1.75,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0.6, 0.25, 0.1),
                ["Transparency"] = 0
            })
            _G.tween(v4.eye2, {
                1.75,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.InOut,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(0.6, 0.25, 0.1),
                ["Transparency"] = 0
            })
            task.wait(0.9)
            v4.eye1.Beam.Enabled = true
            v4.eye2.Beam.Enabled = true
            _G.destroy(v4, 4)
        end
    end
}