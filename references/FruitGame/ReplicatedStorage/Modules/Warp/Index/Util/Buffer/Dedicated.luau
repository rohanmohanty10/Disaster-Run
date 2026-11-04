 

local u1 = {}
u1.__index = u1
local u2 = buffer.create
local u3 = buffer.copy
local u4 = buffer.writei8
local u5 = buffer.writei16
local u6 = buffer.writei32
local u7 = buffer.writeu8
local u8 = buffer.writeu16
local u9 = buffer.writeu32
local u10 = buffer.writef32
local u11 = buffer.writef64
local u12 = buffer.writestring
local u13 = {
    ["point"] = 0,
    ["next"] = 0,
    ["size"] = 128,
    ["bufferSize"] = 128
}
function u1.copy(p14, p15, p16, p17, p18, p19) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u13
    --]]
    if p16 then
        u3(p16, p15, p17 or p14.buffer, p18, p19)
    else
        u3(u2(p19 or u13.size), p15, p17 or p14.buffer, p18, p19)
    end
end
function u1.alloc(p20, p21) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v22 = p20.size
    local v23 = p20.buffer
    while v22 <= p20.next + p21 do
        local v24 = v22 * 1.25
        v22 = math.floor(v24)
    end
    local v25 = u2(v22)
    u3(v25, 0, v23)
    p20.point = p20.next
    p20.buffer = v25
    p20.next = p20.next + p21
end
function u1.build(p26) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v27 = p26.next > p26.point and p26.next or p26.point
    local v28 = u2(v27)
    u3(v28, 0, p26.buffer, 0, v27)
    return v28
end
function u1.buildAndRemove(p29) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v30 = p29.next > p29.point and p29.next or p29.point
    local v31 = u2(v30)
    local v32
    if #p29.ref > 0 then
        v32 = table.clone(p29.ref) or nil
    else
        v32 = nil
    end
    u3(v31, 0, p29.buffer, 0, v30)
    p29:remove()
    return v31, v32
end
function u1.wi8(p33, p34, p35) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if p34 then
        p33:alloc(p35 or 1)
        u4(p33.buffer, p33.point, p34)
    end
end
function u1.wi16(p36, p37, p38) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if p37 then
        p36:alloc(p38 or 2)
        u5(p36.buffer, p36.point, p37)
    end
end
function u1.wi32(p39, p40, p41) --[[ Line: 82 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p40 then
        p39:alloc(p41 or 4)
        u6(p39.buffer, p39.point, p40)
    end
end
function u1.wu8(p42, p43, p44) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p43 then
        p42:alloc(p44 or 1)
        u7(p42.buffer, p42.point, p43)
    end
end
function u1.wu16(p45, p46, p47) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if p46 then
        p45:alloc(p47 or 2)
        u8(p45.buffer, p45.point, p46)
    end
end
function u1.wu32(p48, p49, p50) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if p49 then
        p48:alloc(p50 or 4)
        u9(p48.buffer, p48.point, p49)
    end
end
function u1.wf32(p51, p52, p53) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if p52 then
        p51:alloc(p53 or 4)
        u10(p51.buffer, p51.point, p52)
    end
end
function u1.wf64(p54, p55, p56) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if p55 then
        p54:alloc(p56 or 8)
        u11(p54.buffer, p54.point, p55)
    end
end
function u1.wstring(p57, p58) --[[ Line: 118 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    if p58 then
        p57:alloc(#p58)
        u12(p57.buffer, p57.point, p58)
    end
end
function u1.wType(p59, p60) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7(p59.buffer, p59.point, p60)
    p59.point = p59.point + 1
end
function u1.wRef(p61, p62, p63) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p62 then
        p61:alloc(p63 or 1)
        local v64 = p61.ref
        table.insert(v64, p62)
        local v65 = #p61.ref
        u7(p61.buffer, p61.point, v65)
        p61.point = p61.point + 1
    end
end
function u1.pack(p66, p67) --[[ Line: 138 ]]
    if typeof(p67) == "nil" then
        p66:wi8(0)
        return
    elseif typeof(p67) == "Instance" then
        p66:wi8(-1)
        p66:wRef(p67)
        return
    elseif typeof(p67) == "table" then
        local v68 = 0
        local v69 = true
        for v70 in p67 do
            v68 = v68 + 1
            if typeof(v70) ~= "number" or math.floor(v70) ~= v70 then
                v69 = false
            end
        end
        if v69 then
            p66:wi8(-2)
            p66:wu16(v68)
            for _, v71 in p67 do
                p66:pack(v71)
            end
        else
            p66:wi8(-3)
            p66:wu16(v68)
            for v72, v73 in p67 do
                p66:pack(v72)
                p66:pack(v73)
            end
        end
    elseif typeof(p67) == "EnumItem" then
        p66:wi8(-4)
        p66:wi8(#("%*"):format(p67.EnumType))
        p66:wstring((("%*"):format(p67.EnumType)))
        p66:wu8(p67.Value)
        return
    elseif typeof(p67) == "BrickColor" then
        p66:wi8(-5)
        p66:wi16(p67.Number)
        return
    elseif typeof(p67) == "Enum" then
        p66:wi8(-6)
        p66:wi8(#("%*"):format(p67))
        p66:wstring((("%*"):format(p67)))
        return
    elseif typeof(p67) == "number" then
        if math.floor(p67) == p67 then
            if p67 >= 0 and p67 <= 255 then
                p66:wi8(1)
                p66:wu8(p67)
                return
            elseif p67 >= -32768 and p67 <= 32767 then
                p66:wi8(2)
                p66:wi16(p67)
                return
            elseif p67 >= -2147483647 and p67 <= 2147483647 then
                p66:wi8(3)
                p66:wi32(p67)
            else
                p66:wi8(4)
                p66:wf64(p67)
            end
        else
            p66:wi8(4)
            p66:wf64(p67)
            return
        end
    elseif typeof(p67) == "boolean" then
        p66:wi8(5)
        p66:wu8(p67 and 1 or 0)
        return
    elseif typeof(p67) == "string" then
        local v74 = #p67
        if v74 <= 255 then
            p66:wi8(6)
            p66:wu8(v74)
        elseif v74 <= 65535 then
            p66:wi8(7)
            p66:wu16(v74)
        else
            p66:wi8(8)
            p66:wi32(v74)
        end
        p66:wstring(p67)
        return
    elseif typeof(p67) == "Vector3" then
        p66:wi8(9)
        p66:wf32(p67.X)
        p66:wf32(p67.Y)
        p66:wf32(p67.Z)
        return
    elseif typeof(p67) == "Vector2" then
        p66:wi8(10)
        p66:wf32(p67.X)
        p66:wf32(p67.Y)
        return
    elseif typeof(p67) == "CFrame" then
        p66:wi8(11)
        for _, v75 in { p67:GetComponents() } do
            p66:wf32(v75)
        end
        return
    elseif typeof(p67) == "Color3" then
        p66:wi8(12)
        p66:wu8(p67.R * 255)
        p66:wu8(p67.G * 255)
        p66:wu8(p67.B * 255)
    else
        warn((("Unsupported data type: %* value: %*"):format(typeof(p67), p67)))
    end
end
function u1.flush(p76) --[[ Line: 239 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u2
    --]]
    p76.point = u13.point
    p76.next = u13.next
    p76.size = u13.size
    p76.buffer = u2(u13.bufferSize)
    table.clear(p76.ref)
end
function u1.new() --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u2
        [3] = u1
    --]]
    local v77 = {
        ["point"] = u13.point,
        ["next"] = u13.next,
        ["size"] = u13.size,
        ["buffer"] = u2(u13.bufferSize),
        ["ref"] = {}
    }
    local v78 = u1
    return setmetatable(v77, v78)
end
function u1.remove(p79) --[[ Line: 257 ]]
    p79:flush()
    table.clear(p79)
    setmetatable(p79, nil)
end
return u1.new