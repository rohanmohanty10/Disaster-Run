  

local u1 = {};
u1.__index = u1;

function u1.new(p2: function?) -- Line: 36
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Connected = p2 ~= nil;
    v3._callback = p2;

    return v3;
end;

function u1.Disconnect(p4) -- Line: 47
    if p4.Connected then
        task.spawn(p4._callback);
    end;

    p4.Connected = false;
end;

u1.Destroy = u1.Disconnect;

return u1;