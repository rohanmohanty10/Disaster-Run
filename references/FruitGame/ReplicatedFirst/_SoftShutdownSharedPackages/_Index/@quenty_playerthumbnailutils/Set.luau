 

local v19 = {
    ["union"] = function(p1, p2) --[[ Name: union, Line 15 ]]
        local v3 = {}
        for v4, _ in pairs(p1) do
            v3[v4] = true
        end
        for v5, _ in pairs(p2) do
            v3[v5] = true
        end
        return v3
    end,
    ["unionUpdate"] = function(p6, p7) --[[ Name: unionUpdate, Line 32 ]]
        for v8, _ in pairs(p7) do
            p6[v8] = true
        end
    end,
    ["intersection"] = function(p9, p10) --[[ Name: intersection, Line 44 ]]
        local v11 = {}
        for v12, _ in pairs(p9) do
            if p10[v12] ~= nil then
                v11[v12] = true
            end
        end
        return v11
    end,
    ["copy"] = function(p13) --[[ Name: copy, Line 59 ]]
        local v14 = {}
        for v15, _ in pairs(p13) do
            v14[v15] = true
        end
        return v14
    end,
    ["fromTableValue"] = function(p16) --[[ Name: fromTableValue, Line 72 ]]
        local v17 = {}
        for _, v18 in pairs(p16) do
            v17[v18] = true
        end
        return v17
    end
}
v19.fromList = v19.fromTableValue
function v19.toList(p20) --[[ Line: 96 ]]
    local v21 = {}
    for v22, _ in pairs(p20) do
        table.insert(v21, v22)
    end
    return v21
end
function v19.differenceUpdate(p23, p24) --[[ Line: 112 ]]
    for v25, _ in pairs(p24) do
        p23[v25] = nil
    end
end
function v19.difference(p26, p27) --[[ Line: 124 ]]
    local v28 = {}
    for v29, _ in pairs(p26) do
        v28[v29] = true
    end
    for v30, _ in pairs(p27) do
        v28[v30] = nil
    end
    return v28
end
return v19