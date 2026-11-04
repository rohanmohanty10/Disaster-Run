 

local v1 = {}
local function v3(_, p2) --[[ Line: 8 ]]
    error(("Bad index %q"):format((tostring(p2))), 2)
end
local u4 = {
    ["__index"] = v3,
    ["__newindex"] = v3
}
function v1.readonly(p5) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v6 = u4
    return setmetatable(p5, v6)
end
function v1.copyTable(p7) --[[ Line: 21 ]]
    local v8 = {}
    for v9, v10 in pairs(p7) do
        v8[v9] = v10
    end
    return v8
end
function v1.count(p11) --[[ Line: 29 ]]
    local v12 = 0
    for _, _ in pairs(p11) do
        v12 = v12 + 1
    end
    return v12
end
function v1.getOrCreateValue(p13, p14, p15, p16) --[[ Line: 37 ]]
    local v17 = typeof(p13) == "Instance"
    assert(v17, "Bad argument \'parent\'")
    local v18 = type(p14) == "string"
    assert(v18, "Bad argument \'instanceType\'")
    local v19 = type(p15) == "string"
    assert(v19, "Bad argument \'name\'")
    local v20 = p13:FindFirstChild(p15)
    if v20 then
        if not v20:IsA(p14) then
            warn(("[Utils.getOrCreateValue] - Value of type %q of name %q is of type %q in %s instead"):format(p14, p15, v20.ClassName, v20:GetFullName()))
        end
        return v20
    end
    local v21 = Instance.new(p14)
    v21.Name = p15
    v21.Value = p16
    v21.Parent = p13
    return v21
end
function v1.getValue(p22, p23, p24, p25) --[[ Line: 60 ]]
    local v26 = typeof(p22) == "Instance"
    assert(v26, "Bad argument \'parent\'")
    local v27 = type(p23) == "string"
    assert(v27, "Bad argument \'instanceType\'")
    local v28 = type(p24) == "string"
    assert(v28, "Bad argument \'name\'")
    local v29 = p22:FindFirstChild(p24)
    if not v29 then
        return p25
    end
    if v29:IsA(p23) then
        return v29.Value
    end
    warn(("[Utils.getValue] - Value of type %q of name %q is of type %q in %s instead"):format(p23, p24, v29.ClassName, v29:GetFullName()))
    return nil
end
function v1.setValue(p30, p31, p32, p33) --[[ Line: 79 ]]
    local v34 = typeof(p30) == "Instance"
    assert(v34, "Bad argument \'parent\'")
    local v35 = type(p31) == "string"
    assert(v35, "Bad argument \'instanceType\'")
    local v36 = type(p32) == "string"
    assert(v36, "Bad argument \'name\'")
    local v37 = p30:FindFirstChild(p32)
    if v37 then
        if not v37:IsA(p31) then
            warn(("[Utils.setValue] - Value of type %q of name %q is of type %q in %s instead"):format(p31, p32, v37.ClassName, v37:GetFullName()))
        end
        v37.Value = p33
    else
        local v38 = Instance.new(p31)
        v38.Name = p32
        v38.Value = p33
        v38.Parent = p30
    end
end
function v1.getOrCreateFolder(p39, p40) --[[ Line: 101 ]]
    local v41 = p39:FindFirstChild(p40)
    if v41 then
        return v41
    end
    local v42 = Instance.new("Folder")
    v42.Name = p40
    v42.Parent = p39
    return v42
end
return v1