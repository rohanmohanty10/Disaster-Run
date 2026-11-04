 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Maid")
local u3 = v1("Observable")
local u4 = v1("Promise")
local v5 = v1("Symbol")
local u6 = v1("Table")
local u7 = v1("ThrottledFunction")
local u8 = v1("cancellableDelay")
local u9 = v1("CancelToken")
local u10 = v5.named("unsetValue")
local u80 = {
    ["EMPTY"] = u3.new(function(p11) --[[ Line: 40 ]]
        p11:Complete()
    end),
    ["NEVER"] = u3.new(function(_) --[[ Line: 43 ]] end),
    ["pipe"] = function(u12) --[[ Name: pipe, Line 55 ]]
        local v13 = type(u12) == "table"
        assert(v13, "Bad transformers")
        for v14, v15 in pairs(u12) do
            if type(v15) ~= "function" then
                error(("[Rx.pipe] Bad pipe value of type %q at index %q, expected function"):format(type(v15), (tostring(v14))))
            end
        end
        return function(p16) --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u12
            --]]
            assert(p16, "Bad source")
            for v17, v18 in pairs(u12) do
                p16 = v18(p16)
                if type(p16) ~= "table" or p16.ClassName ~= "Observable" then
                    local v19 = error
                    local v20 = tostring(v17)
                    local v21 = tostring(p16)
                    local v22 = type(p16) == "table" and (p16.ClassName or "") or ""
                    v19(("[Rx.pipe] - Failed to transform %q in pipe, made %q (%s)"):format(v20, v21, (tostring(v22))))
                end
            end
            return p16
        end
    end,
    ["of"] = function(...) --[[ Name: of, Line 93 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local u23 = table.pack(...)
        return u3.new(function(p24) --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u23
            --]]
            for v25 = 1, u23.n do
                p24:Fire(u23[v25])
            end
            p24:Complete()
        end)
    end,
    ["from"] = function(p26) --[[ Name: from, Line 112 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u80
        --]]
        if u4.isPromise(p26) then
            return u80.fromPromise(p26)
        end
        if type(p26) == "table" then
            return u80.of(unpack(p26))
        end
        error("[Rx.from] - cannot convert")
    end,
    ["toPromise"] = function(u27, u28) --[[ Name: toPromise, Line 129 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u9
            [3] = u4
        --]]
        local u29 = u2.new()
        local u31 = u9.new(function(p30) --[[ Line: 132 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u28
            --]]
            u29:GiveTask(p30)
            if u28 then
                if u28:IsCancelled() then
                    p30()
                    return
                end
                u29:GiveTask(u28.Cancelled:Connect(p30))
            end
        end)
        local v34 = u4.new(function(p32, u33) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u29
                [3] = u27
            --]]
            if u31:IsCancelled() then
                u33()
            else
                u29:GiveTask(u31.Cancelled:Connect(function() --[[ Line: 149 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                    --]]
                    u33()
                end))
                u29:GiveTask(u27:Subscribe(p32, u33, u33))
            end
        end)
        v34:Finally(function() --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u29
            --]]
            u29:DoCleaning()
        end)
        return v34
    end,
    ["merge"] = function(u35) --[[ Name: merge, Line 169 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v36 = type(u35) == "table"
        assert(v36, "Bad observables")
        for _, v37 in pairs(u35) do
            local v38 = u3.isObservable(v37)
            assert(v38, "Not an observable")
        end
        return u3.new(function(p39) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u35
            --]]
            local v40 = u2.new()
            for _, v41 in pairs(u35) do
                v40:GiveTask(v41:Subscribe(p39:GetFireFailComplete()))
            end
            return v40
        end)
    end,
    ["fromSignal"] = function(u42) --[[ Name: fromSignal, Line 194 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        return u3.new(function(u43) --[[ Line: 195 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            return u42:Connect(function(...) --[[ Line: 197 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                u43:Fire(...)
            end)
        end)
    end,
    ["fromPromise"] = function(u44) --[[ Name: fromPromise, Line 210 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
        --]]
        local v45 = u4.isPromise
        assert(v45(u44))
        return u3.new(function(u46) --[[ Line: 213 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u2
            --]]
            if u44:IsFulfilled() then
                u46:Fire(u44:Wait())
                u46:Complete()
                return nil
            end
            local v47 = u2.new()
            local u48 = true
            v47:GiveTask(function() --[[ Line: 223 ]]
                --[[
                Upvalues:
                    [1] = u48
                --]]
                u48 = false
            end)
            u44:Then(function(...) --[[ Line: 228 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u46
                --]]
                if u48 then
                    u46:Fire(...)
                    u46:Complete()
                end
            end, function(...) --[[ Line: 234 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u46
                --]]
                if u48 then
                    u46:Fail(...)
                    u46:Complete()
                end
            end)
            return v47
        end)
    end,
    ["tap"] = function(u49, u50, u51) --[[ Name: tap, Line 256 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v52 = type(u49) == "function" and true or u49 == nil
        assert(v52, "Bad onFire")
        local v53 = type(u50) == "function" and true or u50 == nil
        assert(v53, "Bad onError")
        local v54 = type(u51) == "function" and true or u51 == nil
        assert(v54, "Bad onComplete")
        return function(u55) --[[ Line: 261 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u49
                [3] = u50
                [4] = u51
            --]]
            local v56 = u3.isObservable(u55)
            assert(v56, "Bad observable")
            return u3.new(function(u57) --[[ Line: 264 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u49
                    [3] = u50
                    [4] = u51
                --]]
                return u55:Subscribe(function(...) --[[ Line: 266 ]]
                    --[[
                    Upvalues:
                        [1] = u49
                        [2] = u57
                    --]]
                    if u49 then
                        u49(...)
                    end
                    if u57:IsPending() then
                        u57:Fire(...)
                    end
                end, function(...) --[[ Line: 274 ]]
                    --[[
                    Upvalues:
                        [1] = u50
                        [2] = u57
                    --]]
                    if u50 then
                        u50(...)
                    end
                    u57:Error(...)
                end, function(...) --[[ Line: 280 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u57
                    --]]
                    if u51 then
                        u51(...)
                    end
                    u57:Complete(...)
                end)
            end)
        end
    end,
    ["start"] = function(u58) --[[ Name: start, Line 298 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        return function(u59) --[[ Line: 299 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u58
            --]]
            local v60 = u3.isObservable(u59)
            assert(v60, "Bad observable")
            return u3.new(function(p61) --[[ Line: 302 ]]
                --[[
                Upvalues:
                    [1] = u58
                    [2] = u59
                --]]
                p61:Fire(u58())
                return u59:Subscribe(p61:GetFireFailComplete())
            end)
        end
    end,
    ["startFrom"] = function(u62) --[[ Name: startFrom, Line 316 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v63 = type(u62) == "function"
        assert(v63, "Bad callback")
        return function(u64) --[[ Line: 318 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u62
            --]]
            local v65 = u3.isObservable(u64)
            assert(v65, "Bad observable")
            return u3.new(function(p66) --[[ Line: 321 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u64
                --]]
                for _, v67 in pairs(u62()) do
                    p66:Fire(v67)
                end
                return u64:Subscribe(p66:GetFireFailComplete())
            end)
        end
    end,
    ["startWith"] = function(u68) --[[ Name: startWith, Line 338 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v69 = type(u68) == "table"
        assert(v69, "Bad values")
        return function(u70) --[[ Line: 341 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u68
            --]]
            local v71 = u3.isObservable(u70)
            assert(v71, "Bad observable")
            return u3.new(function(p72) --[[ Line: 344 ]]
                --[[
                Upvalues:
                    [1] = u68
                    [2] = u70
                --]]
                for _, v73 in pairs(u68) do
                    p72:Fire(v73)
                end
                return u70:Subscribe(p72:GetFireFailComplete())
            end)
        end
    end,
    ["defaultsTo"] = function(u74) --[[ Name: defaultsTo, Line 366 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        return function(u75) --[[ Line: 367 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u2
                [3] = u74
            --]]
            local v76 = u3.isObservable(u75)
            assert(v76, "Bad observable")
            return u3.new(function(u77) --[[ Line: 370 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u75
                    [3] = u74
                --]]
                local v78 = u2.new()
                local u79 = false
                v78:GiveTask(u75:Subscribe(function(...) --[[ Line: 376 ]]
                    --[[
                    Upvalues:
                        [1] = u79
                        [2] = u77
                    --]]
                    u79 = true
                    u77:Fire(...)
                end, u77:GetFailComplete()))
                if not u79 then
                    u77:Fire(u74)
                end
                return v78
            end)
        end
    end
}
u80.defaultsToNil = u80.defaultsTo(nil)
function u80.endWith(u81) --[[ Line: 416 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return function(u82) --[[ Line: 417 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u81
        --]]
        local v83 = u3.isObservable(u82)
        assert(v83, "Bad observable")
        return u3.new(function(u84) --[[ Line: 420 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u82
                [3] = u81
            --]]
            local v85 = u2.new()
            v85:GiveTask(u82:Subscribe(function(...) --[[ Line: 424 ]]
                --[[
                Upvalues:
                    [1] = u84
                --]]
                u84:Fire(...)
            end, function(...) --[[ Line: 427 ]]
                --[[
                Upvalues:
                    [1] = u81
                    [2] = u84
                --]]
                for _, v86 in pairs(u81) do
                    u84:Fire(v86)
                end
                u84:Fail(...)
            end), function() --[[ Line: 433 ]]
                --[[
                Upvalues:
                    [1] = u81
                    [2] = u84
                --]]
                for _, v87 in pairs(u81) do
                    u84:Fire(v87)
                end
                u84:Complete()
            end)
            return v85
        end)
    end
end
function u80.where(u88) --[[ Line: 460 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v89 = type(u88) == "function"
    assert(v89, "Bad predicate callback")
    return function(u90) --[[ Line: 463 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u88
        --]]
        local v91 = u3.isObservable(u90)
        assert(v91, "Bad observable")
        return u3.new(function(u92) --[[ Line: 466 ]]
            --[[
            Upvalues:
                [1] = u90
                [2] = u88
            --]]
            return u90:Subscribe(function(...) --[[ Line: 468 ]]
                --[[
                Upvalues:
                    [1] = u88
                    [2] = u92
                --]]
                if u88(...) then
                    u92:Fire(...)
                end
            end, u92:GetFailComplete())
        end)
    end
end
function u80.distinct() --[[ Line: 491 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u10
    --]]
    return function(u93) --[[ Line: 492 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u10
        --]]
        local v94 = u3.isObservable(u93)
        assert(v94, "Bad observable")
        return u3.new(function(u95) --[[ Line: 495 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u93
            --]]
            local u96 = u10
            return u93:Subscribe(function(p97) --[[ Line: 499 ]]
                --[[
                Upvalues:
                    [1] = u96
                    [2] = u95
                --]]
                if u96 ~= p97 then
                    u96 = p97
                    u95:Fire(u96)
                end
            end, u95:GetFailComplete())
        end)
    end
end
function u80.mapTo(...) --[[ Line: 519 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u98 = table.pack(...)
    return function(u99) --[[ Line: 521 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u98
        --]]
        local v100 = u3.isObservable(u99)
        assert(v100, "Bad observable")
        return u3.new(function(u101) --[[ Line: 524 ]]
            --[[
            Upvalues:
                [1] = u99
                [2] = u98
            --]]
            return u99:Subscribe(function() --[[ Line: 525 ]]
                --[[
                Upvalues:
                    [1] = u101
                    [2] = u98
                --]]
                local v102 = u101
                local v103 = u98
                local v104 = u98.n
                v102:Fire(table.unpack(v103, 1, v104))
            end, u101:GetFailComplete())
        end)
    end
end
function u80.map(u105) --[[ Line: 548 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v106 = type(u105) == "function"
    assert(v106, "Bad project callback")
    return function(u107) --[[ Line: 551 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u105
        --]]
        local v108 = u3.isObservable(u107)
        assert(v108, "Bad observable")
        return u3.new(function(u109) --[[ Line: 554 ]]
            --[[
            Upvalues:
                [1] = u107
                [2] = u105
            --]]
            return u107:Subscribe(function(...) --[[ Line: 555 ]]
                --[[
                Upvalues:
                    [1] = u109
                    [2] = u105
                --]]
                u109:Fire(u105(...))
            end, u109:GetFailComplete())
        end)
    end
end
function u80.mergeAll() --[[ Line: 579 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return function(u110) --[[ Line: 580 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v111 = u3.isObservable(u110)
        assert(v111, "Bad observable")
        return u3.new(function(u112) --[[ Line: 583 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u110
                [3] = u3
            --]]
            local u113 = u2.new()
            local u114 = 0
            local u115 = false
            u113:GiveTask(u110:Subscribe(function(p116) --[[ Line: 590 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u114
                    [3] = u2
                    [4] = u112
                    [5] = u115
                    [6] = u113
                --]]
                local v117 = u3.isObservable(p116)
                assert(v117, "Not an observable")
                u114 = u114 + 1
                local u118 = u2.new()
                u118:GiveTask(p116:Subscribe(function(...) --[[ Line: 598 ]]
                    --[[
                    Upvalues:
                        [1] = u112
                    --]]
                    u112:Fire(...)
                end, function(...) --[[ Line: 602 ]]
                    --[[
                    Upvalues:
                        [1] = u112
                    --]]
                    u112:Fail(...)
                end, function() --[[ Line: 606 ]]
                    --[[
                    Upvalues:
                        [1] = u118
                        [2] = u114
                        [3] = u115
                        [4] = u112
                        [5] = u113
                    --]]
                    u118:DoCleaning()
                    u114 = u114 - 1
                    if u114 == 0 and u115 then
                        u112:Complete()
                        u113:DoCleaning()
                    end
                end))
                local u119 = u113:GiveTask(u118)
                u118:GiveTask(function() --[[ Line: 618 ]]
                    --[[
                    Upvalues:
                        [1] = u113
                        [2] = u119
                    --]]
                    u113[u119] = nil
                end)
            end, function(...) --[[ Line: 622 ]]
                --[[
                Upvalues:
                    [1] = u112
                    [2] = u113
                --]]
                u112:Fail(...)
                u113:DoCleaning()
            end, function() --[[ Line: 626 ]]
                --[[
                Upvalues:
                    [1] = u115
                    [2] = u114
                    [3] = u112
                    [4] = u113
                --]]
                u115 = true
                if u114 == 0 then
                    u112:Complete()
                    u113:DoCleaning()
                end
            end))
            return u113
        end)
    end
end
function u80.switchAll() --[[ Line: 650 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return function(u120) --[[ Line: 651 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v121 = u3.isObservable(u120)
        assert(v121, "Bad observable")
        return u3.new(function(u122) --[[ Line: 654 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u120
                [3] = u3
            --]]
            local u123 = u2.new()
            local u124 = false
            local u125 = false
            local u126 = nil
            u123:GiveTask(function() --[[ Line: 660 ]]
                --[[
                Upvalues:
                    [1] = u123
                --]]
                u123._innerSub = nil
                u123._outerSuber = nil
            end)
            u123._outerSuber = u120:Subscribe(function(u127) --[[ Line: 669 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u125
                    [3] = u126
                    [4] = u123
                    [5] = u122
                    [6] = u124
                --]]
                local v128 = u3.isObservable(u127)
                assert(v128, "Bad observable")
                u125 = false
                u126 = u127
                u123._innerSub = nil
                u123._innerSub = u127:Subscribe(function(...) --[[ Line: 677 ]]
                    --[[
                    Upvalues:
                        [1] = u122
                    --]]
                    u122:Fire(...)
                end, function(...) --[[ Line: 680 ]]
                    --[[
                    Upvalues:
                        [1] = u126
                        [2] = u127
                        [3] = u122
                    --]]
                    if u126 == u127 then
                        u122:Fail(...)
                    end
                end, function() --[[ Line: 685 ]]
                    --[[
                    Upvalues:
                        [1] = u126
                        [2] = u127
                        [3] = u125
                        [4] = u124
                        [5] = u122
                        [6] = u123
                    --]]
                    if u126 == u127 then
                        u125 = true
                        if u125 and u124 then
                            u122:Complete()
                            u123:DoCleaning()
                        end
                    end
                end)
            end, function(...) --[[ Line: 695 ]]
                --[[
                Upvalues:
                    [1] = u122
                    [2] = u123
                --]]
                u122:Fail(...)
                u123:DoCleaning()
            end, function() --[[ Line: 699 ]]
                --[[
                Upvalues:
                    [1] = u124
                    [2] = u125
                    [3] = u122
                    [4] = u123
                --]]
                u124 = true
                if u125 and u124 then
                    u122:Complete()
                    u123:DoCleaning()
                end
            end)
            return u123
        end)
    end
end
function u80.flatMap(u129, u130) --[[ Line: 721 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v131 = type(u129) == "function"
    assert(v131, "Bad project")
    return function(u132) --[[ Line: 724 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u129
            [4] = u130
        --]]
        local v133 = u3.isObservable(u132)
        assert(v133, "Bad observable")
        return u3.new(function(u134) --[[ Line: 727 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u132
                [3] = u129
                [4] = u3
                [5] = u130
            --]]
            local u135 = u2.new()
            local u136 = 0
            local u137 = false
            u135:GiveTask(u132:Subscribe(function(...) --[[ Line: 734 ]]
                --[[
                Upvalues:
                    [1] = u129
                    [2] = u3
                    [3] = u136
                    [4] = u2
                    [5] = u130
                    [6] = u134
                    [7] = u137
                    [8] = u135
                --]]
                local u138 = ...
                local v139 = u129(...)
                local v140 = u3.isObservable(v139)
                assert(v140, "Bad observable from project")
                u136 = u136 + 1
                local u141 = u2.new()
                u141:GiveTask(v139:Subscribe(function(...) --[[ Line: 745 ]]
                    --[[
                    Upvalues:
                        [1] = u130
                        [2] = u134
                        [3] = u138
                    --]]
                    if u130 then
                        u134:Fire(u130(u138, ...))
                    else
                        u134:Fire(...)
                    end
                end, function(...) --[[ Line: 753 ]]
                    --[[
                    Upvalues:
                        [1] = u134
                    --]]
                    u134:Fail(...)
                end, function() --[[ Line: 756 ]]
                    --[[
                    Upvalues:
                        [1] = u141
                        [2] = u136
                        [3] = u137
                        [4] = u134
                        [5] = u135
                    --]]
                    u141:DoCleaning()
                    u136 = u136 - 1
                    if u136 == 0 and u137 then
                        u134:Complete()
                        u135:DoCleaning()
                    end
                end))
                local u142 = u135:GiveTask(u141)
                u141:GiveTask(function() --[[ Line: 768 ]]
                    --[[
                    Upvalues:
                        [1] = u135
                        [2] = u142
                    --]]
                    u135[u142] = nil
                end)
            end, function(...) --[[ Line: 772 ]]
                --[[
                Upvalues:
                    [1] = u134
                    [2] = u135
                --]]
                u134:Fail(...)
                u135:DoCleaning()
            end, function() --[[ Line: 776 ]]
                --[[
                Upvalues:
                    [1] = u137
                    [2] = u136
                    [3] = u134
                    [4] = u135
                --]]
                u137 = true
                if u136 == 0 then
                    u134:Complete()
                    u135:DoCleaning()
                end
            end))
            return u135
        end)
    end
end
function u80.switchMap(p143) --[[ Line: 789 ]]
    --[[
    Upvalues:
        [1] = u80
    --]]
    return u80.pipe({ u80.map(p143), u80.switchAll() })
end
function u80.takeUntil(u144) --[[ Line: 796 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v145 = u3.isObservable
    assert(v145(u144))
    return function(u146) --[[ Line: 799 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u144
        --]]
        local v147 = u3.isObservable(u146)
        assert(v147, "Bad observable")
        return u3.new(function(p148) --[[ Line: 802 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u144
                [3] = u146
            --]]
            local u149 = u2.new()
            local u150 = false
            local function v151() --[[ Line: 806 ]]
                --[[
                Upvalues:
                    [1] = u149
                    [2] = u150
                --]]
                u149:DoCleaning()
                u150 = true
            end
            u149:GiveTask(u144:Subscribe(v151, v151, nil))
            if u150 then
                u149:DoCleaning()
                return nil
            else
                u149:GiveTask(u146:Subscribe(p148:GetFireFailComplete()))
                return u149
            end
        end)
    end
end
function u80.packed(...) --[[ Line: 842 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u152 = table.pack(...)
    return u3.new(function(p153) --[[ Line: 845 ]]
        --[[
        Upvalues:
            [1] = u152
        --]]
        local v154 = u152
        local v155 = u152.n
        p153:Fire(unpack(v154, 1, v155))
        p153:Complete()
    end)
end
function u80.unpacked(u156) --[[ Line: 856 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v157 = u3.isObservable(u156)
    assert(v157, "Bad observable")
    return u3.new(function(u158) --[[ Line: 859 ]]
        --[[
        Upvalues:
            [1] = u156
        --]]
        return u156:Subscribe(function(p159) --[[ Line: 860 ]]
            --[[
            Upvalues:
                [1] = u158
            --]]
            if type(p159) == "table" then
                u158:Fire(unpack(p159))
            else
                warn(("[Rx.unpacked] - Observable didn\'t return a table got type %q"):format((type(p159))))
            end
        end, u158:GetFailComplete())
    end)
end
function u80.finalize(u160) --[[ Line: 889 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v161 = type(u160) == "function"
    assert(v161, "Bad finalizerCallback")
    return function(u162) --[[ Line: 892 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u160
        --]]
        local v163 = u3.isObservable(u162)
        assert(v163, "Bad observable")
        return u3.new(function(p164) --[[ Line: 895 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u162
                [3] = u160
            --]]
            local v165 = u2.new()
            v165:GiveTask(u162:Subscribe(p164:GetFireFailComplete()))
            v165:GiveTask(u160)
            return v165
        end)
    end
end
function u80.combineLatestAll() --[[ Line: 916 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u80
    --]]
    return function(u166) --[[ Line: 917 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u80
        --]]
        local v167 = u3.isObservable(u166)
        assert(v167, "Bad observable")
        return u3.new(function(u168) --[[ Line: 920 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u166
                [3] = u3
                [4] = u80
            --]]
            local u169 = {}
            local u170 = u2.new()
            local u171 = true
            u170:GiveTask(function() --[[ Line: 925 ]]
                --[[
                Upvalues:
                    [1] = u171
                --]]
                u171 = false
            end)
            u170:GiveTask(u166:Subscribe(function(p172) --[[ Line: 930 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u169
                --]]
                local v173 = u3.isObservable
                assert(v173(p172))
                local v174 = u169
                table.insert(v174, p172)
            end, function(...) --[[ Line: 935 ]]
                --[[
                Upvalues:
                    [1] = u168
                --]]
                u168:Fail(...)
            end), function() --[[ Line: 938 ]]
                --[[
                Upvalues:
                    [1] = u171
                    [2] = u170
                    [3] = u80
                    [4] = u169
                    [5] = u168
                --]]
                if u171 then
                    u170:GiveTask(u80.combineLatest(u169)):Subscribe(u168:GetFireFailComplete())
                end
            end)
            return u170
        end)
    end
end
u80.combineAll = u80.combineLatestAll
function u80.catchError(u175) --[[ Line: 975 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v176 = type(u175) == "function"
    assert(v176, "Bad callback")
    return function(u177) --[[ Line: 978 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u175
        --]]
        local v178 = u3.isObservable(u177)
        assert(v178, "Bad observable")
        return u3.new(function(u179) --[[ Line: 981 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u177
                [3] = u175
                [4] = u3
            --]]
            local u180 = u2.new()
            local u181 = true
            u180:GiveTask(function() --[[ Line: 986 ]]
                --[[
                Upvalues:
                    [1] = u181
                --]]
                u181 = false
            end)
            u180:GiveTask(u177:Subscribe(function(...) --[[ Line: 991 ]]
                --[[
                Upvalues:
                    [1] = u179
                --]]
                u179:Fire(...)
            end, function(...) --[[ Line: 994 ]]
                --[[
                Upvalues:
                    [1] = u181
                    [2] = u175
                    [3] = u3
                    [4] = u180
                    [5] = u179
                --]]
                if u181 then
                    local v182 = u175(...)
                    local v183 = u3.isObservable(v182)
                    assert(v183, "Bad observable")
                    u180:GiveTask(v182:Subscribe(u179:GetFireFailComplete()))
                end
            end, function() --[[ Line: 1008 ]]
                --[[
                Upvalues:
                    [1] = u179
                --]]
                u179:Complete()
            end))
            return u180
        end)
    end
end
function u80.combineLatest(u184) --[[ Line: 1043 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u10
        [3] = u2
        [4] = u6
    --]]
    local v185 = type(u184) == "table"
    assert(v185, "Bad observables")
    return u3.new(function(u186) --[[ Line: 1046 ]]
        --[[
        Upvalues:
            [1] = u184
            [2] = u3
            [3] = u10
            [4] = u2
            [5] = u6
        --]]
        local u187 = 0
        local u188 = {}
        for v189, v190 in pairs(u184) do
            if u3.isObservable(v190) then
                u187 = u187 + 1
                u188[v189] = u10
            else
                u188[v189] = v190
            end
        end
        if u187 ~= 0 then
            local v191 = u2.new()
            for u192, v193 in pairs(u184) do
                if u3.isObservable(v193) then
                    v191:GiveTask(v193:Subscribe(function(p194) --[[ Line: 1080 ]]
                        --[[
                        Upvalues:
                            [1] = u188
                            [2] = u192
                            [3] = u10
                            [4] = u186
                            [5] = u6
                        --]]
                        u188[u192] = p194
                        for _, v195 in pairs(u188) do
                            if v195 == u10 then
                                return
                            end
                        end
                        u186:Fire(u6.copy(u188))
                    end, function(...) --[[ Line: 1084 ]]
                        --[[
                        Upvalues:
                            [1] = u187
                            [2] = u186
                        --]]
                        u187 = u187 - 1
                        u186:Fail(...)
                    end, function() --[[ Line: 1088 ]]
                        --[[
                        Upvalues:
                            [1] = u187
                            [2] = u186
                        --]]
                        u187 = u187 - 1
                        if u187 == 0 then
                            u186:Complete()
                        end
                    end))
                end
            end
            return v191
        end
        u186:Fire(u188)
        u186:Complete()
    end)
end
function u80.using(u196, u197) --[[ Line: 1116 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return u3.new(function(p198) --[[ Line: 1117 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u196
            [3] = u197
            [4] = u3
        --]]
        local v199 = u2.new()
        local v200 = u196()
        v199:GiveTask(v200)
        local v201 = u197(v200)
        local v202 = u3.isObservable(v201)
        assert(v202, "Bad observable")
        v199:GiveTask(v201:Subscribe(p198:GetFireFailComplete()))
        return v199
    end)
end
function u80.first() --[[ Line: 1142 ]]
    --[[
    Upvalues:
        [1] = u80
    --]]
    return u80.take(1)
end
function u80.take(u203) --[[ Line: 1153 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v204 = type(u203) == "number"
    assert(v204, "Bad number")
    local v205 = u203 > 0
    assert(v205, "Bad number")
    return function(u206) --[[ Line: 1157 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u203
        --]]
        local v207 = u3.isObservable(u206)
        assert(v207, "Bad observable")
        return u3.new(function(u208) --[[ Line: 1160 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u206
                [3] = u203
            --]]
            local u209 = 0
            local v210 = u2.new()
            v210:GiveTask(u206:Subscribe(function(...) --[[ Line: 1164 ]]
                --[[
                Upvalues:
                    [1] = u209
                    [2] = u203
                    [3] = u208
                --]]
                if u203 <= u209 then
                    warn("[Rx.take] - Still getting values past subscription")
                else
                    u209 = u209 + 1
                    u208:Fire(...)
                    if u203 <= u209 then
                        u208:Complete()
                    end
                end
            end, u208:GetFailComplete()))
            return v210
        end)
    end
end
function u80.skip(u211) --[[ Line: 1190 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v212 = type(u211) == "number"
    assert(v212, "Bad toSkip")
    local v213 = u211 > 0
    assert(v213, "Bad toSkip")
    return function(u214) --[[ Line: 1194 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u211
        --]]
        local v215 = u3.isObservable(u214)
        assert(v215, "Bad observable")
        return u3.new(function(u216) --[[ Line: 1197 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u214
                [3] = u211
            --]]
            local u217 = 0
            local v218 = u2.new()
            v218:GiveTask(u214:Subscribe(function(...) --[[ Line: 1201 ]]
                --[[
                Upvalues:
                    [1] = u217
                    [2] = u211
                    [3] = u216
                --]]
                if u217 <= u211 then
                    u217 = u217 + 1
                else
                    u216:Fire(...)
                end
            end, u216:GetFailComplete()))
            return v218
        end)
    end
end
function u80.defer(u219) --[[ Line: 1225 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3.new(function(p220) --[[ Line: 1226 ]]
        --[[
        Upvalues:
            [1] = u219
            [2] = u3
        --]]
        local u221 = nil
        local v222, v223 = pcall(function() --[[ Line: 1228 ]]
            --[[
            Upvalues:
                [1] = u221
                [2] = u219
            --]]
            u221 = u219()
        end)
        if v222 then
            if u3.isObservable(u221) then
                return u221:Subscribe(p220:GetFireFailComplete())
            end
            p220:Fail("Not an observable")
        else
            p220:Fail(v223)
        end
    end)
end
function u80.delay(u224) --[[ Line: 1252 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u8
    --]]
    local v225 = type(u224) == "number"
    assert(v225, "Bad seconds")
    return function(u226) --[[ Line: 1255 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u8
            [4] = u224
        --]]
        local v227 = u3.isObservable(u226)
        assert(v227, "Bad observable")
        return u3.new(function(u228) --[[ Line: 1258 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u226
                [3] = u8
                [4] = u224
            --]]
            local u229 = u2.new()
            u229:GiveTask(u226:Subscribe(function(...) --[[ Line: 1261 ]]
                --[[
                Upvalues:
                    [1] = u229
                    [2] = u8
                    [3] = u224
                    [4] = u228
                --]]
                local u230 = table.pack(...)
                u229[u230] = u8(u224, function() --[[ Line: 1264 ]]
                    --[[
                    Upvalues:
                        [1] = u229
                        [2] = u230
                        [3] = u228
                    --]]
                    u229[u230] = nil
                    local v231 = u228
                    local v232 = u230
                    local v233 = u230.n
                    v231:Fire(table.unpack(v232, 1, v233))
                end)
            end, u228:GetFailComplete()))
            return u229
        end)
    end
end
function u80.withLatestFrom(u234) --[[ Line: 1284 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u10
    --]]
    assert(u234, "Bad inputObservables")
    for _, v235 in pairs(u234) do
        local v236 = u3.isObservable(v235)
        assert(v236, "Bad observable")
    end
    return function(u237) --[[ Line: 1291 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u234
            [4] = u10
        --]]
        local v238 = u3.isObservable(u237)
        assert(v238, "Bad observable")
        return u3.new(function(u239) --[[ Line: 1294 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u234
                [3] = u10
                [4] = u237
            --]]
            local v240 = u2.new()
            local u241 = {}
            for u242, v243 in pairs(u234) do
                u241[u242] = u10
                v240:GiveTask(v243:Subscribe(function(p244) --[[ Line: 1302 ]]
                    --[[
                    Upvalues:
                        [1] = u241
                        [2] = u242
                    --]]
                    u241[u242] = p244
                end, nil, nil))
            end
            v240:GiveTask(u237:Subscribe(function(p245) --[[ Line: 1307 ]]
                --[[
                Upvalues:
                    [1] = u241
                    [2] = u10
                    [3] = u239
                --]]
                for _, v246 in pairs(u241) do
                    if v246 == u10 then
                        return
                    end
                end
                local v247 = u239
                local v248 = {}
                local v249 = u241
                __set_list(v248, 1, {p245, unpack(v249)})
                v247:Fire(v248)
            end, u239:GetFailComplete()))
            return v240
        end)
    end
end
function u80.scan(u250, u251) --[[ Line: 1329 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v252 = type(u250) == "function"
    assert(v252, "Bad accumulator")
    return function(u253) --[[ Line: 1332 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u251
            [3] = u250
        --]]
        local v254 = u3.isObservable(u253)
        assert(v254, "Bad observable")
        return u3.new(function(u255) --[[ Line: 1335 ]]
            --[[
            Upvalues:
                [1] = u251
                [2] = u253
                [3] = u250
            --]]
            local u256 = u251
            return u253:Subscribe(function(...) --[[ Line: 1338 ]]
                --[[
                Upvalues:
                    [1] = u256
                    [2] = u250
                    [3] = u255
                --]]
                u256 = u250(u256, ...)
                u255:Fire(u256)
            end, u255:GetFailComplete())
        end)
    end
end
function u80.throttleTime(u257, u258) --[[ Line: 1359 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u7
    --]]
    local v259 = type(u257) == "number"
    assert(v259, "Bad duration")
    local v260 = type(u258) == "table" and true or u258 == nil
    assert(v260, "Bad throttleConfig")
    return function(u261) --[[ Line: 1363 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u7
            [4] = u257
            [5] = u258
        --]]
        local v262 = u3.isObservable(u261)
        assert(v262, "Bad observable")
        return u3.new(function(u263) --[[ Line: 1366 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u7
                [3] = u257
                [4] = u258
                [5] = u261
            --]]
            local v264 = u2.new()
            local u265 = u7.new(u257, function(...) --[[ Line: 1369 ]]
                --[[
                Upvalues:
                    [1] = u263
                --]]
                u263:Fire(...)
            end, u258)
            v264:GiveTask(u265)
            v264:GiveTask(u261:Subscribe(function(...) --[[ Line: 1374 ]]
                --[[
                Upvalues:
                    [1] = u265
                --]]
                u265:Call(...)
            end, u263:GetFailComplete()))
            return v264
        end)
    end
end
function u80.throttleDefer() --[[ Line: 1387 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    return function(u266) --[[ Line: 1388 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v267 = u3.isObservable(u266)
        assert(v267, "Bad observable")
        return u3.new(function(u268) --[[ Line: 1391 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u266
            --]]
            local v269 = u2.new()
            local u270 = nil
            v269:GiveTask(u266:Subscribe(function(...) --[[ Line: 1396 ]]
                --[[
                Upvalues:
                    [1] = u270
                    [2] = u268
                --]]
                if u270 then
                    u270 = table.pack(...)
                else
                    u270 = table.pack(...)
                    task.defer(function() --[[ Line: 1401 ]]
                        --[[
                        Upvalues:
                            [1] = u270
                            [2] = u268
                        --]]
                        local v271 = u270
                        u270 = nil
                        if u268:IsPending() then
                            local v272 = u268
                            local v273 = v271.n
                            v272:Fire(table.unpack(v271, 1, v273))
                        end
                    end)
                end
            end, u268:GetFailComplete()))
            return v269
        end)
    end
end
return u80