 

local u1 = Random.new()
local u5 = {
    ["_getRandomOffset"] = function(_) --[[ Name: _getRandomOffset, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = u1:NextUnitVector() * 2
        return Vector2.new(v2.X, v2.Y)
    end,
    ["Render"] = function(_, p3) --[[ Name: Render, Line 9 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return {
            ["TextLabel"] = p3.TextLabel,
            ["Started"] = os.clock(),
            ["Offset"] = u5:_getRandomOffset(),
            ["Module"] = u5
        }
    end,
    ["Update"] = function(_, p4, _) --[[ Name: Update, Line 18 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        if os.clock() - p4.Started >= 0.1 then
            p4.Started = os.clock()
            p4.Offset = u5:_getRandomOffset()
        end
        return {
            ["Position"] = UDim2.fromOffset(p4.Offset.X, p4.Offset.Y)
        }
    end
}
return u5