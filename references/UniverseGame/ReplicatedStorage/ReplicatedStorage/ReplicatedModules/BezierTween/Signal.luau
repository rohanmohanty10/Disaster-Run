  

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 3
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 15
    -- upvalues: u4 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 24
    assert(p7._connected, "Connection already disconnected.");
    p7._connected = false;

    if p7._signal._handlerListHead == p7 then
        p7._signal._handlerListHead = p7._next;

        return;
    end;

    local _handlerListHead = p7._signal._handlerListHead;

    while _handlerListHead and _handlerListHead._next ~= p7 do
        _handlerListHead = _handlerListHead._next;
    end;

    if _handlerListHead then
        _handlerListHead._next = p7._next;
    end;
end;

local u8 = {};
u8.__index = u8;

function u8.new() -- Line: 46
    -- upvalues: u8 (copy)
    return setmetatable({
        _handlerListHead = false
    }, u8);
end;

function u8.Connect(p9, p10) -- Line: 50
    -- upvalues: u4 (copy)
    local v11 = u4.new(p9, p10);
    v11._next = p9._handlerListHead and p9._handlerListHead or v11._next;
    p9._handlerListHead = v11;

    return v11;
end;

function u8.Fire(p12, ...) -- Line: 57
    -- upvalues: u1 (ref), acquireRunnerThreadAndCallEventHandler (copy)
    local _handlerListHead = p12._handlerListHead;

    while _handlerListHead do
        if _handlerListHead._connected then
            if not u1 or coroutine.status(u1) ~= "suspended" then
                u1 = coroutine.create(function(...) -- Line: 62
                    -- upvalues: acquireRunnerThreadAndCallEventHandler (ref)
                    acquireRunnerThreadAndCallEventHandler(...);

                    while true do
                        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
                    end;
                end);
            end;

            task.spawn(u1, _handlerListHead._fn, ...);
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

function u8.Wait(p13) -- Line: 75
    local u14 = coroutine.running();
    local u15 = nil;
    u15 = p13:Connect(function(...) -- Line: 78
        -- upvalues: u15 (ref), u14 (copy)
        u15:Disconnect();
        task.spawn(u14, ...);
    end);

    return coroutine.yield();
end;

return u8;