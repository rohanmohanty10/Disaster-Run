  

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 35
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread(...) -- Line: 46
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    acquireRunnerThreadAndCallEventHandler(...);

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 74
    -- upvalues: u4 (copy)
    return setmetatable({
        Connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 84
    if not p7.Connected then
        return;
    end;

    p7.Connected = false;

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

u4.Destroy = u4.Disconnect;
setmetatable(u4, {
    __index = function(p8, p9) -- Line: 109, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end,

    __newindex = function(p10, p11, p12) -- Line: 112, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u13 = {};
u13.__index = u13;

function u13.new() -- Line: 149
    -- upvalues: u13 (copy)
    return setmetatable({
        _handlerListHead = false,
        _proxyHandler = nil
    }, u13);
end;

function u13.Wrap(p14) -- Line: 171
    -- upvalues: u13 (copy)
    local v15 = typeof(p14) == "RBXScriptSignal";
    local v16 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p14);
    assert(v15, v16);
    local u17 = u13.new();
    u17._proxyHandler = p14:Connect(function(...) -- Line: 174
        -- upvalues: u17 (copy)
        u17:Fire(...);
    end);

    return u17;
end;

function u13.Is(p18) -- Line: 187
    -- upvalues: u13 (copy)
    local v19;

    if type(p18) == "table" then
        v19 = getmetatable(p18) == u13;
    else
        v19 = false;
    end;

    return v19;
end;

function u13.Connect(p20, p21) -- Line: 205
    -- upvalues: u4 (copy)
    local v22 = u4.new(p20, p21);

    if not p20._handlerListHead then
        p20._handlerListHead = v22;

        return v22;
    end;

    v22._next = p20._handlerListHead;
    p20._handlerListHead = v22;

    return v22;
end;

function u13.ConnectOnce(p23, u24) -- Line: 232
    local u25 = nil;
    local u26 = false;
    u25 = p23:Connect(function(...) -- Line: 235
        -- upvalues: u26 (ref), u25 (ref), u24 (copy)
        if u26 then
            return;
        end;

        u26 = true;
        u25:Disconnect();
        u24(...);
    end);

    return u25;
end;

u13.Once = u13.ConnectOnce;

function u13.GetConnections(p27) -- Line: 245
    local _handlerListHead = p27._handlerListHead;
    local v28 = {};

    while _handlerListHead do
        table.insert(v28, _handlerListHead);
        _handlerListHead = _handlerListHead._next;
    end;

    return v28;
end;

function u13.DisconnectAll(p29) -- Line: 264
    local _handlerListHead = p29._handlerListHead;

    while _handlerListHead do
        _handlerListHead.Connected = false;
        _handlerListHead = _handlerListHead._next;
    end;

    p29._handlerListHead = false;
end;

function u13.Fire(p30, ...) -- Line: 289
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p30._handlerListHead;

    while _handlerListHead do
        if _handlerListHead.Connected then
            if not u1 or coroutine.status(u1) ~= "suspended" then
                u1 = coroutine.create(runEventHandlerInFreeThread);
            end;

            task.spawn(u1, _handlerListHead._fn, ...);
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

function u13.FireDeferred(p31, ...) -- Line: 311
    local _handlerListHead = p31._handlerListHead;

    while _handlerListHead do
        task.defer(_handlerListHead._fn, ...);
        _handlerListHead = _handlerListHead._next;
    end;
end;

function u13.Wait(p32) -- Line: 335
    local u33 = coroutine.running();
    local u34 = nil;
    local u35 = false;
    u34 = p32:Connect(function(...) -- Line: 339
        -- upvalues: u35 (ref), u34 (ref), u33 (copy)
        if u35 then
            return;
        end;

        u35 = true;
        u34:Disconnect();
        task.spawn(u33, ...);
    end);

    return coroutine.yield();
end;

function u13.Destroy(p36) -- Line: 361
    p36:DisconnectAll();
    local v37 = rawget(p36, "_proxyHandler");

    if v37 then
        v37:Disconnect();
    end;
end;

setmetatable(u13, {
    __index = function(p38, p39) -- Line: 372, Name: __index
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p39))), 2);
    end,

    __newindex = function(p40, p41, p42) -- Line: 375, Name: __newindex
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p41))), 2);
    end
});

return u13;