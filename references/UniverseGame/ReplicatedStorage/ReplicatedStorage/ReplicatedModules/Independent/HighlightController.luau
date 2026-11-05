  

 

local u1 = {
    Controllers = {}
};
local Controller = require(script:WaitForChild("Controller"));

function u1.AddController(p2, u3) -- Line: 6
    -- upvalues: u1 (copy), Controller (copy)
    if not u1.Controllers[u3] then
        local u4 = Controller.new(u3);
        u4.Janitor:Add(function() -- Line: 9
            -- upvalues: u1 (ref), u3 (copy), u4 (copy)
            if u1.Controllers[u3] == u4 then
                u1.Controllers[u3] = nil;
            end;
        end);
        u1.Controllers[u3] = u4;
    end;

    return u1.Controllers[u3];
end;

function u1.GetController(p5, p6) -- Line: 19
    -- upvalues: u1 (copy)
    return u1.Controllers[p6];
end;

function u1.Add(p7, p8, ...) -- Line: 23
    -- upvalues: u1 (copy)
    (u1:GetController(p8) or u1:AddController(p8)):Add(...);
end;

function u1.Remove(p9, p10, ...) -- Line: 28
    -- upvalues: u1 (copy)
    local v11 = u1:GetController(p10);

    if v11 then
        v11:Remove(...);
    end;
end;

function u1.GetAll(p12, p13) -- Line: 35
    -- upvalues: u1 (copy)
    local v14 = u1:GetController(p13);

    return not v14 and {} or v14:GetAll();
end;

function u1.Get(p15, p16, ...) -- Line: 43
    -- upvalues: u1 (copy)
    local v17 = u1:GetController(p16);

    if v17 then
        return v17:Get(...);
    end;
end;

return u1;