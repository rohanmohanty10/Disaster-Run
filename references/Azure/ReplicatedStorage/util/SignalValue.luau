 

 

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.util.Signal);

function u1.new(p2) -- Line: 18
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Changed = Signal.new();
    v3.Value = p2;

    return v3;
end;

function u1.Destroy(p4) -- Line: 27
    if p4.Changed then
        p4.Changed:Destroy();
    end;

    table.clear(p4);
end;

return u1;