 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Brio")
local u3 = v1("BrioUtils")
local u4 = v1("Maid")
local u5 = v1("Observable")
local u6 = v1("Rx")
local u62 = {
    ["toBrio"] = function() --[[ Name: toBrio, Line 24 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
        --]]
        return u6.map(function(p7) --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            if u2.isBrio(p7) then
                return p7
            else
                return u2.new(p7)
            end
        end)
    end,
    ["completeOnDeath"] = function(u8, u9) --[[ Name: completeOnDeath, Line 41 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
        --]]
        local v10 = u2.isBrio
        assert(v10(u8))
        local v11 = u5.isObservable
        assert(v11(u9))
        return u5.new(function(u12) --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u9
            --]]
            if not u8:IsDead() then
                local v13 = u8:ToMaid()
                v13:GiveTask(function() --[[ Line: 53 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                    --]]
                    u12:Complete()
                end)
                v13:GiveTask(u9:Subscribe(u12:GetFireFailComplete()))
                return v13
            end
            u12:Complete()
        end)
    end,
    ["emitWhileAllDead"] = function(u14) --[[ Name: emitWhileAllDead, Line 69 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u3
            [4] = u2
        --]]
        return function(u15) --[[ Line: 70 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u3
                [4] = u2
                [5] = u14
            --]]
            return u5.new(function(u16) --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                    [3] = u2
                    [4] = u14
                    [5] = u15
                --]]
                local u17 = u4.new()
                local u18 = true
                u17:GiveTask(function() --[[ Line: 75 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18 = false
                end)
                local u19 = {}
                local u20 = false
                local function u26(p21) --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u17
                        [3] = u18
                        [4] = u19
                        [5] = u3
                        [6] = u2
                        [7] = u14
                        [8] = u16
                        [9] = u20
                    --]]
                    if p21:IsDead() then
                        return
                    else
                        local u22 = u4.new()
                        u17[u22] = u22
                        u22:GiveTask(function() --[[ Line: 107 ]]
                            --[[
                            Upvalues:
                                [1] = u17
                                [2] = u22
                                [3] = u18
                                [4] = u19
                                [5] = u3
                                [6] = u2
                                [7] = u14
                                [8] = u16
                                [9] = u20
                            --]]
                            u17[u22] = nil
                            if u18 then
                                u19 = u3.aliveOnly(u19)
                                if next(u19) then
                                    u17._lastBrio = nil
                                else
                                    local v23 = u2.new(u14)
                                    u17._lastBrio = v23
                                    u16:Fire(v23)
                                end
                                u20 = true
                            end
                        end)
                        u22:GiveTask(p21:GetDiedSignal():Connect(function() --[[ Line: 111 ]]
                            --[[
                            Upvalues:
                                [1] = u17
                                [2] = u22
                            --]]
                            u17[u22] = nil
                        end))
                        local v24 = u19
                        table.insert(v24, p21)
                        if u18 then
                            u19 = u3.aliveOnly(u19)
                            if next(u19) then
                                u17._lastBrio = nil
                            else
                                local v25 = u2.new(u14)
                                u17._lastBrio = v25
                                u16:Fire(v25)
                            end
                            u20 = true
                        end
                    end
                end
                u17:GiveTask(u15:Subscribe(function(p27) --[[ Line: 120 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u17
                        [3] = u16
                        [4] = u26
                    --]]
                    if u2.isBrio(p27) then
                        u26(p27)
                    else
                        warn(("[RxBrioUtils.emitWhileAllDead] - Not a brio, %q"):format((tostring(p27))))
                        u17._lastBrio = nil
                        u16:Fail("Not a brio")
                    end
                end, function(...) --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                    --]]
                    u16:Fail(...)
                end, function(...) --[[ Line: 133 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                    --]]
                    u16:Complete(...)
                end))
                if not u20 and u18 then
                    u19 = u3.aliveOnly(u19)
                    if next(u19) then
                        u17._lastBrio = nil
                    else
                        local v28 = u2.new(u14)
                        u17._lastBrio = v28
                        u16:Fire(v28)
                    end
                    u20 = true
                end
                return u17
            end)
        end
    end,
    ["reduceToAliveList"] = function(u29) --[[ Name: reduceToAliveList, Line 153 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u3
            [4] = u2
        --]]
        local v30 = type(u29) == "function" and true or u29 == nil
        assert(v30, "Bad selectFromBrio")
        return function(u31) --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u3
                [4] = u29
                [5] = u2
            --]]
            return u5.new(function(u32) --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                    [3] = u29
                    [4] = u31
                    [5] = u2
                --]]
                local u33 = u4.new()
                local u34 = true
                u33:GiveTask(function() --[[ Line: 161 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                    --]]
                    u34 = false
                end)
                local u35 = {}
                local u36 = false
                local function u45() --[[ Line: 167 ]]
                    --[[
                    Upvalues:
                        [1] = u34
                        [2] = u35
                        [3] = u3
                        [4] = u29
                        [5] = u33
                        [6] = u36
                        [7] = u32
                    --]]
                    if u34 then
                        u35 = u3.aliveOnly(u35)
                        local v37 = {}
                        if u29 then
                            for _, v38 in pairs(u35) do
                                local v39 = u29(v38:GetValue())
                                local v40 = v39 ~= nil
                                assert(v40, "Bad value")
                                table.insert(v37, v39)
                            end
                        else
                            for _, v41 in pairs(u35) do
                                local v42 = v41:GetValue()
                                local v43 = v42 ~= nil
                                assert(v43, "Bad value")
                                table.insert(v37, v42)
                            end
                        end
                        local v44 = u3.first(u35, v37)
                        u33._lastBrio = v44
                        u36 = true
                        u32:Fire(v44)
                    end
                end
                local function u49(p46) --[[ Line: 198 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u33
                        [3] = u45
                        [4] = u35
                    --]]
                    if not p46:IsDead() then
                        local u47 = u4.new()
                        u33[u47] = u47
                        u47:GiveTask(function() --[[ Line: 207 ]]
                            --[[
                            Upvalues:
                                [1] = u33
                                [2] = u47
                                [3] = u45
                            --]]
                            u33[u47] = nil
                            u45()
                        end)
                        u47:GiveTask(p46:GetDiedSignal():Connect(function() --[[ Line: 211 ]]
                            --[[
                            Upvalues:
                                [1] = u33
                                [2] = u47
                            --]]
                            u33[u47] = nil
                        end))
                        local v48 = u35
                        table.insert(v48, p46)
                        u45()
                    end
                end
                u33:GiveTask(u31:Subscribe(function(p50) --[[ Line: 220 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u33
                        [3] = u32
                        [4] = u49
                    --]]
                    if u2.isBrio(p50) then
                        u49(p50)
                    else
                        warn(("[RxBrioUtils.mergeToAliveList] - Not a brio, %q"):format((tostring(p50))))
                        u33._lastBrio = nil
                        u32:Fail("Not a brio")
                    end
                end, function(...) --[[ Line: 230 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                    --]]
                    u32:Fail(...)
                end, function(...) --[[ Line: 233 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                    --]]
                    u32:Complete(...)
                end))
                if not u36 then
                    u45()
                end
                return u33
            end)
        end
    end,
    ["reemitLastBrioOnDeath"] = function() --[[ Name: reemitLastBrioOnDeath, Line 252 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u2
        --]]
        return function(u51) --[[ Line: 253 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u2
            --]]
            return u5.new(function(u52) --[[ Line: 254 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u51
                    [3] = u2
                --]]
                local u53 = u4.new()
                u53:GiveTask(u51:Subscribe(function(u54) --[[ Line: 258 ]]
                    --[[
                    Upvalues:
                        [1] = u53
                        [2] = u2
                        [3] = u52
                    --]]
                    u53._conn = nil
                    if u2.isBrio(u54) then
                        if u54:IsDead() then
                            u52:Fire(u54)
                        else
                            u53._conn = u54:GetDiedSignal():Connect(function() --[[ Line: 273 ]]
                                --[[
                                Upvalues:
                                    [1] = u52
                                    [2] = u54
                                --]]
                                u52:Fire(u54)
                            end)
                            u52:Fire(u54)
                        end
                    else
                        warn(("[RxBrioUtils.reemitLastBrioOnDeath] - Not a brio, %q"):format((tostring(u54))))
                        u52:Fail("Not a brio")
                        return
                    end
                end, function(...) --[[ Line: 279 ]]
                    --[[
                    Upvalues:
                        [1] = u52
                    --]]
                    u52:Fail(...)
                end, function(...) --[[ Line: 282 ]]
                    --[[
                    Upvalues:
                        [1] = u52
                    --]]
                    u52:Complete(...)
                end))
                return u53
            end)
        end
    end,
    ["where"] = function(u55) --[[ Name: where, Line 299 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u2
        --]]
        local v56 = type(u55) == "function"
        assert(v56, "Bad predicate")
        return function(u57) --[[ Line: 301 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u2
                [4] = u55
            --]]
            return u5.new(function(u58) --[[ Line: 302 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u57
                    [3] = u2
                    [4] = u55
                --]]
                local v59 = u4.new()
                v59:GiveTask(u57:Subscribe(function(p60) --[[ Line: 305 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u55
                        [3] = u58
                    --]]
                    local v61 = u2.isBrio(p60)
                    assert(v61, "Not a brio")
                    if not p60:IsDead() then
                        if u55(p60:GetValue()) then
                            u58:Fire(p60)
                        end
                    end
                end, u58:GetFailComplete()))
                return v59
            end)
        end
    end
}
u62.filter = u62.where
function u62.combineLatest(p63) --[[ Line: 340 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
        [3] = u62
    --]]
    local v64 = type(p63) == "table"
    assert(v64, "Bad observables")
    warn("[RxBrioUtils.combineLatest] - Deprecated since 3.6.0. Use RxBrioUtils.flatCombineLatest")
    return u6.combineLatest(p63):Pipe({ u6.map(u3.flatten), u62.onlyLastBrioSurvives() })
end
function u62.flatMap(p65, p66) --[[ Line: 361 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u62
    --]]
    local v67 = type(p65) == "function"
    assert(v67, "Bad project")
    warn("[RxBrioUtils.flatMap] - Deprecated since 3.6.0. Use RxBrioUtils.flatMapBrio")
    return u6.flatMap(u62.mapBrio(p65), p66)
end
function u62.flatMapBrio(p68) --[[ Line: 381 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u62
    --]]
    return u6.flatMap(u62.mapBrioBrio(p68))
end
function u62.switchMap(p69) --[[ Line: 393 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u62
    --]]
    local v70 = type(p69) == "function"
    assert(v70, "Bad project")
    warn("[RxBrioUtils.switchMap] - Deprecated since 3.6.0. Use RxBrioUtils.switchMapBrio")
    return u6.switchMap(u62.mapBrio(p69))
end
function u62.switchMapBrio(p71) --[[ Line: 413 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u62
    --]]
    local v72 = type(p71) == "function"
    assert(v72, "Bad project")
    return u6.switchMap(u62.mapBrioBrio(p71))
end
function u62.flatCombineLatest(p73) --[[ Line: 437 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u62
        [3] = u6
    --]]
    local v74 = type(p73) == "table"
    assert(v74, "Bad observables")
    local v75 = {}
    for v76, v77 in pairs(p73) do
        if u5.isObservable(v77) then
            v75[v76] = u62.flattenToValueAndNil(v77)
        else
            v75[v76] = v77
        end
    end
    return u6.combineLatest(v75)
end
function u62.mapBrio(u78) --[[ Line: 460 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
        [4] = u62
    --]]
    local v79 = type(u78) == "function"
    assert(v79, "Bad project")
    warn("[RxBrioUtils.mapBrio] - Deprecated since 3.6.0. Use RxBrioUtils.mapBrioBrio")
    return function(p80) --[[ Line: 465 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u6
            [3] = u78
            [4] = u5
            [5] = u62
        --]]
        local v81 = u2.isBrio(p80)
        assert(v81, "Not a brio")
        if p80:IsDead() then
            return u6.EMPTY
        end
        local v82 = u78(p80:GetValue())
        local v83 = u5.isObservable(v82)
        assert(v83, "Not an observable")
        return u62.completeOnDeath(p80, v82)
    end
end
function u62.prepend(...) --[[ Line: 485 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u3
    --]]
    local u84 = table.pack(...)
    return u6.map(function(p85) --[[ Line: 488 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u84
        --]]
        local v86 = u2.isBrio(p85)
        assert(v86, "Bad brio")
        local v87 = u3.prepend
        local v88 = u84
        local v89 = u84.n
        return v87(p85, table.unpack(v88, 1, v89))
    end)
end
function u62.extend(...) --[[ Line: 501 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u3
    --]]
    local u90 = table.pack(...)
    return u6.map(function(p91) --[[ Line: 504 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u90
        --]]
        local v92 = u2.isBrio(p91)
        assert(v92, "Bad brio")
        local v93 = u3.extend
        local v94 = u90
        local v95 = u90.n
        return v93(p91, table.unpack(v94, 1, v95))
    end)
end
function u62.map(u96) --[[ Line: 517 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u3
    --]]
    return u6.map(function(...) --[[ Line: 518 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u96
            [3] = u3
        --]]
        local v97 = select("#", ...)
        local v98 = {}
        local v99
        if v97 == 1 then
            if u2.isBrio(...) then
                table.insert(v98, (...))
                v99 = (...):GetPackedValues()
            else
                v99 = { ... }
            end
        else
            v99 = {}
            for v100, v101 in pairs({ ... }) do
                if u2.isBrio(v101) then
                    table.insert(v98, v101)
                    v99[v100] = v101:GetValue()
                else
                    v99[v100] = v101
                end
            end
            v99.n = v97
        end
        local v102 = table.pack
        local v103 = u96
        local v104 = v99.n
        local v105 = v102(v103(table.unpack(v99, 1, v104)))
        local v106 = {}
        for v107 = 1, v105.n do
            local v108 = v105[v107]
            if u2.isBrio(v108) then
                table.insert(v98, v108)
                v106[v107] = v108:GetValue()
            else
                v106[v107] = v108
            end
        end
        local v109 = u3.first
        local v110 = v106.n
        return v109(v98, table.unpack(v106, 1, v110))
    end)
end
function u62._mapResult(u111) --[[ Line: 559 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return function(...) --[[ Line: 560 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u111
            [3] = u2
        --]]
        local v112 = select("#", ...)
        if v112 == 0 then
            return u3.withOtherValues(u111)
        end
        if v112 == 1 then
            if not u2.isBrio(...) then
                return u3.withOtherValues(u111, ...)
            end
            local v113 = { u111, (...) }
            return u3.first(v113, (...):GetValue())
        end
        local v114 = { u111 }
        local v115 = {}
        for v116, v117 in pairs({ ... }) do
            if u2.isBrio(v117) then
                table.insert(v114, v117)
                v115[v116] = v117:GetValue()
            else
                v115[v116] = v117
            end
        end
        return u3.first(v114, unpack(v115, 1, v112))
    end
end
function u62.mapBrioBrio(u118) --[[ Line: 596 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
        [4] = u62
    --]]
    local v119 = type(u118) == "function"
    assert(v119, "Bad project")
    return function(p120) --[[ Line: 599 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u6
            [3] = u118
            [4] = u5
            [5] = u62
        --]]
        local v121 = u2.isBrio(p120)
        assert(v121, "Not a brio")
        if p120:IsDead() then
            return u6.EMPTY
        end
        local v122 = u118(p120:GetValue())
        local v123 = u5.isObservable(v122)
        assert(v123, "Not an observable")
        return u62.completeOnDeath(p120, v122):Pipe({ u6.map(u62._mapResult(p120)) })
    end
end
function u62.toEmitOnDeathObservable(u124, u125) --[[ Line: 621 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
    --]]
    if u2.isBrio(u124) then
        return u5.new(function(u126) --[[ Line: 625 ]]
            --[[
            Upvalues:
                [1] = u124
                [2] = u125
            --]]
            if not u124:IsDead() then
                u126:Fire(u124:GetValue())
                return u124:GetDiedSignal():Connect(function() --[[ Line: 631 ]]
                    --[[
                    Upvalues:
                        [1] = u126
                        [2] = u125
                    --]]
                    u126:Fire(u125)
                    u126:Complete()
                end)
            end
            u126:Fire(u125)
            u126:Complete()
        end)
    else
        return u6.of(u124)
    end
end
function u62.mapBrioToEmitOnDeathObservable(u127) --[[ Line: 646 ]]
    --[[
    Upvalues:
        [1] = u62
    --]]
    return function(p128) --[[ Line: 647 ]]
        --[[
        Upvalues:
            [1] = u62
            [2] = u127
        --]]
        return u62.toEmitOnDeathObservable(p128, u127)
    end
end
function u62.emitOnDeath(p129) --[[ Line: 659 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u62
    --]]
    return u6.switchMap(u62.mapBrioToEmitOnDeathObservable(p129))
end
u62.flattenToValueAndNil = u62.emitOnDeath(nil)
function u62.onlyLastBrioSurvives() --[[ Line: 678 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u2
        [4] = u3
    --]]
    return function(u130) --[[ Line: 679 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u2
            [4] = u3
        --]]
        return u5.new(function(u131) --[[ Line: 680 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u130
                [3] = u2
                [4] = u3
            --]]
            local u132 = u4.new()
            u132:GiveTask(u130:Subscribe(function(p133) --[[ Line: 683 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u132
                    [3] = u131
                    [4] = u3
                --]]
                if u2.isBrio(p133) then
                    local v134 = u3.clone(p133)
                    u132._lastBrio = v134
                    u131:Fire(v134)
                else
                    warn(("[RxBrioUtils.onlyLastBrioSurvives] - Not a brio, %q"):format((tostring(p133))))
                    u132._lastBrio = nil
                    u131:Fail("Not a brio")
                end
            end, u131:GetFailComplete()))
            return u132
        end)
    end
end
u62.switchToBrio = u6.pipe({ u62.toBrio(), u62.onlyLastBrioSurvives() })
return u62