 

local u1 = Random.new(tick())
local u25 = {
    ["GetRandomVector"] = function(p2, p3, p4) --[[ Name: GetRandomVector, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p4 then
            local v5 = u1:NextNumber(p2[1], p3[1])
            local v6 = u1:NextNumber(p2[2], p3[2])
            local v7 = u1
            local v8 = p2[3]
            local v9 = p3[3]
            return Vector3.new(v5, v6, v7:NextNumber(v8, v9))
        else
            local v10 = u1:NextInteger(p2[1], p3[1])
            local v11 = u1:NextInteger(p2[2], p3[2])
            local v12 = u1
            local v13 = p2[3]
            local v14 = p3[3]
            return Vector3.new(v10, v11, v12:NextInteger(v13, v14))
        end
    end,
    ["GetRandomCFrame"] = function(p15, p16, p17) --[[ Name: GetRandomCFrame, Line 23 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p17 then
            return CFrame.new(u1:NextNumber(p15[1], p16[1]), u1:NextNumber(p15[2], p16[2]), u1:NextNumber(p15[3], p16[3]))
        else
            return CFrame.new(u1:NextInteger(p15[1], p16[1]), u1:NextInteger(p15[2], p16[2]), u1:NextInteger(p15[3], p16[3]))
        end
    end,
    ["GetRandomAngles"] = function(p18, p19, p20) --[[ Name: GetRandomAngles, Line 39 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p20 then
            return CFrame.Angles(u1:NextNumber(p18[1], p19[1]), u1:NextNumber(p18[2], p19[2]), u1:NextNumber(p18[3], p19[3]))
        else
            return CFrame.Angles(u1:NextInteger(p18[1], p19[1]), u1:NextInteger(p18[2], p19[2]), u1:NextInteger(p18[3], p19[3]))
        end
    end,
    ["GetRandomNumber"] = function(p21, p22, p23) --[[ Name: GetRandomNumber, Line 55 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if p23 then
            return u1:NextNumber(p21, p22)
        else
            return u1:NextInteger(p21, p22)
        end
    end,
    ["GetRandomSign"] = function() --[[ Name: GetRandomSign, Line 63 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        local v24 = u25.GetRandomNumber(-1, 1)
        return v24 == 0 and 1 or v24
    end
}
return u25