 

local u74 = {
    ["append"] = function(p1, p2) --[[ Name: append, Line 15 ]]
        for _, v3 in pairs(p2) do
            p1[#p1 + 1] = v3
        end
        return p1
    end,
    ["merge"] = function(p4, p5) --[[ Name: merge, Line 30 ]]
        local v6 = {}
        for v7, v8 in pairs(p4) do
            v6[v7] = v8
        end
        for v9, v10 in pairs(p5) do
            v6[v9] = v10
        end
        return v6
    end,
    ["reverse"] = function(p11) --[[ Name: reverse, Line 47 ]]
        local v12 = {}
        for v13 = #p11, 1, -1 do
            local v14 = p11[v13]
            table.insert(v12, v14)
        end
        return v12
    end,
    ["values"] = function(p15) --[[ Name: values, Line 61 ]]
        local v16 = {}
        for _, v17 in pairs(p15) do
            table.insert(v16, v17)
        end
        return v16
    end,
    ["keys"] = function(p18) --[[ Name: keys, Line 75 ]]
        local v19 = {}
        for v20, _ in pairs(p18) do
            table.insert(v19, v20)
        end
        return v19
    end,
    ["mergeLists"] = function(p21, p22) --[[ Name: mergeLists, Line 90 ]]
        local v23 = {}
        for _, v24 in pairs(p21) do
            table.insert(v23, v24)
        end
        for _, v25 in pairs(p22) do
            table.insert(v23, v25)
        end
        return v23
    end,
    ["swapKeyValue"] = function(p26) --[[ Name: swapKeyValue, Line 107 ]]
        local v27 = {}
        for v28, v29 in pairs(p26) do
            v27[v29] = v28
        end
        return v27
    end,
    ["toList"] = function(p30) --[[ Name: toList, Line 121 ]]
        local v31 = {}
        for _, v32 in pairs(p30) do
            table.insert(v31, v32)
        end
        return v31
    end,
    ["count"] = function(p33) --[[ Name: count, Line 136 ]]
        local v34 = 0
        for _, _ in pairs(p33) do
            v34 = v34 + 1
        end
        return v34
    end,
    ["copy"] = table.clone,
    ["deepCopy"] = function(p35, p36) --[[ Name: deepCopy, Line 161 ]]
        --[[
        Upvalues:
            [1] = u74
        --]]
        local v37 = p36 or {}
        if v37[p35] then
            return v37[p35]
        end
        if type(p35) ~= "table" then
            return p35
        end
        local v38 = {}
        v37[p35] = v38
        for v39, v40 in pairs(p35) do
            v38[u74.deepCopy(v39, v37)] = u74.deepCopy(v40, v37)
        end
        local v41 = u74.deepCopy
        local v42 = getmetatable(p35)
        return setmetatable(v38, v41(v42, v37))
    end,
    ["deepOverwrite"] = function(p43, p44) --[[ Name: deepOverwrite, Line 185 ]]
        --[[
        Upvalues:
            [1] = u74
        --]]
        for v45, v46 in pairs(p44) do
            local v47 = p43[v45]
            if type(v47) == "table" and type(v46) == "table" then
                p43[v45] = u74.deepOverwrite(p43[v45], v46)
            else
                p43[v45] = v46
            end
        end
        return p43
    end,
    ["getIndex"] = function(p48, p49) --[[ Name: getIndex, Line 203 ]]
        local v50 = p49 ~= nil
        assert(v50, "Needle cannot be nil")
        for v51, v52 in pairs(p48) do
            if p49 == v52 then
                return v51
            end
        end
        return nil
    end,
    ["stringify"] = function(p53, p54, p55) --[[ Name: stringify, Line 222 ]]
        --[[
        Upvalues:
            [1] = u74
        --]]
        local v56 = p55 or tostring(p53)
        local v57 = p54 or 0
        for v58, v59 in pairs(p53) do
            local v60 = "\n" .. string.rep("  ", v57) .. tostring(v58) .. ": "
            if type(v59) == "table" then
                local v61 = v56 .. v60
                v56 = u74.stringify(v59, v57 + 1, v61)
            else
                v56 = v56 .. v60 .. tostring(v59)
            end
        end
        return v56
    end,
    ["contains"] = function(p62, p63) --[[ Name: contains, Line 244 ]]
        for _, v64 in pairs(p62) do
            if v64 == p63 then
                return true
            end
        end
        return false
    end,
    ["overwrite"] = function(p65, p66) --[[ Name: overwrite, Line 261 ]]
        for v67, v68 in pairs(p66) do
            p65[v67] = v68
        end
        return p65
    end,
    ["take"] = function(p69, p70) --[[ Name: take, Line 278 ]]
        local v71 = #p69
        local v72 = {}
        for v73 = 1, math.min(v71, p70) do
            v72[v73] = p69[v73]
        end
        return v72
    end
}
local function v76(_, p75) --[[ Line: 286 ]]
    error(("Bad index %q"):format((tostring(p75))), 2)
end
local u77 = {
    ["__index"] = v76,
    ["__newindex"] = v76
}
function u74.readonly(p78) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u77
    --]]
    local v79 = u77
    return setmetatable(p78, v79)
end
function u74.deepReadonly(p80) --[[ Line: 312 ]]
    --[[
    Upvalues:
        [1] = u74
    --]]
    for _, v81 in pairs(p80) do
        if type(v81) == "table" then
            u74.deepReadonly(v81)
        end
    end
    return u74.readonly(p80)
end
return u74