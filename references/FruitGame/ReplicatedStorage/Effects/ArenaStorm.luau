 

local v1 = {}
local u2 = nil
local u3 = false
function v1.start(_, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v5 = workspace.Effects:FindFirstChild("stormCircleModel")
    if p4 == true then
        if u2 == nil then
            u2 = script.ColorCorrection:Clone()
            u2.TintColor = Color3.fromRGB(255, 255, 255)
            u2.Contrast = 0
            u2.Brightness = 0
            u2.Parent = workspace.CurrentCamera
        end
        if u3 ~= true then
            u3 = true
            _G.tween(u2, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["TintColor"] = script.ColorCorrection.TintColor,
                ["Contrast"] = 1,
                ["Brightness"] = 0.5
            })
            script.looped:Play()
            script.enter:Play()
            local v6 = v5 and v5.PrimaryPart
            if v6 then
                _G.tween(v6, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = Color3.fromRGB(0, 0, 0),
                    ["Transparency"] = -5
                })
                return
            end
        end
    elseif u3 ~= false and u2 ~= nil then
        u3 = false
        _G.tween(u2, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255),
            ["Contrast"] = 0,
            ["Brightness"] = 0
        })
        script.looped:Stop()
        script.exit:Play()
        local v7 = v5 and v5.PrimaryPart
        if v7 then
            _G.tween(v7, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.fromRGB(255, 0, 0),
                ["Transparency"] = -5
            })
        end
    end
end
return v1