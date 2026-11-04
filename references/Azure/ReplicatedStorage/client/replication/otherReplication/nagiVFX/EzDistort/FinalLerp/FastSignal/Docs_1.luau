 
 

error("This is not supposed to run!");
local u1 = {};
u1.__index = u1;
local v2 = {};
v2.__index = v2;

function u1.new() -- Line: 59
    return {};
end;

function u1.Is(p3) -- Line: 77
    return true;
end;

function u1.IsActive(p4) -- Line: 92
    return true;
end;

function u1.Connect(p5, p6) -- Line: 113
end;

function u1.Once(p7, p8) -- Line: 135
end;

function u1.Wait(p9) -- Line: 156
end;

function u1.Fire(p10, ...) -- Line: 175
end;

function u1.DisconnectAll(p11) -- Line: 190
end;

function u1.Destroy(p12) -- Line: 204
end;

function v2.Disconnect(p13) -- Line: 220
end;

return {
    new = function() -- Line: 227, Name: new
        -- upvalues: u1 (copy)
        return u1.new();
    end,

    Is = function(p14) -- Line: 231, Name: Is
        return true;
    end
};