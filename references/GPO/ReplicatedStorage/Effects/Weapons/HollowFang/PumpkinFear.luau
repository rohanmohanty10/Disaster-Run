 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v3 = script.Handle:Clone()
            local v4
            if p2 then
                v3:Destroy()
                v3 = script.Handle2:Clone()
                v4 = 45
            else
                v4 = 25
            end
            v3.Parent = workspace.Effects
            v3.CFrame = p1
            _G.customEmit(v3)
            _G.destroy(v3, 6)
            local v5 = script.PointLight:Clone()
            v5.Parent = v3
            _G.tween(v5, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = v4,
                ["Brightness"] = 0
            })
            _G.destroy(v5, 1)
        end
    end
}