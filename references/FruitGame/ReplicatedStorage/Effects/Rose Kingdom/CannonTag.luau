 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        local u3 = script.Part:Clone()
        u3.CFrame = p1
        local u4 = u3.BillboardGui
        u3.Parent = workspace.Effects
        p2.Changed:Connect(function(_) --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
            --]]
            _G.tween(u4.ImageLabel, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["ImageTransparency"] = 1
            })
            _G.destroy(u3, 1)
        end)
    end
}