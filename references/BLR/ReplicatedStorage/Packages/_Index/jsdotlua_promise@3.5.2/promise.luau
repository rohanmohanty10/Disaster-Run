  

local u1 = {
    __mode = "k"
};

local function isCallable(p2) -- Line: 10
    if type(p2) == "function" then
        return true;
    end;

    local v3 = type(p2) == "table" and getmetatable(p2);

    if v3 then
        local v4 = rawget(v3, "__call");

        if type(v4) == "function" then
            return true;
        end;
    end;

    return false;
end;

local function makeEnum(u5, p6) -- Line: 28
    local v7 = {};

    for _, v in ipairs(p6) do
        v7[v] = v;
    end;

    return setmetatable(v7, {
        __index = function(p8, p9) -- Line: 36, Name: __index
            -- upvalues: u5 (copy)
            error(string.format("%s is not in %s!", p9, u5), 2);
        end,

        __newindex = function() -- Line: 39, Name: __newindex
            -- upvalues: u5 (copy)
            error(string.format("Creating new members in %s is not allowed!", u5), 2);
        end
    });
end;

local u10 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 64
    -- upvalues: u10 (ref)
    local v13 = p11 or {};
    local v14 = {
        error = tostring(v13.error) or "[This error has no error text.]",
        trace = v13.trace,
        context = v13.context,
        kind = v13.kind,
        parent = p12,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v14, u10);
end;

function u10.is(p15) -- Line: 77
    if type(p15) == "table" then
        local v16 = getmetatable(p15);

        if type(v16) == "table" then
            local v17;

            if rawget(p15, "error") == nil then
                v17 = false;
            else
                local v18 = rawget(v16, "extend");
                v17 = type(v18) == "function";
            end;

            return v17;
        end;
    end;

    return false;
end;

function u10.isKind(p19, p20) -- Line: 89
    -- upvalues: u10 (ref)
    assert(p20 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v21 = u10.is(p19) and p19.kind == p20;

    return v21;
end;

function u10.extend(p22, p23) -- Line: 95
    -- upvalues: u10 (ref)
    local v24 = p23 or {};
    v24.kind = v24.kind or p22.kind;

    return u10.new(v24, p22);
end;

function u10.getErrorChain(p25) -- Line: 103
    local v26 = { p25 };

    while v26[#v26].parent do
        table.insert(v26, v26[#v26].parent);
    end;

    return v26;
end;

function u10.__tostring(p27) -- Line: 113
    local v28 = { string.format("-- Promise.Error(%s) --", p27.kind or "?") };

    for _, v in ipairs(p27:getErrorChain()) do
        table.insert(v28, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v28, "\n");
end;

local function pack(...) -- Line: 137
    return select("#", ...), { ... };
end;

local function packResult(p29, ...) -- Line: 144
    return p29, select("#", ...), { ... };
end;

local function makeErrorHandler(u30) -- Line: 148
    -- upvalues: u10 (ref)
    assert(u30 ~= nil, "traceback is nil");

    return function(p31) -- Line: 151
        -- upvalues: u10 (ref), u30 (copy)
        if type(p31) == "table" then
            return p31;
        end;

        return u10.new({
            error = p31,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p31), 2),
            context = "Promise created at:\n\n" .. u30
        });
    end;
end;

local function runExecutor(u32, p33, ...) -- Line: 171
    -- upvalues: packResult (copy), u10 (ref)
    assert(u32 ~= nil, "traceback is nil");

    return packResult(xpcall(p33, function(p34) -- Line: 151
        -- upvalues: u10 (ref), u32 (copy)
        if type(p34) == "table" then
            return p34;
        end;

        return u10.new({
            error = p34,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p34), 2),
            context = "Promise created at:\n\n" .. u32
        });
    end, ...));
end;

local function createAdvancer(u35, u36, u37, u38) -- Line: 179
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 180
        -- upvalues: runExecutor (ref), u35 (copy), u36 (copy), u37 (copy), u38 (copy)
        local v39, v40, v41 = runExecutor(u35, u36, ...);

        if v39 then
            u37(unpack(v41, 1, v40));

            return;
        end;

        u38(v41[1]);
    end;
end;

local function isEmpty(p42) -- Line: 191
    return next(p42) == nil;
end;

local u43 = {
    Error = u10,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u43.__index = u43.prototype;

function u43._new(p44, u45, p46) -- Line: 230
    -- upvalues: u43 (copy), u1 (copy), runExecutor (copy)
    if p46 ~= nil and not u43.is(p46) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u47 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p44,
        _status = u43.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p46,
        _consumers = setmetatable({}, u1)
    };

    if p46 and p46._status == u43.Status.Started then
        p46._consumers[u47] = true;
    end;

    setmetatable(u47, u43);

    local function resolve(...) -- Line: 278
        -- upvalues: u47 (copy)
        u47:_resolve(...);
    end;

    local function reject(...) -- Line: 282
        -- upvalues: u47 (copy)
        u47:_reject(...);
    end;

    local function onCancel(p48) -- Line: 286
        -- upvalues: u47 (copy), u43 (ref)
        if p48 then
            if u47._status == u43.Status.Cancelled then
                p48();
            else
                u47._cancellationHook = p48;
            end;
        end;

        return u47._status == u43.Status.Cancelled;
    end;

    u47._thread = coroutine.create(function() -- Line: 298
        -- upvalues: runExecutor (ref), u47 (copy), u45 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v49, _, v50 = runExecutor(u47._source, u45, resolve, reject, onCancel);

        if not v49 then
            reject(v50[1]);
        end;
    end);
    task.spawn(u47._thread);

    return u47;
end;

function u43.new(p51) -- Line: 349
    -- upvalues: u43 (copy)
    return u43._new(debug.traceback(nil, 2), p51);
end;

function u43.__tostring(p52) -- Line: 353
    return string.format("Promise(%s)", p52._status);
end;

function u43.defer(u53) -- Line: 375
    -- upvalues: u43 (copy), runExecutor (copy)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u43._new(debug_traceback_ret, function(u54, u55, u56) -- Line: 378
        -- upvalues: u43 (ref), runExecutor (ref), debug_traceback_ret (copy), u53 (copy)
        local u57 = nil;
        u57 = u43._timeEvent:Connect(function() -- Line: 380
            -- upvalues: u57 (ref), runExecutor (ref), debug_traceback_ret (ref), u53 (ref), u54 (copy), u55 (copy), u56 (copy)
            u57:Disconnect();
            local v58, _, v59 = runExecutor(debug_traceback_ret, u53, u54, u55, u56);

            if not v58 then
                u55(v59[1]);
            end;
        end);
    end);
end;

u43.async = u43.defer;

function u43.resolve(...) -- Line: 418
    -- upvalues: pack (copy), u43 (copy)
    local u60, u61 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p62) -- Line: 420
        -- upvalues: u61 (copy), u60 (copy)
        p62(unpack(u61, 1, u60));
    end);
end;

function u43.reject(...) -- Line: 435
    -- upvalues: pack (copy), u43 (copy)
    local u63, u64 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p65, p66) -- Line: 437
        -- upvalues: u64 (copy), u63 (copy)
        p66(unpack(u64, 1, u63));
    end);
end;

function u43._try(p67, u68, ...) -- Line: 446
    -- upvalues: pack (copy), u43 (copy)
    local u69, u70 = pack(...);

    return u43._new(p67, function(p71) -- Line: 449
        -- upvalues: u68 (copy), u70 (copy), u69 (copy)
        p71(u68(unpack(u70, 1, u69)));
    end);
end;

function u43.try(p72, ...) -- Line: 477
    -- upvalues: u43 (copy)
    return u43._try(debug.traceback(nil, 2), p72, ...);
end;

function u43._all(p73, u74, u75) -- Line: 486
    -- upvalues: u43 (copy)
    if type(u74) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u74) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u74 == 0 or u75 == 0 then
        return u43.resolve({});
    end;

    return u43._new(p73, function(u76, u77, p78) -- Line: 504
        -- upvalues: u75 (copy), u74 (copy)
        local u79 = {};
        local u80 = {};
        local u81 = 0;
        local u82 = 0;
        local u83 = false;

        local function resolveOne(p84, ...) -- Line: 522
            -- upvalues: u83 (ref), u81 (ref), u75 (ref), u79 (copy), u74 (ref), u76 (copy), u80 (copy)
            if u83 then
                return;
            end;

            u81 = u81 + 1;

            if u75 == nil then
                u79[p84] = ...;
            else
                u79[u81] = ...;
            end;

            if u81 >= (u75 or #u74) then
                u83 = true;
                u76(u79);

                for _, v in ipairs(u80) do
                    v:cancel();
                end;
            end;
        end;

        p78(function() -- Line: 515, Name: cancel
            -- upvalues: u80 (copy)
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u74) do
            u80[i] = v:andThen(function(...) -- Line: 547
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 549
                -- upvalues: u82 (ref), u75 (ref), u74 (ref), u80 (copy), u83 (ref), u77 (copy)
                u82 = u82 + 1;

                if u75 == nil or #u74 - u82 < u75 then
                    for _, v2 in ipairs(u80) do
                        v2:cancel();
                    end;

                    u83 = true;
                    u77(...);
                end;
            end);
        end;

        if u83 then
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.all(...) -- Line: 591
    -- upvalues: u43 (copy)
    local v85 = { ... };

    if type(v85[1]) == "table" and not u43.is(v85[1]) then
        v85 = v85[1];
    end;

    return u43._all(debug.traceback(nil, 2), v85);
end;

function u43.fold(p86, u87, p88) -- Line: 628
    -- upvalues: u43 (copy)
    local v89 = type(p86) == "table";
    assert(v89, "Bad argument #1 to Promise.fold: must be a table");
    local v90;

    if type(u87) == "function" then
        v90 = true;
    elseif type(u87) == "table" then
        local v91 = getmetatable(u87);

        if v91 then
            local v92 = rawget(v91, "__call");
            v90 = type(v92) == "function";
        else
            v90 = false;
        end;
    else
        v90 = false;
    end;

    assert(v90, "Bad argument #2 to Promise.fold: must be a function");
    local u93 = u43.resolve(p88);

    return u43.each(p86, function(u94, u95) -- Line: 633
        -- upvalues: u93 (ref), u87 (copy)
        u93 = u93:andThen(function(p96) -- Line: 634
            -- upvalues: u87 (ref), u94 (copy), u95 (copy)
            return u87(p96, u94, u95);
        end);
    end):andThen(function() -- Line: 637
        -- upvalues: u93 (ref)
        return u93;
    end);
end;

function u43.some(p97, p98) -- Line: 661
    -- upvalues: u43 (copy)
    local v99 = type(p98) == "number";
    assert(v99, "Bad argument #2 to Promise.some: must be a number");

    return u43._all(debug.traceback(nil, 2), p97, p98);
end;

function u43.any(p100) -- Line: 685
    -- upvalues: u43 (copy)
    return u43._all(debug.traceback(nil, 2), p100, 1):andThen(function(p101) -- Line: 686
        return p101[1];
    end);
end;

function u43.allSettled(u102) -- Line: 707
    -- upvalues: u43 (copy)
    if type(u102) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u102) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u102 == 0 then
        return u43.resolve({});
    end;

    return u43._new(debug.traceback(nil, 2), function(u103, p104, p105) -- Line: 725
        -- upvalues: u102 (copy)
        local u106 = {};
        local u107 = {};
        local u108 = 0;

        local function u110(p109, ...) -- Line: 735
            -- upvalues: u108 (ref), u106 (copy), u102 (ref), u103 (copy)
            u108 = u108 + 1;
            u106[p109] = ...;

            if u108 >= #u102 then
                u103(u106);
            end;
        end;

        p105(function() -- Line: 745
            -- upvalues: u107 (copy)
            for _, v in ipairs(u107) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u102) do
            u107[i] = v:finally(function(...) -- Line: 754
                -- upvalues: u110 (copy), i (copy)
                u110(i, ...);
            end);
        end;
    end);
end;

function u43.race(u111) -- Line: 785
    -- upvalues: u43 (copy)
    local v112 = type(u111) == "table";
    assert(v112, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u111) do
        local v113 = u43.is(v);
        local string_format = string.format;
        local v114 = tostring(i);
        assert(v113, string_format("Non-promise value passed into %s at index %s", "Promise.race", v114));
    end;

    return u43._new(debug.traceback(nil, 2), function(u115, u116, p117) -- Line: 792
        -- upvalues: u111 (copy)
        local u118 = {};
        local u119 = false;

        local function cancel() -- Line: 796
            -- upvalues: u118 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;

        local function finalize(u120) -- Line: 802
            -- upvalues: u118 (copy), u119 (ref)
            return function(...) -- Line: 803
                -- upvalues: u118 (ref), u119 (ref), u120 (copy)
                for _, v in ipairs(u118) do
                    v:cancel();
                end;

                u119 = true;

                return u120(...);
            end;
        end;

        if p117(function(...) -- Line: 803
            -- upvalues: u118 (copy), u119 (ref), u116 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;

            u119 = true;

            return u116(...);
        end) then
            return;
        end;

        for i, v in ipairs(u111) do
            u118[i] = v:andThen(function(...) -- Line: 803
                -- upvalues: u118 (copy), u119 (ref), u115 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u115(...);
            end, function(...) -- Line: 803
                -- upvalues: u118 (copy), u119 (ref), u116 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u116(...);
            end);
        end;

        if u119 then
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.each(u121, u122) -- Line: 880
    -- upvalues: u43 (copy), u10 (ref)
    local v123 = type(u121) == "table";
    assert(v123, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v124;

    if type(u122) == "function" then
        v124 = true;
    elseif type(u122) == "table" then
        local v125 = getmetatable(u122);

        if v125 then
            local v126 = rawget(v125, "__call");
            v124 = type(v126) == "function";
        else
            v124 = false;
        end;
    else
        v124 = false;
    end;

    assert(v124, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u43._new(debug.traceback(nil, 2), function(p127, p128, p129) -- Line: 884
        -- upvalues: u121 (copy), u43 (ref), u10 (ref), u122 (copy)
        local v130 = {};
        local u131 = {};
        local u132 = false;

        local function _() -- Line: 890
            -- upvalues: u131 (copy)
            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end;

        p129(function() -- Line: 896
            -- upvalues: u132 (ref), u131 (copy)
            u132 = true;

            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end);
        local v133 = {};

        for i, v in ipairs(u121) do
            if u43.is(v) then
                if v:getStatus() == u43.Status.Cancelled then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u43.Status.Rejected then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(select(2, v:await()));
                end;

                local v134 = v:andThen(function(...) -- Line: 929
                    return ...;
                end);
                table.insert(u131, v134);
                v133[i] = v134;
            else
                v133[i] = v;
            end;
        end;

        for i, v in ipairs(v133) do
            local v135;

            if u43.is(v) then
                local v136;
                v136, v135 = v:await();

                if not v136 then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(v135);
                end;
            else
                v135 = v;
            end;

            if u132 then
                return;
            end;

            local v137 = u43.resolve(u122(v135, i));
            table.insert(u131, v137);
            local v138, v139 = v137:await();

            if not v138 then
                for _, v2 in ipairs(u131) do
                    v2:cancel();
                end;

                return p128(v139);
            end;

            v130[i] = v139;
        end;

        p127(v130);
    end);
end;

function u43.is(p140) -- Line: 979
    -- upvalues: u43 (copy)
    if type(p140) ~= "table" then
        return false;
    end;

    local v141 = getmetatable(p140);

    if v141 == u43 then
        return true;
    end;

    if v141 ~= nil then
        if type(v141) == "table" then
            local v142 = rawget(v141, "__index");

            if type(v142) == "table" then
                local v143 = rawget(v141, "__index");
                local v144 = rawget(v143, "andThen");
                local v145;

                if type(v144) == "function" then
                    v145 = true;
                else
                    local v146 = type(v144) == "table" and getmetatable(v144);

                    if v146 then
                        local v147 = rawget(v146, "__call");
                        v145 = type(v147) == "function";
                    else
                        v145 = false;
                    end;
                end;

                if v145 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p140.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v148 = type(andThen) == "table" and getmetatable(andThen);

    if v148 then
        local v149 = rawget(v148, "__call");

        if type(v149) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u43.promisify(u150) -- Line: 1028
    -- upvalues: u43 (copy)
    return function(...) -- Line: 1029
        -- upvalues: u43 (ref), u150 (copy)
        return u43._try(debug.traceback(nil, 2), u150, ...);
    end;
end;

local u151 = nil;
local u152 = nil;

function u43.delay(p153) -- Line: 1059
    -- upvalues: u43 (copy), u152 (ref), u151 (ref)
    local v154 = type(p153) == "number";
    assert(v154, "Bad argument #1 to Promise.delay, must be a number.");
    local u155 = (p153 < 0.016666666666666666 or p153 == (1 / 0)) and 0.016666666666666666 or p153;

    return u43._new(debug.traceback(nil, 2), function(p156, p157, p158) -- Line: 1067
        -- upvalues: u43 (ref), u155 (ref), u152 (ref), u151 (ref)
        local v159 = u43._getTime();
        local v160 = v159 + u155;
        local u161 = {
            resolve = p156,
            startTime = v159,
            endTime = v160
        };

        if u152 == nil then
            u151 = u161;
            u152 = u43._timeEvent:Connect(function() -- Line: 1079
                -- upvalues: u43 (ref), u151 (ref), u152 (ref)
                local v162 = u43._getTime();

                while u151 ~= nil and u151.endTime < v162 do
                    local v163 = u151;
                    u151 = v163.next;

                    if u151 == nil then
                        u152:Disconnect();
                        u152 = nil;
                    else
                        u151.previous = nil;
                    end;

                    v163.resolve(u43._getTime() - v163.startTime);
                end;
            end);
        elseif u151.endTime < v160 then
            local v164 = u151;
            local next2 = v164.next;

            while next2 ~= nil and next2.endTime < v160 do
                v164 = next2;
                next2 = next2.next;
            end;

            v164.next = u161;
            u161.previous = v164;

            if next2 ~= nil then
                u161.next = next2;
                next2.previous = u161;
            end;
        else
            u161.next = u151;
            u151.previous = u161;
            u151 = u161;
        end;

        p158(function() -- Line: 1124
            -- upvalues: u161 (copy), u151 (ref), u152 (ref)
            local next2 = u161.next;

            if u151 == u161 then
                if next2 == nil then
                    u152:Disconnect();
                    u152 = nil;
                else
                    next2.previous = nil;
                end;

                u151 = next2;

                return;
            end;

            local previous = u161.previous;
            previous.next = next2;

            if next2 ~= nil then
                next2.previous = previous;
            end;
        end);
    end);
end;

function u43.prototype.timeout(p165, u166, u167) -- Line: 1188
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u43.race({ u43.delay(u166):andThen(function() -- Line: 1192
            -- upvalues: u43 (ref), u167 (copy), u10 (ref), u166 (copy), debug_traceback_ret (copy)
            return u43.reject(u167 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u166, debug_traceback_ret)
            }) or u167);
        end), p165 });
end;

function u43.prototype.getStatus(p168) -- Line: 1212
    return p168._status;
end;

function u43.prototype._andThen(u169, u170, u171, u172) -- Line: 1221
    -- upvalues: u43 (copy), runExecutor (copy), u10 (ref)
    u169._unhandledRejection = false;

    return u43._new(u170, function(u173, u174) -- Line: 1225
        -- upvalues: u171 (copy), u170 (copy), runExecutor (ref), u172 (copy), u169 (copy), u43 (ref), u10 (ref)
        local v175;

        if u171 then
            local u176 = u170;
            local u177 = u171;

            v175 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u176 (copy), u177 (copy), u173 (copy), u174 (copy)
                local v178, v179, v180 = runExecutor(u176, u177, ...);

                if v178 then
                    u173(unpack(v180, 1, v179));

                    return;
                end;

                u174(v180[1]);
            end;
        else
            v175 = u173;
        end;

        local v181;

        if u172 then
            local u182 = u170;
            local u183 = u172;

            v181 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u182 (copy), u183 (copy), u173 (copy), u174 (copy)
                local v184, v185, v186 = runExecutor(u182, u183, ...);

                if v184 then
                    u173(unpack(v186, 1, v185));

                    return;
                end;

                u174(v186[1]);
            end;
        else
            v181 = u174;
        end;

        if u169._status == u43.Status.Started then
            table.insert(u169._queuedResolve, v175);
            table.insert(u169._queuedReject, v181);

            return;
        end;

        if u169._status == u43.Status.Resolved then
            v175(unpack(u169._values, 1, u169._valuesLength));

            return;
        end;

        if u169._status == u43.Status.Rejected then
            v181(unpack(u169._values, 1, u169._valuesLength));

            return;
        end;

        if u169._status == u43.Status.Cancelled then
            u174(u10.new({
                error = "Promise is cancelled",
                kind = u10.Kind.AlreadyCancelled,
                context = "Promise created at\n\n" .. u170
            }));
        end;
    end, u169);
end;

function u43.prototype.andThen(p187, p188, p189) -- Line: 1282
    local v190;

    if p188 == nil or type(p188) == "function" then
        v190 = true;
    elseif type(p188) == "table" then
        local v191 = getmetatable(p188);

        if v191 then
            local v192 = rawget(v191, "__call");
            v190 = type(v192) == "function";
        else
            v190 = false;
        end;
    else
        v190 = false;
    end;

    assert(v190, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v193;

    if p189 == nil or type(p189) == "function" then
        v193 = true;
    elseif type(p189) == "table" then
        local v194 = getmetatable(p189);

        if v194 then
            local v195 = rawget(v194, "__call");
            v193 = type(v195) == "function";
        else
            v193 = false;
        end;
    else
        v193 = false;
    end;

    assert(v193, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p187:_andThen(debug.traceback(nil, 2), p188, p189);
end;

function u43.prototype.andThenAsync(p196, p197, p198) -- Line: 1310
    -- upvalues: pack (copy), u43 (copy)
    local v199;

    if p197 == nil or type(p197) == "function" then
        v199 = true;
    elseif type(p197) == "table" then
        local v200 = getmetatable(p197);

        if v200 then
            local v201 = rawget(v200, "__call");
            v199 = type(v201) == "function";
        else
            v199 = false;
        end;
    else
        v199 = false;
    end;

    assert(v199, string.format("Please pass a handler function to %s!", "Promise:andThenAsync"));
    local v202;

    if p198 == nil or type(p198) == "function" then
        v202 = true;
    elseif type(p198) == "table" then
        local v203 = getmetatable(p198);

        if v203 then
            local v204 = rawget(v203, "__call");
            v202 = type(v204) == "function";
        else
            v202 = false;
        end;
    else
        v202 = false;
    end;

    assert(v202, string.format("Please pass a handler function to %s!", "Promise:andThenAsync"));

    return p196:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1317
        -- upvalues: pack (ref), u43 (ref)
        local u205, u206 = pack(...);

        return u43.defer(function(p207) -- Line: 1319
            -- upvalues: u206 (copy), u205 (copy)
            p207(unpack(u206, 1, u205));
        end);
    end, function(...) -- Line: 1323
        -- upvalues: pack (ref), u43 (ref)
        local u208, u209 = pack(...);

        return u43.defer(function(p210, p211) -- Line: 1325
            -- upvalues: u209 (copy), u208 (copy)
            p211(unpack(u209, 1, u208));
        end);
    end):andThen(p197, p198);
end;

function u43.prototype.catch(p212, p213) -- Line: 1352
    local v214;

    if p213 == nil or type(p213) == "function" then
        v214 = true;
    elseif type(p213) == "table" then
        local v215 = getmetatable(p213);

        if v215 then
            local v216 = rawget(v215, "__call");
            v214 = type(v216) == "function";
        else
            v214 = false;
        end;
    else
        v214 = false;
    end;

    assert(v214, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p212:_andThen(debug.traceback(nil, 2), nil, p213);
end;

function u43.prototype.tap(p217, u218) -- Line: 1373
    -- upvalues: u43 (copy), pack (copy)
    local v219;

    if type(u218) == "function" then
        v219 = true;
    elseif type(u218) == "table" then
        local v220 = getmetatable(u218);

        if v220 then
            local v221 = rawget(v220, "__call");
            v219 = type(v221) == "function";
        else
            v219 = false;
        end;
    else
        v219 = false;
    end;

    assert(v219, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p217:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1375
        -- upvalues: u218 (copy), u43 (ref), pack (ref)
        local v222 = u218(...);

        if not u43.is(v222) then
            return ...;
        end;

        local u223, u224 = pack(...);

        return v222:andThen(function() -- Line: 1380
            -- upvalues: u224 (copy), u223 (copy)
            return unpack(u224, 1, u223);
        end);
    end);
end;

function u43.prototype.andThenCall(p225, u226, ...) -- Line: 1408
    -- upvalues: pack (copy)
    local v227;

    if type(u226) == "function" then
        v227 = true;
    elseif type(u226) == "table" then
        local v228 = getmetatable(u226);

        if v228 then
            local v229 = rawget(v228, "__call");
            v227 = type(v229) == "function";
        else
            v227 = false;
        end;
    else
        v227 = false;
    end;

    assert(v227, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u230, u231 = pack(...);

    return p225:_andThen(debug.traceback(nil, 2), function() -- Line: 1411
        -- upvalues: u226 (copy), u231 (copy), u230 (copy)
        return u226(unpack(u231, 1, u230));
    end);
end;

function u43.prototype.andThenReturn(p232, ...) -- Line: 1438
    -- upvalues: pack (copy)
    local u233, u234 = pack(...);

    return p232:_andThen(debug.traceback(nil, 2), function() -- Line: 1440
        -- upvalues: u234 (copy), u233 (copy)
        return unpack(u234, 1, u233);
    end);
end;

function u43.prototype.cancel(p235) -- Line: 1456
    -- upvalues: u43 (copy)
    if p235._status ~= u43.Status.Started then
        return;
    end;

    p235._status = u43.Status.Cancelled;

    if p235._cancellationHook then
        p235._cancellationHook();
    end;

    coroutine.close(p235._thread);

    if p235._parent then
        p235._parent:_consumerCancelled(p235);
    end;

    for i in pairs(p235._consumers) do
        i:cancel();
    end;

    p235:_finalize();
end;

function u43.prototype._consumerCancelled(p236, p237) -- Line: 1484
    -- upvalues: u43 (copy)
    if p236._status ~= u43.Status.Started then
        return;
    end;

    p236._consumers[p237] = nil;

    if next(p236._consumers) == nil then
        p236:cancel();
    end;
end;

function u43.prototype._finally(u238, u239, u240, u241) -- Line: 1500
    -- upvalues: u43 (copy), runExecutor (copy)
    if not u241 then
        u238._unhandledRejection = false;
    end;

    return u43._new(u239, function(u242, u243) -- Line: 1506
        -- upvalues: u240 (copy), u239 (copy), runExecutor (ref), u241 (copy), u238 (copy), u43 (ref)
        local u244;

        if u240 then
            local u245 = u239;
            local u246 = u240;

            u244 = function(...) -- Line: 180
                -- upvalues: runExecutor (ref), u245 (copy), u246 (copy), u242 (copy), u243 (copy)
                local v247, v248, v249 = runExecutor(u245, u246, ...);

                if v247 then
                    u242(unpack(v249, 1, v248));

                    return;
                end;

                u243(v249[1]);
            end;
        else
            u244 = u242;
        end;

        local v250 = u241 and function(...) -- Line: 1514
            -- upvalues: u238 (ref), u43 (ref), u242 (copy), u244 (copy)
            if u238._status == u43.Status.Rejected then
                return u242(u238);
            end;

            return u244(...);
        end or u244;

        if u238._status == u43.Status.Started then
            table.insert(u238._queuedFinally, v250);

            return;
        end;

        v250(u238._status);
    end, u238);
end;

function u43.prototype.finally(p251, p252) -- Line: 1582
    local v253;

    if p252 == nil or type(p252) == "function" then
        v253 = true;
    elseif type(p252) == "table" then
        local v254 = getmetatable(p252);

        if v254 then
            local v255 = rawget(v254, "__call");
            v253 = type(v255) == "function";
        else
            v253 = false;
        end;
    else
        v253 = false;
    end;

    assert(v253, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p251:_finally(debug.traceback(nil, 2), p252);
end;

function u43.prototype.finallyCall(p256, u257, ...) -- Line: 1596
    -- upvalues: pack (copy)
    local v258;

    if type(u257) == "function" then
        v258 = true;
    elseif type(u257) == "table" then
        local v259 = getmetatable(u257);

        if v259 then
            local v260 = rawget(v259, "__call");
            v258 = type(v260) == "function";
        else
            v258 = false;
        end;
    else
        v258 = false;
    end;

    assert(v258, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u261, u262 = pack(...);

    return p256:_finally(debug.traceback(nil, 2), function() -- Line: 1599
        -- upvalues: u257 (copy), u262 (copy), u261 (copy)
        return u257(unpack(u262, 1, u261));
    end);
end;

function u43.prototype.finallyReturn(p263, ...) -- Line: 1622
    -- upvalues: pack (copy)
    local u264, u265 = pack(...);

    return p263:_finally(debug.traceback(nil, 2), function() -- Line: 1624
        -- upvalues: u265 (copy), u264 (copy)
        return unpack(u265, 1, u264);
    end);
end;

function u43.prototype.done(p266, p267) -- Line: 1632
    local v268;

    if p267 == nil or type(p267) == "function" then
        v268 = true;
    elseif type(p267) == "table" then
        local v269 = getmetatable(p267);

        if v269 then
            local v270 = rawget(v269, "__call");
            v268 = type(v270) == "function";
        else
            v268 = false;
        end;
    else
        v268 = false;
    end;

    assert(v268, string.format("Please pass a handler function to %s!", "Promise:done"));

    return p266:_finally(debug.traceback(nil, 2), p267, true);
end;

function u43.prototype.doneCall(p271, u272, ...) -- Line: 1643
    -- upvalues: pack (copy)
    local v273;

    if type(u272) == "function" then
        v273 = true;
    elseif type(u272) == "table" then
        local v274 = getmetatable(u272);

        if v274 then
            local v275 = rawget(v274, "__call");
            v273 = type(v275) == "function";
        else
            v273 = false;
        end;
    else
        v273 = false;
    end;

    assert(v273, string.format("Please pass a handler function to %s!", "Promise:doneCall"));
    local u276, u277 = pack(...);

    return p271:_finally(debug.traceback(nil, 2), function() -- Line: 1646
        -- upvalues: u272 (copy), u277 (copy), u276 (copy)
        return u272(unpack(u277, 1, u276));
    end, true);
end;

function u43.prototype.doneReturn(p278, ...) -- Line: 1654
    -- upvalues: pack (copy)
    local u279, u280 = pack(...);

    return p278:_finally(debug.traceback(nil, 2), function() -- Line: 1656
        -- upvalues: u280 (copy), u279 (copy)
        return unpack(u280, 1, u279);
    end, true);
end;

function u43.prototype.awaitStatus(p281) -- Line: 1668
    -- upvalues: u43 (copy)
    p281._unhandledRejection = false;

    if p281._status == u43.Status.Started then
        local coroutine_running_ret = coroutine.running();
        p281:finally(function() -- Line: 1674
            -- upvalues: coroutine_running_ret (copy)
            task.spawn(coroutine_running_ret);
        end);
        coroutine.yield();
    end;

    if p281._status == u43.Status.Resolved then
        return p281._status, unpack(p281._values, 1, p281._valuesLength);
    end;

    if p281._status == u43.Status.Rejected then
        return p281._status, unpack(p281._values, 1, p281._valuesLength);
    end;

    return p281._status;
end;

local function awaitHelper(p282, ...) -- Line: 1690
    -- upvalues: u43 (copy)
    return p282 == u43.Status.Resolved, ...;
end;

function u43.prototype.await(p283) -- Line: 1715
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p283:awaitStatus());
end;

local function expectHelper(p284, ...) -- Line: 1719
    -- upvalues: u43 (copy)
    if p284 ~= u43.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u43.prototype.expect(p285) -- Line: 1752
    -- upvalues: expectHelper (copy)
    return expectHelper(p285:awaitStatus());
end;

u43.prototype.awaitValue = u43.prototype.expect;

function u43.prototype._unwrap(p286) -- Line: 1766
    -- upvalues: u43 (copy)
    if p286._status == u43.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p286._status == u43.Status.Resolved, unpack(p286._values, 1, p286._valuesLength);
end;

function u43.prototype._resolve(u287, ...) -- Line: 1776
    -- upvalues: u43 (copy), u10 (ref), pack (copy)
    if u287._status ~= u43.Status.Started then
        if u43.is((...)) then
            (...):_consumerCancelled(u287);
        end;

        return;
    end;

    if u43.is((...)) then
        if select("#", ...) > 1 then
            local string_format_ret = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u287._source);
            warn(string_format_ret);
        end;

        local u288 = ...;
        local v290 = u288:andThen(function(...) -- Line: 1797
            -- upvalues: u287 (copy)
            u287:_resolve(...);
        end, function(...) -- Line: 1799
            -- upvalues: u288 (copy), u10 (ref), u287 (copy)
            local v289 = u288._values[1];

            if u288._error then
                v289 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u288._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v289, u10.Kind.ExecutionError) then
                return u287:_reject(v289:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u287._source)
                }));
            end;

            u287:_reject(...);
        end);

        if v290._status == u43.Status.Cancelled then
            u287:cancel();

            return;
        end;

        if v290._status == u43.Status.Started then
            u287._parent = v290;
            v290._consumers[u287] = true;
        end;

        return;
    end;

    u287._status = u43.Status.Resolved;
    local v291, v292 = pack(...);
    u287._valuesLength = v291;
    u287._values = v292;

    for _, v in ipairs(u287._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u287:_finalize();
end;

function u43.prototype._reject(u293, ...) -- Line: 1847
    -- upvalues: u43 (copy), pack (copy)
    if u293._status ~= u43.Status.Started then
        return;
    end;

    u293._status = u43.Status.Rejected;
    local v294, v295 = pack(...);
    u293._valuesLength = v294;
    u293._values = v295;

    if next(u293._queuedReject) == nil then
        local u296 = tostring((...));
        coroutine.wrap(function() -- Line: 1869
            -- upvalues: u43 (ref), u293 (copy), u296 (copy)
            u43._timeEvent:Wait();

            if not u293._unhandledRejection then
                return;
            end;

            local string_format_ret = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u296, u293._source);

            for _, v in ipairs(u43._unhandledRejectionCallbacks) do
                task.spawn(v, u293, unpack(u293._values, 1, u293._valuesLength));
            end;

            if u43.TEST then
                return;
            end;

            warn(string_format_ret);
        end)();
    else
        for _, v in ipairs(u293._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u293:_finalize();
end;

function u43.prototype._finalize(p297) -- Line: 1901
    -- upvalues: u43 (copy)
    for _, v in ipairs(p297._queuedFinally) do
        coroutine.wrap(v)(p297._status);
    end;

    p297._queuedFinally = nil;
    p297._queuedReject = nil;
    p297._queuedResolve = nil;

    if not u43.TEST then
        p297._parent = nil;
        p297._consumers = nil;
    end;

    task.defer(coroutine.close, p297._thread);
end;

function u43.prototype.now(p298, p299) -- Line: 1938
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    if p298._status == u43.Status.Resolved then
        return p298:_andThen(debug_traceback_ret, function(...) -- Line: 1941
            return ...;
        end);
    end;

    local reject = u43.reject;

    if p299 == nil then
        p299 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. debug_traceback_ret
        }) or p299;
    end;

    return reject(p299);
end;

function u43.retry(u300, u301, ...) -- Line: 1983
    -- upvalues: u43 (copy)
    local v302;

    if type(u300) == "function" then
        v302 = true;
    elseif type(u300) == "table" then
        local v303 = getmetatable(u300);

        if v303 then
            local v304 = rawget(v303, "__call");
            v302 = type(v304) == "function";
        else
            v302 = false;
        end;
    else
        v302 = false;
    end;

    assert(v302, "Parameter #1 to Promise.retry must be a function");
    local v305 = type(u301) == "number";
    assert(v305, "Parameter #2 to Promise.retry must be a number");
    local u306 = { ... };
    local u307 = select("#", ...);

    return u43.resolve(u300(...)):catch(function(...) -- Line: 1989
        -- upvalues: u301 (copy), u43 (ref), u300 (copy), u306 (copy), u307 (copy)
        if u301 > 0 then
            return u43.retry(u300, u301 - 1, unpack(u306, 1, u307));
        end;

        return u43.reject(...);
    end);
end;

function u43.retryWithDelay(u308, u309, u310, ...) -- Line: 2011
    -- upvalues: u43 (copy)
    local v311;

    if type(u308) == "function" then
        v311 = true;
    elseif type(u308) == "table" then
        local v312 = getmetatable(u308);

        if v312 then
            local v313 = rawget(v312, "__call");
            v311 = type(v313) == "function";
        else
            v311 = false;
        end;
    else
        v311 = false;
    end;

    assert(v311, "Parameter #1 to Promise.retry must be a function");
    local v314 = type(u309) == "number";
    assert(v314, "Parameter #2 (times) to Promise.retry must be a number");
    local v315 = type(u310) == "number";
    assert(v315, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u316 = { ... };
    local u317 = select("#", ...);

    return u43.resolve(u308(...)):catch(function(...) -- Line: 2018
        -- upvalues: u309 (copy), u43 (ref), u310 (copy), u308 (copy), u316 (copy), u317 (copy)
        if u309 <= 0 then
            return u43.reject(...);
        end;

        u43.delay(u310):await();

        return u43.retryWithDelay(u308, u309 - 1, u310, unpack(u316, 1, u317));
    end);
end;

function u43.fromEvent(u318, p319) -- Line: 2053
    -- upvalues: u43 (copy)
    local u320 = p319 or function() -- Line: 2054
        return true;
    end;

    return u43._new(debug.traceback(nil, 2), function(u321, p322, p323) -- Line: 2058
        -- upvalues: u318 (copy), u320 (ref)
        local u324 = nil;
        local u325 = false;

        local function disconnect() -- Line: 2062
            -- upvalues: u324 (ref)
            u324:Disconnect();
            u324 = nil;
        end;

        u324 = u318:Connect(function(...) -- Line: 2071
            -- upvalues: u320 (ref), u321 (copy), u324 (ref), u325 (ref)
            local v326 = u320(...);

            if v326 ~= true then
                if type(v326) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u321(...);

            if not u324 then
                u325 = true;

                return;
            end;

            u324:Disconnect();
            u324 = nil;
        end);

        if u325 and u324 then
            return disconnect();
        end;

        p323(disconnect);
    end);
end;

function u43.onUnhandledRejection(u327) -- Line: 2105
    -- upvalues: u43 (copy)
    table.insert(u43._unhandledRejectionCallbacks, u327);

    return function() -- Line: 2108
        -- upvalues: u43 (ref), u327 (copy)
        local table_find_ret = table.find(u43._unhandledRejectionCallbacks, u327);

        if table_find_ret then
            table.remove(u43._unhandledRejectionCallbacks, table_find_ret);
        end;
    end;
end;

return u43;