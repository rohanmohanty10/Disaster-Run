 

local u19 = {
    ["DeepCopy"] = function(p1, p2, p3) --[[ Name: DeepCopy, Line 3 ]]
        --[[
        Upvalues:
            [1] = u19
        --]]
        local v4 = {}
        local v5 = p3 or {}
        for v6, v7 in p1 do
            if not (p2 and p2[v6]) then
                if typeof(v7) == "table" and not v5[v7] then
                    v5[v7] = true
                    v4[v6] = u19.DeepCopy(v7, p2, v5)
                else
                    v4[v6] = v7
                end
            end
        end
        return v4
    end,
    ["ShallowCopy"] = function(p8) --[[ Name: ShallowCopy, Line 21 ]]
        local v9 = {}
        for v10, v11 in p8 do
            v9[v10] = v11
        end
        return v9
    end,
    ["Merge"] = function(p12, p13) --[[ Name: Merge, Line 29 ]]
        local v14 = {}
        for v15, v16 in p12 do
            v14[v15] = v16
        end
        for v17, v18 in p13 do
            v14[v17] = v18
        end
        return v14
    end
}
return u19