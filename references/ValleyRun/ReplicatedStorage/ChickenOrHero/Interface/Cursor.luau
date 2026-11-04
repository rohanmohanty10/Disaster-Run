 

 

local u1 = {
    Changed = require(script.Parent.Signal).new()
};
local u2 = {};
local u3 = 0;

function u1.request(p4) -- Line: 9
    -- upvalues: u2 (copy), u3 (ref), u1 (copy)
    if p4 == nil or u2[p4] then
        return;
    end;

    u2[p4] = true;
    u3 = u3 + 1;

    if u3 == 1 then
        u1.Changed:Fire(true);
    end;
end;

function u1.release(p5) -- Line: 20
    -- upvalues: u2 (copy), u3 (ref), u1 (copy)
    if p5 == nil or not u2[p5] then
        return;
    end;

    u2[p5] = nil;
    u3 = u3 - 1;

    if u3 == 0 then
        u1.Changed:Fire(false);
    end;
end;

function u1.active() -- Line: 31
    -- upvalues: u3 (ref)
    return u3 > 0;
end;

return u1;