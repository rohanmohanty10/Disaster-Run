  

 

local _ = table.insert;
local _ = table.remove;
local _ = table.find;
local clear = table.clear;
local u1 = {};
u1.__index = u1;
u1.Keys = {};

function u1.new() -- Line: 8
    -- upvalues: u1 (copy)
    local v2 = {
        Keys = {}
    };
    setmetatable(v2, u1);

    return v2;
end;

function u1.AddKey(p3, p4) -- Line: 15
    p3.Keys[p4] = true;
end;

function u1.RemoveKey(p5, p6) -- Line: 19
    p5.Keys[p6] = nil;
end;

function u1.IsKeyDown(p7, p8) -- Line: 23
    if typeof(p8) == "EnumItem" then
        p8 = p8.Name or p8;
    end;

    return p7.Keys[p8];
end;

function u1.Destroy(p9) -- Line: 28
    -- upvalues: clear (copy)
    clear(p9.Keys);
    clear(p9);
end;

return u1;