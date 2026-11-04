 

return function(u1) --[[ Line: 1 ]]
    return function(p2) --[[ Line: 2 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = false
        local v4 = nil
        for v5, v6 in pairs(p2) do
            if v3 then
                break
            end
            if type(v5) == "table" then
                for _, v7 in ipairs(v5) do
                    if v7 == u1 then
                        v4 = v6
                        v3 = true
                        break
                    end
                end
            elseif v5 == u1 then
                v4 = v6
                v3 = true
            end
        end
        if not v3 then
            v4 = p2.default
        end
        if v4 then
            if type(v4) == "function" then
                return v4()
            else
                return v4
            end
        else
            return
        end
    end
end