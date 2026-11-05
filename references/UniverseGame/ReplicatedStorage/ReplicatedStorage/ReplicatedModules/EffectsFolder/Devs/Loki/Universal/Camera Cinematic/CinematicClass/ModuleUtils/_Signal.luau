  

 

local u1 = {};

local function runCallback(p2, p3, ...) -- Line: 7
    -- upvalues: u1 (copy)
    p2(...);
    table.insert(u1, p3);
end;

local function yielder() -- Line: 12
    -- upvalues: runCallback (copy)
    while true do
        runCallback(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.Disconnect(p5) -- Line: 28
    if not p5.Connected then
        return;
    end;

    p5.Connected = false;
    local _next = p5._next;
    local _prev = p5._prev;

    if _next then
        _next._prev = _prev;
    end;

    if _prev then
        _prev._next = _next;
    end;

    local _signal = p5._signal;

    if _signal._head == p5 then
        _signal._head = _next;
    end;
end;

function u4.Reconnect(p6) -- Line: 50
    if p6.Connected then
        return;
    end;

    p6.Connected = true;
    local _signal = p6._signal;
    local _head = _signal._head;

    if _head then
        _head._prev = p6;
    end;

    _signal._head = p6;
    p6._next = _head;
    p6._prev = false;
end;

local u7 = {};
u7.__index = u7;
local u8, u9;

if task then
    local BindableEvent = Instance.new("BindableEvent");
    u8 = BindableEvent.Event.Connect;
    u9 = BindableEvent.Event:Connect(function() -- Line: 105
    end).Disconnect;
    BindableEvent:Destroy();
else
    u9 = nil;
    u8 = nil;
end;

local function connect(p10, p11, ...) -- Line: 110
    -- upvalues: u4 (copy)
    local _head = p10._head;
    local v12 = setmetatable({
        Connected = true,
        _prev = false,
        _signal = p10,
        _fn = p11,
        _varargs = ... and { ... } or false,
        _next = _head
    }, u4);

    if _head then
        _head._prev = v12;
    end;

    p10._head = v12;

    return v12;
end;

local function fire(p13, ...) -- Line: 154
    -- upvalues: u1 (copy), yielder (copy)
    local _head = p13._head;

    while _head do
        local v14;

        if #u1 > 0 then
            v14 = u1[#u1];
            u1[#u1] = nil;
        else
            v14 = coroutine.create(yielder);
            coroutine.resume(v14);
        end;

        if _head._varargs then
            local _varargs = _head._varargs;
            local v15 = #_varargs;
            local v16 = table.pack(...);
            local v17 = v15;

            for i = 1, v16.n do
                v15 = v15 + 1;
                _varargs[v15] = v16[i];
            end;

            task.spawn(v14, _head._fn, v14, table.unpack(_varargs));

            for i = v15, v17 + 1, -1 do
                _varargs[i] = nil;
            end;
        else
            task.spawn(v14, _head._fn, v14, ...);
        end;

        _head = _head._next;
    end;
end;

local function destroy(p18) -- Line: 236
    -- upvalues: u9 (ref)
    local _head = p18._head;

    while _head do
        if _head.Connected then
            _head.Connected = false;
            local _next = _head._next;
            local _prev = _head._prev;

            if _next then
                _next._prev = _prev;
            end;

            if _prev then
                _prev._next = _next;
            end;

            local _signal = _head._signal;

            if _signal._head == _head then
                _signal._head = _next;
            end;
        end;

        _head = _head._next;
    end;

    for i, _ in pairs(p18._waiting) do
        if coroutine.status(i) == "suspended" then
            task.cancel(i);
        end;

        p18._waiting[i] = nil;
    end;

    local RBXScriptConnection = p18.RBXScriptConnection;

    if RBXScriptConnection then
        u9(RBXScriptConnection);
        p18.RBXScriptConnection = nil;
    end;
end;

function u7.new() -- Line: 252
    -- upvalues: u7 (copy)
    local v19 = {
        _head = false,
        _waiting = {}
    };
    setmetatable(v19, u7);

    return v19;
end;

function u7.wrap(p20) -- Line: 259
    -- upvalues: u7 (copy), u8 (ref), fire (copy)
    local u21 = setmetatable({
        _head = false,
        _waiting = {}
    }, u7);
    u21.RBXScriptConnection = u8(p20, function(...) -- Line: 262
        -- upvalues: fire (ref), u21 (copy)
        fire(u21, ...);
    end);

    return u21;
end;

u7.Connect = connect;

function u7.Once(p22, u23, ...) -- Line: 129
    -- upvalues: connect (copy)
    local u24 = nil;
    u24 = connect(p22, function(...) -- Line: 131
        -- upvalues: u24 (ref), u23 (copy)
        local v25 = u24;

        if v25.Connected then
            v25.Connected = false;
            local _next = v25._next;
            local _prev = v25._prev;

            if _next then
                _next._prev = _prev;
            end;

            if _prev then
                _prev._next = _next;
            end;

            local _signal = v25._signal;

            if _signal._head == v25 then
                _signal._head = _next;
            end;
        end;

        u23(...);
    end, ...);

    return u24;
end;

function u7.Wait(u26) -- Line: 138
    -- upvalues: connect (copy)
    local u27 = coroutine.running();
    local u28 = nil;
    u28 = connect(u26, function(...) -- Line: 141
        -- upvalues: u28 (ref), u26 (copy), u27 (copy)
        local v29 = u28;

        if v29.Connected then
            v29.Connected = false;
            local _next = v29._next;
            local _prev = v29._prev;

            if _next then
                _next._prev = _prev;
            end;

            if _prev then
                _prev._next = _next;
            end;

            local _signal = v29._signal;

            if _signal._head == v29 then
                _signal._head = _next;
            end;
        end;

        u26._waiting[u27] = nil;

        if coroutine.status(u27) == "suspended" then
            task.spawn(u27, ...);
        end;
    end);
    u26._waiting[u27] = true;

    return coroutine.yield();
end;

u7.Fire = fire;

function u7.FireDefer(u30, ...) -- Line: 190
    -- upvalues: u1 (copy), yielder (copy)
    local u31 = table.pack(...);
    task.defer(function() -- Line: 193
        -- upvalues: u30 (copy), u1 (ref), yielder (ref), u31 (copy)
        local _head = u30._head;

        while _head do
            local v32;

            if #u1 > 0 then
                v32 = u1[#u1];
                u1[#u1] = nil;
            else
                v32 = coroutine.create(yielder);
                coroutine.resume(v32);
            end;

            if _head._varargs then
                local _varargs = _head._varargs;
                local v33 = #_varargs;
                local v34 = v33;

                for i = 1, u31.n do
                    v33 = v33 + 1;
                    _varargs[v33] = u31[i];
                end;

                task.spawn(v32, _head._fn, v32, table.unpack(_varargs));

                for i = v33, v34 + 1, -1 do
                    _varargs[i] = nil;
                end;
            else
                task.spawn(v32, _head._fn, v32, table.unpack(u31));
            end;

            _head = _head._next;
        end;
    end);
end;

function u7.DisconnectAll(p35) -- Line: 228
    local _head = p35._head;

    while _head do
        if _head.Connected then
            _head.Connected = false;
            local _next = _head._next;
            local _prev = _head._prev;

            if _next then
                _next._prev = _prev;
            end;

            if _prev then
                _prev._next = _next;
            end;

            local _signal = _head._signal;

            if _signal._head == _head then
                _signal._head = _next;
            end;
        end;

        _head = _head._next;
    end;
end;

u7.Destroy = destroy;

return {
    new = u7.new,
    wrap = u7.wrap
};