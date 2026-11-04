 

local u1 = require(script.Parent.loader).load(script)("RxAttributeUtils")
local u2 = {
    ["ClassName"] = "AttributeValue"
}
u2.__index = u2
function u2.new(p3, p4, p5) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = typeof(p3) == "Instance"
    assert(v6, "Bad object")
    local v7 = type(p4) == "string"
    assert(v7, "Bad attributeName")
    local v8 = {
        ["_object"] = p3,
        ["_attributeName"] = p4,
        ["_defaultValue"] = p5
    }
    if p5 ~= nil and v8._object:GetAttribute(v8._attributeName) == nil then
        v8._object:SetAttribute(rawget(v8, "_attributeName"), p5)
    end
    local v9 = u2
    return setmetatable(v8, v9)
end
function u2.Observe(p10) --[[ Line: 58 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.observeAttribute(p10._object, p10._attributeName, (rawget(p10, "_defaultValue")))
end
function u2.__index(p11, p12) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p12 == "Value" then
        local v13 = p11._object:GetAttribute((rawget(p11, "_attributeName")))
        local v14 = rawget(p11, "_defaultValue")
        if v13 == nil then
            return v14
        else
            return v13
        end
    else
        if p12 == "Changed" then
            return p11._object:GetAttributeChangedSignal(p11._attributeName)
        end
        if u2[p12] then
            return u2[p12]
        end
        error(("%q is not a member of AttributeValue"):format((tostring(p12))))
        return
    end
end
function u2.__newindex(p15, p16, p17) --[[ Line: 93 ]]
    if p16 == "Value" then
        p15._object:SetAttribute(rawget(p15, "_attributeName"), p17)
    else
        error(("%q is not a member of AttributeValue"):format((tostring(p16))))
    end
end
return u2