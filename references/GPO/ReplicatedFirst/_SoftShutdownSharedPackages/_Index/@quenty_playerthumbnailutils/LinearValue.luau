 

local u1 = {
    ["ClassName"] = "LinearValue"
}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    return setmetatable({
        ["_constructor"] = p2,
        ["_values"] = p3
    }, v4)
end
function u1.isLinear(p5) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6
    if type(p5) == "table" then
        v6 = getmetatable(p5) == u1
    else
        v6 = false
    end
    return v6
end
function u1.ToBaseValue(p7) --[[ Line: 39 ]]
    local v8 = p7._constructor
    local v9 = p7._values
    return v8(unpack(v9))
end
function u1.GetMagnitude(p10) --[[ Line: 84 ]]
    local v11 = 0
    for v12 = 1, #p10._values do
        local v13 = p10._values[v12]
        v11 = v11 + v13 * v13
    end
    return math.sqrt(v11)
end
function u1.__index(p14, p15) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1[p15] then
        return u1[p15]
    elseif p15 == "magnitude" then
        return p14:GetMagnitude()
    else
        return nil
    end
end
local function u18(p16, p17) --[[ Line: 110 ]]
    return p16 + p17
end
function u1.__add(p19, p20) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u18
    --]]
    if u1.isLinear(p19) and u1.isLinear(p20) then
        local v21 = p19._constructor == p20._constructor
        assert(v21, "a is not the same type of linearValue as b")
        local v22 = {}
        for v23 = 1, #p19._values do
            v22[v23] = u18(p19._values[v23], p20._values[v23])
        end
        return u1.new(p19._constructor, v22)
    elseif u1.isLinear(p19) then
        if type(p20) == "number" then
            local v24 = {}
            for v25 = 1, #p19._values do
                v24[v25] = u18(p19._values[v25], p20)
            end
            return u1.new(p19._constructor, v24)
        end
        error("Bad type (b)")
        return
    elseif u1.isLinear(p20) then
        if type(p19) == "number" then
            local v26 = {}
            for v27 = 1, #p20._values do
                v26[v27] = u18(p19, p20._values[v27])
            end
            return u1.new(p20._constructor, v26)
        end
        error("Bad type (a)")
    else
        error("Neither value is a linearValue")
    end
end
local function u30(p28, p29) --[[ Line: 114 ]]
    return p28 - p29
end
function u1.__sub(p31, p32) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u30
    --]]
    if u1.isLinear(p31) and u1.isLinear(p32) then
        local v33 = p31._constructor == p32._constructor
        assert(v33, "a is not the same type of linearValue as b")
        local v34 = {}
        for v35 = 1, #p31._values do
            v34[v35] = u30(p31._values[v35], p32._values[v35])
        end
        return u1.new(p31._constructor, v34)
    elseif u1.isLinear(p31) then
        if type(p32) == "number" then
            local v36 = {}
            for v37 = 1, #p31._values do
                v36[v37] = u30(p31._values[v37], p32)
            end
            return u1.new(p31._constructor, v36)
        end
        error("Bad type (b)")
        return
    elseif u1.isLinear(p32) then
        if type(p31) == "number" then
            local v38 = {}
            for v39 = 1, #p32._values do
                v38[v39] = u30(p31, p32._values[v39])
            end
            return u1.new(p32._constructor, v38)
        end
        error("Bad type (a)")
    else
        error("Neither value is a linearValue")
    end
end
local function u42(p40, p41) --[[ Line: 118 ]]
    return p40 * p41
end
function u1.__mul(p43, p44) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u42
    --]]
    if u1.isLinear(p43) and u1.isLinear(p44) then
        local v45 = p43._constructor == p44._constructor
        assert(v45, "a is not the same type of linearValue as b")
        local v46 = {}
        for v47 = 1, #p43._values do
            v46[v47] = u42(p43._values[v47], p44._values[v47])
        end
        return u1.new(p43._constructor, v46)
    elseif u1.isLinear(p43) then
        if type(p44) == "number" then
            local v48 = {}
            for v49 = 1, #p43._values do
                v48[v49] = u42(p43._values[v49], p44)
            end
            return u1.new(p43._constructor, v48)
        end
        error("Bad type (b)")
        return
    elseif u1.isLinear(p44) then
        if type(p43) == "number" then
            local v50 = {}
            for v51 = 1, #p44._values do
                v50[v51] = u42(p43, p44._values[v51])
            end
            return u1.new(p44._constructor, v50)
        end
        error("Bad type (a)")
    else
        error("Neither value is a linearValue")
    end
end
local function u54(p52, p53) --[[ Line: 122 ]]
    return p52 / p53
end
function u1.__div(p55, p56) --[[ Line: 44 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u54
    --]]
    if u1.isLinear(p55) and u1.isLinear(p56) then
        local v57 = p55._constructor == p56._constructor
        assert(v57, "a is not the same type of linearValue as b")
        local v58 = {}
        for v59 = 1, #p55._values do
            v58[v59] = u54(p55._values[v59], p56._values[v59])
        end
        return u1.new(p55._constructor, v58)
    elseif u1.isLinear(p55) then
        if type(p56) == "number" then
            local v60 = {}
            for v61 = 1, #p55._values do
                v60[v61] = u54(p55._values[v61], p56)
            end
            return u1.new(p55._constructor, v60)
        end
        error("Bad type (b)")
        return
    elseif u1.isLinear(p56) then
        if type(p55) == "number" then
            local v62 = {}
            for v63 = 1, #p56._values do
                v62[v63] = u54(p55, p56._values[v63])
            end
            return u1.new(p56._constructor, v62)
        end
        error("Bad type (a)")
    else
        error("Neither value is a linearValue")
    end
end
function u1.__eq(_, p64, p65) --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if not (u1.isLinear(p64) and u1.isLinear(p65)) then
        return false
    end
    if #p64._values ~= #p65._values then
        return false
    end
    for v66 = 1, #p64._values do
        if p64._values[v66] ~= p65._values[v66] then
            return false
        end
    end
    return true
end
return u1