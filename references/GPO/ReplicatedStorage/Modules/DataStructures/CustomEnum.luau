 

local u1 = {
    ["Class"] = {},
    ["Item"] = {}
}
local u2 = {}
local u3 = {}
function u2.__index(p4, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = u2
    local v7 = rawget(v6, p5)
    if not v7 then
        error(tostring(p5) .. " is not a valid member of \"" .. p4._MainParent.Name .. "." .. p4.Name .. "\"")
    end
    return v7
end
function u3.__index(p8, p9) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v10 = p8._Items
    local v11 = rawget(v10, p9)
    if not v11 then
        local v12 = u3
        v11 = rawget(v12, p9)
    end
    if not v11 then
        error(tostring(p9) .. " is not a valid member of \"" .. p8.Name .. "\"")
    end
    return v11
end
function u3.__tostring(p13) --[[ Line: 25 ]]
    return (rawget(p13, "_MainParent") and (p13._MainParent.Name .. "." or "") or "") .. p13.Name
end
function u2.IsA(p14, p15) --[[ Line: 29 ]]
    if typeof(p15) == "table" and p15.Type == "EnumClass" then
        p15 = p15.Name
    end
    local v16 = typeof(p15) == "string"
    local v17 = "invalid argument #2 to \'IsA\' (string expected, got " .. typeof(p15) .. ")"
    assert(v16, v17)
    for v18, v19 in next, p14._Parents do
        if v18 == p15 or v19:IsA(p15) then
            return true
        end
    end
    return p14._Parents[p15] ~= nil
end
function u2.GetFullName(p20) --[[ Line: 42 ]]
    local v21 = p20.Name
    local v22 = rawget(p20, "_MainParent")
    while v22 do
        v21 = v22.Name .. "." .. v21
        v22 = rawget(v22, "_MainParent")
    end
    return v21
end
u2.__tostring = u2.GetFullName
function u3.GetEnumItems(p23) --[[ Line: 54 ]]
    return p23._Items
end
function u3.IsA(p24, p25) --[[ Line: 57 ]]
    if typeof(p25) == "table" and p25.Type == "EnumClass" then
        p25 = p25.Name
    end
    local v26 = typeof(p25) == "string"
    local v27 = "invalid argument #2 to \'IsA\' (string expected, got " .. typeof(p25) .. ")"
    assert(v26, v27)
    for v28, v29 in next, p24._Parents do
        if v28 == p25 or v29:IsA(p25) then
            return true
        end
    end
    return p24._Parents[p25] ~= nil
end
function u3.AddItem(p30, p31) --[[ Line: 70 ]]
    local v32 = type(p31) == "table"
    local v33 = "invalid argument #1 to \'AddItem\' (EnumItem or EnumClass expected, got " .. typeof(p31) .. ")"
    assert(v32, v33)
    local v34 = p31.Type == "EnumItem" and true or p31.Type == "EnumClass"
    local v35 = "invalid argument #1 to \'AddItem\' (EnumItem or EnumClass expected, got " .. typeof(p31) .. ")"
    assert(v34, v35)
    p30._Items[p31.Name] = p31
    p31._Parents[p30.Name] = p30
    if rawget(p31, "_MainParent") == nil then
        p31._MainParent = p30
    end
end
function u3.GetFullName(p36) --[[ Line: 80 ]]
    local v37 = p36.Name
    local v38 = rawget(p36, "_MainParent")
    while v38 do
        v37 = v38.Name .. "." .. v37
        v38 = rawget(v38, "_MainParent")
    end
    return v37
end
u3.__tostring = u3.GetFullName
function u1.Item.new(p39, p40) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v41
    if type(p39) == "table" then
        v41 = p39.Type == "EnumClass"
    else
        v41 = false
    end
    local v42 = "invalid argument #1 to \'EnumItem.new\' (EnumClass expected, got " .. typeof(p39) .. ")"
    assert(v41, v42)
    local v43 = type(p40) == "string"
    local v44 = "invalid argument #2 to EnumItem.new (string expected, got " .. typeof(p40) .. ")"
    assert(v43, v44)
    local v45 = u2
    local v46 = setmetatable({
        ["Name"] = p40,
        ["Type"] = "EnumItem",
        ["_Parents"] = {},
        ["_MainParent"] = p39
    }, v45)
    p39:AddItem(v46)
    return v46
end
function u1.Class.new(p47, p48) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v49 = u3
    local v50 = setmetatable({
        ["Name"] = p47,
        ["Type"] = "EnumClass",
        ["_Items"] = {},
        ["_Parents"] = {},
        ["_MainParent"] = nil
    }, v49)
    if p48 ~= nil then
        local v51 = type(p48) == "table"
        local v52 = "invalid argument #2 to EnumClass.new (table expected, got " .. type(p48) .. ")"
        assert(v51, v52)
        for _, v53 in next, p48 do
            if typeof(v53) == "string" then
                u1.Item.new(v50, v53)
            elseif typeof(v53) == "table" and (v53.Type == "EnumItem" or v53.Type == "EnumClass") then
                v50:AddItem(v53)
            end
        end
    end
    return v50
end
return u1