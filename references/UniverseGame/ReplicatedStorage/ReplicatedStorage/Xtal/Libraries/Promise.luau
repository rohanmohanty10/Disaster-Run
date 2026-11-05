  

 

local u1 = {
    __mode = "k"
};

local function makeEnum(u2, p3) -- Line: 13
    local v4 = {};

    for _, v in ipairs(p3) do
        v4[v] = v;
    end;

    return setmetatable(v4, {
        __index = function(p5, p6) -- Line: 21, Name: __index
            -- upvalues: u2 (copy)
            error(string.format("%s is not in %s!", p6, u2), 2);
        end,

        __newindex = function() -- Line: 24, Name: __newindex
            -- upvalues: u2 (copy)
            error(string.format("Creating new members in %s is not allowed!", u2), 2);
        end
    });
end;

local u7 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u7.__index = u7;

function u7.new(p8, p9) -- Line: 46
    -- upvalues: u7 (ref)
    local v10 = p8 or {};
    local v11 = {
        error = tostring(v10.error) or "[This error has no error text.]",
        trace = v10.trace,
        context = v10.context,
        kind = v10.kind,
        parent = p9,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v11, u7);
end;

function u7.is(p12) -- Line: 59
    if type(p12) == "table" then
        local v13 = getmetatable(p12);

        if type(v13) == "table" then
            local v14;

            if rawget(p12, "error") == nil then
                v14 = false;
            else
                local v15 = rawget(v13, "extend");
                v14 = type(v15) == "function";
            end;

            return v14;
        end;
    end;

    return false;
end;

function u7.isKind(p16, p17) -- Line: 71
    -- upvalues: u7 (ref)
    assert(p17 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v18 = u7.is(p16) and p16.kind == p17;

    return v18;
end;

function u7.extend(p19, p20) -- Line: 77
    -- upvalues: u7 (ref)
    local v21 = p20 or {};
    v21.kind = v21.kind or p19.kind;

    return u7.new(v21, p19);
end;

function u7.getErrorChain(p22) -- Line: 85
    local v23 = { p22 };

    while v23[#v23].parent do
        table.insert(v23, v23[#v23].parent);
    end;

    return v23;
end;

function u7.__tostring(p24) -- Line: 95
    local v25 = { string.format("-- Promise.Error(%s) --", p24.kind or "?") };

    for _, v in ipairs(p24:getErrorChain()) do
        table.insert(v25, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v25, "\n");
end;

local function pack(...) -- Line: 116
    return select("#", ...), { ... };
end;

local function packResult(p26, ...) -- Line: 123
    return p26, select("#", ...), { ... };
end;

local function makeErrorHandler(u27) -- Line: 127
    -- upvalues: u7 (ref)
    assert(u27 ~= nil);

    return function(p28) -- Line: 130
        -- upvalues: u7 (ref), u27 (copy)
        if type(p28) == "table" then
            return p28;
        end;

        return u7.new({
            error = p28,
            kind = u7.Kind.ExecutionError,
            trace = debug.traceback(tostring(p28), 2),
            context = "Promise created at:\n\n" .. u27
        });
    end;
end;

local function runExecutor(u29, p30, ...) -- Line: 150
    -- upvalues: packResult (copy), u7 (ref)
    local v31 = xpcall;
    assert(u29 ~= nil);

    return packResult(v31(p30, function(p32) -- Line: 130
        -- upvalues: u7 (ref), u29 (copy)
        if type(p32) == "table" then
            return p32;
        end;

        return u7.new({
            error = p32,
            kind = u7.Kind.ExecutionError,
            trace = debug.traceback(tostring(p32), 2),
            context = "Promise created at:\n\n" .. u29
        });
    end, ...));
end;

local function createAdvancer(u33, u34, u35, u36) -- Line: 158
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 159
        -- upvalues: runExecutor (ref), u33 (copy), u34 (copy), u35 (copy), u36 (copy)
        local v37, v38, v39 = runExecutor(u33, u34, ...);

        if v37 then
            u35(unpack(v39, 1, v38));

            return;
        end;

        u36(v39[1]);
    end;
end;

local function isEmpty(p40) -- Line: 170
    return next(p40) == nil;
end;

local u41 = {
    Error = u7,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    prototype = {}
};
u41.__index = u41.prototype;

function u41._new(p42, u43, p44) -- Line: 195
    -- upvalues: u41 (copy), u1 (copy), runExecutor (copy)
    if p44 ~= nil and not u41.is(p44) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u45 = {
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p42,
        _status = u41.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p44,
        _consumers = setmetatable({}, u1)
    };

    if p44 and p44._status == u41.Status.Started then
        p44._consumers[u45] = true;
    end;

    setmetatable(u45, u41);

    local function resolve(...) -- Line: 240
        -- upvalues: u45 (copy)
        u45:_resolve(...);
    end;

    local function reject(...) -- Line: 244
        -- upvalues: u45 (copy)
        u45:_reject(...);
    end;

    local function onCancel(p46) -- Line: 248
        -- upvalues: u45 (copy), u41 (ref)
        if p46 then
            if u45._status == u41.Status.Cancelled then
                p46();
            else
                u45._cancellationHook = p46;
            end;
        end;

        return u45._status == u41.Status.Cancelled;
    end;

    coroutine.wrap(function() -- Line: 260
        -- upvalues: runExecutor (ref), u45 (copy), u43 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v47, _, v48 = runExecutor(u45._source, u43, resolve, reject, onCancel);

        if not v47 then
            reject(v48[1]);
        end;
    end)();

    return u45;
end;

function u41.new(p49) -- Line: 277
    -- upvalues: u41 (copy)
    return u41._new(debug.traceback(nil, 2), p49);
end;

function u41.__tostring(p50) -- Line: 281
    return string.format("Promise(%s)", p50._status);
end;

function u41.defer(u51) -- Line: 288
    -- upvalues: u41 (copy), runExecutor (copy)
    local u52 = debug.traceback(nil, 2);

    return u41._new(u52, function(u53, u54, u55) -- Line: 291
        -- upvalues: u41 (ref), runExecutor (ref), u52 (copy), u51 (copy)
        local u56 = nil;
        u56 = u41._timeEvent:Connect(function() -- Line: 293
            -- upvalues: u56 (ref), runExecutor (ref), u52 (ref), u51 (ref), u53 (copy), u54 (copy), u55 (copy)
            u56:Disconnect();
            local v57, _, v58 = runExecutor(u52, u51, u53, u54, u55);

            if not v57 then
                u54(v58[1]);
            end;
        end);
    end);
end;

u41.async = u41.defer;

function u41.resolve(...) -- Line: 312
    -- upvalues: pack (copy), u41 (copy)
    local u59, u60 = pack(...);

    return u41._new(debug.traceback(nil, 2), function(p61) -- Line: 314
        -- upvalues: u60 (copy), u59 (copy)
        p61(unpack(u60, 1, u59));
    end);
end;

function u41.reject(...) -- Line: 322
    -- upvalues: pack (copy), u41 (copy)
    local u62, u63 = pack(...);

    return u41._new(debug.traceback(nil, 2), function(p64, p65) -- Line: 324
        -- upvalues: u63 (copy), u62 (copy)
        p65(unpack(u63, 1, u62));
    end);
end;

function u41._try(p66, u67, ...) -- Line: 333
    -- upvalues: pack (copy), u41 (copy)
    local u68, u69 = pack(...);

    return u41._new(p66, function(p70) -- Line: 336
        -- upvalues: u67 (copy), u69 (copy), u68 (copy)
        p70(u67(unpack(u69, 1, u68)));
    end);
end;

function u41.try(...) -- Line: 344
    -- upvalues: u41 (copy)
    return u41._try(debug.traceback(nil, 2), ...);
end;

function u41._all(p71, u72, u73) -- Line: 353
    -- upvalues: u41 (copy)
    if type(u72) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u72) do
        if not u41.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u72 == 0 or u73 == 0 then
        return u41.resolve({});
    end;

    return u41._new(p71, function(u74, u75, p76) -- Line: 371
        -- upvalues: u73 (copy), u72 (copy)
        local u77 = {};
        local u78 = {};
        local u79 = 0;
        local u80 = 0;
        local u81 = false;

        local function resolveOne(p82, ...) -- Line: 389
            -- upvalues: u81 (ref), u79 (ref), u73 (ref), u77 (copy), u72 (ref), u74 (copy), u78 (copy)
            if u81 then
                return;
            end;

            u79 = u79 + 1;

            if u73 == nil then
                u77[p82] = ...;
            else
                u77[u79] = ...;
            end;

            if u79 >= (u73 or #u72) then
                u81 = true;
                u74(u77);

                for _, v in ipairs(u78) do
                    v:cancel();
                end;
            end;
        end;

        p76(function() -- Line: 382, Name: cancel
            -- upvalues: u78 (copy)
            for _, v in ipairs(u78) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u72) do
            u78[i] = v:andThen(function(...) -- Line: 415
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 418
                -- upvalues: u80 (ref), u73 (ref), u72 (ref), u78 (copy), u81 (ref), u75 (copy)
                u80 = u80 + 1;

                if u73 == nil or #u72 - u80 < u73 then
                    for _, v2 in ipairs(u78) do
                        v2:cancel();
                    end;

                    u81 = true;
                    u75(...);
                end;
            end);
        end;

        if u81 then
            for _, v in ipairs(u78) do
                v:cancel();
            end;
        end;
    end);
end;

function u41.all(p83) -- Line: 437
    -- upvalues: u41 (copy)
    return u41._all(debug.traceback(nil, 2), p83);
end;

function u41.fold(p84, u85, p86) -- Line: 441
    -- upvalues: u41 (copy)
    local v87 = type(p84) == "table";
    assert(v87, "Bad argument #1 to Promise.fold: must be a table");
    local v88 = type(u85) == "function";
    assert(v88, "Bad argument #2 to Promise.fold: must be a function");
    local u89 = u41.resolve(p86);

    return u41.each(p84, function(u90, u91) -- Line: 446
        -- upvalues: u89 (ref), u85 (copy)
        u89 = u89:andThen(function(p92) -- Line: 447
            -- upvalues: u85 (ref), u90 (copy), u91 (copy)
            return u85(p92, u90, u91);
        end);
    end):andThenReturn(u89);
end;

function u41.some(p93, p94) -- Line: 453
    -- upvalues: u41 (copy)
    local v95 = type(p94) == "number";
    assert(v95, "Bad argument #2 to Promise.some: must be a number");

    return u41._all(debug.traceback(nil, 2), p93, p94);
end;

function u41.any(p96) -- Line: 459
    -- upvalues: u41 (copy)
    return u41._all(debug.traceback(nil, 2), p96, 1):andThen(function(p97) -- Line: 460
        return p97[1];
    end);
end;

function u41.allSettled(u98) -- Line: 465
    -- upvalues: u41 (copy)
    if type(u98) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u98) do
        if not u41.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u98 == 0 then
        return u41.resolve({});
    end;

    return u41._new(debug.traceback(nil, 2), function(u99, p100, p101) -- Line: 483
        -- upvalues: u98 (copy)
        local u102 = {};
        local u103 = {};
        local u104 = 0;

        local function u106(p105, ...) -- Line: 493
            -- upvalues: u104 (ref), u102 (copy), u98 (ref), u99 (copy)
            u104 = u104 + 1;
            u102[p105] = ...;

            if u104 >= #u98 then
                u99(u102);
            end;
        end;

        p101(function() -- Line: 503
            -- upvalues: u103 (copy)
            for _, v in ipairs(u103) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u98) do
            u103[i] = v:finally(function(...) -- Line: 513
                -- upvalues: u106 (copy), i (copy)
                u106(i, ...);
            end);
        end;
    end);
end;

function u41.race(u107) -- Line: 525
    -- upvalues: u41 (copy)
    local v108 = type(u107) == "table";
    assert(v108, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u107) do
        local v109 = u41.is(v);
        local format = string.format;
        local v110 = tostring(i);
        assert(v109, format("Non-promise value passed into %s at index %s", "Promise.race", v110));
    end;

    return u41._new(debug.traceback(nil, 2), function(u111, u112, p113) -- Line: 532
        -- upvalues: u107 (copy)
        local u114 = {};
        local u115 = false;

        local function cancel() -- Line: 536
            -- upvalues: u114 (copy)
            for _, v in ipairs(u114) do
                v:cancel();
            end;
        end;

        local function finalize(u116) -- Line: 542
            -- upvalues: u114 (copy), u115 (ref)
            return function(...) -- Line: 543
                -- upvalues: u114 (ref), u115 (ref), u116 (copy)
                for _, v in ipairs(u114) do
                    v:cancel();
                end;

                u115 = true;

                return u116(...);
            end;
        end;

        if p113(function(...) -- Line: 543
            -- upvalues: u114 (copy), u115 (ref), u112 (copy)
            for _, v in ipairs(u114) do
                v:cancel();
            end;

            u115 = true;

            return u112(...);
        end) then
            return;
        end;

        for i, v in ipairs(u107) do
            u114[i] = v:andThen(function(...) -- Line: 543
                -- upvalues: u114 (copy), u115 (ref), u111 (copy)
                for _, v2 in ipairs(u114) do
                    v2:cancel();
                end;

                u115 = true;

                return u111(...);
            end, function(...) -- Line: 543
                -- upvalues: u114 (copy), u115 (ref), u112 (copy)
                for _, v2 in ipairs(u114) do
                    v2:cancel();
                end;

                u115 = true;

                return u112(...);
            end);
        end;

        if u115 then
            for _, v in ipairs(u114) do
                v:cancel();
            end;
        end;
    end);
end;

function u41.each(u117, u118) -- Line: 572
    -- upvalues: u41 (copy), u7 (ref)
    local v119 = type(u117) == "table";
    assert(v119, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v120 = type(u118) == "function";
    assert(v120, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u41._new(debug.traceback(nil, 2), function(p121, p122, p123) -- Line: 576
        -- upvalues: u117 (copy), u41 (ref), u7 (ref), u118 (copy)
        local v124 = {};
        local u125 = {};
        local u126 = false;

        local function _() -- Line: 582
            -- upvalues: u125 (copy)
            for _, v in ipairs(u125) do
                v:cancel();
            end;
        end;

        p123(function() -- Line: 588
            -- upvalues: u126 (ref), u125 (copy)
            u126 = true;

            for _, v in ipairs(u125) do
                v:cancel();
            end;
        end);
        local v127 = {};

        for i, v in ipairs(u117) do
            if u41.is(v) then
                if v:getStatus() == u41.Status.Cancelled then
                    for _, v2 in ipairs(u125) do
                        v2:cancel();
                    end;

                    return p122(u7.new({
                        error = "Promise is cancelled",
                        kind = u7.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u41.Status.Rejected then
                    for _, v2 in ipairs(u125) do
                        v2:cancel();
                    end;

                    return p122(select(2, v:await()));
                end;

                local v128 = v:andThen(function(...) -- Line: 621
                    return ...;
                end);
                table.insert(u125, v128);
                v127[i] = v128;
            else
                v127[i] = v;
            end;
        end;

        for i, v in ipairs(v127) do
            if u41.is(v) then
                local v129, v = v:await();

                if not v129 then
                    for _, v2 in ipairs(u125) do
                        v2:cancel();
                    end;

                    return p122(v);
                end;
            end;

            if u126 then
                return;
            end;

            local v130 = u41.resolve(u118(v, i));
            table.insert(u125, v130);
            local v131, v132 = v130:await();

            if not v131 then
                for _, v2 in ipairs(u125) do
                    v2:cancel();
                end;

                return p122(v132);
            end;

            v124[i] = v132;
        end;

        p121(v124);
    end);
end;

function u41.is(p133) -- Line: 668
    -- upvalues: u41 (copy)
    if type(p133) ~= "table" then
        return false;
    end;

    local v134 = getmetatable(p133);

    if v134 == u41 then
        return true;
    end;

    if v134 == nil then
        return type(p133.andThen) == "function";
    end;

    if type(v134) == "table" then
        local v135 = rawget(v134, "__index");

        if type(v135) == "table" then
            local v136 = rawget(v134, "__index");
            local v137 = rawget(v136, "andThen");

            if type(v137) == "function" then
                return true;
            end;
        end;
    end;

    return false;
end;

function u41.promisify(u138) -- Line: 696
    -- upvalues: u41 (copy)
    return function(...) -- Line: 697
        -- upvalues: u41 (ref), u138 (copy)
        return u41._try(debug.traceback(nil, 2), u138, ...);
    end;
end;

local u139 = nil;
local u140 = nil;

function u41.delay(p141) -- Line: 712
    -- upvalues: u41 (copy), u140 (ref), u139 (ref)
    local v142 = type(p141) == "number";
    assert(v142, "Bad argument #1 to Promise.delay, must be a number.");
    local u143 = (p141 < 0.016666666666666666 or p141 == (1 / 0)) and 0.016666666666666666 or p141;

    return u41._new(debug.traceback(nil, 2), function(p144, p145, p146) -- Line: 720
        -- upvalues: u41 (ref), u143 (ref), u140 (ref), u139 (ref)
        local v147 = u41._getTime();
        local v148 = v147 + u143;
        local u149 = {
            resolve = p144,
            startTime = v147,
            endTime = v148
        };

        if u140 == nil then
            u139 = u149;
            u140 = u41._timeEvent:Connect(function() -- Line: 732
                -- upvalues: u41 (ref), u139 (ref), u140 (ref)
                local v150 = u41._getTime();

                while u139 ~= nil and u139.endTime < v150 do
                    local v151 = u139;
                    u139 = v151.next;

                    if u139 == nil then
                        u140:Disconnect();
                        u140 = nil;
                    else
                        u139.previous = nil;
                    end;

                    v151.resolve(u41._getTime() - v151.startTime);
                end;
            end);
        elseif u139.endTime < v148 then
            local v152 = u139;
            local next2 = v152.next;

            while next2 ~= nil and next2.endTime < v148 do
                v152 = next2;
                next2 = next2.next;
            end;

            v152.next = u149;
            u149.previous = v152;

            if next2 ~= nil then
                u149.next = next2;
                next2.previous = u149;
            end;
        else
            u149.next = u139;
            u139.previous = u149;
            u139 = u149;
        end;

        p146(function() -- Line: 777
            -- upvalues: u149 (copy), u139 (ref), u140 (ref)
            local next2 = u149.next;

            if u139 == u149 then
                if next2 == nil then
                    u140:Disconnect();
                    u140 = nil;
                else
                    next2.previous = nil;
                end;

                u139 = next2;

                return;
            end;

            local previous = u149.previous;
            previous.next = next2;

            if next2 ~= nil then
                next2.previous = previous;
            end;
        end);
    end);
end;

function u41.prototype.timeout(p153, u154, u155) -- Line: 806
    -- upvalues: u41 (copy), u7 (ref)
    local u156 = debug.traceback(nil, 2);

    return u41.race({ u41.delay(u154):andThen(function() -- Line: 810
            -- upvalues: u41 (ref), u155 (copy), u7 (ref), u154 (copy), u156 (copy)
            return u41.reject(u155 == nil and u7.new({
                error = "Timed out",
                kind = u7.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u154, u156)
            }) or u155);
        end), p153 });
end;

function u41.prototype.getStatus(p157) -- Line: 825
    return p157._status;
end;

function u41.prototype._andThen(u158, u159, u160, u161) -- Line: 834
    -- upvalues: u41 (copy), runExecutor (copy), u7 (ref)
    u158._unhandledRejection = false;

    return u41._new(u159, function(u162, u163) -- Line: 838
        -- upvalues: u160 (copy), u159 (copy), runExecutor (ref), u161 (copy), u158 (copy), u41 (ref), u7 (ref)
        local v164;

        if u160 then
            local u165 = u159;
            local u166 = u160;

            v164 = function(...) -- Line: 159
                -- upvalues: runExecutor (ref), u165 (copy), u166 (copy), u162 (copy), u163 (copy)
                local v167, v168, v169 = runExecutor(u165, u166, ...);

                if v167 then
                    u162(unpack(v169, 1, v168));

                    return;
                end;

                u163(v169[1]);
            end;
        else
            v164 = u162;
        end;

        local v170;

        if u161 then
            local u171 = u159;
            local u172 = u161;

            v170 = function(...) -- Line: 159
                -- upvalues: runExecutor (ref), u171 (copy), u172 (copy), u162 (copy), u163 (copy)
                local v173, v174, v175 = runExecutor(u171, u172, ...);

                if v173 then
                    u162(unpack(v175, 1, v174));

                    return;
                end;

                u163(v175[1]);
            end;
        else
            v170 = u163;
        end;

        if u158._status == u41.Status.Started then
            table.insert(u158._queuedResolve, v164);
            table.insert(u158._queuedReject, v170);

            return;
        end;

        if u158._status == u41.Status.Resolved then
            v164(unpack(u158._values, 1, u158._valuesLength));

            return;
        end;

        if u158._status == u41.Status.Rejected then
            v170(unpack(u158._values, 1, u158._valuesLength));

            return;
        end;

        if u158._status == u41.Status.Cancelled then
            u163(u7.new({
                error = "Promise is cancelled",
                kind = u7.Kind.AlreadyCancelled,
                context = "Promise created at\n\n" .. u159
            }));
        end;
    end, u158);
end;

function u41.prototype.andThen(p176, p177, p178) -- Line: 884
    local v179 = p177 == nil and true or type(p177) == "function";
    assert(v179, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v180 = p178 == nil and true or type(p178) == "function";
    assert(v180, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p176:_andThen(debug.traceback(nil, 2), p177, p178);
end;

function u41.prototype.catch(p181, p182) -- Line: 900
    local v183 = p182 == nil and true or type(p182) == "function";
    assert(v183, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p181:_andThen(debug.traceback(nil, 2), nil, p182);
end;

function u41.prototype.tap(p184, u185) -- Line: 912
    -- upvalues: u41 (copy), pack (copy)
    local v186 = type(u185) == "function";
    assert(v186, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p184:_andThen(debug.traceback(nil, 2), function(...) -- Line: 914
        -- upvalues: u185 (copy), u41 (ref), pack (ref)
        local v187 = u185(...);

        if not u41.is(v187) then
            return ...;
        end;

        local u188, u189 = pack(...);

        return v187:andThen(function() -- Line: 919
            -- upvalues: u189 (copy), u188 (copy)
            return unpack(u189, 1, u188);
        end);
    end);
end;

function u41.prototype.andThenCall(p190, u191, ...) -- Line: 931
    -- upvalues: pack (copy)
    local v192 = type(u191) == "function";
    assert(v192, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u193, u194 = pack(...);

    return p190:_andThen(debug.traceback(nil, 2), function() -- Line: 934
        -- upvalues: u191 (copy), u194 (copy), u193 (copy)
        return u191(unpack(u194, 1, u193));
    end);
end;

function u41.prototype.andThenReturn(p195, ...) -- Line: 942
    -- upvalues: pack (copy)
    local u196, u197 = pack(...);

    return p195:_andThen(debug.traceback(nil, 2), function() -- Line: 944
        -- upvalues: u197 (copy), u196 (copy)
        return unpack(u197, 1, u196);
    end);
end;

function u41.prototype.cancel(p198) -- Line: 953
    -- upvalues: u41 (copy)
    if p198._status ~= u41.Status.Started then
        return;
    end;

    p198._status = u41.Status.Cancelled;

    if p198._cancellationHook then
        p198._cancellationHook();
    end;

    if p198._parent then
        p198._parent:_consumerCancelled(p198);
    end;

    for i in pairs(p198._consumers) do
        i:cancel();
    end;

    p198:_finalize();
end;

function u41.prototype._consumerCancelled(p199, p200) -- Line: 979
    -- upvalues: u41 (copy)
    if p199._status ~= u41.Status.Started then
        return;
    end;

    p199._consumers[p200] = nil;

    if next(p199._consumers) == nil then
        p199:cancel();
    end;
end;

function u41.prototype._finally(u201, u202, u203, u204) -- Line: 995
    -- upvalues: u41 (copy), runExecutor (copy)
    if not u204 then
        u201._unhandledRejection = false;
    end;

    return u41._new(u202, function(u205, u206) -- Line: 1001
        -- upvalues: u203 (copy), u202 (copy), runExecutor (ref), u204 (copy), u201 (copy), u41 (ref)
        local u207;

        if u203 then
            local u208 = u202;
            local u209 = u203;

            u207 = function(...) -- Line: 159
                -- upvalues: runExecutor (ref), u208 (copy), u209 (copy), u205 (copy), u206 (copy)
                local v210, v211, v212 = runExecutor(u208, u209, ...);

                if v210 then
                    u205(unpack(v212, 1, v211));

                    return;
                end;

                u206(v212[1]);
            end;
        else
            u207 = u205;
        end;

        local v213 = u204 and function(...) -- Line: 1014
            -- upvalues: u201 (ref), u41 (ref), u205 (copy), u207 (copy)
            if u201._status == u41.Status.Rejected then
                return u205(u201);
            end;

            return u207(...);
        end or u207;

        if u201._status == u41.Status.Started then
            table.insert(u201._queuedFinally, v213);

            return;
        end;

        v213(u201._status);
    end, u201);
end;

function u41.prototype.finally(p214, p215) -- Line: 1033
    local v216 = p215 == nil and true or type(p215) == "function";
    assert(v216, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p214:_finally(debug.traceback(nil, 2), p215);
end;

function u41.prototype.finallyCall(p217, u218, ...) -- Line: 1044
    -- upvalues: pack (copy)
    local v219 = type(u218) == "function";
    assert(v219, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u220, u221 = pack(...);

    return p217:_finally(debug.traceback(nil, 2), function() -- Line: 1047
        -- upvalues: u218 (copy), u221 (copy), u220 (copy)
        return u218(unpack(u221, 1, u220));
    end);
end;

function u41.prototype.finallyReturn(p222, ...) -- Line: 1055
    -- upvalues: pack (copy)
    local u223, u224 = pack(...);

    return p222:_finally(debug.traceback(nil, 2), function() -- Line: 1057
        -- upvalues: u224 (copy), u223 (copy)
        return unpack(u224, 1, u223);
    end);
end;

function u41.prototype.done(p225, p226) -- Line: 1065
    local v227 = p226 == nil and true or type(p226) == "function";
    assert(v227, string.format("Please pass a handler function to %s!", "Promise:done"));

    return p225:_finally(debug.traceback(nil, 2), p226, true);
end;

function u41.prototype.doneCall(p228, u229, ...) -- Line: 1076
    -- upvalues: pack (copy)
    local v230 = type(u229) == "function";
    assert(v230, string.format("Please pass a handler function to %s!", "Promise:doneCall"));
    local u231, u232 = pack(...);

    return p228:_finally(debug.traceback(nil, 2), function() -- Line: 1079
        -- upvalues: u229 (copy), u232 (copy), u231 (copy)
        return u229(unpack(u232, 1, u231));
    end, true);
end;

function u41.prototype.doneReturn(p233, ...) -- Line: 1087
    -- upvalues: pack (copy)
    local u234, u235 = pack(...);

    return p233:_finally(debug.traceback(nil, 2), function() -- Line: 1089
        -- upvalues: u235 (copy), u234 (copy)
        return unpack(u235, 1, u234);
    end, true);
end;

function u41.prototype.awaitStatus(p236) -- Line: 1099
    -- upvalues: u41 (copy)
    p236._unhandledRejection = false;

    if p236._status == u41.Status.Started then
        local BindableEvent = Instance.new("BindableEvent");
        p236:finally(function() -- Line: 1105
            -- upvalues: BindableEvent (copy)
            BindableEvent:Fire();
        end);
        BindableEvent.Event:Wait();
        BindableEvent:Destroy();
    end;

    if p236._status == u41.Status.Resolved then
        return p236._status, unpack(p236._values, 1, p236._valuesLength);
    end;

    if p236._status == u41.Status.Rejected then
        return p236._status, unpack(p236._values, 1, p236._valuesLength);
    end;

    return p236._status;
end;

local function awaitHelper(p237, ...) -- Line: 1122
    -- upvalues: u41 (copy)
    return p237 == u41.Status.Resolved, ...;
end;

function u41.prototype.await(p238) -- Line: 1129
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p238:awaitStatus());
end;

local function expectHelper(p239, ...) -- Line: 1133
    -- upvalues: u41 (copy)
    if p239 ~= u41.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u41.prototype.expect(p240) -- Line: 1145
    -- upvalues: expectHelper (copy)
    return expectHelper(p240:awaitStatus());
end;

u41.prototype.awaitValue = u41.prototype.expect;

function u41.prototype._unwrap(p241) -- Line: 1159
    -- upvalues: u41 (copy)
    if p241._status == u41.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p241._status == u41.Status.Resolved, unpack(p241._values, 1, p241._valuesLength);
end;

function u41.prototype._resolve(u242, ...) -- Line: 1169
    -- upvalues: u41 (copy), u7 (ref), pack (copy)
    if u242._status ~= u41.Status.Started then
        if u41.is((...)) then
            (...):_consumerCancelled(u242);
        end;

        return;
    end;

    if u41.is((...)) then
        if select("#", ...) > 1 then
            local v243 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u242._source);
            warn(v243);
        end;

        local u244 = ...;
        local v246 = u244:andThen(function(...) -- Line: 1192
            -- upvalues: u242 (copy)
            u242:_resolve(...);
        end, function(...) -- Line: 1195
            -- upvalues: u244 (copy), u7 (ref), u242 (copy)
            local v245 = u244._values[1];

            if u244._error then
                v245 = u7.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u244._error,
                    kind = u7.Kind.ExecutionError
                });
            end;

            if u7.isKind(v245, u7.Kind.ExecutionError) then
                return u242:_reject(v245:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u242._source)
                }));
            end;

            u242:_reject(...);
        end);

        if v246._status == u41.Status.Cancelled then
            u242:cancel();

            return;
        end;

        if v246._status == u41.Status.Started then
            u242._parent = v246;
            v246._consumers[u242] = true;
        end;

        return;
    end;

    u242._status = u41.Status.Resolved;
    local v247, v248 = pack(...);
    u242._valuesLength = v247;
    u242._values = v248;

    for _, v in ipairs(u242._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u242:_finalize();
end;

function u41.prototype._reject(u249, ...) -- Line: 1244
    -- upvalues: u41 (copy), pack (copy)
    if u249._status ~= u41.Status.Started then
        return;
    end;

    u249._status = u41.Status.Rejected;
    local v250, v251 = pack(...);
    u249._valuesLength = v250;
    u249._values = v251;

    if next(u249._queuedReject) == nil then
        local u252 = tostring((...));
        coroutine.wrap(function() -- Line: 1266
            -- upvalues: u41 (ref), u249 (copy), u252 (copy)
            u41._timeEvent:Wait();

            if not u249._unhandledRejection then
                return;
            end;

            local v253 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u252, u249._source);

            if u41.TEST then
                return;
            end;

            warn(v253);
        end)();
    else
        for _, v in ipairs(u249._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u249:_finalize();
end;

function u41.prototype._finalize(p254) -- Line: 1298
    -- upvalues: u41 (copy)
    for _, v in ipairs(p254._queuedFinally) do
        coroutine.wrap(v)(p254._status);
    end;

    p254._queuedFinally = nil;
    p254._queuedReject = nil;
    p254._queuedResolve = nil;

    if not u41.TEST then
        p254._parent = nil;
        p254._consumers = nil;
    end;
end;

function u41.prototype.now(p255, p256) -- Line: 1321
    -- upvalues: u41 (copy), u7 (ref)
    local v257 = debug.traceback(nil, 2);

    if p255._status == u41.Status.Resolved then
        return p255:_andThen(v257, function(...) -- Line: 1324
            return ...;
        end);
    end;

    local reject = u41.reject;

    if p256 == nil then
        p256 = u7.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u7.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. v257
        }) or p256;
    end;

    return reject(p256);
end;

function u41.retry(u258, u259, ...) -- Line: 1339
    -- upvalues: u41 (copy)
    local v260 = type(u258) == "function";
    assert(v260, "Parameter #1 to Promise.retry must be a function");
    local v261 = type(u259) == "number";
    assert(v261, "Parameter #2 to Promise.retry must be a number");
    local u262 = { ... };
    local u263 = select("#", ...);

    return u41.resolve(u258(...)):catch(function(...) -- Line: 1345
        -- upvalues: u259 (copy), u41 (ref), u258 (copy), u262 (copy), u263 (copy)
        if u259 > 0 then
            return u41.retry(u258, u259 - 1, unpack(u262, 1, u263));
        end;

        return u41.reject(...);
    end);
end;

function u41.fromEvent(u264, p265) -- Line: 1357
    -- upvalues: u41 (copy)
    local u266 = p265 or function() -- Line: 1358
        return true;
    end;

    return u41._new(debug.traceback(nil, 2), function(u267, p268, p269) -- Line: 1362
        -- upvalues: u264 (copy), u266 (ref)
        local u270 = nil;
        local u271 = false;

        local function disconnect() -- Line: 1366
            -- upvalues: u270 (ref)
            u270:Disconnect();
            u270 = nil;
        end;

        u270 = u264:Connect(function(...) -- Line: 1375
            -- upvalues: u266 (ref), u267 (copy), u270 (ref), u271 (ref)
            local v272 = u266(...);

            if v272 ~= true then
                if type(v272) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u267(...);

            if not u270 then
                u271 = true;

                return;
            end;

            u270:Disconnect();
            u270 = nil;
        end);

        if u271 and u270 then
            return disconnect();
        end;

        p269(disconnect);
    end);
end;

return u41;