 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Brio")
local u3 = v1("Maid")
local u4 = v1("Observable")
local u5 = v1("Rx")
local u6 = v1("Symbol").named("unsetValue")
local u100 = {
    ["observeProperty"] = function(u7, u8) --[[ Name: observeProperty, Line 32 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local v9 = typeof(u7) == "Instance"
        assert(v9, "\'instance\' should be of type Instance")
        local v10 = type(u8) == "string"
        assert(v10, "\'propertyName\' should be of type string")
        return u4.new(function(u11) --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u7
                [3] = u8
            --]]
            local v12 = u3.new()
            v12:GiveTask(u7:GetPropertyChangedSignal(u8):Connect(function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u7
                    [3] = u8
                --]]
                u11:Fire(u7[u8], u7)
            end))
            u11:Fire(u7[u8], u7)
            return v12
        end)
    end,
    ["observeAncestry"] = function(u13) --[[ Name: observeAncestry, Line 54 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return u5.start(function() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            return u13, u13.Parent
        end)(u5.fromSignal(u13.AncestryChanged))
    end,
    ["observeFirstAncestorBrio"] = function(u14, u15) --[[ Name: observeFirstAncestorBrio, Line 69 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v16 = typeof(u14) == "Instance"
        assert(v16, "Bad instance")
        local v17 = type(u15) == "string"
        assert(v17, "Bad className")
        return u4.new(function(u18) --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u14
                [3] = u15
                [4] = u2
            --]]
            local u19 = u3.new()
            local u20 = nil
            local function v23() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u15
                    [3] = u20
                    [4] = u2
                    [5] = u19
                    [6] = u18
                --]]
                local v21 = u14:FindFirstAncestorWhichIsA(u15)
                if v21 then
                    if v21 ~= u20 then
                        u20 = v21
                        local v22 = u2.new(v21)
                        u19._current = v22
                        u18:Fire(v22)
                        return
                    end
                elseif u20 then
                    u19._current = nil
                    u20 = nil
                end
            end
            u19:GiveTask(u14.AncestryChanged:Connect(v23))
            local v24 = u14:FindFirstAncestorWhichIsA(u15)
            if v24 then
                if v24 ~= u20 then
                    u20 = v24
                    local v25 = u2.new(v24)
                    u19._current = v25
                    u18:Fire(v25)
                end
            elseif u20 then
                u19._current = nil
                u20 = nil
            end
            return u19
        end)
    end,
    ["observePropertyBrio"] = function(u26, u27, u28) --[[ Name: observePropertyBrio, Line 108 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u6
            [4] = u2
        --]]
        local v29 = typeof(u26) == "Instance"
        assert(v29, "Bad instance")
        local v30 = type(u27) == "string"
        assert(v30, "Bad propertyName")
        local v31 = type(u28) == "function" and true or u28 == nil
        assert(v31, "Bad predicate")
        return u4.new(function(u32) --[[ Line: 113 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u6
                [3] = u26
                [4] = u27
                [5] = u28
                [6] = u2
            --]]
            local u33 = u3.new()
            local u34 = u6
            local function v37() --[[ Line: 117 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u27
                    [3] = u34
                    [4] = u28
                    [5] = u2
                    [6] = u33
                    [7] = u32
                --]]
                local v35 = u26[u27]
                if u34 ~= v35 then
                    u34 = v35
                    if u28 and not u28(v35) then
                        u33._lastBrio = nil
                    else
                        local v36 = u2.new(u26[u27])
                        u33._lastBrio = v36
                        if u33._lastBrio == v36 then
                            u32:Fire(v36)
                            return
                        end
                    end
                end
            end
            u33:GiveTask(u26:GetPropertyChangedSignal(u27):Connect(v37))
            local v38 = u26[u27]
            if u34 ~= v38 then
                u34 = v38
                if u28 and not u28(v38) then
                    u33._lastBrio = nil
                else
                    local v39 = u2.new(u26[u27])
                    u33._lastBrio = v39
                    if u33._lastBrio == v39 then
                        u32:Fire(v39)
                    end
                end
            end
            return u33
        end)
    end,
    ["observeLastNamedChildBrio"] = function(u40, u41, u42) --[[ Name: observeLastNamedChildBrio, Line 156 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v43 = typeof(u40) == "Instance"
        assert(v43, "Bad parent")
        local v44 = type(u41) == "string"
        assert(v44, "Bad className")
        local v45 = type(u42) == "string"
        assert(v45, "Bad name")
        return u4.new(function(u46) --[[ Line: 161 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u41
                [3] = u42
                [4] = u2
                [5] = u40
            --]]
            local u47 = u3.new()
            local function v53(u48) --[[ Line: 164 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u3
                    [3] = u42
                    [4] = u2
                    [5] = u47
                    [6] = u46
                --]]
                if u48:IsA(u41) then
                    local u49 = u3.new()
                    local function v51() --[[ Line: 171 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u42
                            [3] = u2
                            [4] = u49
                            [5] = u47
                            [6] = u46
                        --]]
                        if u48.Name == u42 then
                            local v50 = u2.new(u48)
                            u49._brio = v50
                            u47._lastBrio = v50
                            u46:Fire(v50)
                        else
                            u49._brio = nil
                        end
                    end
                    u49:GiveTask(u48:GetPropertyChangedSignal("Name"):Connect(v51))
                    if u48.Name == u42 then
                        local v52 = u2.new(u48)
                        u49._brio = v52
                        u47._lastBrio = v52
                        u46:Fire(v52)
                    else
                        u49._brio = nil
                    end
                    u47[u48] = u49
                end
            end
            u47:GiveTask(u40.ChildAdded:Connect(v53))
            u47:GiveTask(u40.ChildRemoved:Connect(function(p54) --[[ Line: 190 ]]
                --[[
                Upvalues:
                    [1] = u47
                --]]
                u47[p54] = nil
            end))
            for _, v55 in pairs(u40:GetChildren()) do
                v53(v55)
            end
            return u47
        end)
    end,
    ["observeChildrenOfNameBrio"] = function(u56, u57, u58) --[[ Name: observeChildrenOfNameBrio, Line 210 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v59 = typeof(u56) == "Instance"
        assert(v59, "Bad parent")
        local v60 = type(u57) == "string"
        assert(v60, "Bad className")
        local v61 = type(u58) == "string"
        assert(v61, "Bad name")
        return u4.new(function(u62) --[[ Line: 215 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u57
                [3] = u58
                [4] = u2
                [5] = u56
            --]]
            local u63 = u3.new()
            local function v69(u64) --[[ Line: 218 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u3
                    [3] = u58
                    [4] = u2
                    [5] = u62
                    [6] = u63
                --]]
                if u64:IsA(u57) then
                    local u65 = u3.new()
                    local function v67() --[[ Line: 225 ]]
                        --[[
                        Upvalues:
                            [1] = u64
                            [2] = u58
                            [3] = u2
                            [4] = u65
                            [5] = u62
                        --]]
                        if u64.Name == u58 then
                            local v66 = u2.new(u64)
                            u65._brio = v66
                            u62:Fire(v66)
                        else
                            u65._brio = nil
                        end
                    end
                    u65:GiveTask(u64:GetPropertyChangedSignal("Name"):Connect(v67))
                    if u64.Name == u58 then
                        local v68 = u2.new(u64)
                        u65._brio = v68
                        u62:Fire(v68)
                    else
                        u65._brio = nil
                    end
                    u63[u64] = u65
                end
            end
            u63:GiveTask(u56.ChildAdded:Connect(v69))
            u63:GiveTask(u56.ChildRemoved:Connect(function(p70) --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u63
                --]]
                u63[p70] = nil
            end))
            for _, v71 in pairs(u56:GetChildren()) do
                v69(v71)
            end
            return u63
        end)
    end,
    ["observeChildrenOfClassBrio"] = function(p72, u73) --[[ Name: observeChildrenOfClassBrio, Line 262 ]]
        --[[
        Upvalues:
            [1] = u100
        --]]
        local v74 = typeof(p72) == "Instance"
        assert(v74, "Bad parent")
        local v75 = type(u73) == "string"
        assert(v75, "Bad className")
        return u100.observeChildrenBrio(p72, function(p76) --[[ Line: 266 ]]
            --[[
            Upvalues:
                [1] = u73
            --]]
            return p76:IsA(u73)
        end)
    end,
    ["observeChildrenBrio"] = function(u77, u78) --[[ Name: observeChildrenBrio, Line 278 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v79 = typeof(u77) == "Instance"
        assert(v79, "Bad parent")
        local v80 = type(u78) == "function" and true or u78 == nil
        assert(v80, "Bad predicate")
        return u4.new(function(u81) --[[ Line: 282 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u78
                [3] = u2
                [4] = u77
            --]]
            local u82 = u3.new()
            local function v85(p83) --[[ Line: 285 ]]
                --[[
                Upvalues:
                    [1] = u78
                    [2] = u2
                    [3] = u82
                    [4] = u81
                --]]
                if not u78 or u78(p83) then
                    local v84 = u2.new(p83)
                    u82[p83] = v84
                    u81:Fire(v84)
                end
            end
            u82:GiveTask(u77.ChildAdded:Connect(v85))
            u82:GiveTask(u77.ChildRemoved:Connect(function(p86) --[[ Line: 294 ]]
                --[[
                Upvalues:
                    [1] = u82
                --]]
                u82[p86] = nil
            end))
            for _, v87 in pairs(u77:GetChildren()) do
                if not u78 or u78(v87) then
                    local v88 = u2.new(v87)
                    u82[v87] = v88
                    u81:Fire(v88)
                end
            end
            return u82
        end)
    end,
    ["observeDescendants"] = function(u89, u90) --[[ Name: observeDescendants, Line 313 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        local v91 = typeof(u89) == "Instance"
        assert(v91, "Bad parent")
        local v92 = type(u90) == "function" and true or u90 == nil
        assert(v92, "Bad predicate")
        return u4.new(function(u93) --[[ Line: 317 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u90
                [3] = u89
            --]]
            local v94 = u3.new()
            local u95 = {}
            local function v97(p96) --[[ Line: 321 ]]
                --[[
                Upvalues:
                    [1] = u90
                    [2] = u95
                    [3] = u93
                --]]
                if not u90 or u90(p96) then
                    u95[p96] = true
                    u93:Fire(p96, true)
                end
            end
            v94:GiveTask(u89.DescendantAdded:Connect(v97))
            v94:GiveTask(u89.DescendantRemoving:Connect(function(p98) --[[ Line: 329 ]]
                --[[
                Upvalues:
                    [1] = u95
                    [2] = u93
                --]]
                if u95[p98] then
                    u95[p98] = nil
                    u93:Fire(p98, false)
                end
            end))
            for _, v99 in pairs(u89:GetDescendants()) do
                if not u90 or u90(v99) then
                    u95[v99] = true
                    u93:Fire(v99, true)
                end
            end
            return v94
        end)
    end
}
return u100