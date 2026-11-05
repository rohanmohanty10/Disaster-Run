  

 

local u5 = {
    ["function"] = function(p1) -- Line: 6
        p1();
    end,

    RBXScriptConnection = function(p2) -- Line: 9
        p2:Disconnect();
    end,

    Instance = function(p3) -- Line: 12
        p3:Destroy();
    end,

    table = function(p4) -- Line: 15
        p4:Destroy();
    end
};
local u6 = {};
u6.__index = u6;
u6.ClassName = "Maid";

function u6.new(...) -- Line: 28
    -- upvalues: u6 (copy)
    local v7 = setmetatable({}, u6);
    v7.Trash = {};

    for _, v in pairs({ ... }) do
        v7:Mark(v);
    end;

    return v7;
end;

function u6.Mark(p8, p9) -- Line: 42
    -- upvalues: u5 (copy)
    local v10 = typeof(p9);

    if u5[v10] then
        p8.Trash[p9] = v10;

        return;
    end;

    error(("Maid does not support type \"%s\""):format(v10), 2);
end;

function u6.Unmark(p11, p12) -- Line: 52
    if p12 then
        p11.Trash[p12] = nil;

        return;
    end;

    p11.Trash = {};
end;

function u6.Sweep(p13) -- Line: 60
    -- upvalues: u5 (copy)
    for i, v in pairs(p13.Trash) do
        u5[v](i);
    end;

    p13.Trash = {};
end;

u6.Destroy = u6.Sweep;

return u6;