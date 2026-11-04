 

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
        for v6 = 1, #v2 do
            if v2[v6]:IsA("BasePart") then
                if v2[v6].Parent == p1 then
                    v2[v6].Anchored = true
                end
                v2[v6].Transparency = 1
                v2[v6]:ClearAllChildren()
            end
        end
    end
}