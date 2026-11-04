 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        local u2 = script.Sukuna:Clone()
        u2.CFrame = p1.PrimaryPart.CFrame
        u2.Parent = workspace.Effects
        _G.PlaySound(u2, script.DismantleGrip)
        task.delay(0.2, function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            _G.particleEnabled(u2, false)
            _G.destroy(u2, 1)
        end)
        task.wait(0.15)
        local v3 = script.Fx:Clone()
        v3.Parent = workspace.Effects
        v3.CFrame = p1.PrimaryPart.CFrame
        _G.customEmit(v3)
        _G.destroy(v3, 1)
    end
}