 

 

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;

function u2.Disconnect(p3) -- Line: 8
    if p3.Connected then
        p3.Connected = false;
        p3._signal._handlers[p3] = nil;
    end;
end;

function u1.new() -- Line: 15
    -- upvalues: u1 (copy)
    return setmetatable({
        _handlers = {}
    }, u1);
end;

function u1.Connect(p4, p5) -- Line: 19
    -- upvalues: u2 (copy)
    local v6 = setmetatable({
        Connected = true,
        _signal = p4,
        _handler = p5
    }, u2);
    p4._handlers[v6] = true;

    return v6;
end;

function u1.Fire(p7, ...) -- Line: 25
    local v8 = {};

    for i in p7._handlers do
        table.insert(v8, i);
    end;

    for _, v in v8 do
        if v.Connected then
            task.spawn(v._handler, ...);
        end;
    end;
end;

function u1.DisconnectAll(p9) -- Line: 38
    for i in p9._handlers do
        i.Connected = false;
    end;

    table.clear(p9._handlers);
end;

return u1;