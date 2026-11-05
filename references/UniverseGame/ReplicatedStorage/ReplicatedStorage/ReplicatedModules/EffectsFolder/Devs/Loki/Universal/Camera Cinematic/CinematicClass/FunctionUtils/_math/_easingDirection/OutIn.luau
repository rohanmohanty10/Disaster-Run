  

 

local In = require(script.Parent.In);
local Out = require(script.Parent.Out);

return function(p1, p2) -- Line: 4
    -- upvalues: Out (copy), In (copy)
    if p1 < 0.5 then
        return Out(p1 * 2, p2) * 0.5;
    end;

    return 0.5 + In(p1 * 2 - 1, p2) * 0.5;
end;