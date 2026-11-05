  

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 34
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread(...) -- Line: 45
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    acquireRunnerThreadAndCallEventHandler(...);

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 56
    -- upvalues: u4 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 65
    assert(p7._connected, "Can\'t disconnect a connection twice.", 2);
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

setmetatable(u4, {
    __index = function(p8, p9) -- Line: 88, Name: __index
        error(string.format("Attempt to get Connection::%s (not a valid member)", (tostring(p9))), 2);
    end,

    __newindex = function(p10, p11, p12) -- Line: 91, Name: __newindex
        error(string.format("Attempt to set Connection::%s (not a valid member)", (tostring(p11))), 2);
    end
});
local u13 = {};
u13.__index = u13;

function u13.new() -- Line: 100
    -- upvalues: u13 (copy), u4 (copy)
    local u14 = setmetatable({
        _handlerListHead = false,
        Invoked = {}
    }, u13);

    function u14.Invoked.Connect(p15, p16) -- Line: 105
        -- upvalues: u4 (ref), u14 (copy)
        local v17 = u4.new(u14, p16);

        if not u14._handlerListHead then
            u14._handlerListHead = v17;

            return v17;
        end;

        v17._next = u14._handlerListHead;
        u14._handlerListHead = v17;

        return v17;
    end;

    function u14.Invoked.Wait(p18) -- Line: 117
        local u19 = coroutine.running();
        local script = getfenv(2).script;
        local u20 = nil;
        u20 = p18:Connect(function(...) -- Line: 122
            -- upvalues: u20 (ref), script (copy), u19 (copy)
            u20:Disconnect();

            if script:FindFirstAncestorOfClass("DataModel") then
                task.spawn(u19, ...);
            end;
        end);

        return coroutine.yield();
    end;

    return u14;
end;

function u13.DisconnectAll(p21) -- Line: 136
    p21._handlerListHead = false;
end;

function u13.Destroy(p22) -- Line: 140
    p22:DisconnectAll();
    table.clear(p22);
end;

function u13.Invoke(p23, ...) -- Line: 149
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p23._handlerListHead;

    while _handlerListHead do
        if _handlerListHead._connected then
            if not u1 then
                u1 = coroutine.create(runEventHandlerInFreeThread);
            end;

            if getfenv(_handlerListHead._fn).script:FindFirstAncestorOfClass("DataModel") then
                task.spawn(u1, _handlerListHead._fn, ...);
            end;
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

setmetatable(u13, {
    __index = function(p24, p25) -- Line: 167, Name: __index
        error(string.format("Attempt to get Signal::%s (not a valid member)", (tostring(p25))), 2);
    end,

    __newindex = function(p26, p27, p28) -- Line: 170, Name: __newindex
        error(string.format("Attempt to set Signal::%s (not a valid member)", (tostring(p27))), 2);
    end
});

return u13;