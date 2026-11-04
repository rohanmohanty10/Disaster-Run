 
 

local u1 = {
    enabled = true
};

function u1.print(...) -- Line: 13
    -- upvalues: u1 (copy)
    if u1.enabled then
        print(...);
    end;
end;

function u1.warn(...) -- Line: 17
    -- upvalues: u1 (copy)
    if u1.enabled then
        warn(...);
    end;
end;

return u1;