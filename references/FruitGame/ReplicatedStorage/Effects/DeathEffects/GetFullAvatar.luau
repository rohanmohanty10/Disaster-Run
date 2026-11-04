 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = p1:GetDescendants()
        local v3 = _G.getAccessorys(p1)
        if v3 then
            for v4 = 1, #v3 do
                local v5 = v3[v4]
                table.insert(v2, v5)
            end
        end
        return v2
    end
}