 

local v1 = script.Parent.Parent.Promises
local u2 = require(v1:WaitForChild("Promise"))
local u3 = game:GetService("DataStoreService")
local u106 = {
    ["promiseDataStore"] = function(u4, u5) --[[ Name: promiseDataStore, Line 10 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local v6 = type(u4) == "string"
        assert(v6, "Bad name")
        if u5 ~= nil then
            local v7 = type(u5) == "string"
            assert(v7, "Bad scope")
        end
        return u2.new(function(p8, p9) --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u5
            --]]
            local u10 = nil
            local v11, v12 = pcall(function() --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u3
                    [3] = u4
                    [4] = u5
                --]]
                u10 = u3:GetDataStore(u4, u5)
            end)
            if v11 then
                return p8(u10)
            else
                return p9(v12)
            end
        end)
    end,
    ["promiseOrderedDataStore"] = function(u13, u14) --[[ Name: promiseOrderedDataStore, Line 26 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local v15 = type(u13) == "string"
        assert(v15, "Bad name")
        return u2.new(function(p16, p17) --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u13
                [3] = u14
            --]]
            local u18 = nil
            local v19, v20 = pcall(function() --[[ Line: 31 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u3
                    [3] = u13
                    [4] = u14
                --]]
                u18 = u3:GetOrderedDataStore(u13, u14)
            end)
            if v19 then
                return p16(u18)
            else
                return p17(v20)
            end
        end)
    end,
    ["getAsync"] = function(u21, u22) --[[ Name: getAsync, Line 41 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v23 = typeof(u21) == "Instance"
        assert(v23, "Bad robloxDataStore")
        local v24 = type(u22) == "string"
        assert(v24, "Bad key")
        return u2.spawn(function(p25, p26) --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u22
            --]]
            local u27 = nil
            local u28 = nil
            local v31, v32 = pcall(function() --[[ Line: 48 ]]
                --[[
                Upvalues:
                    [1] = u27
                    [2] = u28
                    [3] = u21
                    [4] = u22
                --]]
                local v29, v30 = u21:GetAsync(u22)
                u27 = v29
                u28 = v30
            end)
            if v31 then
                return p25(u27, u28)
            else
                return p26(v32)
            end
        end)
    end,
    ["updateAsync"] = function(u33, u34, u35) --[[ Name: updateAsync, Line 58 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v36 = typeof(u33) == "Instance"
        assert(v36, "Bad robloxDataStore")
        local v37 = type(u34) == "string"
        assert(v37, "Bad key")
        local v38 = type(u35) == "function"
        assert(v38, "Bad updateFunc")
        return u2.spawn(function(p39, p40) --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u34
                [3] = u35
            --]]
            local u41 = nil
            local v42, v43 = pcall(function() --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u33
                    [3] = u34
                    [4] = u35
                --]]
                u41 = { u33:UpdateAsync(u34, u35) }
            end)
            if not v42 then
                return p40(v43)
            end
            if not u41 then
                return p40("No result loaded")
            end
            local v44 = u41
            return p39(unpack(v44))
        end)
    end,
    ["setAsync"] = function(u45, u46, u47, u48) --[[ Name: setAsync, Line 78 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v49 = typeof(u45) == "Instance"
        assert(v49, "Bad robloxDataStore")
        local v50 = type(u46) == "string"
        assert(v50, "Bad key")
        local v51 = type(u48) == "table" and true or u48 == nil
        assert(v51, "Bad userIds")
        return u2.spawn(function(p52, p53) --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u45
                [2] = u46
                [3] = u47
                [4] = u48
            --]]
            local v54, v55 = pcall(function() --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u46
                    [3] = u47
                    [4] = u48
                --]]
                u45:SetAsync(u46, u47, u48)
            end)
            if v54 then
                return p52(true)
            else
                return p53(v55)
            end
        end)
    end,
    ["promiseIncrementAsync"] = function(u56, u57, u58) --[[ Name: promiseIncrementAsync, Line 94 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v59 = typeof(u56) == "Instance"
        assert(v59, "Bad robloxDataStore")
        local v60 = type(u57) == "string"
        assert(v60, "Bad key")
        local v61 = type(u58) == "number" and true or u58 == nil
        assert(v61, "Bad delta")
        return u2.spawn(function(p62, p63) --[[ Line: 99 ]]
            --[[
            Upvalues:
                [1] = u56
                [2] = u57
                [3] = u58
            --]]
            local v64, v65 = pcall(function() --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u57
                    [3] = u58
                --]]
                u56:IncrementAsync(u57, u58)
            end)
            if v64 then
                return p62(true)
            else
                return p63(v65)
            end
        end)
    end,
    ["removeAsync"] = function(u66, u67) --[[ Name: removeAsync, Line 110 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v68 = typeof(u66) == "Instance"
        assert(v68, "Bad robloxDataStore")
        local v69 = type(u67) == "string"
        assert(v69, "Bad key")
        return u2.spawn(function(p70, p71) --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u67
            --]]
            local v72, v73 = pcall(function() --[[ Line: 115 ]]
                --[[
                Upvalues:
                    [1] = u66
                    [2] = u67
                --]]
                u66:RemoveAsync(u67)
            end)
            if v72 then
                return p70(true)
            else
                return p71(v73)
            end
        end)
    end,
    ["promiseSortedPagesAsync"] = function(u74, u75, u76, u77, u78) --[[ Name: promiseSortedPagesAsync, Line 125 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v79
        if typeof(u74) == "Instance" then
            v79 = u74:IsA("OrderedDataStore")
        else
            v79 = false
        end
        assert(v79, "Bad orderedDataStore")
        local v80 = type(u75) == "boolean"
        assert(v80, "Bad ascending")
        local v81 = type(u76) == "number"
        assert(v81, "Bad entries")
        return u2.spawn(function(p82, p83) --[[ Line: 130 ]]
            --[[
            Upvalues:
                [1] = u74
                [2] = u75
                [3] = u76
                [4] = u77
                [5] = u78
            --]]
            local u84 = nil
            local v85, v86 = pcall(function() --[[ Line: 132 ]]
                --[[
                Upvalues:
                    [1] = u84
                    [2] = u74
                    [3] = u75
                    [4] = u76
                    [5] = u77
                    [6] = u78
                --]]
                u84 = u74:GetSortedAsync(u75, u76, u77, u78)
            end)
            if v85 then
                local v87 = u84
                if typeof(v87) == "Instance" then
                    return p82(u84)
                else
                    return p83(v86)
                end
            else
                return p83(v86)
            end
        end)
    end,
    ["promiseOrderedEntries"] = function(p88, p89, p90, u91, p92, p93) --[[ Name: promiseOrderedEntries, Line 146 ]]
        --[[
        Upvalues:
            [1] = u106
            [2] = u2
        --]]
        local v94
        if typeof(p88) == "Instance" then
            v94 = p88:IsA("OrderedDataStore")
        else
            v94 = false
        end
        assert(v94, "Bad orderedDataStore")
        local v95 = type(p89) == "boolean"
        assert(v95, "Bad ascending")
        local v96 = type(u91) == "number"
        assert(v96, "Bad entries")
        return u106.promiseSortedPagesAsync(p88, p89, p90, p92, p93):Then(function(u97) --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u91
            --]]
            return u2.spawn(function(p98, p99) --[[ Line: 153 ]]
                --[[
                Upvalues:
                    [1] = u91
                    [2] = u97
                --]]
                local v100 = 0
                local v101 = {}
                while v100 < u91 do
                    local v102 = v100
                    for _, v103 in pairs(u97:GetCurrentPage()) do
                        table.insert(v101, v103)
                        v100 = v100 + 1
                        if u91 <= v100 then
                            break
                        end
                    end
                    if v102 == v100 or u97.IsFinished then
                        break
                    end
                    if v100 < u91 then
                        local v104, v105 = pcall(function() --[[ Line: 175 ]]
                            --[[
                            Upvalues:
                                [1] = u97
                            --]]
                            u97:AdvanceToNextPageAsync()
                        end)
                        if not v104 then
                            return p99(v105)
                        end
                    end
                end
                return p98(v101)
            end)
        end)
    end
}
return u106