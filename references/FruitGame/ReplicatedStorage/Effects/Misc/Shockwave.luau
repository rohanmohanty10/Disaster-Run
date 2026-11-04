 

return {
    ["start"] = function(_, p1, p2, p3, p4, p5, p6, p7, _, p8, p9) --[[ Name: start, Line 4 ]]
        if _G.checkRenderDistance(p1.Position) ~= false then
            local v10 = script.Shock:Clone()
            v10.CFrame = p1
            if p9 then
                v10.Material = p9
            end
            if p2 then
                v10.CFrame = p2
            end
            if typeof(p3) == "BrickColor" then
                v10.BrickColor = p3
            else
                v10.Color = p3
            end
            if p5 then
                v10.Size = p5
            end
            v10.Transparency = p7 == nil and 0 or p7
            _G.destroy(v10, p6)
            local v11 = {
                ["Size"] = p4,
                ["CFrame"] = p1,
                ["Transparency"] = 1
            }
            if p8 then
                v11.Color = p8
            end
            _G.tween(v10, {
                p6,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, v11)
        end
    end
}