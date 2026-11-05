  

 

local In = require(script.Parent.In);
local Out = require(script.Parent.Out);

return function(p1, p2) -- Line: 4
    -- upvalues: In (copy), Out (copy)
    if p1 < 0.5 then
        return In(p1 * 2, p2) * 0.5;
    end;

    return 0.5 + Out(p1 * 2 - 1, p2) * 0.5;
end;