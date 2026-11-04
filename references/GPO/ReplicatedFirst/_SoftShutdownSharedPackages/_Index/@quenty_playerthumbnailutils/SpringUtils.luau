 

local u1 = require(script.Parent.loader).load(script)("LinearValue")
return {
    ["animating"] = function(p2, p3) --[[ Name: animating, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = p3 or 1e-6
        local v5 = p2.Position
        local v6 = p2.Target
        local v7 = nil
        if type(v6) == "number" then
            local v8 = p2.Position - p2.Target
            if v4 < math.abs(v8) then
                v7 = true
            else
                local v9 = p2.Velocity
                v7 = v4 < math.abs(v9)
            end
        else
            local v10 = typeof(v6)
            if v10 == "Vector3" or (v10 == "Vector2" or u1.isLinear(v6)) then
                v7 = v4 < (p2.Position - p2.Target).magnitude and true or v4 < p2.Velocity.magnitude
            else
                error("Unknown type")
            end
        end
        if v7 then
            return true, v5
        else
            return false, v6
        end
    end,
    ["getVelocityAdjustment"] = function(p11, p12, p13) --[[ Name: getVelocityAdjustment, Line 58 ]]
        assert(p11, "Bad velocity")
        assert(p12, "Bad dampen")
        assert(p13, "Bad speed")
        return p11 * (2 * p12 / p13)
    end,
    ["toLinearIfNeeded"] = function(p14) --[[ Name: toLinearIfNeeded, Line 73 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if typeof(p14) == "Color3" then
            return u1.new(Color3.new, { p14.r, p14.g, p14.b })
        elseif typeof(p14) == "UDim2" then
            return u1.new(UDim2.new, {
                p14.X.Scale,
                p14.X.Offset,
                p14.Y.Scale,
                p14.Y.Offset
            })
        elseif typeof(p14) == "UDim" then
            return u1.new(UDim.new, { p14.scale, p14.offset })
        else
            return p14
        end
    end,
    ["fromLinearIfNeeded"] = function(p15) --[[ Name: fromLinearIfNeeded, Line 91 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if u1.isLinear(p15) then
            return p15:ToBaseValue()
        else
            return p15
        end
    end
}