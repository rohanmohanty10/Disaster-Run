 

local u1 = {
    ["__mode"] = "k"
}
local function v7(u2, p3) --[[ Line: 28 ]]
    local v4 = {}
    for _, v5 in ipairs(p3) do
        v4[v5] = v5
    end
    return setmetatable(v4, {
        ["__index"] = function(_, p6) --[[ Name: __index, Line 36 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            error(string.format("%s is not in %s!", p6, u2), 2)
        end,
        ["__newindex"] = function() --[[ Name: __newindex, Line 39 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            error(string.format("Creating new members in %s is not allowed!", u2), 2)
        end
    })
end
local u8 = {
    ["Kind"] = v7("Promise.Error.Kind", {
        "ExecutionError",
        "AlreadyCancelled",
        "NotResolvedInTime",
        "TimedOut"
    })
}
u8.__index = u8
function u8.new(p9, p10) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v11 = p9 or {}
    local v12 = {}
    local v13 = v11.error
    v12.error = tostring(v13) or "[This error has no error text.]"
    v12.trace = v11.trace
    v12.context = v11.context
    v12.kind = v11.kind
    v12.parent = p10
    v12.createdTick = os.clock()
    v12.createdTrace = debug.traceback()
    local v14 = u8
    return setmetatable(v12, v14)
end
function u8.is(p15) --[[ Line: 77 ]]
    if type(p15) == "table" then
        local v16 = getmetatable(p15)
        if type(v16) == "table" then
            local v17
            if rawget(p15, "error") == nil then
                v17 = false
            else
                local v18 = rawget(v16, "extend")
                v17 = type(v18) == "function"
            end
            return v17
        end
    end
    return false
end
function u8.isKind(p19, p20) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v21 = p20 ~= nil
    assert(v21, "Argument #2 to Promise.Error.isKind must not be nil")
    local v22 = u8.is(p19)
    if v22 then
        v22 = p19.kind == p20
    end
    return v22
end
function u8.extend(p23, p24) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v25 = p24 or {}
    v25.kind = v25.kind or p23.kind
    return u8.new(v25, p23)
end
function u8.getErrorChain(p26) --[[ Line: 103 ]]
    local v27 = { p26 }
    while v27[#v27].parent do
        local v28 = v27[#v27].parent
        table.insert(v27, v28)
    end
    return v27
end
function u8.__tostring(p29) --[[ Line: 113 ]]
    local v30 = { string.format("-- Promise.Error(%s) --", p29.kind or "?") }
    for _, v31 in ipairs(p29:getErrorChain()) do
        local v32 = table.concat
        local v33 = { v31.trace or v31.error, v31.context }
        table.insert(v30, v32(v33, "\n"))
    end
    return table.concat(v30, "\n")
end
local function u34(...) --[[ Line: 137 ]]
    return select("#", ...), { ... }
end
local function u36(p35, ...) --[[ Line: 144 ]]
    return p35, select("#", ...), { ... }
end
local function u43(u37, p38, ...) --[[ Line: 171 ]]
    --[[
    Upvalues:
        [1] = u36
        [2] = u8
    --]]
    local v39 = u36
    local v40 = xpcall
    local v41 = u37 ~= nil
    assert(v41, "traceback is nil")
    return v39(v40(p38, function(p42) --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u37
        --]]
        if type(p42) == "table" then
            return p42
        else
            return u8.new({
                ["error"] = p42,
                ["kind"] = u8.Kind.ExecutionError,
                ["trace"] = debug.traceback(tostring(p42), 2),
                ["context"] = "Promise created at:\n\n" .. u37
            })
        end
    end, ...))
end
local u44 = {
    ["Error"] = u8,
    ["Status"] = v7("Promise.Status", {
        "Started",
        "Resolved",
        "Rejected",
        "Cancelled"
    }),
    ["_getTime"] = os.clock,
    ["_timeEvent"] = game:GetService("RunService").Heartbeat,
    ["_unhandledRejectionCallbacks"] = {},
    ["prototype"] = {}
}
u44.__index = u44.prototype
function u44._new(p45, u46, p47) --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u1
        [3] = u43
    --]]
    if p47 ~= nil and not u44.is(p47) then
        error("Argument #2 to Promise.new must be a promise or nil", 2)
    end
    local u48 = {
        ["_thread"] = nil,
        ["_source"] = p45,
        ["_status"] = u44.Status.Started,
        ["_values"] = nil,
        ["_valuesLength"] = -1,
        ["_unhandledRejection"] = true,
        ["_queuedResolve"] = {},
        ["_queuedReject"] = {},
        ["_queuedFinally"] = {},
        ["_cancellationHook"] = nil,
        ["_parent"] = p47
    }
    local v49 = u1
    u48._consumers = setmetatable({}, v49)
    if p47 and p47._status == u44.Status.Started then
        p47._consumers[u48] = true
    end
    local v50 = u44
    setmetatable(u48, v50)
    local function u51(...) --[[ Line: 278 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        u48:_resolve(...)
    end
    local function u52(...) --[[ Line: 282 ]]
        --[[
        Upvalues:
            [1] = u48
        --]]
        u48:_reject(...)
    end
    local function u54(p53) --[[ Line: 286 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u44
        --]]
        if p53 then
            if u48._status == u44.Status.Cancelled then
                p53()
            else
                u48._cancellationHook = p53
            end
        end
        return u48._status == u44.Status.Cancelled
    end
    u48._thread = coroutine.create(function() --[[ Line: 298 ]]
        --[[
        Upvalues:
            [1] = u43
            [2] = u48
            [3] = u46
            [4] = u51
            [5] = u52
            [6] = u54
        --]]
        local v55, _, v56 = u43(u48._source, u46, u51, u52, u54)
        if not v55 then
            u52(v56[1])
        end
    end)
    task.spawn(u48._thread)
    return u48
end
function u44.new(p57) --[[ Line: 349 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return u44._new(debug.traceback(nil, 2), p57)
end
function u44.__tostring(p58) --[[ Line: 353 ]]
    return string.format("Promise(%s)", p58._status)
end
function u44.defer(u59) --[[ Line: 375 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u43
    --]]
    local u60 = debug.traceback(nil, 2)
    return u44._new(u60, function(u61, u62, u63) --[[ Line: 378 ]]
        --[[
        Upvalues:
            [1] = u43
            [2] = u60
            [3] = u59
        --]]
        task.defer(function() --[[ Line: 379 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u60
                [3] = u59
                [4] = u61
                [5] = u62
                [6] = u63
            --]]
            local v64, _, v65 = u43(u60, u59, u61, u62, u63)
            if not v64 then
                u62(v65[1])
            end
        end)
    end)
end
u44.async = u44.defer
function u44.resolve(...) --[[ Line: 416 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u44
    --]]
    local u66, u67 = u34(...)
    return u44._new(debug.traceback(nil, 2), function(p68) --[[ Line: 418 ]]
        --[[
        Upvalues:
            [1] = u67
            [2] = u66
        --]]
        local v69 = u67
        local v70 = u66
        p68(unpack(v69, 1, v70))
    end)
end
function u44.reject(...) --[[ Line: 433 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u44
    --]]
    local u71, u72 = u34(...)
    return u44._new(debug.traceback(nil, 2), function(_, p73) --[[ Line: 435 ]]
        --[[
        Upvalues:
            [1] = u72
            [2] = u71
        --]]
        local v74 = u72
        local v75 = u71
        p73(unpack(v74, 1, v75))
    end)
end
function u44._try(p76, u77, ...) --[[ Line: 444 ]]
    --[[
    Upvalues:
        [1] = u34
        [2] = u44
    --]]
    local u78, u79 = u34(...)
    return u44._new(p76, function(p80) --[[ Line: 447 ]]
        --[[
        Upvalues:
            [1] = u77
            [2] = u79
            [3] = u78
        --]]
        local v81 = u79
        local v82 = u78
        p80(u77(unpack(v81, 1, v82)))
    end)
end
function u44.try(p83, ...) --[[ Line: 475 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return u44._try(debug.traceback(nil, 2), p83, ...)
end
function u44._all(p84, u85, u86) --[[ Line: 484 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if type(u85) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
    end
    for v87, v88 in pairs(u85) do
        if not u44.is(v88) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(v87))), 3)
        end
    end
    if #u85 == 0 or u86 == 0 then
        return u44.resolve({})
    else
        return u44._new(p84, function(u89, u90, p91) --[[ Line: 502 ]]
            --[[
            Upvalues:
                [1] = u86
                [2] = u85
            --]]
            local u92 = {}
            local u93 = {}
            local u94 = 0
            local u95 = 0
            local u96 = false
            local function u99(p97, ...) --[[ Line: 520 ]]
                --[[
                Upvalues:
                    [1] = u96
                    [2] = u94
                    [3] = u86
                    [4] = u92
                    [5] = u85
                    [6] = u89
                    [7] = u93
                --]]
                if not u96 then
                    u94 = u94 + 1
                    if u86 == nil then
                        u92[p97] = ...
                    else
                        u92[u94] = ...
                    end
                    if u94 >= (u86 or #u85) then
                        u96 = true
                        u89(u92)
                        for _, v98 in ipairs(u93) do
                            v98:cancel()
                        end
                    end
                end
            end
            p91(function() --[[ Name: cancel, Line 513 ]]
                --[[
                Upvalues:
                    [1] = u93
                --]]
                for _, v100 in ipairs(u93) do
                    v100:cancel()
                end
            end)
            local u101 = u96
            for u102, v103 in ipairs(u85) do
                u93[u102] = v103:andThen(function(...) --[[ Line: 545 ]]
                    --[[
                    Upvalues:
                        [1] = u99
                        [2] = u102
                    --]]
                    u99(u102, ...)
                end, function(...) --[[ Line: 547 ]]
                    --[[
                    Upvalues:
                        [1] = u95
                        [2] = u86
                        [3] = u85
                        [4] = u93
                        [5] = u101
                        [6] = u90
                    --]]
                    u95 = u95 + 1
                    if u86 == nil or #u85 - u95 < u86 then
                        for _, v104 in ipairs(u93) do
                            v104:cancel()
                        end
                        u101 = true
                        u90(...)
                    end
                end)
            end
            if u101 then
                for _, v105 in ipairs(u93) do
                    v105:cancel()
                end
            end
        end)
    end
end
function u44.all(p106) --[[ Line: 589 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return u44._all(debug.traceback(nil, 2), p106)
end
function u44.fold(p107, u108, p109) --[[ Line: 618 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v110 = type(p107) == "table"
    assert(v110, "Bad argument #1 to Promise.fold: must be a table")
    local v111
    if type(u108) == "function" then
        v111 = true
    elseif type(u108) == "table" then
        local v112 = getmetatable(u108)
        if v112 then
            local v113 = rawget(v112, "__call")
            v111 = type(v113) == "function"
        else
            v111 = false
        end
    else
        v111 = false
    end
    assert(v111, "Bad argument #2 to Promise.fold: must be a function")
    local u114 = u44.resolve(p109)
    return u44.each(p107, function(u115, u116) --[[ Line: 623 ]]
        --[[
        Upvalues:
            [1] = u114
            [2] = u108
        --]]
        u114 = u114:andThen(function(p117) --[[ Line: 624 ]]
            --[[
            Upvalues:
                [1] = u108
                [2] = u115
                [3] = u116
            --]]
            return u108(p117, u115, u116)
        end)
    end):andThen(function() --[[ Line: 627 ]]
        --[[
        Upvalues:
            [1] = u114
        --]]
        return u114
    end)
end
function u44.some(p118, p119) --[[ Line: 651 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v120 = type(p119) == "number"
    assert(v120, "Bad argument #2 to Promise.some: must be a number")
    return u44._all(debug.traceback(nil, 2), p118, p119)
end
function u44.any(p121) --[[ Line: 675 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return u44._all(debug.traceback(nil, 2), p121, 1):andThen(function(p122) --[[ Line: 676 ]]
        return p122[1]
    end)
end
function u44.allSettled(u123) --[[ Line: 697 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if type(u123) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
    end
    for v124, v125 in pairs(u123) do
        if not u44.is(v125) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(v124))), 2)
        end
    end
    if #u123 == 0 then
        return u44.resolve({})
    else
        return u44._new(debug.traceback(nil, 2), function(u126, _, p127) --[[ Line: 715 ]]
            --[[
            Upvalues:
                [1] = u123
            --]]
            local u128 = {}
            local u129 = {}
            local u130 = 0
            local function u132(p131, ...) --[[ Line: 725 ]]
                --[[
                Upvalues:
                    [1] = u130
                    [2] = u128
                    [3] = u123
                    [4] = u126
                --]]
                u130 = u130 + 1
                u128[p131] = ...
                if u130 >= #u123 then
                    u126(u128)
                end
            end
            p127(function() --[[ Line: 735 ]]
                --[[
                Upvalues:
                    [1] = u129
                --]]
                for _, v133 in ipairs(u129) do
                    v133:cancel()
                end
            end)
            for u134, v135 in ipairs(u123) do
                u129[u134] = v135:finally(function(...) --[[ Line: 744 ]]
                    --[[
                    Upvalues:
                        [1] = u132
                        [2] = u134
                    --]]
                    u132(u134, ...)
                end)
            end
        end)
    end
end
function u44.race(u136) --[[ Line: 775 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v137 = type(u136) == "table"
    local v138 = string.format
    assert(v137, v138("Please pass a list of promises to %s", "Promise.race"))
    for v139, v140 in pairs(u136) do
        local v141 = u44.is(v140)
        local v142 = string.format
        local v143 = tostring(v139)
        assert(v141, v142("Non-promise value passed into %s at index %s", "Promise.race", v143))
    end
    return u44._new(debug.traceback(nil, 2), function(u144, u145, p146) --[[ Line: 782 ]]
        --[[
        Upvalues:
            [1] = u136
        --]]
        local u147 = {}
        local u148 = false
        if not p146(function(...) --[[ Line: 793 ]]
            --[[
            Upvalues:
                [1] = u147
                [2] = u148
                [3] = u145
            --]]
            for _, v149 in ipairs(u147) do
                v149:cancel()
            end
            u148 = true
            return u145(...)
        end) then
            local u150 = u148
            for v151, v152 in ipairs(u136) do
                u147[v151] = v152:andThen(function(...) --[[ Line: 793 ]]
                    --[[
                    Upvalues:
                        [1] = u147
                        [2] = u150
                        [3] = u144
                    --]]
                    for _, v153 in ipairs(u147) do
                        v153:cancel()
                    end
                    u150 = true
                    return u144(...)
                end, function(...) --[[ Line: 793 ]]
                    --[[
                    Upvalues:
                        [1] = u147
                        [2] = u150
                        [3] = u145
                    --]]
                    for _, v154 in ipairs(u147) do
                        v154:cancel()
                    end
                    u150 = true
                    return u145(...)
                end)
            end
            if u150 then
                for _, v155 in ipairs(u147) do
                    v155:cancel()
                end
            end
        end
    end)
end
function u44.each(u156, u157) --[[ Line: 870 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u8
    --]]
    local v158 = type(u156) == "table"
    local v159 = string.format
    assert(v158, v159("Please pass a list of promises to %s", "Promise.each"))
    local v160
    if type(u157) == "function" then
        v160 = true
    elseif type(u157) == "table" then
        local v161 = getmetatable(u157)
        if v161 then
            local v162 = rawget(v161, "__call")
            v160 = type(v162) == "function"
        else
            v160 = false
        end
    else
        v160 = false
    end
    local v163 = string.format
    assert(v160, v163("Please pass a handler function to %s!", "Promise.each"))
    return u44._new(debug.traceback(nil, 2), function(p164, p165, p166) --[[ Line: 874 ]]
        --[[
        Upvalues:
            [1] = u156
            [2] = u44
            [3] = u8
            [4] = u157
        --]]
        local v167 = {}
        local u168 = {}
        local u169 = false
        p166(function() --[[ Line: 886 ]]
            --[[
            Upvalues:
                [1] = u169
                [2] = u168
            --]]
            u169 = true
            for _, v170 in ipairs(u168) do
                v170:cancel()
            end
        end)
        local v171 = u169
        local v172 = {}
        for v173, v174 in ipairs(u156) do
            if u44.is(v174) then
                if v174:getStatus() == u44.Status.Cancelled then
                    for _, v175 in ipairs(u168) do
                        v175:cancel()
                    end
                    return p165(u8.new({
                        ["error"] = "Promise is cancelled",
                        ["kind"] = u8.Kind.AlreadyCancelled,
                        ["context"] = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", v173, v174._source)
                    }))
                end
                if v174:getStatus() == u44.Status.Rejected then
                    for _, v176 in ipairs(u168) do
                        v176:cancel()
                    end
                    return p165(select(2, v174:await()))
                end
                local v177 = v174:andThen(function(...) --[[ Line: 919 ]]
                    return ...
                end)
                table.insert(u168, v177)
                v172[v173] = v177
            else
                v172[v173] = v174
            end
        end
        for v178, v181 in ipairs(v172) do
            if u44.is(v181) then
                local v180, v181 = v181:await()
                if not v180 then
                    for _, v182 in ipairs(u168) do
                        v182:cancel()
                    end
                    return p165(v181)
                end
            end
            if v171 then
                return
            end
            local v183 = u44.resolve(u157(v181, v178))
            table.insert(u168, v183)
            local v184, v185 = v183:await()
            if not v184 then
                for _, v186 in ipairs(u168) do
                    v186:cancel()
                end
                return p165(v185)
            end
            v167[v178] = v185
        end
        p164(v167)
    end)
end
function u44.is(p187) --[[ Line: 969 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if type(p187) ~= "table" then
        return false
    end
    local v188 = getmetatable(p187)
    if v188 == u44 then
        return true
    end
    if v188 ~= nil then
        if type(v188) == "table" then
            local v189 = rawget(v188, "__index")
            if type(v189) == "table" then
                local v190 = rawget(v188, "__index")
                local v191 = rawget(v190, "andThen")
                local v192
                if type(v191) == "function" then
                    v192 = true
                else
                    local v193 = type(v191) == "table" and getmetatable(v191)
                    if v193 then
                        local v194 = rawget(v193, "__call")
                        v192 = type(v194) == "function"
                    else
                        v192 = false
                    end
                end
                if v192 then
                    return true
                end
            end
        end
        return false
    end
    local v195 = p187.andThen
    if type(v195) == "function" then
        return true
    end
    local v196 = type(v195) == "table" and getmetatable(v195)
    if v196 then
        local v197 = rawget(v196, "__call")
        if type(v197) == "function" then
            return true
        end
    end
    return false
end
function u44.promisify(u198) --[[ Line: 1018 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return function(...) --[[ Line: 1019 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u198
        --]]
        return u44._try(debug.traceback(nil, 2), u198, ...)
    end
end
function u44.delay(u199) --[[ Line: 1042 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v200 = type(u199) == "number"
    assert(v200, "Bad argument #1 to Promise.delay, must be a number.")
    local u201 = u44._getTime()
    return u44._new(debug.traceback(nil, 2), function(u202) --[[ Line: 1045 ]]
        --[[
        Upvalues:
            [1] = u199
            [2] = u44
            [3] = u201
        --]]
        task.delay(u199, function() --[[ Line: 1046 ]]
            --[[
            Upvalues:
                [1] = u202
                [2] = u44
                [3] = u201
            --]]
            u202(u44._getTime() - u201)
        end)
    end)
end
local function v207(p203, u204, u205) --[[ Line: 1090 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u8
    --]]
    local u206 = debug.traceback(nil, 2)
    return u44.race({ u44.delay(u204):andThen(function() --[[ Line: 1094 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u205
                [3] = u8
                [4] = u204
                [5] = u206
            --]]
            return u44.reject(u205 == nil and u8.new({
                ["kind"] = u8.Kind.TimedOut,
                ["error"] = "Timed out",
                ["context"] = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u204, u206)
            }) or u205)
        end), p203 })
end
u44.prototype.timeout = v207
function u44.prototype.getStatus(p208) --[[ Line: 1114 ]]
    return p208._status
end
function u44.prototype._andThen(u209, u210, u211, u212) --[[ Line: 1123 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u43
    --]]
    u209._unhandledRejection = false
    if u209._status ~= u44.Status.Cancelled then
        return u44._new(u210, function(u213, u214, p215) --[[ Line: 1135 ]]
            --[[
            Upvalues:
                [1] = u211
                [2] = u210
                [3] = u43
                [4] = u212
                [5] = u209
                [6] = u44
            --]]
            local u216
            if u211 then
                local u217 = u210
                local u218 = u211
                u216 = function(...) --[[ Line: 180 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u217
                        [3] = u218
                        [4] = u213
                        [5] = u214
                    --]]
                    local v219, v220, v221 = u43(u217, u218, ...)
                    if v219 then
                        u213(unpack(v221, 1, v220))
                    else
                        u214(v221[1])
                    end
                end
            else
                u216 = u213
            end
            if u212 then
                local u222 = u210
                local u223 = u212
                u214 = function(...) --[[ Line: 180 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u222
                        [3] = u223
                        [4] = u213
                        [5] = u214
                    --]]
                    local v224, v225, v226 = u43(u222, u223, ...)
                    if v224 then
                        u213(unpack(v226, 1, v225))
                    else
                        u214(v226[1])
                    end
                end
            end
            if u209._status == u44.Status.Started then
                local v227 = u209._queuedResolve
                table.insert(v227, u216)
                local v228 = u209._queuedReject
                table.insert(v228, u214)
                p215(function() --[[ Line: 1154 ]]
                    --[[
                    Upvalues:
                        [1] = u209
                        [2] = u44
                        [3] = u216
                        [4] = u214
                    --]]
                    if u209._status == u44.Status.Started then
                        table.remove(u209._queuedResolve, table.find(u209._queuedResolve, u216))
                        table.remove(u209._queuedReject, table.find(u209._queuedReject, u214))
                    end
                end)
            elseif u209._status == u44.Status.Resolved then
                local v229 = u209._values
                local v230 = u209._valuesLength
                u216(unpack(v229, 1, v230))
            elseif u209._status == u44.Status.Rejected then
                local v231 = u209._values
                local v232 = u209._valuesLength
                u214(unpack(v231, 1, v232))
            end
        end, u209)
    end
    local v233 = u44.new(function() --[[ Line: 1128 ]] end)
    v233:cancel()
    return v233
end
function u44.prototype.andThen(p234, p235, p236) --[[ Line: 1193 ]]
    local v237
    if p235 == nil or type(p235) == "function" then
        v237 = true
    elseif type(p235) == "table" then
        local v238 = getmetatable(p235)
        if v238 then
            local v239 = rawget(v238, "__call")
            v237 = type(v239) == "function"
        else
            v237 = false
        end
    else
        v237 = false
    end
    local v240 = string.format
    assert(v237, v240("Please pass a handler function to %s!", "Promise:andThen"))
    local v241
    if p236 == nil or type(p236) == "function" then
        v241 = true
    elseif type(p236) == "table" then
        local v242 = getmetatable(p236)
        if v242 then
            local v243 = rawget(v242, "__call")
            v241 = type(v243) == "function"
        else
            v241 = false
        end
    else
        v241 = false
    end
    local v244 = string.format
    assert(v241, v244("Please pass a handler function to %s!", "Promise:andThen"))
    return p234:_andThen(debug.traceback(nil, 2), p235, p236)
end
function u44.prototype.catch(p245, p246) --[[ Line: 1220 ]]
    local v247
    if p246 == nil or type(p246) == "function" then
        v247 = true
    elseif type(p246) == "table" then
        local v248 = getmetatable(p246)
        if v248 then
            local v249 = rawget(v248, "__call")
            v247 = type(v249) == "function"
        else
            v247 = false
        end
    else
        v247 = false
    end
    local v250 = string.format
    assert(v247, v250("Please pass a handler function to %s!", "Promise:catch"))
    return p245:_andThen(debug.traceback(nil, 2), nil, p246)
end
function u44.prototype.tap(p251, u252) --[[ Line: 1241 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u34
    --]]
    local v253
    if type(u252) == "function" then
        v253 = true
    elseif type(u252) == "table" then
        local v254 = getmetatable(u252)
        if v254 then
            local v255 = rawget(v254, "__call")
            v253 = type(v255) == "function"
        else
            v253 = false
        end
    else
        v253 = false
    end
    local v256 = string.format
    assert(v253, v256("Please pass a handler function to %s!", "Promise:tap"))
    return p251:_andThen(debug.traceback(nil, 2), function(...) --[[ Line: 1243 ]]
        --[[
        Upvalues:
            [1] = u252
            [2] = u44
            [3] = u34
        --]]
        local v257 = u252(...)
        if not u44.is(v257) then
            return ...
        end
        local u258, u259 = u34(...)
        return v257:andThen(function() --[[ Line: 1248 ]]
            --[[
            Upvalues:
                [1] = u259
                [2] = u258
            --]]
            local v260 = u259
            local v261 = u258
            return unpack(v260, 1, v261)
        end)
    end)
end
function u44.prototype.andThenCall(p262, u263, ...) --[[ Line: 1276 ]]
    --[[
    Upvalues:
        [1] = u34
    --]]
    local v264
    if type(u263) == "function" then
        v264 = true
    elseif type(u263) == "table" then
        local v265 = getmetatable(u263)
        if v265 then
            local v266 = rawget(v265, "__call")
            v264 = type(v266) == "function"
        else
            v264 = false
        end
    else
        v264 = false
    end
    local v267 = string.format
    assert(v264, v267("Please pass a handler function to %s!", "Promise:andThenCall"))
    local u268, u269 = u34(...)
    return p262:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1279 ]]
        --[[
        Upvalues:
            [1] = u263
            [2] = u269
            [3] = u268
        --]]
        local v270 = u269
        local v271 = u268
        return u263(unpack(v270, 1, v271))
    end)
end
function u44.prototype.andThenReturn(p272, ...) --[[ Line: 1306 ]]
    --[[
    Upvalues:
        [1] = u34
    --]]
    local u273, u274 = u34(...)
    return p272:_andThen(debug.traceback(nil, 2), function() --[[ Line: 1308 ]]
        --[[
        Upvalues:
            [1] = u274
            [2] = u273
        --]]
        local v275 = u274
        local v276 = u273
        return unpack(v275, 1, v276)
    end)
end
function u44.prototype.cancel(p277) --[[ Line: 1324 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if p277._status == u44.Status.Started then
        p277._status = u44.Status.Cancelled
        if p277._cancellationHook then
            p277._cancellationHook()
        end
        coroutine.close(p277._thread)
        if p277._parent then
            p277._parent:_consumerCancelled(p277)
        end
        for v278 in pairs(p277._consumers) do
            v278:cancel()
        end
        p277:_finalize()
    end
end
function u44.prototype._consumerCancelled(p279, p280) --[[ Line: 1352 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if p279._status == u44.Status.Started then
        p279._consumers[p280] = nil
        if next(p279._consumers) == nil then
            p279:cancel()
        end
    end
end
function u44.prototype._finally(u281, u282, u283) --[[ Line: 1368 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u43
    --]]
    u281._unhandledRejection = false
    return u44._new(u282, function(u284, u285, p286) --[[ Line: 1371 ]]
        --[[
        Upvalues:
            [1] = u281
            [2] = u283
            [3] = u43
            [4] = u282
            [5] = u44
        --]]
        local u287 = nil
        p286(function() --[[ Line: 1374 ]]
            --[[
            Upvalues:
                [1] = u281
                [2] = u287
            --]]
            u281:_consumerCancelled(u281)
            if u287 then
                u287:cancel()
            end
        end)
        local v292 = u283 and function(...) --[[ Line: 1387 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u282
                [3] = u283
                [4] = u285
                [5] = u44
                [6] = u287
                [7] = u284
                [8] = u281
            --]]
            local v288, _, v289 = u43(u282, u283, ...)
            local v290 = v289[1]
            if v288 then
                if u44.is(v290) then
                    u287 = v290
                    v290:finally(function(p291) --[[ Line: 1398 ]]
                        --[[
                        Upvalues:
                            [1] = u44
                            [2] = u284
                            [3] = u281
                        --]]
                        if p291 ~= u44.Status.Rejected then
                            u284(u281)
                        end
                    end):catch(function(...) --[[ Line: 1403 ]]
                        --[[
                        Upvalues:
                            [1] = u285
                        --]]
                        u285(...)
                    end)
                else
                    u284(u281)
                end
            else
                return u285(v290)
            end
        end or u284
        if u281._status == u44.Status.Started then
            local v293 = u281._queuedFinally
            table.insert(v293, v292)
        else
            v292(u281._status)
        end
    end)
end
function u44.prototype.finally(p294, p295) --[[ Line: 1473 ]]
    local v296
    if p295 == nil or type(p295) == "function" then
        v296 = true
    elseif type(p295) == "table" then
        local v297 = getmetatable(p295)
        if v297 then
            local v298 = rawget(v297, "__call")
            v296 = type(v298) == "function"
        else
            v296 = false
        end
    else
        v296 = false
    end
    local v299 = string.format
    assert(v296, v299("Please pass a handler function to %s!", "Promise:finally"))
    return p294:_finally(debug.traceback(nil, 2), p295)
end
function u44.prototype.finallyCall(p300, u301, ...) --[[ Line: 1487 ]]
    --[[
    Upvalues:
        [1] = u34
    --]]
    local v302
    if type(u301) == "function" then
        v302 = true
    elseif type(u301) == "table" then
        local v303 = getmetatable(u301)
        if v303 then
            local v304 = rawget(v303, "__call")
            v302 = type(v304) == "function"
        else
            v302 = false
        end
    else
        v302 = false
    end
    local v305 = string.format
    assert(v302, v305("Please pass a handler function to %s!", "Promise:finallyCall"))
    local u306, u307 = u34(...)
    return p300:_finally(debug.traceback(nil, 2), function() --[[ Line: 1490 ]]
        --[[
        Upvalues:
            [1] = u301
            [2] = u307
            [3] = u306
        --]]
        local v308 = u307
        local v309 = u306
        return u301(unpack(v308, 1, v309))
    end)
end
function u44.prototype.finallyReturn(p310, ...) --[[ Line: 1513 ]]
    --[[
    Upvalues:
        [1] = u34
    --]]
    local u311, u312 = u34(...)
    return p310:_finally(debug.traceback(nil, 2), function() --[[ Line: 1515 ]]
        --[[
        Upvalues:
            [1] = u312
            [2] = u311
        --]]
        local v313 = u312
        local v314 = u311
        return unpack(v313, 1, v314)
    end)
end
function u44.prototype.awaitStatus(p315) --[[ Line: 1527 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    p315._unhandledRejection = false
    if p315._status == u44.Status.Started then
        local u316 = coroutine.running()
        p315:finally(function() --[[ Line: 1534 ]]
            --[[
            Upvalues:
                [1] = u316
            --]]
            task.spawn(u316)
        end):catch(function() --[[ Line: 1540 ]] end)
        coroutine.yield()
    end
    if p315._status == u44.Status.Resolved then
        local v317 = p315._status
        local v318 = p315._values
        local v319 = p315._valuesLength
        return v317, unpack(v318, 1, v319)
    end
    if p315._status ~= u44.Status.Rejected then
        return p315._status
    end
    local v320 = p315._status
    local v321 = p315._values
    local v322 = p315._valuesLength
    return v320, unpack(v321, 1, v322)
end
local function u324(p323, ...) --[[ Line: 1555 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    return p323 == u44.Status.Resolved, ...
end
function u44.prototype.await(p325) --[[ Line: 1580 ]]
    --[[
    Upvalues:
        [1] = u324
    --]]
    return u324(p325:awaitStatus())
end
local function u327(p326, ...) --[[ Line: 1584 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if p326 ~= u44.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3)
    end
    return ...
end
function u44.prototype.expect(p328) --[[ Line: 1617 ]]
    --[[
    Upvalues:
        [1] = u327
    --]]
    return u327(p328:awaitStatus())
end
u44.prototype.awaitValue = u44.prototype.expect
function u44.prototype._unwrap(p329) --[[ Line: 1631 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    if p329._status == u44.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end
    local v330 = p329._status == u44.Status.Resolved
    local v331 = p329._values
    local v332 = p329._valuesLength
    return v330, unpack(v331, 1, v332)
end
local function v341(u333, ...) --[[ Line: 1641 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u8
        [3] = u34
    --]]
    if u333._status == u44.Status.Started then
        if u44.is((...)) then
            if select("#", ...) > 1 then
                local v334 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u333._source)
                warn(v334)
            end
            local u335 = ...
            local v337 = u335:andThen(function(...) --[[ Line: 1662 ]]
                --[[
                Upvalues:
                    [1] = u333
                --]]
                u333:_resolve(...)
            end, function(...) --[[ Line: 1664 ]]
                --[[
                Upvalues:
                    [1] = u335
                    [2] = u8
                    [3] = u333
                --]]
                local v336 = u335._values[1]
                if u335._error then
                    v336 = u8.new({
                        ["error"] = u335._error,
                        ["kind"] = u8.Kind.ExecutionError,
                        ["context"] = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
                    })
                end
                if u8.isKind(v336, u8.Kind.ExecutionError) then
                    return u333:_reject(v336:extend({
                        ["error"] = "This Promise was chained to a Promise that errored.",
                        ["trace"] = "",
                        ["context"] = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u333._source)
                    }))
                end
                u333:_reject(...)
            end)
            if v337._status == u44.Status.Cancelled then
                u333:cancel()
            elseif v337._status == u44.Status.Started then
                u333._parent = v337
                v337._consumers[u333] = true
            end
        else
            u333._status = u44.Status.Resolved
            local v338, v339 = u34(...)
            u333._valuesLength = v338
            u333._values = v339
            for _, v340 in ipairs(u333._queuedResolve) do
                coroutine.wrap(v340)(...)
            end
            u333:_finalize()
            return
        end
    else
        if u44.is((...)) then
            (...):_consumerCancelled(u333)
        end
        return
    end
end
u44.prototype._resolve = v341
function u44.prototype._reject(u342, ...) --[[ Line: 1712 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u34
    --]]
    if u342._status == u44.Status.Started then
        u342._status = u44.Status.Rejected
        local v343, v344 = u34(...)
        u342._valuesLength = v343
        u342._values = v344
        local v345 = u342._queuedReject
        if next(v345) == nil then
            local u346 = tostring((...))
            coroutine.wrap(function() --[[ Line: 1734 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u342
                    [3] = u346
                --]]
                u44._timeEvent:Wait()
                if u342._unhandledRejection then
                    local v347 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u346, u342._source)
                    for _, v348 in ipairs(u44._unhandledRejectionCallbacks) do
                        local v349 = task.spawn
                        local v350 = u342
                        local v351 = u342._values
                        local v352 = u342._valuesLength
                        v349(v348, v350, unpack(v351, 1, v352))
                    end
                    if not u44.TEST then
                        warn(v347)
                    end
                else
                    return
                end
            end)()
        else
            for _, v353 in ipairs(u342._queuedReject) do
                coroutine.wrap(v353)(...)
            end
        end
        u342:_finalize()
    end
end
function u44.prototype._finalize(p354) --[[ Line: 1766 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    for _, v355 in ipairs(p354._queuedFinally) do
        coroutine.wrap(v355)(p354._status)
    end
    p354._queuedFinally = nil
    p354._queuedReject = nil
    p354._queuedResolve = nil
    if not u44.TEST then
        p354._parent = nil
        p354._consumers = nil
    end
    task.defer(coroutine.close, p354._thread)
end
local function v360(p356, p357) --[[ Line: 1803 ]]
    --[[
    Upvalues:
        [1] = u44
        [2] = u8
    --]]
    local v358 = debug.traceback(nil, 2)
    if p356._status == u44.Status.Resolved then
        return p356:_andThen(v358, function(...) --[[ Line: 1806 ]]
            return ...
        end)
    end
    local v359 = u44.reject
    if p357 == nil then
        p357 = u8.new({
            ["kind"] = u8.Kind.NotResolvedInTime,
            ["error"] = "This Promise was not resolved in time for :now()",
            ["context"] = ":now() was called at:\n\n" .. v358
        }) or p357
    end
    return v359(p357)
end
u44.prototype.now = v360
function u44.retry(u361, u362, ...) --[[ Line: 1848 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v363
    if type(u361) == "function" then
        v363 = true
    elseif type(u361) == "table" then
        local v364 = getmetatable(u361)
        if v364 then
            local v365 = rawget(v364, "__call")
            v363 = type(v365) == "function"
        else
            v363 = false
        end
    else
        v363 = false
    end
    assert(v363, "Parameter #1 to Promise.retry must be a function")
    local v366 = type(u362) == "number"
    assert(v366, "Parameter #2 to Promise.retry must be a number")
    local u367 = { ... }
    local u368 = select("#", ...)
    return u44.resolve(u361(...)):catch(function(...) --[[ Line: 1854 ]]
        --[[
        Upvalues:
            [1] = u362
            [2] = u44
            [3] = u361
            [4] = u367
            [5] = u368
        --]]
        if u362 <= 0 then
            return u44.reject(...)
        end
        local v369 = u367
        local v370 = u368
        return u44.retry(u361, u362 - 1, unpack(v369, 1, v370))
    end)
end
function u44.retryWithDelay(u371, u372, u373, ...) --[[ Line: 1876 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v374
    if type(u371) == "function" then
        v374 = true
    elseif type(u371) == "table" then
        local v375 = getmetatable(u371)
        if v375 then
            local v376 = rawget(v375, "__call")
            v374 = type(v376) == "function"
        else
            v374 = false
        end
    else
        v374 = false
    end
    assert(v374, "Parameter #1 to Promise.retry must be a function")
    local v377 = type(u372) == "number"
    assert(v377, "Parameter #2 (times) to Promise.retry must be a number")
    local v378 = type(u373) == "number"
    assert(v378, "Parameter #3 (seconds) to Promise.retry must be a number")
    local u379 = { ... }
    local u380 = select("#", ...)
    return u44.resolve(u371(...)):catch(function(...) --[[ Line: 1883 ]]
        --[[
        Upvalues:
            [1] = u372
            [2] = u44
            [3] = u373
            [4] = u371
            [5] = u379
            [6] = u380
        --]]
        if u372 <= 0 then
            return u44.reject(...)
        end
        u44.delay(u373):await()
        local v381 = u379
        local v382 = u380
        return u44.retryWithDelay(u371, u372 - 1, u373, unpack(v381, 1, v382))
    end)
end
function u44.fromEvent(u383, p384) --[[ Line: 1918 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local u385 = p384 or function() --[[ Line: 1919 ]]
        return true
    end
    return u44._new(debug.traceback(nil, 2), function(u386, _, p387) --[[ Line: 1923 ]]
        --[[
        Upvalues:
            [1] = u383
            [2] = u385
        --]]
        local u388 = nil
        local u389 = false
        local function v390() --[[ Line: 1927 ]]
            --[[
            Upvalues:
                [1] = u388
            --]]
            u388:Disconnect()
            u388 = nil
        end
        u388 = u383:Connect(function(...) --[[ Line: 1936 ]]
            --[[
            Upvalues:
                [1] = u385
                [2] = u386
                [3] = u388
                [4] = u389
            --]]
            local v391 = u385(...)
            if v391 == true then
                u386(...)
                if u388 then
                    u388:Disconnect()
                    u388 = nil
                else
                    u389 = true
                end
            else
                if type(v391) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean")
                end
                return
            end
        end)
        if u389 and u388 then
            return v390()
        end
        p387(v390)
    end)
end
function u44.onUnhandledRejection(u392) --[[ Line: 1970 ]]
    --[[
    Upvalues:
        [1] = u44
    --]]
    local v393 = u44._unhandledRejectionCallbacks
    table.insert(v393, u392)
    return function() --[[ Line: 1973 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u392
        --]]
        local v394 = table.find(u44._unhandledRejectionCallbacks, u392)
        if v394 then
            table.remove(u44._unhandledRejectionCallbacks, v394)
        end
    end
end
return u44