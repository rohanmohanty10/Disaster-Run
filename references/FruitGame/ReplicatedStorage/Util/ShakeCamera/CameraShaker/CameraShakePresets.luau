 

local u1 = require(script.Parent.CameraShakeInstance)
local u9 = {
    ["Bump"] = function() --[[ Name: Bump, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = u1.new(2.5, 4, 0.1, 0.75)
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v2.RotationInfluence = Vector3.new(1, 1, 1)
        return v2
    end,
    ["Explosion"] = function() --[[ Name: Explosion, Line 20 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = u1.new(5, 10, 0, 1.5)
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v3.RotationInfluence = Vector3.new(4, 1, 1)
        return v3
    end,
    ["Earthquake"] = function() --[[ Name: Earthquake, Line 28 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = u1.new(0.6, 3.5, 2, 10)
        v4.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v4.RotationInfluence = Vector3.new(1, 1, 4)
        return v4
    end,
    ["BadTrip"] = function() --[[ Name: BadTrip, Line 36 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v5 = u1.new(10, 0.15, 5, 10)
        v5.PositionInfluence = Vector3.new(0, 0, 0.15)
        v5.RotationInfluence = Vector3.new(2, 1, 4)
        return v5
    end,
    ["HandheldCamera"] = function() --[[ Name: HandheldCamera, Line 45 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v6 = u1.new(1, 0.25, 5, 10)
        v6.PositionInfluence = Vector3.new(0, 0, 0)
        v6.RotationInfluence = Vector3.new(1, 0.5, 0.5)
        return v6
    end,
    ["Vibration"] = function() --[[ Name: Vibration, Line 54 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v7 = u1.new(0.4, 20, 2, 2)
        v7.PositionInfluence = Vector3.new(0, 0.15, 0)
        v7.RotationInfluence = Vector3.new(1.25, 0, 4)
        return v7
    end,
    ["RoughDriving"] = function() --[[ Name: RoughDriving, Line 62 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v8 = u1.new(1, 2, 1, 1)
        v8.PositionInfluence = Vector3.new(0, 0, 0)
        v8.RotationInfluence = Vector3.new(1, 1, 1)
        return v8
    end
}
return setmetatable({}, {
    ["__index"] = function(_, p10) --[[ Name: __index, Line 74 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        local v11 = u9[p10]
        if type(v11) == "function" then
            return v11()
        end
        error("No preset found with index \"" .. p10 .. "\"")
    end
})