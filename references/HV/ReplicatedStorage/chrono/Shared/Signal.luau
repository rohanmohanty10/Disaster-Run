 

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 52
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread() -- Line: 63
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6, p7) -- Line: 78
    -- upvalues: u4 (copy)
    return setmetatable({
        _type_ = "Connection",
        Connected = true,
        _next = false,
        _signal = p5,
        _fn = p6,
        _defer = p7 or false,
        _binCleanup = u4.Disconnect
    }, u4);
end;

function u4.Disconnect(p8) -- Line: 90
    p8.Connected = false;

    if p8._signal._handlerListHead == p8 then
        p8._signal._handlerListHead = p8._next;

        return;
    end;

    local _handlerListHead = p8._signal._handlerListHead;

    while _handlerListHead and _handlerListHead._next ~= p8 do
        _handlerListHead = _handlerListHead._next;
    end;

    if _handlerListHead then
        _handlerListHead._next = p8._next;
    end;
end;

setmetatable(u4, {
    __index = function(p9, p10) -- Line: 112, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p10))), 2);
    end,

    __newindex = function(p11, p12, p13) -- Line: 115, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p12))), 2);
    end
});
local u14 = {};
u14.__index = u14;

function u14.new() -- Line: 123
    -- upvalues: u14 (copy)
    return setmetatable({
        _type_ = "Event",
        _handlerListHead = false
    }, u14);
end;

function u14.Connect(p15, p16, p17) -- Line: 130
    -- upvalues: u4 (copy)
    local v18 = u4.new(p15, p16, p17);

    if not p15._handlerListHead then
        p15._handlerListHead = v18;

        return v18;
    end;

    v18._next = p15._handlerListHead;
    p15._handlerListHead = v18;

    return v18;
end;

function u14.Wait(p19, p20) -- Line: 143
    local coroutine_running_ret = coroutine.running();
    local u21 = nil;
    u21 = p19:Connect(function(...) -- Line: 146
        -- upvalues: u21 (ref), coroutine_running_ret (copy)
        u21:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end, p20);

    return coroutine.yield();
end;

function u14.Once(p22, u23, p24) -- Line: 155
    local u25 = nil;
    u25 = p22:Connect(function(...) -- Line: 157
        -- upvalues: u25 (ref), u23 (copy)
        if u25.Connected then
            u25:Disconnect();
        end;

        u23(...);
    end, p24);

    return u25;
end;

local u26 = {};
u26.__index = u26;

function u26.new() -- Line: 170
    -- upvalues: u14 (copy), u26 (copy)
    local v27 = {
        _type_ = "Signal",
        Event = u14.new(),
        _binCleanup = u26.DisconnectAll
    };

    return setmetatable(v27, u26);
end;

function u26.DisconnectAll(p28) -- Line: 180
    p28.Event._handlerListHead = false;
end;

function u26.Fire(p29, ...) -- Line: 188
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p29.Event._handlerListHead;
    debug.profilebegin("Signal.Fire");

    while _handlerListHead do
        if _handlerListHead.Connected then
            if _handlerListHead._defer then
                task.defer(_handlerListHead._fn, ...);
            else
                if not u1 then
                    u1 = coroutine.create(runEventHandlerInFreeThread);
                    coroutine.resume(u1);
                end;

                task.spawn(u1, _handlerListHead._fn, ...);
            end;
        end;

        _handlerListHead = _handlerListHead._next;
    end;

    debug.profileend();
end;

setmetatable(u26, {
    __index = function(p30, p31) -- Line: 211, Name: __index
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p31))), 2);
    end,

    __newindex = function(p32, p33, p34) -- Line: 214, Name: __newindex
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p33))), 2);
    end
});

return u26;