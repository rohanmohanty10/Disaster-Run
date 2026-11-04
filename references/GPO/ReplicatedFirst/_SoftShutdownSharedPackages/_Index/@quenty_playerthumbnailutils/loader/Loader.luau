 

local u1 = {
    ["ClassName"] = "Loader"
}
u1.__index = u1
function u1.new(p2) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    return setmetatable({
        ["_script"] = p2
    }, v3)
end
local function u5(p4) --[[ Line: 18 ]]
    return p4.Value or p4.Changed:Wait()
end
function u1.__call(p6, p7) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if type(p7) == "string" then
        local v8 = p6._script.Parent[p7]
        if v8:IsA("ObjectValue") then
            return require(u5(v8))
        else
            return require(v8)
        end
    else
        return require(p7)
    end
end
function u1.__index(p9, p10) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if type(p10) == "string" then
        local v11 = p9._script.Parent[p10]
        if v11:IsA("ObjectValue") then
            return require(u5(v11))
        else
            return require(v11)
        end
    else
        return require(p10)
    end
end
return u1