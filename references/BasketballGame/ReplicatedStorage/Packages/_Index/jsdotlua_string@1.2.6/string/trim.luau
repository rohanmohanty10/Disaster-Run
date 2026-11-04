 
 

local trimStart = require(script.Parent:WaitForChild("trimStart"));
local trimEnd = require(script.Parent:WaitForChild("trimEnd"));

return function(p1: string) -- Line: 6
    -- upvalues: trimStart (copy), trimEnd (copy)
    return trimStart(trimEnd(p1));
end;