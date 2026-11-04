 

return {
    ["start"] = function(_, u1, p2, p3) --[[ Name: start, Line 3 ]]
        local u4 = script.ScreenGui:Clone()
        u4.Frame.BackgroundTransparency = 1
        if p3 == true then
            u4.Frame.BackgroundTransparency = 0
        end
        u4.Parent = game.Players.LocalPlayer.PlayerGui
        if p2 == nil then
            _G.tween(u4.Frame, {
                u1,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                true,
                0
            }, {
                ["BackgroundTransparency"] = 0
            })
            _G.destroy(u4, u1 * 2)
        else
            _G.tween(u4.Frame, {
                u1 / 2,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                u1,
                0
            }, {
                ["BackgroundTransparency"] = 0
            })
            task.delay(u1 / 2 + 0.1, function() --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u1
                --]]
                _G.tween(u4.Frame, {
                    u1 / 2,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    u1,
                    0
                }, {
                    ["BackgroundTransparency"] = 1
                })
                _G.destroy(u4, u1 / 2)
            end)
        end
    end
}