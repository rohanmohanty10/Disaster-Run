 

return {
    ["scan"] = function(_, p1, p2, p3) --[[ Name: scan, Line 10 ]]
        local v4 = p1:FindFirstChild("PrismaticLiftLocations")
        if v4 then
            local v5 = v4:GetChildren()
            local v6 = {}
            for v7 = 1, #v5 do
                local v8 = { v5[v7], v5[v7].explodeBind }
                table.insert(v6, v8)
            end
            local v9 = false
            for v10 = 1, #v6 do
                local v11 = v6[v10]
                local v12, v13 = unpack(v11)
                if v12 and (v13 and (v12.Value - p2).Magnitude <= p3 + 30) then
                    v9 = true
                end
            end
            return v9
        end
    end
}