 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local u2 = script.Chidori:Clone()
        u2.CFrame = p1.PrimaryPart.CFrame
        u2.Parent = workspace.Effects
        _G.PlaySound(u2, script.ElectricGrip)
        task.delay(0.6, function() --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            _G.particleEnabled(u2, false)
            _G.destroy(u2, 2)
        end)
    end
}