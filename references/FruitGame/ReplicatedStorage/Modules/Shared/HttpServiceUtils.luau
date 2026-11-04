 

local u1 = require(script.Parent.Promises.Promise)
local u2 = game:GetService("HttpService")
return {
    ["PromiseGetAsync"] = function(u3, u4, u5) --[[ Name: PromiseGetAsync, Line 7 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        return u1.spawn(function(p6, p7) --[[ Line: 8 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u4
                [4] = u5
            --]]
            local u8 = nil
            local v9, v10 = pcall(function() --[[ Line: 11 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u2
                    [3] = u3
                    [4] = u4
                    [5] = u5
                --]]
                u8 = u2:GetAsync(u3, u4, u5)
            end)
            if not v9 then
                p7(v10)
            end
            p6(u8)
        end)
    end,
    ["PromiseJSONDecode"] = function(u11) --[[ Name: PromiseJSONDecode, Line 23 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        return u1.spawn(function(p12, p13) --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u11
            --]]
            local u14 = nil
            local v15, v16 = pcall(function() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u2
                    [3] = u11
                --]]
                u14 = u2:JSONDecode(u11)
            end)
            if not v15 then
                p13(v16)
            end
            p12(u14)
        end)
    end,
    ["PromisePostAsync"] = function(u17, u18, _, _, _) --[[ Name: PromisePostAsync, Line 39 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        return u1.spawn(function(p19, p20) --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u17
                [3] = u18
            --]]
            local u21 = nil
            local v22, v23 = pcall(function() --[[ Line: 43 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u2
                    [3] = u17
                    [4] = u18
                --]]
                u21 = u2:PostAsync(u17, u2:JSONEncode(u18))
            end)
            if not v22 then
                p20(v23)
            end
            p19(u21)
        end)
    end,
    ["PromiseRequestAsync"] = function(u24) --[[ Name: PromiseRequestAsync, Line 63 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        return u1.spawn(function(p25, p26) --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u24
            --]]
            local u27 = nil
            local v28, v29 = pcall(function() --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u2
                    [3] = u24
                --]]
                u27 = u2:RequestAsync(u24)
            end)
            if not v28 then
                p26(v29)
            end
            p25(u27)
        end)
    end
}