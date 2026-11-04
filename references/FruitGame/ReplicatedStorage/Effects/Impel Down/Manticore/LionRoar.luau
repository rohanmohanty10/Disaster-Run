 

return {
    ["start"] = function(_, p1, _) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) ~= false then
            game:GetService("TweenService")
            local v2 = workspace.Effects
            local v3 = script.LionRoar:Clone()
            local u4 = v3.Roar
            v3.Parent = v2
            _G.customWeld(u4, p1["Cube.006"], CFrame.new(0, -1, -14.68), u4)
            task.wait(0.65)
            _G.customEmit(u4)
            _G.particleEnabled(u4, true)
            task.delay(0.8, function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                _G.particleEnabled(u4, false)
            end)
            _G.destroy(v3, 2.5)
        end
    end
}