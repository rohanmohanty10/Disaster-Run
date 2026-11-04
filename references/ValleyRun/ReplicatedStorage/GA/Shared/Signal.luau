 

 

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;

function u2.Disconnect(p3) -- Line: 32
    if not p3._connected then
        return;
    end;

    p3._connected = false;
    local v4 = p3._signal and p3._signal._connections;
    local v5 = v4 and table.find(v4, p3);

    if v5 then
        table.remove(v4, v5);
    end;

    p3._fn = nil;
    p3._signal = nil;
end;

u2.Destroy = u2.Disconnect;

function u2.IsConnected(p6) -- Line: 49
    return p6._connected == true;
end;

function u1.new() -- Line: 53
    -- upvalues: u1 (copy)
    return setmetatable({
        _connections = {}
    }, u1);
end;

function u1.Connect(p7: table, p8: function) -- Line: 57
    -- upvalues: u2 (copy)
    local v9 = setmetatable({
        _connected = true,
        _fn = p8,
        _signal = p7
    }, u2);
    table.insert(p7._connections, v9);

    return v9;
end;

function u1.Fire(p10, ...) -- Line: 67
    for _, v in table.clone(p10._connections) do
        if v._connected and v._fn then
            task.spawn(v._fn, ...);
        end;
    end;
end;

function u1.DisconnectAll(p11) -- Line: 76
    for _, v in table.clone(p11._connections) do
        v._connected = false;
        v._fn = nil;
        v._signal = nil;
    end;

    table.clear(p11._connections);
end;

u1.Destroy = u1.DisconnectAll;

return u1;