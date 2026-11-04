 
 

require(script.Parent.Parent.types);
local intermediate = require(script.Parent.Parent.utils.intermediate);

return function(p1) -- Line: 4, Name: immediate
    -- upvalues: intermediate (copy)
    local u2 = intermediate.to(p1);

    return function(p3, p4) -- Line: 7
        -- upvalues: intermediate (ref), u2 (copy)
        local v5 = intermediate.index(u2, p3);

        if not v5 then
            return false;
        end;

        p4.complete = true;
        p4.value = v5;
    end;
end;