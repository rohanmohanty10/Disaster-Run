 
 

local function cacheSet(p1: table, p2: any, p3: any, p4: boolean) -- Line: 9
    p1._data[p2] = {
        t = os.clock(),
        d = p3,
        p = p4
    };
end;

local function cacheUnset(p5: table, p6: any) -- Line: 13
    p5._data[p6] = nil;
end;

local function cachePersist(p7: table, p8: any) -- Line: 17
    local v9 = p7._data[p8];

    if v9 == nil then
        return;
    end;

    v9.p = true;
    p7._data[p8] = v9;
end;

local function cacheUnpersist(p10: table, p11: any) -- Line: 29
    local v12 = p10._data[p11];

    if v12 == nil then
        return;
    end;

    v12.p = false;
    p10._data[p11] = v12;
end;

local function cacheGet(p13, p14, p15) -- Line: 41
    local v16 = p13._data[p14];

    if v16 ~= nil then
        if v16.t + p13._ttl > os.clock() or v16.p then
            return v16.d, v16.t + p13._ttl - os.clock();
        end;

        p13._data[p14] = nil;

        return nil, nil;
    end;

    if typeof(p15) == "function" then
        p15 = p15();
    end;

    if p15 == nil then
        return nil, nil;
    end;

    p13._data[p14] = {
        p = false,
        t = os.clock(),
        d = p15
    };

    return p15, p13._ttl;
end;

local function cacheGetNoTtl(p17: table, p18: any, p19: any) -- Line: 72
    local v20 = p17._data[p18];

    if v20 ~= nil then
        local v21;

        if v20 then
            v21 = v20.d;
        else
            v21 = nil;
        end;

        return v21, (1 / 0);
    end;

    if typeof(p19) == "function" then
        p19 = p19();
    end;

    if p19 == nil then
        return nil, (1 / 0);
    end;

    p17._data[p18] = {
        p = false,
        t = os.clock(),
        d = p19
    };

    return p19, (1 / 0);
end;

local function cacheCount(p22: table) -- Line: 96
    local v23 = 0;

    for _ in p22._data do
        v23 = v23 + 1;
    end;

    return v23;
end;

local function cacheClean(p24) -- Line: 102
    for i, v in p24._data do
        if v.t + p24._ttl <= os.clock() and not v.p then
            p24._data[i] = nil;
        end;
    end;
end;

local function cacheClear(p25: table) -- Line: 112
    p25._data = {};
end;

local function cacheDestroy(p26: table) -- Line: 116
    p26._data = {};

    if p26._ttl ~= nil then
        task.cancel(p26._cleanup);
    end;
end;

return function(p27: number?) -- Line: 140, Name: newCache
    -- upvalues: cacheSet (copy), cacheUnset (copy), cachePersist (copy), cacheUnpersist (copy), cacheClean (copy), cacheClear (copy), cacheCount (copy), cacheDestroy (copy), cacheGet (copy), cacheGetNoTtl (copy)
    local u28 = {
        _data = {},
        _ttl = p27,
        Set = cacheSet,
        Unset = cacheUnset,
        Persist = cachePersist,
        Unpersist = cacheUnpersist,
        Clean = cacheClean,
        Clear = cacheClear,
        Count = cacheCount,
        Destroy = cacheDestroy
    };

    if p27 == nil then
        u28.Get = cacheGetNoTtl;

        return u28;
    end;

    u28.Get = cacheGet;
    u28._cleanup = task.spawn(function() -- Line: 158, Name: cleanupThread
        -- upvalues: cacheClean (ref), u28 (copy)
        while true do
            task.wait(5);
            cacheClean(u28);
        end;
    end);

    return u28;
end;