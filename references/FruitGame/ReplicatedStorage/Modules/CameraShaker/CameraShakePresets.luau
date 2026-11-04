 

local u1 = require(script.Parent.CameraShakeInstance)
local u19 = {
    ["Bump"] = function() --[[ Name: Bump, Line 26 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = u1.new(2.5, 4, 0.1, 0.75)
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v2.RotationInfluence = Vector3.new(1, 1, 1)
        return v2
    end,
    ["Punch"] = function() --[[ Name: Punch, Line 33 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = u1.new(1, 10, 0, 0.4)
        v3.PositionInfluence = Vector3.new(0.3, 0.3, 0.3)
        v3.RotationInfluence = Vector3.new(1, 1, 1)
        return v3
    end,
    ["PunchHeavy"] = function() --[[ Name: PunchHeavy, Line 40 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = u1.new(4, 8, 0.1, 0.8)
        v4.PositionInfluence = Vector3.new(0.3, 0.3, 0.3)
        v4.RotationInfluence = Vector3.new(3, 1, 1)
        return v4
    end,
    ["Explosion"] = function() --[[ Name: Explosion, Line 48 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v5 = u1.new(5, 10, 0, 1.5)
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v5.RotationInfluence = Vector3.new(4, 1, 1)
        return v5
    end,
    ["Earthquake"] = function() --[[ Name: Earthquake, Line 58 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v6 = u1.new(0.6, 3.5, 2, 10)
        v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v6.RotationInfluence = Vector3.new(1, 1, 4)
        return v6
    end,
    ["BadTrip"] = function() --[[ Name: BadTrip, Line 68 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v7 = u1.new(10, 0.15, 5, 10)
        v7.PositionInfluence = Vector3.new(0, 0, 0.15)
        v7.RotationInfluence = Vector3.new(2, 1, 4)
        return v7
    end,
    ["WindBreak"] = function() --[[ Name: WindBreak, Line 75 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v8 = u1.new(3, 5, 0.05, 0.75)
        v8.PositionInfluence = Vector3.new(0.08, 0.08, 0.08)
        v8.RotationInfluence = Vector3.new(0.45, 0.3, 0.35)
        return v8
    end,
    ["HandheldCamera"] = function() --[[ Name: HandheldCamera, Line 84 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v9 = u1.new(1, 0.25, 5, 10)
        v9.PositionInfluence = Vector3.new(0, 0, 0)
        v9.RotationInfluence = Vector3.new(1, 0.5, 0.5)
        return v9
    end,
    ["Vibration"] = function() --[[ Name: Vibration, Line 94 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v10 = u1.new(0.4, 20, 2, 2)
        v10.PositionInfluence = Vector3.new(0, 0.15, 0)
        v10.RotationInfluence = Vector3.new(1.25, 0, 4)
        return v10
    end,
    ["RoughDriving"] = function() --[[ Name: RoughDriving, Line 104 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v11 = u1.new(1, 2, 1, 1)
        v11.PositionInfluence = Vector3.new(0, 0, 0)
        v11.RotationInfluence = Vector3.new(1, 1, 1)
        return v11
    end,
    ["Underwater"] = function() --[[ Name: Underwater, Line 111 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v12 = u1.new(1, 0.25, 5, 10)
        v12.PositionInfluence = Vector3.new(0, 0, 0)
        v12.RotationInfluence = Vector3.new(0.25, 0.25, 0.25)
        return v12
    end,
    ["Choke"] = function() --[[ Name: Choke, Line 118 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v13 = u1.new(2, 4, 1, 1)
        v13.PositionInfluence = Vector3.new(0, 0, 0)
        v13.RotationInfluence = Vector3.new(3, 1, 3)
        return v13
    end,
    ["JinxMinigun"] = function() --[[ Name: JinxMinigun, Line 125 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v14 = u1.new(0.4, 20, 0.2, 0.2)
        v14.PositionInfluence = Vector3.new(0.1, 0.1, 0.1)
        v14.RotationInfluence = Vector3.new(1, 1, 1)
        return v14
    end,
    ["DragonBreath"] = function() --[[ Name: DragonBreath, Line 132 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v15 = u1.new(0.8, 6, 0.25, 0.5)
        v15.PositionInfluence = Vector3.new(0.1, 0.1, 0.1)
        v15.RotationInfluence = Vector3.new(1, 1, 1)
        return v15
    end,
    ["Shaking"] = function() --[[ Name: Shaking, Line 139 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v16 = u1.new(1, 6, 0.05, 0.45)
        v16.PositionInfluence = Vector3.new(0.3, 0.3, 0.3)
        v16.RotationInfluence = Vector3.new(0.5, 0.75, 1)
        return v16
    end,
    ["AceBlowUp"] = function() --[[ Name: AceBlowUp, Line 146 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v17 = u1.new(5, 10, 0.05, 0.75)
        v17.PositionInfluence = Vector3.new(0.1, 0.1, 0.1)
        v17.RotationInfluence = Vector3.new(1, 0.5, 0.85)
        return v17
    end,
    ["HakaiSlashHold"] = function() --[[ Name: HakaiSlashHold, Line 152 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v18 = u1.new(0.3, 5, 0.25, 0.5)
        v18.PositionInfluence = Vector3.new(0.1, 0.1, 0.1)
        v18.RotationInfluence = Vector3.new(1, 1, 1)
        return v18
    end
}
return setmetatable({}, {
    ["__index"] = function(_, p20) --[[ Name: __index, Line 162 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        local v21 = u19[p20]
        if type(v21) == "function" then
            return v21()
        end
        error("No preset found with index \"" .. p20 .. "\"")
    end
})