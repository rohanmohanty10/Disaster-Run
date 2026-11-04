 

local u5 = {
    ["__index"] = function(p1, p2) --[[ Name: __index, Line 76 ]]
        for v3, v4 in p1 do
            if v3 ~= "__isparenttable" and v4[p2] then
                return v4[p2]
            end
        end
        return nil
    end
}
class = setmetatable({
    ["__baseclass"] = {}
}, {
    ["__index"] = function(p6, p7) --[[ Name: __index, Line 29 ]]
        if rawget(p6, "__baseclass") then
            return p6.__baseclass[p7]
        else
            return nil
        end
    end,
    ["__call"] = function(p8, ...) --[[ Name: __call, Line 36 ]]
        return p8:new(...)
    end,
    ["__add"] = function(p9, p10) --[[ Name: __add, Line 40 ]]
        return p9:addparent(p10)
    end,
    ["__eq"] = function(p11, p12) --[[ Name: __eq, Line 44 ]]
        if not p12.__baseclass or p12.__baseclass ~= p11.__baseclass then
            return false
        end
        for v13, _ in p11 do
            if not p12[v13] then
                return false
            end
        end
        for v14, _ in p12 do
            if not p11[v14] then
                return false
            end
        end
        return true
    end,
    ["__lt"] = function(p15, p16) --[[ Name: __lt, Line 59 ]]
        if not p16.__baseclass then
            return false
        end
        local v17 = p16.__baseclass
        if rawget(v17, "__isparenttable") then
            for _, v18 in p16.__baseclass do
                if p15 == v18 or getmetatable(p15).__lt(p15, v18) then
                    return true
                end
            end
        elseif p15 == p16.__baseclass or getmetatable(p15).__t(p15, p16.__baseclass) then
            return true
        end
        return false
    end,
    ["__le"] = function(p19, p20) --[[ Name: __le, Line 71 ]]
        return p19 < p20 and true or p19 == p20
    end
})
function class.new(p21, ...) --[[ Line: 87 ]]
    local v22 = {
        ["__baseclass"] = p21
    }
    local v23 = getmetatable(p21)
    setmetatable(v22, v23)
    if v22.init then
        v22:init(...)
    end
    return v22
end
function class.convert(p24, p25) --[[ Line: 97 ]]
    p25.__baseclass = p24
    local v26 = getmetatable(p24)
    setmetatable(p25, v26)
    return p25
end
function class.addparent(p27, ...) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v28 = p27.__baseclass
    if rawget(v28, "__isparenttable") then
        for _, v29 in ipairs({ ... }) do
            local v30 = p27.__baseclass
            table.insert(v30, v29)
        end
        return p27
    end
    local v31 = {
        ["__isparenttable"] = true,
        p27.__baseclass,
        ...
    }
    local v32 = u5
    p27.__baseclass = setmetatable(v31, v32)
    return p27
end
function class.setmetamethod(p33, p34, p35) --[[ Line: 115 ]]
    local v36 = {}
    for v37, v38 in getmetatable(p33) do
        v36[v37] = v38
    end
    v36[p34] = p35
    setmetatable(p33, v36)
end
return class