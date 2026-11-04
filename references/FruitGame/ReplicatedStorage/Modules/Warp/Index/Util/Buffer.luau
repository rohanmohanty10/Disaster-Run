 

local v1 = {}
v1.__index = v1
local u2 = require(script.Dedicated)
local u3 = buffer.tostring
local u4 = buffer.fromstring
local u5 = buffer.readu8
local u6 = buffer.readi8
local u7 = buffer.readu16
local u8 = buffer.readi16
local u9 = buffer.readi32
local u10 = buffer.readf32
local u11 = buffer.readf64
local u12 = buffer.readstring
local u13 = buffer.len
local function u50(p14, p15, p16) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u7
        [4] = u50
        [5] = u12
        [6] = u8
        [7] = u9
        [8] = u11
        [9] = u10
    --]]
    local v17 = u6(p14, p15)
    local v18 = p15 + 1
    if v17 == 0 then
        return nil, v18
    elseif v17 == -1 then
        if p16 and #p16 ~= 0 then
            local v19 = p16[u5(p14, v18)]
            if typeof(v19) == "Instance" then
                return v19, v18 + 1
            else
                return nil, v18 + 1
            end
        else
            return nil, v18 + 1
        end
    else
        if v17 == -2 then
            local v20 = u7(p14, v18)
            local v21 = v18 + 2
            local v22 = {}
            for _ = 1, v20 do
                local v23
                v23, v21 = u50(p14, v21, p16)
                table.insert(v22, v23)
            end
            return v22, v21
        end
        if v17 == -3 then
            local v24 = u7(p14, v18)
            local v25 = v18 + 2
            local v26 = {}
            for _ = 1, v24 do
                local v27, v28 = u50(p14, v25, p16)
                local v29
                v29, v25 = u50(p14, v28, p16)
                v26[v27] = v29
            end
            return v26, v25
        end
        if v17 == -4 then
            local v30 = u6(p14, v18)
            local v31 = u12(p14, v18 + 1, v30)
            local v32 = u5(p14, v18 + 1 + v30)
            return Enum[v31]:FromValue(v32), v18 + 2 + v30
        end
        if v17 == -5 then
            local v33 = u8(p14, v18)
            return BrickColor.new(v33), v18 + 2
        end
        if v17 == -6 then
            local v34 = u6(p14, v18)
            local v35 = u12(p14, v18 + 1, v34)
            return Enum[v35], v18 + 1 + v34
        end
        if v17 == 1 then
            return u5(p14, v18), v18 + 1
        end
        if v17 == 2 then
            return u8(p14, v18), v18 + 2
        end
        if v17 == 3 then
            return u9(p14, v18), v18 + 4
        end
        if v17 == 4 then
            return u11(p14, v18), v18 + 8
        end
        if v17 == 5 then
            return u5(p14, v18) == 1, v18 + 1
        end
        if v17 == 6 then
            local v36 = u5(p14, v18)
            return u12(p14, v18 + 1, v36), v18 + v36 + 1
        end
        if v17 == 7 then
            local v37 = u7(p14, v18)
            return u12(p14, v18 + 2, v37), v18 + v37 + 2
        end
        if v17 == 8 then
            local v38 = u9(p14, v18)
            return u12(p14, v18 + 4, v38), v18 + v38 + 4
        end
        if v17 == 9 then
            local v39 = u10(p14, v18)
            local v40 = u10(p14, v18 + 4)
            local v41 = u10(p14, v18 + 8)
            return Vector3.new(v39, v40, v41), v18 + 12
        end
        if v17 == 10 then
            local v42 = u10(p14, v18)
            local v43 = u10(p14, v18 + 8)
            return Vector2.new(v42, v43), v18 + 8
        end
        if v17 == 11 then
            local v44 = {}
            for v45 = 1, 12 do
                local v46 = u10(p14, v18 + (v45 - 1) * 4)
                table.insert(v44, v46)
            end
            return CFrame.new(unpack(v44)), v18 + 48
        end
        if v17 == 12 then
            local v47 = u5(p14, v18)
            local v48 = u5(p14, v18 + 1)
            local v49 = u5(p14, v18 + 2)
            return Color3.fromRGB(v47, v48, v49), v18 + 3
        end
        error((("Unsupported type marker: %*"):format(v17)))
        return
    end
end
function v1.new() --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2()
end
function v1.convert(p51) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3(p51)
end
function v1.revert(p52) --[[ Line: 127 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    return u4(p52)
end
function v1.write(p53) --[[ Line: 131 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v54 = u2()
    v54:pack(p53)
    return v54:buildAndRemove()
end
function v1.read(p55, p56) --[[ Line: 137 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u50
    --]]
    local v57 = 0
    local v58 = {}
    while v57 < u13(p55) do
        local v59
        v59, v57 = u50(p55, v57, p56)
        table.insert(v58, v59)
    end
    return table.unpack(v58)
end
return v1