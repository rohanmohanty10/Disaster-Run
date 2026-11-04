 

 

local u1 = require("./_t");
local v2 = {};
local table_create_ret = table.create(50);

local function runCallback(p3, p4, ...) -- Line: 35
    -- upvalues: table_create_ret (copy)
    local v5, v6 = xpcall(p3, debug.traceback, ...);

    if not v5 then
        warn(v6);
    end;

    if #table_create_ret < 50 then
        table.insert(table_create_ret, p4);
    end;
end;

local function threadWorker() -- Line: 46
    -- upvalues: runCallback (copy)
    while true do
        runCallback(coroutine.yield());
    end;
end;

local function getPooledThread() -- Line: 53
    -- upvalues: table_create_ret (copy), threadWorker (copy)
    local v7;

    while true do
        v7 = table.remove(table_create_ret);

        if v7 and coroutine.status(v7) == "suspended" then
            break;
        end;

        if not v7 then
            local coroutine_create_ret = coroutine.create(threadWorker);
            coroutine.resume(coroutine_create_ret);

            return coroutine_create_ret;
        end;
    end;

    return v7;
end;

function v2.defer(p8: function, ...) -- Line: 72
    -- upvalues: u1 (copy), getPooledThread (copy)
    assert(u1.callback(p8));
    local v9 = getPooledThread();

    return task.defer(v9, p8, v9, ...);
end;

function v2.spawn(p10: function, ...) -- Line: 79
    -- upvalues: u1 (copy), getPooledThread (copy)
    assert(u1.callback(p10));
    local v11 = getPooledThread();

    return task.spawn(v11, p10, v11, ...);
end;

function v2.delay(p12: number, p13: function, ...) -- Line: 86
    -- upvalues: u1 (copy), getPooledThread (copy)
    assert(u1.number(p12));
    assert(u1.callback(p13));
    local v14 = getPooledThread();

    return task.delay(p12, v14, p13, v14, ...);
end;

return v2;