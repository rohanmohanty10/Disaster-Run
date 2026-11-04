 

local u1 = game:GetService("TweenService")
local u9 = {
    ["Render"] = function(_, p2) --[[ Name: Render, Line 7 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        return {
            ["TextLabel"] = p2.TextLabel,
            ["Started"] = os.clock(),
            ["Offset"] = -10,
            ["Module"] = u9
        }
    end,
    ["Update"] = function(_, p3) --[[ Name: Update, Line 16 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = (os.clock() - p3.Started) / 0.25
        local v5 = u1:GetValue(math.min(v4, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local v6 = {}
        local v7 = UDim2.fromOffset
        local v8 = p3.Offset
        v6.Position = v7(0, (math.lerp(v8, 0, v5)))
        v6.TextTransparency = 1 - v5
        return v6
    end
}
return u9