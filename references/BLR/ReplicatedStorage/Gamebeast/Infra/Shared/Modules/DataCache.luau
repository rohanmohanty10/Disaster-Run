  

local v1 = {};
game:GetService("ReplicatedStorage");
local u2 = {};

function v1.Set(p3: table, p4: string, p5: any) -- Line: 36
    -- upvalues: u2 (copy)
    u2[p4] = p5;
end;

function v1.Get(p6: table, p7: string) -- Line: 40
    -- upvalues: u2 (copy)
    return u2[p7];
end;

return v1;