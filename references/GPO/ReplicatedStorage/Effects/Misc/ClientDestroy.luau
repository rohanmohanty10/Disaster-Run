 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        if p1 == nil then
            return
        elseif p3 ~= nil then
            local v4 = p2 - (workspace:GetServerTimeNow() - p3)
            _G.destroy(p1, v4)
        end
    end
}