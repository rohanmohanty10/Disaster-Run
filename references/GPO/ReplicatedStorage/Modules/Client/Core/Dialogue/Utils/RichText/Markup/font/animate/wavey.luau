 

game:GetService("TweenService")
local u6 = {
    ["Render"] = function(_, p1) --[[ Name: Render, Line 7 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        return {
            ["TextLabel"] = p1.TextLabel,
            ["Started"] = os.clock(),
            ["Module"] = u6
        }
    end,
    ["Update"] = function(_, p2) --[[ Name: Update, Line 15 ]]
        local v3 = {}
        local v4 = UDim2.fromOffset
        local v5 = (os.clock() - p2.Started) * 10
        v3.Position = v4(0, math.sin(v5) * 2.5)
        return v3
    end
}
return u6