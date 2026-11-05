  

 

local v1 = {};
local RunService = game:GetService("RunService");
local u2 = nil;

local function pushThread(p3, p4) -- Line: 22
    -- upvalues: u2 (ref)
    local v5 = { p3, p4 };

    if not u2 then
        u2 = v5;

        return;
    end;

    if p4 <= u2[2] then
        v5[3] = u2;
        u2 = v5;

        return;
    end;

    local v6 = u2;

    while v6[3] and v6[3][2] < p4 do
        v6 = v6[3];
    end;

    v5[3] = v6[3];
    v6[3] = v5;
end;

RunService.Heartbeat:Connect(function() -- Line: 48, Name: popThreads
    -- upvalues: u2 (ref)
    local v7 = os.clock();

    while u2 and u2[2] - v7 < 0.008333333333333333 do
        local v8 = u2[1];
        u2 = u2[3];
        coroutine.resume(v8, v7);
    end;
end);

local function HandleError(p9) -- Line: 72
    local v10 = debug.traceback();
    warn(errorMessage:format(p9, v10));
end;

function v1.Wait(p11, p12) -- Line: 77
    -- upvalues: pushThread (copy), RunService (copy)
    local v13 = tonumber(p12);

    if not v13 then
        return RunService.Heartbeat:Wait();
    end;

    local v14 = os.clock();
    pushThread(coroutine.running(), v14 + v13);

    return coroutine.yield() - v14;
end;

function v1.Spawn(p15, ...) -- Line: 90
    return task.spawn(...);
end;

function v1.Delay(p16, ...) -- Line: 94
    return task.delay(...);
end;

function v1.Defer(p17, ...) -- Line: 98
    return task.defer(...);
end;

return v1;