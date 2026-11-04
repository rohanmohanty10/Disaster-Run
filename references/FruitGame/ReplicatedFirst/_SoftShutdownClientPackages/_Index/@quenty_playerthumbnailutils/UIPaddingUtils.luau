 

local u8 = {
    ["fromUDim"] = function(p1) --[[ Name: fromUDim, Line 8 ]]
        local v2 = Instance.new("UIPadding")
        v2.PaddingBottom = p1
        v2.PaddingTop = p1
        v2.PaddingLeft = p1
        v2.PaddingRight = p1
        return v2
    end,
    ["getTotalPadding"] = function(p3) --[[ Name: getTotalPadding, Line 18 ]]
        return UDim2.new(p3.PaddingLeft + p3.PaddingRight, p3.PaddingBottom + p3.PaddingTop)
    end,
    ["getTotalAbsolutePadding"] = function(p4, p5) --[[ Name: getTotalAbsolutePadding, Line 23 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        local v6 = u8.getTotalPadding(p4)
        return Vector2.new(v6.X.Offset + v6.X.Scale * p5.x, v6.Y.Offset + v6.Y.Scale * p5.Y)
    end,
    ["getHorizontalPadding"] = function(p7) --[[ Name: getHorizontalPadding, Line 31 ]]
        return p7.PaddingLeft + p7.PaddingRight
    end
}
return u8