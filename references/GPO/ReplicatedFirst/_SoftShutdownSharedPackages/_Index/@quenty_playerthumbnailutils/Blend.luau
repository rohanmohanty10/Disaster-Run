 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("AccelTween")
local u3 = v1("BlendDefaultProps")
local u4 = v1("Brio")
local u5 = v1("Maid")
local u6 = v1("MaidTaskUtils")
local u7 = v1("Observable")
local u8 = v1("Promise")
local u9 = v1("Rx")
local u10 = v1("BrioUtils")
local u11 = v1("RxInstanceUtils")
local u12 = v1("RxValueBaseUtils")
local u13 = v1("Signal")
local u14 = v1("Spring")
local u15 = v1("SpringUtils")
local u16 = v1("StepUtils")
local u17 = v1("ValueBaseUtils")
local u18 = v1("ValueObject")
local u19 = v1("ValueObjectUtils")
local u164 = {
    ["New"] = function(u20) --[[ Name: New, Line 49 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u7
            [3] = u5
            [4] = u164
        --]]
        local v21 = type(u20) == "string"
        assert(v21, "Bad className")
        local u22 = u3[u20]
        return function(u23) --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u5
                [3] = u20
                [4] = u22
                [5] = u164
            --]]
            return u7.new(function(p24) --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u20
                    [3] = u22
                    [4] = u164
                    [5] = u23
                --]]
                local v25 = u5.new()
                local v26 = Instance.new(u20)
                v25:GiveTask(v26)
                if u22 then
                    for v27, v28 in pairs(u22) do
                        v26[v27] = v28
                    end
                end
                v25:GiveTask(u164.mount(v26, u23))
                p24:Fire(v26)
                return v25
            end)
        end
    end,
    ["State"] = function(p29) --[[ Name: State, Line 82 ]]
        --[[
        Upvalues:
            [1] = u18
        --]]
        return u18.new(p29)
    end,
    ["Dynamic"] = function(...) --[[ Name: Dynamic, Line 86 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
            [3] = u8
            [4] = u7
        --]]
        return u164.Computed(...):Pipe({ u9.switchMap(function(p30, ...) --[[ Line: 91 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u9
                    [3] = u7
                --]]
                if u8.isPromise(p30) then
                    return u9.fromPromise(p30)
                elseif u7.isObservable(p30) then
                    return p30
                else
                    return u9.of(p30, ...)
                end
            end) })
    end,
    ["Computed"] = function(...) --[[ Name: Computed, Line 129 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
            [3] = u7
        --]]
        local v31 = { ... }
        local u32 = select("#", ...)
        local u33 = v31[u32]
        local v34 = type(u33) == "function"
        assert(v34, "Bad compute")
        local v35 = {}
        for v36 = 1, u32 - 1 do
            local v37 = u164.toPropertyObservable(v31[v36])
            if v37 then
                v35[v36] = v37
            else
                v35[v36] = u9.of(v31[v36])
            end
        end
        if #v35 == 0 then
            return u7.new(function(p38) --[[ Line: 148 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                p38:Fire(u33())
            end)
        elseif #v35 == 1 then
            return u9.map(u33)(v35[1])
        else
            return u9.combineLatest(v35):Pipe({ u9.map(function(p39) --[[ Line: 156 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u32
                    --]]
                    local v40 = u33
                    local v41 = u32 - 1
                    return v40(unpack(p39, 1, v41))
                end) })
        end
    end,
    ["OnChange"] = function(u42) --[[ Name: OnChange, Line 179 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v43 = type(u42) == "string"
        assert(v43, "Bad propertyName")
        return function(p44) --[[ Line: 182 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u42
            --]]
            return u11.observeProperty(p44, u42)
        end
    end,
    ["OnEvent"] = function(u45) --[[ Name: OnEvent, Line 205 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        local v46 = type(u45) == "string"
        assert(v46, "Bad eventName")
        return function(p47) --[[ Line: 208 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u45
            --]]
            return u9.fromSignal(p47[u45])
        end
    end,
    ["Attached"] = function(u48) --[[ Name: Attached, Line 219 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u6
        --]]
        return function(u49) --[[ Line: 220 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u5
                [3] = u48
                [4] = u6
            --]]
            return u7.new(function(p50) --[[ Line: 221 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u48
                    [3] = u49
                    [4] = u6
                --]]
                local v51 = u5.new()
                local v52 = u48(u49)
                if u6.isValidTask(v52) then
                    v51:GiveTask(v52)
                end
                p50:Fire(v52)
                return v51
            end)
        end
    end,
    ["ComputedPairs"] = function(p53, u54) --[[ Name: ComputedPairs, Line 243 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
            [3] = u7
            [4] = u5
            [5] = u4
        --]]
        local u55 = u164.toPropertyObservable(p53) or u9.of(p53)
        return u7.new(function(u56) --[[ Line: 246 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u55
                [3] = u54
                [4] = u4
            --]]
            local u57 = {}
            local v58 = u5.new()
            local u59 = u5.new()
            v58:GiveTask(u59)
            v58:GiveTask(u55:Subscribe(function(p60) --[[ Line: 253 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u5
                    [3] = u54
                    [4] = u4
                    [5] = u56
                    [6] = u59
                --]]
                local v61 = type(p60) == "table"
                assert(v61, "Bad value emitted from source")
                local v62 = {}
                for v63, _ in pairs(u57) do
                    v62[v63] = true
                end
                for v64, v65 in pairs(p60) do
                    v62[v64] = nil
                    if u57[v64] ~= v65 then
                        local v66 = u5.new()
                        local v67 = u54(v64, v65, v66)
                        local v68 = u4.new(v67)
                        v66:GiveTask(v68)
                        u56:Fire(v68)
                        u59[v64] = v66
                        u57[v64] = v65
                    end
                end
                for v69, _ in pairs(v62) do
                    u59[v69] = nil
                    u57[v69] = nil
                end
            end), u56:GetFailComplete())
            return v58
        end)
    end,
    ["AccelTween"] = function(p70, p71) --[[ Name: AccelTween, Line 296 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
            [3] = u2
            [4] = u7
            [5] = u5
            [6] = u16
        --]]
        local u72 = u164.toPropertyObservable(p70) or u9.of(p70)
        local u73 = u164.toNumberObservable(p71)
        return u7.new(function(u74) --[[ Line: 314 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u16
                [3] = u72
                [4] = u2
                [5] = u73
            --]]
            local u75 = nil
            local u76 = u5.new()
            local u77, v78 = u16.bindToRenderStep(function() --[[ Line: 318 ]]
                --[[
                Upvalues:
                    [1] = u74
                    [2] = u75
                --]]
                u74:Fire(u75.p)
                return u75.rtime > 0
            end)
            u76:GiveTask(v78)
            u76:GiveTask(u72:Subscribe(function(p79) --[[ Line: 324 ]]
                --[[
                Upvalues:
                    [1] = u75
                    [2] = u76
                    [3] = u2
                    [4] = u73
                    [5] = u77
                --]]
                local u80 = u75
                if not u80 then
                    local v81 = u76
                    u80 = u2.new(p79)
                    if u73 then
                        v81:GiveTask(u73:Subscribe(function(p82) --[[ Line: 304 ]]
                            --[[
                            Upvalues:
                                [1] = u80
                            --]]
                            local v83 = type(p82) == "number"
                            assert(v83, "Bad value")
                            u80.a = p82
                        end))
                    end
                end
                u75 = u80
                u75.t = p79
                u77()
            end))
            return u76
        end)
    end,
    ["Spring"] = function(p84, p85, p86) --[[ Name: Spring, Line 355 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
            [3] = u14
            [4] = u7
            [5] = u5
            [6] = u16
            [7] = u15
        --]]
        local u87 = u164.toPropertyObservable(p84) or u9.of(p84)
        local u88 = u164.toNumberObservable(p85)
        local u89 = u164.toNumberObservable(p86)
        local function u97(p90, p91) --[[ Line: 360 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u88
                [3] = u89
            --]]
            local u92 = u14.new(p91)
            if u88 then
                p90:GiveTask(u88:Subscribe(function(p93) --[[ Line: 364 ]]
                    --[[
                    Upvalues:
                        [1] = u92
                    --]]
                    local v94 = type(p93) == "number"
                    assert(v94, "Bad value")
                    u92.Speed = p93
                end))
            end
            if u89 then
                p90:GiveTask(u89:Subscribe(function(p95) --[[ Line: 371 ]]
                    --[[
                    Upvalues:
                        [1] = u92
                    --]]
                    local v96 = type(p95) == "number"
                    assert(v96, "Bad value")
                    u92.Damper = p95
                end))
            end
            return u92
        end
        return u7.new(function(u98) --[[ Line: 382 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u16
                [3] = u15
                [4] = u87
                [5] = u97
            --]]
            local u99 = nil
            local u100 = u5.new()
            local u103, v104 = u16.bindToRenderStep(function() --[[ Line: 386 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u99
                    [3] = u98
                --]]
                local v101, v102 = u15.animating(u99)
                u98:Fire(u15.fromLinearIfNeeded(v102))
                return v101
            end)
            u100:GiveTask(v104)
            u100:GiveTask(u87:Subscribe(function(p105) --[[ Line: 393 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u99
                    [3] = u97
                    [4] = u100
                    [5] = u103
                --]]
                if p105 then
                    u99 = u99 or u97(u100, (u15.toLinearIfNeeded(p105)))
                    u99.t = u15.toLinearIfNeeded(p105)
                    u103()
                else
                    warn("Got nil value from emitted source")
                end
            end))
            return u100
        end)
    end,
    ["toPropertyObservable"] = function(p106) --[[ Name: toPropertyObservable, Line 414 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u17
            [3] = u12
            [4] = u18
            [5] = u19
            [6] = u8
            [7] = u9
        --]]
        if u7.isObservable(p106) then
            return p106
        end
        if typeof(p106) == "Instance" then
            if u17.isValueBase(p106) then
                return u12.observeValue(p106)
            end
        elseif type(p106) == "table" then
            if u18.isValueObject(p106) then
                return u19.observeValue(p106)
            end
            if u8.isPromise(p106) then
                return u9.fromPromise(p106)
            end
        end
        return nil
    end,
    ["toNumberObservable"] = function(p107) --[[ Name: toNumberObservable, Line 439 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u164
        --]]
        if type(p107) == "number" then
            return u9.of(p107)
        else
            return u164.toPropertyObservable(p107)
        end
    end,
    ["toEventObservable"] = function(p108) --[[ Name: toEventObservable, Line 453 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u13
            [3] = u9
        --]]
        if u7.isObservable(p108) then
            return p108
        elseif typeof(p108) == "RBXScriptSignal" or u13.isSignal(p108) then
            return u9.fromSignal(p108)
        else
            return nil
        end
    end,
    ["toEventHandler"] = function(u109) --[[ Name: toEventHandler, Line 469 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u13
        --]]
        if type(u109) == "function" then
            return u109
        end
        if typeof(u109) == "Instance" then
            if u17.isValueBase(u109) then
                return function(p110) --[[ Line: 475 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    u109.Value = p110
                end
            end
        elseif type(u109) == "table" then
            if u13.isSignal(u109) then
                return function(...) --[[ Line: 481 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    u109:Fire(...)
                end
            end
            if u109.ClassName == "ValueObject" then
                return function(p111) --[[ Line: 485 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    u109.Value = p111
                end
            end
        end
        return nil
    end,
    ["Children"] = function(u112, p113) --[[ Name: Children, Line 538 ]]
        --[[
        Upvalues:
            [1] = u164
            [2] = u9
        --]]
        local v114 = typeof(u112) == "Instance"
        assert(v114, "Bad parent")
        local v115 = u164._observeChildren(p113)
        if v115 then
            return v115:Pipe({ u9.tap(function(p116) --[[ Line: 544 ]]
                    --[[
                    Upvalues:
                        [1] = u112
                    --]]
                    p116.Parent = u112
                end) })
        else
            return u9.EMPTY
        end
    end,
    ["Instance"] = function(u117) --[[ Name: Instance, Line 589 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        return u7.new(function(p118) --[[ Line: 590 ]]
            --[[
            Upvalues:
                [1] = u117
            --]]
            p118:Fire(u117)
        end)
    end,
    ["Single"] = function(u119) --[[ Name: Single, Line 625 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u4
            [4] = u10
        --]]
        return u7.new(function(u120) --[[ Line: 626 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u119
                [3] = u4
                [4] = u10
            --]]
            local u121 = u5.new()
            u121:GiveTask(u119:Subscribe(function(p122) --[[ Line: 629 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u10
                    [3] = u121
                    [4] = u120
                --]]
                if u4.isBrio(p122) then
                    local v123 = u10.clone(p122)
                    u121._current = v123
                    u120:Fire(v123)
                    return v123
                else
                    local v124 = u4.new(p122)
                    u121._current = v124
                    u120:Fire(v124)
                    return v124
                end
            end))
            return u121
        end)
    end,
    ["_observeChildren"] = function(u125) --[[ Name: _observeChildren, Line 654 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u18
            [3] = u5
            [4] = u164
            [5] = u6
            [6] = u4
            [7] = u8
            [8] = u9
            [9] = u13
        --]]
        if typeof(u125) == "Instance" then
            return u7.new(function(p126) --[[ Line: 657 ]]
                --[[
                Upvalues:
                    [1] = u125
                --]]
                p126:Fire(u125)
                return u125
            end)
        elseif u18.isValueObject(u125) then
            return u7.new(function(u127) --[[ Line: 665 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u125
                    [3] = u164
                    [4] = u6
                --]]
                local u128 = u5.new()
                local function v134() --[[ Line: 669 ]]
                    --[[
                    Upvalues:
                        [1] = u125
                        [2] = u128
                        [3] = u127
                        [4] = u164
                        [5] = u6
                    --]]
                    local v129 = u125.Value
                    if typeof(v129) == "Instance" then
                        u128._current = v129
                        u127:Fire(v129)
                        return
                    else
                        local v130 = u164._observeChildren(v129)
                        if v130 then
                            u128._current = nil
                            local u131 = false
                            local u132 = nil
                            u132 = v130:Subscribe(function(p133) --[[ Line: 683 ]]
                                --[[
                                Upvalues:
                                    [1] = u127
                                --]]
                                u127:Fire(p133)
                            end, function(...) --[[ Line: 685 ]]
                                --[[
                                Upvalues:
                                    [1] = u127
                                --]]
                                u127:Fail(...)
                            end, function() --[[ Line: 687 ]]
                                --[[
                                Upvalues:
                                    [1] = u131
                                    [2] = u128
                                    [3] = u132
                                --]]
                                u131 = true
                                if u128._current == u132 then
                                    u128._current = nil
                                end
                            end)
                            if u131 then
                                if u132 then
                                    u6.doCleanup(u132)
                                end
                            else
                                u128._current = u132
                            end
                        else
                            u128._current = nil
                        end
                    end
                end
                u128:GiveTask(u125.Changed:Connect(v134))
                v134()
                return u128
            end)
        elseif u4.isBrio(u125) then
            return u7.new(function(u135) --[[ Line: 720 ]]
                --[[
                Upvalues:
                    [1] = u125
                    [2] = u164
                --]]
                if u125:IsDead() then
                    return nil
                end
                local v136 = u125:GetValue()
                if typeof(v136) == "Instance" then
                    local v137 = u125:ToMaid()
                    v137:GiveTask(v136)
                    u135:Fire(v136)
                    return v137
                end
                local v138 = u164._observeChildren(v136)
                if not v138 then
                    warn(("Unknown type in brio %q"):format((typeof(v136))))
                    return nil
                end
                local u139 = u125:ToMaid()
                u139:GiveTask(v138:Subscribe(function(p140) --[[ Line: 741 ]]
                    --[[
                    Upvalues:
                        [1] = u135
                    --]]
                    u135:Fire(p140)
                end, function(...) --[[ Line: 743 ]]
                    --[[
                    Upvalues:
                        [1] = u135
                    --]]
                    u135:Fail(...)
                end, function() --[[ Line: 745 ]]
                    --[[
                    Upvalues:
                        [1] = u139
                    --]]
                    u139:DoCleaning()
                end))
                return u139
            end)
        else
            if u8.isPromise(u125) then
                u125 = u9.fromPromise(u125)
            end
            if u13.isSignal(u125) or typeof(u125) == "RBXScriptSignal" then
                u125 = u9.fromSignal(u125)
            end
            if u7.isObservable(u125) then
                return u7.new(function(u141) --[[ Line: 769 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u125
                        [3] = u164
                    --]]
                    local u142 = u5.new()
                    u142:GiveTask(u125:Subscribe(function(p143) --[[ Line: 772 ]]
                        --[[
                        Upvalues:
                            [1] = u142
                            [2] = u141
                            [3] = u164
                            [4] = u5
                        --]]
                        if typeof(p143) == "Instance" then
                            u142:GiveTask(p143)
                            u141:Fire(p143)
                            return
                        else
                            local v144 = u164._observeChildren(p143)
                            if v144 then
                                local u145 = u5.new()
                                u145:GiveTask(v144:Subscribe(function(p146) --[[ Line: 786 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u141
                                    --]]
                                    u141:Fire(p146)
                                end, function(...) --[[ Line: 788 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u145
                                        [2] = u141
                                    --]]
                                    u145:DoCleaning()
                                    u141:Fail(...)
                                end, function() --[[ Line: 791 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u145
                                    --]]
                                    u145:DoCleaning()
                                end))
                                u145:GiveTask(function() --[[ Line: 795 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u142
                                        [2] = u145
                                    --]]
                                    u142[u145] = nil
                                end)
                                u142[u145] = u145
                            else
                                warn(("Failed to convert %q into children"):format((tostring(p143))))
                            end
                        end
                    end, function(...) --[[ Line: 802 ]]
                        --[[
                        Upvalues:
                            [1] = u141
                        --]]
                        u141:Fire(...)
                    end, function() --[[ Line: 804 ]] end))
                    return u142
                end)
            elseif type(u125) == "table" and not getmetatable(u125) then
                local v147 = {}
                for v148, v149 in pairs(u125) do
                    local v150 = u164._observeChildren(v149)
                    if v150 then
                        table.insert(v147, v150)
                    else
                        warn(("Failed to convert [%s] %q into children"):format(tostring(v148), (tostring(v149))))
                    end
                end
                if next(v147) then
                    return u9.merge(v147)
                else
                    return nil
                end
            else
                return nil
            end
        end
    end,
    ["mount"] = function(u151, p152) --[[ Name: mount, Line 850 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u164
            [3] = u7
        --]]
        local v153 = u5.new()
        local v154 = {}
        local v155 = nil
        for u156, u157 in pairs(p152) do
            if type(u156) == "string" then
                if u156 == "Parent" then
                    v155 = u157
                else
                    local v158 = u164.toPropertyObservable(u157)
                    if v158 then
                        v153:GiveTask(v158:Subscribe(function(u159) --[[ Line: 863 ]]
                            --[[
                            Upvalues:
                                [1] = u151
                                [2] = u156
                            --]]
                            task.spawn(function() --[[ Line: 864 ]]
                                --[[
                                Upvalues:
                                    [1] = u151
                                    [2] = u156
                                    [3] = u159
                                --]]
                                u151[u156] = u159
                            end)
                        end))
                    else
                        task.spawn(function() --[[ Line: 869 ]]
                            --[[
                            Upvalues:
                                [1] = u151
                                [2] = u156
                                [3] = u157
                            --]]
                            u151[u156] = u157
                        end)
                    end
                end
            elseif type(u156) == "function" then
                local v160 = u164.toEventObservable(u156(u151, u157))
                if u7.isObservable(v160) then
                    table.insert(v154, { v160, u157 })
                else
                    warn(("Unable to apply event listener %q"):format((tostring(u156))))
                end
            else
                warn(("Unable to apply property %q"):format((tostring(u156))))
            end
        end
        for _, v161 in pairs(v154) do
            v153:GiveTask(v161[1]:Subscribe(u164.toEventHandler(v161[2])))
        end
        if v155 then
            local v162 = u164.toPropertyObservable(v155)
            if v162 then
                v153:GiveTask(v162:Subscribe(function(p163) --[[ Line: 895 ]]
                    --[[
                    Upvalues:
                        [1] = u151
                    --]]
                    u151.Parent = p163
                end))
                return v153
            end
            u151.Parent = v155
        end
        return v153
    end
}
return u164