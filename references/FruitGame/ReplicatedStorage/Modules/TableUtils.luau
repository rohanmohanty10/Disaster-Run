 

return {
    ["ShallowCopy"] = function(_, p1) --[[ Name: ShallowCopy, Line 3 ]]
        local v2 = {}
        for v3, v4 in pairs(p1) do
            v2[v3] = v4
        end
        return v2
    end,
    ["DeepCopy"] = function(p5, p6) --[[ Name: DeepCopy, Line 11 ]]
        local v7 = {}
        for v8, v10 in pairs(p6) do
            if type(v10) == "table" then
                local v10 = p5:DeepCopy(v10)
            end
            v7[v8] = v10
        end
        return v7
    end
}