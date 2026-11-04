 

local u1 = game:GetService("HttpService")
local u2 = require(script.Parent.Parent.Promises.Promise2)
local u47 = {
    ["PromiseGetAsync"] = function(u3, u4, u5) --[[ Name: PromiseGetAsync, Line 17 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        return u2.try(function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
                [3] = u4
                [4] = u5
            --]]
            return u1:GetAsync(u3, u4, u5)
        end)
    end,
    ["PromisePostAsync"] = function(u6, u7, u8, u9, u10) --[[ Name: PromisePostAsync, Line 32 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        return u2.try(function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u1
                [3] = u6
                [4] = u8
                [5] = u9
                [6] = u10
            --]]
            local v11 = u7
            local v12
            if type(v11) == "string" then
                v12 = u7
            else
                v12 = u1:JSONEncode(u7)
            end
            return u1:PostAsync(u6, v12, u8, u9, u10)
        end)
    end,
    ["PromiseRequestAsync"] = function(u13) --[[ Name: PromiseRequestAsync, Line 50 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        return u2.try(function() --[[ Line: 56 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u13
            --]]
            return u1:RequestAsync(u13)
        end)
    end,
    ["PromiseJSONDecode"] = function(u14) --[[ Name: PromiseJSONDecode, Line 66 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        return u2.try(function() --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u14
            --]]
            return u1:JSONDecode(u14)
        end)
    end,
    ["PromiseJSONEncode"] = function(u15) --[[ Name: PromiseJSONEncode, Line 77 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        return u2.try(function() --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u15
            --]]
            return u1:JSONEncode(u15)
        end)
    end,
    ["PromiseGetJSON"] = function(p16, p17, p18) --[[ Name: PromiseGetJSON, Line 90 ]]
        --[[
        Upvalues:
            [1] = u47
        --]]
        return u47.PromiseGetAsync(p16, p17, p18):andThen(function(p19) --[[ Line: 92 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            return u47.PromiseJSONDecode(p19)
        end)
    end,
    ["PromisePostJSON"] = function(p20, p21, p22) --[[ Name: PromisePostJSON, Line 104 ]]
        --[[
        Upvalues:
            [1] = u47
        --]]
        local v23 = p22 or {}
        v23["Content-Type"] = v23["Content-Type"] or "application/json"
        return u47.PromisePostAsync(p20, p21, Enum.HttpContentType.ApplicationJson, false, v23):andThen(function(p24) --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            return u47.PromiseJSONDecode(p24)
        end)
    end,
    ["PromiseRequestWithRetry"] = function(u25, p26, p27) --[[ Name: PromiseRequestWithRetry, Line 126 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u47
        --]]
        return u2.retry(function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u25
            --]]
            return u47.PromiseRequestAsync(u25)
        end, p26 or 3, p27 or 1)
    end,
    ["PromiseBatchRequests"] = function(p28, u29) --[[ Name: PromiseBatchRequests, Line 151 ]]
        --[[
        Upvalues:
            [1] = u47
            [2] = u2
        --]]
        local u30 = {}
        for v31, u32 in ipairs(p28) do
            u30[v31] = function() --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u32
                --]]
                return u47.PromiseRequestAsync(u32)
            end
        end
        if u29 then
            return u2.new(function(u33, u34) --[[ Line: 167 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u30
                --]]
                local u35 = {}
                local u36 = 0
                local u37 = 0
                local u38 = 0
                local function u43() --[[ Line: 173 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u29
                        [3] = u38
                        [4] = u30
                        [5] = u35
                        [6] = u36
                        [7] = u33
                        [8] = u43
                        [9] = u34
                    --]]
                    while u37 < u29 and u38 < #u30 do
                        u38 = u38 + 1
                        local u39 = u38
                        local v40 = u30[u39]
                        u37 = u37 + 1
                        v40():andThen(function(p41) --[[ Line: 181 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                                [2] = u39
                                [3] = u36
                                [4] = u37
                                [5] = u30
                                [6] = u33
                                [7] = u43
                            --]]
                            u35[u39] = p41
                            u36 = u36 + 1
                            u37 = u37 - 1
                            if u36 == #u30 then
                                u33(u35)
                            else
                                u43()
                            end
                        end, function(p42) --[[ Line: 191 ]]
                            --[[
                            Upvalues:
                                [1] = u34
                            --]]
                            u34(p42)
                        end)
                    end
                end
                u43()
            end)
        end
        local v44 = {}
        for v45, v46 in ipairs(u30) do
            v44[v45] = v46()
        end
        return u2.all(v44)
    end
}
return u47