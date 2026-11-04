  

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
        -- upvalues: runExecutor (ref), debug_traceback_ret (copy), u53 (copy)
        task.defer(function() -- Line: 379
            -- upvalues: runExecutor (ref), debug_traceback_ret (ref), u53 (ref), u54 (copy), u55 (copy), u56 (copy)
            local v57, _, v58 = runExecutor(debug_traceback_ret, u53, u54, u55, u56);

            if not v57 then
                u55(v58[1]);
            end;
        end);
    end);
end;

u43.async = u43.defer;

function u43.resolve(...) -- Line: 416
    -- upvalues: pack (copy), u43 (copy)
    local u59, u60 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p61) -- Line: 418
        -- upvalues: u60 (copy), u59 (copy)
        p61(unpack(u60, 1, u59));
    end);
end;

function u43.reject(...) -- Line: 433
    -- upvalues: pack (copy), u43 (copy)
    local u62, u63 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p64, p65) -- Line: 435
        -- upvalues: u63 (copy), u62 (copy)
        p65(unpack(u63, 1, u62));
    end);
end;

function u43._try(p66, u67, ...) -- Line: 444
    -- upvalues: pack (copy), u43 (copy)
    local u68, u69 = pack(...);

    return u43._new(p66, function(p70) -- Line: 447
        -- upvalues: u67 (copy), u69 (copy), u68 (copy)
        p70(u67(unpack(u69, 1, u68)));
    end);
end;

function u43.try(p71, ...) -- Line: 475
    -- upvalues: u43 (copy)
    return u43._try(debug.traceback(nil, 2), p71, ...);
end;

function u43._all(p72, u73, u74) -- Line: 484
    -- upvalues: u43 (copy)
    if type(u73) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u73) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u73 == 0 or u74 == 0 then
        return u43.resolve({});
    end;

    return u43._new(p72, function(u75, u76, p77) -- Line: 502
        -- upvalues: u74 (copy), u73 (copy)
        local u78 = {};
        local u79 = {};
        local u80 = 0;
        local u81 = 0;
        local u82 = false;

        local function resolveOne(p83, ...) -- Line: 520
            -- upvalues: u82 (ref), u80 (ref), u74 (ref), u78 (copy), u73 (ref), u75 (copy), u79 (copy)
            if u82 then
                return;
            end;

            u80 = u80 + 1;

            if u74 == nil then
                u78[p83] = ...;
            else
                u78[u80] = ...;
            end;

            if u80 >= (u74 or #u73) then
                u82 = true;
                u75(u78);

                for _, v in ipairs(u79) do
                    v:cancel();
                end;
            end;
        end;

        p77(function() -- Line: 513, Name: cancel
            -- upvalues: u79 (copy)
            for _, v in ipairs(u79) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u73) do
            u79[i] = v:andThen(function(...) -- Line: 545
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 547
                -- upvalues: u81 (ref), u74 (ref), u73 (ref), u79 (copy), u82 (ref), u76 (copy)
                u81 = u81 + 1;

                if u74 == nil or #u73 - u81 < u74 then
                    for _, v2 in ipairs(u79) do
                        v2:cancel();
                    end;

                    u82 = true;
                    u76(...);
                end;
            end);
        end;

        if u82 then
            for _, v in ipairs(u79) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.all(p84) -- Line: 589
    -- upvalues: u43 (copy)
    return u43._all(debug.traceback(nil, 2), p84);
end;

function u43.fold(p85, u86, p87) -- Line: 618
    -- upvalues: u43 (copy)
    local v88 = type(p85) == "table";
    assert(v88, "Bad argument #1 to Promise.fold: must be a table");
    local v89;

    if type(u86) == "function" then
        v89 = true;
    elseif type(u86) == "table" then
        local v90 = getmetatable(u86);

        if v90 then
            local v91 = rawget(v90, "__call");
            v89 = type(v91) == "function";
        else
            v89 = false;
        end;
    else
        v89 = false;
    end;

    assert(v89, "Bad argument #2 to Promise.fold: must be a function");
    local u92 = u43.resolve(p87);

    return u43.each(p85, function(u93, u94) -- Line: 623
        -- upvalues: u92 (ref), u86 (copy)
        u92 = u92:andThen(function(p95) -- Line: 624
            -- upvalues: u86 (ref), u93 (copy), u94 (copy)
            return u86(p95, u93, u94);
        end);
    end):andThen(function() -- Line: 627
        -- upvalues: u92 (ref)
        return u92;
    end);
end;

function u43.some(p96, p97) -- Line: 651
    -- upvalues: u43 (copy)
    local v98 = type(p97) == "number";
    assert(v98, "Bad argument #2 to Promise.some: must be a number");

    return u43._all(debug.traceback(nil, 2), p96, p97);
end;

function u43.any(p99) -- Line: 675
    -- upvalues: u43 (copy)
    return u43._all(debug.traceback(nil, 2), p99, 1):andThen(function(p100) -- Line: 676
        return p100[1];
    end);
end;

function u43.allSettled(u101) -- Line: 697
    -- upvalues: u43 (copy)
    if type(u101) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u101) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u101 == 0 then
        return u43.resolve({});
    end;

    return u43._new(debug.traceback(nil, 2), function(u102, p103, p104) -- Line: 715
        -- upvalues: u101 (copy)
        local u105 = {};
        local u106 = {};
        local u107 = 0;

        local function u109(p108, ...) -- Line: 725
            -- upvalues: u107 (ref), u105 (copy), u101 (ref), u102 (copy)
            u107 = u107 + 1;
            u105[p108] = ...;

            if u107 >= #u101 then
                u102(u105);
            end;
        end;

        p104(function() -- Line: 735
            -- upvalues: u106 (copy)
            for _, v in ipairs(u106) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u101) do
            u106[i] = v:finally(function(...) -- Line: 744
                -- upvalues: u109 (copy), i (copy)
                u109(i, ...);
            end);
        end;
    end);
end;

function u43.race(u110) -- Line: 775
    -- upvalues: u43 (copy)
    local v111 = type(u110) == "table";
    assert(v111, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u110) do
        local v112 = u43.is(v);
        local string_format = string.format;
        local v113 = tostring(i);
        assert(v112, string_format("Non-promise value passed into %s at index %s", "Promise.race", v113));
    end;

    return u43._new(debug.traceback(nil, 2), function(u114, u115, p116) -- Line: 782
        -- upvalues: u110 (copy)
        local u117 = {};
        local u118 = false;

        local function cancel() -- Line: 786
            -- upvalues: u117 (copy)
            for _, v in ipairs(u117) do
                v:cancel();
            end;
        end;

        local function finalize(u119) -- Line: 792
            -- upvalues: u117 (copy), u118 (ref)
            return function(...) -- Line: 793
                -- upvalues: u117 (ref), u118 (ref), u119 (copy)
                for _, v in ipairs(u117) do
                    v:cancel();
                end;

                u118 = true;

                return u119(...);
            end;
        end;

        if p116(function(...) -- Line: 793
            -- upvalues: u117 (copy), u118 (ref), u115 (copy)
            for _, v in ipairs(u117) do
                v:cancel();
            end;

            u118 = true;

            return u115(...);
        end) then
            return;
        end;

        for i, v in ipairs(u110) do
            u117[i] = v:andThen(function(...) -- Line: 793
                -- upvalues: u117 (copy), u118 (ref), u114 (copy)
                for _, v2 in ipairs(u117) do
                    v2:cancel();
                end;

                u118 = true;

                return u114(...);
            end, function(...) -- Line: 793
                -- upvalues: u117 (copy), u118 (ref), u115 (copy)
                for _, v2 in ipairs(u117) do
                    v2:cancel();
                end;

                u118 = true;

                return u115(...);
            end);
        end;

        if u118 then
            for _, v in ipairs(u117) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.each(u120, u121) -- Line: 870
    -- upvalues: u43 (copy), u10 (ref)
    local v122 = type(u120) == "table";
    assert(v122, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v123;

    if type(u121) == "function" then
        v123 = true;
    elseif type(u121) == "table" then
        local v124 = getmetatable(u121);

        if v124 then
            local v125 = rawget(v124, "__call");
            v123 = type(v125) == "function";
        else
            v123 = false;
        end;
    else
        v123 = false;
    end;

    assert(v123, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u43._new(debug.traceback(nil, 2), function(p126, p127, p128) -- Line: 874
        -- upvalues: u120 (copy), u43 (ref), u10 (ref), u121 (copy)
        local v129 = {};
        local u130 = {};
        local u131 = false;

        local function _() -- Line: 880
            -- upvalues: u130 (copy)
            for _, v in ipairs(u130) do
                v:cancel();
            end;
        end;

        p128(function() -- Line: 886
            -- upvalues: u131 (ref), u130 (copy)
            u131 = true;

            for _, v in ipairs(u130) do
                v:cancel();
            end;
        end);
        local v132 = {};

        for i, v in ipairs(u120) do
            if u43.is(v) then
                if v:getStatus() == u43.Status.Cancelled then
                    for _, v2 in ipairs(u130) do
                        v2:cancel();
                    end;

                    return p127(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u43.Status.Rejected then
                    for _, v2 in ipairs(u130) do
                        v2:cancel();
                    end;

                    return p127(select(2, v:await()));
                end;

                local v133 = v:andThen(function(...) -- Line: 919
                    return ...;
                end);
                table.insert(u130, v133);
                v132[i] = v133;
            else
                v132[i] = v;
            end;
        end;

        for i, v in ipairs(v132) do
            local v134;

            if u43.is(v) then
                local v135;
                v135, v134 = v:await();

                if not v135 then
                    for _, v2 in ipairs(u130) do
                        v2:cancel();
                    end;

                    return p127(v134);
                end;
            else
                v134 = v;
            end;

            if u131 then
                return;
            end;

            local v136 = u43.resolve(u121(v134, i));
            table.insert(u130, v136);
            local v137, v138 = v136:await();

            if not v137 then
                for _, v2 in ipairs(u130) do
                    v2:cancel();
                end;

                return p127(v138);
            end;

            v129[i] = v138;
        end;

        p126(v129);
    end);
end;

function u43.is(p139) -- Line: 969
    -- upvalues: u43 (copy)
    if type(p139) ~= "table" then
        return false;
    end;

    local v140 = getmetatable(p139);

    if v140 == u43 then
        return true;
    end;

    if v140 ~= nil then
        if type(v140) == "table" then
            local v141 = rawget(v140, "__index");

            if type(v141) == "table" then
                local v142 = rawget(v140, "__index");
                local v143 = rawget(v142, "andThen");
                local v144;

                if type(v143) == "function" then
                    v144 = true;
                else
                    local v145 = type(v143) == "table" and getmetatable(v143);

                    if v145 then
                        local v146 = rawget(v145, "__call");
                        v144 = type(v146) == "function";
                    else
                        v144 = false;
                    end;
                end;

                if v144 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p139.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v147 = type(andThen) == "table" and getmetatable(andThen);

    if v147 then
        local v148 = rawget(v147, "__call");

        if type(v148) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u43.promisify(u149) -- Line: 1018
    -- upvalues: u43 (copy)
    return function(...) -- Line: 1019
        -- upvalues: u43 (ref), u149 (copy)
        return u43._try(debug.traceback(nil, 2), u149, ...);
    end;
end;

function u43.delay(u150) -- Line: 1042
    -- upvalues: u43 (copy)
    local v151 = type(u150) == "number";
    assert(v151, "Bad argument #1 to Promise.delay, must be a number.");
    local u152 = u43._getTime();

    return u43._new(debug.traceback(nil, 2), function(u153) -- Line: 1045
        -- upvalues: u150 (copy), u43 (ref), u152 (copy)
        task.delay(u150, function() -- Line: 1046
            -- upvalues: u153 (copy), u43 (ref), u152 (ref)
            u153(u43._getTime() - u152);
        end);
    end);
end;

function u43.prototype.timeout(p154, u155, u156) -- Line: 1090
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u43.race({ u43.delay(u155):andThen(function() -- Line: 1094
            -- upvalues: u43 (ref), u156 (copy), u10 (ref), u155 (copy), debug_traceback_ret (copy)
            return u43.reject(u156 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u155, debug_traceback_ret)
            }) or u156);
        end), p154 });
end;

function u43.prototype.getStatus(p157) -- Line: 1114
    return p157._status;
end;

function u43.prototype._andThen(u158, u159, u160, u161) -- Line: 1123
    -- upvalues: u43 (copy), runExecutor (copy)
    u158._unhandledRejection = false;

    if u158._status ~= u43.Status.Cancelled then
        return u43._new(u159, function(u162, u163, p164) -- Line: 1135
            -- upvalues: u160 (copy), u159 (copy), runExecutor (ref), u161 (copy), u158 (copy), u43 (ref)
            local u165;

            if u160 then
                local u166 = u159;
                local u167 = u160;

                u165 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u166 (copy), u167 (copy), u162 (copy), u163 (copy)
                    local v168, v169, v170 = runExecutor(u166, u167, ...);

                    if v168 then
                        u162(unpack(v170, 1, v169));

                        return;
                    end;

                    u163(v170[1]);
                end;
            else
                u165 = u162;
            end;

            if u161 then
                local u171 = u159;
                local u172 = u161;

                u163 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u171 (copy), u172 (copy), u162 (copy), u163 (copy)
                    local v173, v174, v175 = runExecutor(u171, u172, ...);

                    if v173 then
                        u162(unpack(v175, 1, v174));

                        return;
                    end;

                    u163(v175[1]);
                end;
            end;

            if u158._status == u43.Status.Started then
                table.insert(u158._queuedResolve, u165);
                table.insert(u158._queuedReject, u163);
                p164(function() -- Line: 1154
                    -- upvalues: u158 (ref), u43 (ref), u165 (ref), u163 (ref)
                    if u158._status == u43.Status.Started then
                        table.remove(u158._queuedResolve, table.find(u158._queuedResolve, u165));
                        table.remove(u158._queuedReject, table.find(u158._queuedReject, u163));
                    end;
                end);
            elseif u158._status == u43.Status.Resolved then
                u165(unpack(u158._values, 1, u158._valuesLength));
            elseif u158._status == u43.Status.Rejected then
                u163(unpack(u158._values, 1, u158._valuesLength));
            end;
        end, u158);
    end;

    local v176 = u43.new(function() -- Line: 1128
    end);
    v176:cancel();

    return v176;
end;

function u43.prototype.andThen(p177, p178, p179) -- Line: 1193
    local v180;

    if p178 == nil or type(p178) == "function" then
        v180 = true;
    elseif type(p178) == "table" then
        local v181 = getmetatable(p178);

        if v181 then
            local v182 = rawget(v181, "__call");
            v180 = type(v182) == "function";
        else
            v180 = false;
        end;
    else
        v180 = false;
    end;

    assert(v180, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v183;

    if p179 == nil or type(p179) == "function" then
        v183 = true;
    elseif type(p179) == "table" then
        local v184 = getmetatable(p179);

        if v184 then
            local v185 = rawget(v184, "__call");
            v183 = type(v185) == "function";
        else
            v183 = false;
        end;
    else
        v183 = false;
    end;

    assert(v183, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p177:_andThen(debug.traceback(nil, 2), p178, p179);
end;

function u43.prototype.catch(p186, p187) -- Line: 1220
    local v188;

    if p187 == nil or type(p187) == "function" then
        v188 = true;
    elseif type(p187) == "table" then
        local v189 = getmetatable(p187);

        if v189 then
            local v190 = rawget(v189, "__call");
            v188 = type(v190) == "function";
        else
            v188 = false;
        end;
    else
        v188 = false;
    end;

    assert(v188, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p186:_andThen(debug.traceback(nil, 2), nil, p187);
end;

function u43.prototype.tap(p191, u192) -- Line: 1241
    -- upvalues: u43 (copy), pack (copy)
    local v193;

    if type(u192) == "function" then
        v193 = true;
    elseif type(u192) == "table" then
        local v194 = getmetatable(u192);

        if v194 then
            local v195 = rawget(v194, "__call");
            v193 = type(v195) == "function";
        else
            v193 = false;
        end;
    else
        v193 = false;
    end;

    assert(v193, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p191:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1243
        -- upvalues: u192 (copy), u43 (ref), pack (ref)
        local v196 = u192(...);

        if not u43.is(v196) then
            return ...;
        end;

        local u197, u198 = pack(...);

        return v196:andThen(function() -- Line: 1248
            -- upvalues: u198 (copy), u197 (copy)
            return unpack(u198, 1, u197);
        end);
    end);
end;

function u43.prototype.andThenCall(p199, u200, ...) -- Line: 1276
    -- upvalues: pack (copy)
    local v201;

    if type(u200) == "function" then
        v201 = true;
    elseif type(u200) == "table" then
        local v202 = getmetatable(u200);

        if v202 then
            local v203 = rawget(v202, "__call");
            v201 = type(v203) == "function";
        else
            v201 = false;
        end;
    else
        v201 = false;
    end;

    assert(v201, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u204, u205 = pack(...);

    return p199:_andThen(debug.traceback(nil, 2), function() -- Line: 1279
        -- upvalues: u200 (copy), u205 (copy), u204 (copy)
        return u200(unpack(u205, 1, u204));
    end);
end;

function u43.prototype.andThenReturn(p206, ...) -- Line: 1306
    -- upvalues: pack (copy)
    local u207, u208 = pack(...);

    return p206:_andThen(debug.traceback(nil, 2), function() -- Line: 1308
        -- upvalues: u208 (copy), u207 (copy)
        return unpack(u208, 1, u207);
    end);
end;

function u43.prototype.cancel(p209) -- Line: 1324
    -- upvalues: u43 (copy)
    if p209._status ~= u43.Status.Started then
        return;
    end;

    p209._status = u43.Status.Cancelled;

    if p209._cancellationHook then
        p209._cancellationHook();
    end;

    coroutine.close(p209._thread);

    if p209._parent then
        p209._parent:_consumerCancelled(p209);
    end;

    for i in pairs(p209._consumers) do
        i:cancel();
    end;

    p209:_finalize();
end;

function u43.prototype._consumerCancelled(p210, p211) -- Line: 1352
    -- upvalues: u43 (copy)
    if p210._status ~= u43.Status.Started then
        return;
    end;

    p210._consumers[p211] = nil;

    if next(p210._consumers) == nil then
        p210:cancel();
    end;
end;

function u43.prototype._finally(u212, u213, u214) -- Line: 1368
    -- upvalues: u43 (copy), runExecutor (copy)
    u212._unhandledRejection = false;

    return u43._new(u213, function(u215, u216, p217) -- Line: 1371
        -- upvalues: u212 (copy), u214 (copy), runExecutor (ref), u213 (copy), u43 (ref)
        local u218 = nil;
        p217(function() -- Line: 1374
            -- upvalues: u212 (ref), u218 (ref)
            u212:_consumerCancelled(u212);

            if u218 then
                u218:cancel();
            end;
        end);
        local v223 = u214 and function(...) -- Line: 1387
            -- upvalues: runExecutor (ref), u213 (ref), u214 (ref), u216 (copy), u43 (ref), u218 (ref), u215 (copy), u212 (ref)
            local v219, _, v220 = runExecutor(u213, u214, ...);
            local v221 = v220[1];

            if not v219 then
                return u216(v221);
            end;

            if not u43.is(v221) then
                u215(u212);

                return;
            end;

            u218 = v221;
            v221:finally(function(p222) -- Line: 1398
                -- upvalues: u43 (ref), u215 (ref), u212 (ref)
                if p222 ~= u43.Status.Rejected then
                    u215(u212);
                end;
            end):catch(function(...) -- Line: 1403
                -- upvalues: u216 (ref)
                u216(...);
            end);
        end or u215;

        if u212._status == u43.Status.Started then
            table.insert(u212._queuedFinally, v223);
        else
            v223(u212._status);
        end;
    end);
end;

function u43.prototype.finally(p224, p225) -- Line: 1473
    local v226;

    if p225 == nil or type(p225) == "function" then
        v226 = true;
    elseif type(p225) == "table" then
        local v227 = getmetatable(p225);

        if v227 then
            local v228 = rawget(v227, "__call");
            v226 = type(v228) == "function";
        else
            v226 = false;
        end;
    else
        v226 = false;
    end;

    assert(v226, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p224:_finally(debug.traceback(nil, 2), p225);
end;

function u43.prototype.finallyCall(p229, u230, ...) -- Line: 1487
    -- upvalues: pack (copy)
    local v231;

    if type(u230) == "function" then
        v231 = true;
    elseif type(u230) == "table" then
        local v232 = getmetatable(u230);

        if v232 then
            local v233 = rawget(v232, "__call");
            v231 = type(v233) == "function";
        else
            v231 = false;
        end;
    else
        v231 = false;
    end;

    assert(v231, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u234, u235 = pack(...);

    return p229:_finally(debug.traceback(nil, 2), function() -- Line: 1490
        -- upvalues: u230 (copy), u235 (copy), u234 (copy)
        return u230(unpack(u235, 1, u234));
    end);
end;

function u43.prototype.finallyReturn(p236, ...) -- Line: 1513
    -- upvalues: pack (copy)
    local u237, u238 = pack(...);

    return p236:_finally(debug.traceback(nil, 2), function() -- Line: 1515
        -- upvalues: u238 (copy), u237 (copy)
        return unpack(u238, 1, u237);
    end);
end;

function u43.prototype.awaitStatus(p239) -- Line: 1527
    -- upvalues: u43 (copy)
    p239._unhandledRejection = false;

    if p239._status == u43.Status.Started then
        local coroutine_running_ret = coroutine.running();
        p239:finally(function() -- Line: 1534
            -- upvalues: coroutine_running_ret (copy)
            task.spawn(coroutine_running_ret);
        end):catch(function() -- Line: 1540
        end);
        coroutine.yield();
    end;

    if p239._status == u43.Status.Resolved then
        return p239._status, unpack(p239._values, 1, p239._valuesLength);
    end;

    if p239._status == u43.Status.Rejected then
        return p239._status, unpack(p239._values, 1, p239._valuesLength);
    end;

    return p239._status;
end;

local function awaitHelper(p240, ...) -- Line: 1555
    -- upvalues: u43 (copy)
    return p240 == u43.Status.Resolved, ...;
end;

function u43.prototype.await(p241) -- Line: 1580
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p241:awaitStatus());
end;

local function expectHelper(p242, ...) -- Line: 1584
    -- upvalues: u43 (copy)
    if p242 ~= u43.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u43.prototype.expect(p243) -- Line: 1617
    -- upvalues: expectHelper (copy)
    return expectHelper(p243:awaitStatus());
end;

u43.prototype.awaitValue = u43.prototype.expect;

function u43.prototype._unwrap(p244) -- Line: 1631
    -- upvalues: u43 (copy)
    if p244._status == u43.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p244._status == u43.Status.Resolved, unpack(p244._values, 1, p244._valuesLength);
end;

function u43.prototype._resolve(u245, ...) -- Line: 1641
    -- upvalues: u43 (copy), u10 (ref), pack (copy)
    if u245._status ~= u43.Status.Started then
        if u43.is((...)) then
            (...):_consumerCancelled(u245);
        end;

        return;
    end;

    if u43.is((...)) then
        if select("#", ...) > 1 then
            local string_format_ret = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u245._source);
            warn(string_format_ret);
        end;

        local u246 = ...;
        local v248 = u246:andThen(function(...) -- Line: 1662
            -- upvalues: u245 (copy)
            u245:_resolve(...);
        end, function(...) -- Line: 1664
            -- upvalues: u246 (copy), u10 (ref), u245 (copy)
            local v247 = u246._values[1];

            if u246._error then
                v247 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u246._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v247, u10.Kind.ExecutionError) then
                return u245:_reject(v247:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u245._source)
                }));
            end;

            u245:_reject(...);
        end);

        if v248._status == u43.Status.Cancelled then
            u245:cancel();

            return;
        end;

        if v248._status == u43.Status.Started then
            u245._parent = v248;
            v248._consumers[u245] = true;
        end;

        return;
    end;

    u245._status = u43.Status.Resolved;
    local v249, v250 = pack(...);
    u245._valuesLength = v249;
    u245._values = v250;

    for _, v in ipairs(u245._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u245:_finalize();
end;

function u43.prototype._reject(u251, ...) -- Line: 1712
    -- upvalues: u43 (copy), pack (copy)
    if u251._status ~= u43.Status.Started then
        return;
    end;

    u251._status = u43.Status.Rejected;
    local v252, v253 = pack(...);
    u251._valuesLength = v252;
    u251._values = v253;

    if next(u251._queuedReject) == nil then
        local u254 = tostring((...));
        coroutine.wrap(function() -- Line: 1734
            -- upvalues: u43 (ref), u251 (copy), u254 (copy)
            u43._timeEvent:Wait();

            if not u251._unhandledRejection then
                return;
            end;

            local string_format_ret = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u254, u251._source);

            for _, v in ipairs(u43._unhandledRejectionCallbacks) do
                task.spawn(v, u251, unpack(u251._values, 1, u251._valuesLength));
            end;

            if u43.TEST then
                return;
            end;

            warn(string_format_ret);
        end)();
    else
        for _, v in ipairs(u251._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u251:_finalize();
end;

function u43.prototype._finalize(p255) -- Line: 1766
    -- upvalues: u43 (copy)
    for _, v in ipairs(p255._queuedFinally) do
        coroutine.wrap(v)(p255._status);
    end;

    p255._queuedFinally = nil;
    p255._queuedReject = nil;
    p255._queuedResolve = nil;

    if not u43.TEST then
        p255._parent = nil;
        p255._consumers = nil;
    end;

    task.defer(coroutine.close, p255._thread);
end;

function u43.prototype.now(p256, p257) -- Line: 1803
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    if p256._status == u43.Status.Resolved then
        return p256:_andThen(debug_traceback_ret, function(...) -- Line: 1806
            return ...;
        end);
    end;

    local reject = u43.reject;

    if p257 == nil then
        p257 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. debug_traceback_ret
        }) or p257;
    end;

    return reject(p257);
end;

function u43.retry(u258, u259, ...) -- Line: 1848
    -- upvalues: u43 (copy)
    local v260;

    if type(u258) == "function" then
        v260 = true;
    elseif type(u258) == "table" then
        local v261 = getmetatable(u258);

        if v261 then
            local v262 = rawget(v261, "__call");
            v260 = type(v262) == "function";
        else
            v260 = false;
        end;
    else
        v260 = false;
    end;

    assert(v260, "Parameter #1 to Promise.retry must be a function");
    local v263 = type(u259) == "number";
    assert(v263, "Parameter #2 to Promise.retry must be a number");
    local u264 = { ... };
    local u265 = select("#", ...);

    return u43.resolve(u258(...)):catch(function(...) -- Line: 1854
        -- upvalues: u259 (copy), u43 (ref), u258 (copy), u264 (copy), u265 (copy)
        if u259 > 0 then
            return u43.retry(u258, u259 - 1, unpack(u264, 1, u265));
        end;

        return u43.reject(...);
    end);
end;

function u43.retryWithDelay(u266, u267, u268, ...) -- Line: 1876
    -- upvalues: u43 (copy)
    local v269;

    if type(u266) == "function" then
        v269 = true;
    elseif type(u266) == "table" then
        local v270 = getmetatable(u266);

        if v270 then
            local v271 = rawget(v270, "__call");
            v269 = type(v271) == "function";
        else
            v269 = false;
        end;
    else
        v269 = false;
    end;

    assert(v269, "Parameter #1 to Promise.retry must be a function");
    local v272 = type(u267) == "number";
    assert(v272, "Parameter #2 (times) to Promise.retry must be a number");
    local v273 = type(u268) == "number";
    assert(v273, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u274 = { ... };
    local u275 = select("#", ...);

    return u43.resolve(u266(...)):catch(function(...) -- Line: 1883
        -- upvalues: u267 (copy), u43 (ref), u268 (copy), u266 (copy), u274 (copy), u275 (copy)
        if u267 <= 0 then
            return u43.reject(...);
        end;

        u43.delay(u268):await();

        return u43.retryWithDelay(u266, u267 - 1, u268, unpack(u274, 1, u275));
    end);
end;

function u43.fromEvent(u276, p277) -- Line: 1918
    -- upvalues: u43 (copy)
    local u278 = p277 or function() -- Line: 1919
        return true;
    end;

    return u43._new(debug.traceback(nil, 2), function(u279, p280, p281) -- Line: 1923
        -- upvalues: u276 (copy), u278 (ref)
        local u282 = nil;
        local u283 = false;

        local function disconnect() -- Line: 1927
            -- upvalues: u282 (ref)
            u282:Disconnect();
            u282 = nil;
        end;

        u282 = u276:Connect(function(...) -- Line: 1936
            -- upvalues: u278 (ref), u279 (copy), u282 (ref), u283 (ref)
            local v284 = u278(...);

            if v284 ~= true then
                if type(v284) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u279(...);

            if not u282 then
                u283 = true;

                return;
            end;

            u282:Disconnect();
            u282 = nil;
        end);

        if u283 and u282 then
            return disconnect();
        end;

        p281(disconnect);
    end);
end;

function u43.onUnhandledRejection(u285) -- Line: 1970
    -- upvalues: u43 (copy)
    table.insert(u43._unhandledRejectionCallbacks, u285);

    return function() -- Line: 1973
        -- upvalues: u43 (ref), u285 (copy)
        local table_find_ret = table.find(u43._unhandledRejectionCallbacks, u285);

        if table_find_ret then
            table.remove(u43._unhandledRejectionCallbacks, table_find_ret);
        end;
    end;
end;

return u43;