 

 

local v1 = {};
local u2 = nil;

function v1.setSink(p3) -- Line: 7
    -- upvalues: u2 (ref)
    u2 = p3;
end;

function v1.track(p4, p5, p6) -- Line: 12
    -- upvalues: u2 (ref)
    if u2 then
        u2(p4, p5, p6);
    end;
end;

return v1;