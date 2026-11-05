  

 

local Cycle = require(script:WaitForChild("Cycle"));

return function(p1, p2, p3) -- Line: 3
    -- upvalues: Cycle (copy)
    if not p1 or p1:GetAttribute("Cycling") then
        return;
    end;

    Cycle.new(p1, p2, p3);
end;