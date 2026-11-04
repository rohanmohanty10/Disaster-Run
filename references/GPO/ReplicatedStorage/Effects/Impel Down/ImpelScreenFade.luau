 

local u1 = game:GetService("Players").LocalPlayer
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.FadeType
        local u4 = p2.FadeTime
        local v5 = p2.WillFadeOut
        if v3 == "In" then
            local u6 = script.ScreenGui:Clone()
            u6.Name = "ImpelScreenFadeGui"
            u6.Frame.BackgroundTransparency = 1
            u6.Parent = u1.PlayerGui
            _G.tween(u6.Frame, { u4, "Quad", Enum.EasingDirection.Out }, {
                ["BackgroundTransparency"] = 0
            })
            if v5 ~= nil then
                task.delay(u4 / 2 + 0.1, function() --[[ Line: 23 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                        [2] = u4
                    --]]
                    _G.tween(u6.Frame, {
                        u4 / 2,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        u4,
                        0
                    }, {
                        ["BackgroundTransparency"] = 1
                    })
                    _G.destroy(u6, u4 / 2)
                end)
                return
            end
        elseif v3 == "Out" then
            local v7 = u1.PlayerGui:FindFirstChild("ImpelScreenFadeGui")
            if v7 and v7.Enabled == false then
                v7.Enabled = true
            end
            if v7 then
                _G.tween(v7.Frame, {
                    u4,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    u4,
                    0
                }, {
                    ["BackgroundTransparency"] = 1
                })
                _G.destroy(v7, u4)
            end
        end
    end
}