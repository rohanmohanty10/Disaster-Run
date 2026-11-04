 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 8 ]]
        for _, v3 in pairs(script.SpeedLines:GetChildren()) do
            local u4 = v3:Clone()
            u4.Enabled = true
            u4.Parent = p1.Log.Primary
            task.delay(p2, function() --[[ Line: 14 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                u4.Enabled = false
                _G.destroy(u4, 1)
            end)
        end
        task.wait(p2)
        local v5 = script.Smoke:Clone()
        v5.Parent = p1.Log.Primary
        _G.customEmit(v5)
        _G.shakenear(p1.Log.Primary.Position, 50, 50, 50, -1)
        _G.destroy(v5, 2)
    end
}