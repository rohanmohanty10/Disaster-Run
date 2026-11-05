  

 

local Stands = require(script.Parent:WaitForChild("Stands"));
local u1 = {
    Conversion = {}
};

for i, v in Stands do
    u1.Conversion[v] = i;
end;

function u1.GetAbilityId(p2) -- Line: 11
    -- upvalues: u1 (copy)
    return u1.Conversion[p2];
end;

function u1.GetAbilityName(p3) -- Line: 15
    -- upvalues: Stands (copy)
    return Stands[tonumber(string.match(p3, "%d+"))];
end;

return u1;