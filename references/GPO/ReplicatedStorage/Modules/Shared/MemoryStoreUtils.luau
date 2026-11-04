 

local u1 = require(script.Parent.Promises.Promise)
return {
    ["PromiseSortedMapSetAsync"] = function(u2, u3, u4, u5) --[[ Name: PromiseSortedMapSetAsync, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.spawn(function(p6, p7) --[[ Line: 6 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
                [4] = u5
            --]]
            local v8, v9 = pcall(function() --[[ Line: 8 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u3
                    [3] = u4
                    [4] = u5
                --]]
                u2:SetAsync(u3, u4, u5 or 86400)
            end)
            if not v8 then
                p7(v9)
            end
            p6(true)
        end)
    end,
    ["PromiseSortedMapGetAsync"] = function(u10, u11) --[[ Name: PromiseSortedMapGetAsync, Line 20 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.spawn(function(p12, p13) --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
            --]]
            local u14 = nil
            local v15, v16 = pcall(function() --[[ Line: 23 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u10
                    [3] = u11
                --]]
                u14 = u10:GetAsync(u11)
            end)
            if not v15 then
                p13(v16)
            end
            p12(u14)
        end)
    end,
    ["PromiseSortedMapRemoveAsync"] = function(u17, u18) --[[ Name: PromiseSortedMapRemoveAsync, Line 35 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.spawn(function(p19, p20) --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
            --]]
            local v21, v22 = pcall(function() --[[ Line: 38 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u18
                --]]
                u17:RemoveAsync(u18)
            end)
            if not v21 then
                p20(v22)
            end
            p19(true)
        end)
    end,
    ["PromiseSortedMapGetRangeAsync"] = function(u23, u24) --[[ Name: PromiseSortedMapGetRangeAsync, Line 50 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.spawn(function(p25, p26) --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u24
            --]]
            local u27 = nil
            local v28, v29 = pcall(function() --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u23
                    [3] = u24
                --]]
                u27 = u23:GetRangeAsync(Enum.SortDirection.Ascending, u24 or 200)
            end)
            if not v28 then
                p26(v29)
            end
            p25(u27)
        end)
    end,
    ["PromiseSortedMapUpdatedAsync"] = function(u30, u31, u32, u33) --[[ Name: PromiseSortedMapUpdatedAsync, Line 66 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.spawn(function(p34, p35) --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u30
                [2] = u31
                [3] = u32
                [4] = u33
            --]]
            local u36 = nil
            local v37, v38 = pcall(function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u30
                    [3] = u31
                    [4] = u32
                    [5] = u33
                --]]
                u36 = u30:UpdateAsync(u31, function(_) --[[ Line: 71 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                    --]]
                    return u32
                end, u33 or 86400)
            end)
            if not v37 then
                p35(v38)
            end
            p34(u36)
        end)
    end
}