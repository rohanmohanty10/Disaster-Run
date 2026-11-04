 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        tick()
        local v2 = script.Part:Clone()
        v2.Parent = workspace.Effects
        _G.tween(v2, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        repeat
            v2.CFrame = p1.CFrame * CFrame.new(0, 0, v2.Size.X / 2) * CFrame.Angles(0, -1.5707963267948966, 0)
            game["Run Service"].RenderStepped:Wait()
        until p1.Parent == nil
        v2:Destroy()
    end
}