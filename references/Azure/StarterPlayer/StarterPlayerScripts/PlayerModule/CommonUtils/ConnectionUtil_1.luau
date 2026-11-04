 
 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 25
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = {};

    return v2;
end;

function u1.connect(p3, p4, p5, p6) -- Line: 33
    if p3._connections[p4] then
        p3._connections[p4]();
    end;

    local u7 = p5:Connect(p6);

    p3._connections[p4] = function() -- Line: 39
        -- upvalues: u7 (copy)
        u7:Disconnect();
    end;
end;

function u1.connectManual(p8, p9, p10) -- Line: 42
    if p8._connections[p9] then
        p8._connections[p9]();
    end;

    p8._connections[p9] = p10;
end;

function u1.disconnect(p11, p12) -- Line: 49
    if p11._connections[p12] then
        p11._connections[p12]();
        p11._connections[p12] = nil;
    end;
end;

function u1.disconnectAll(p13) -- Line: 56
    for _, v in pairs(p13._connections) do
        v();
    end;

    p13._connections = {};
end;

return u1;