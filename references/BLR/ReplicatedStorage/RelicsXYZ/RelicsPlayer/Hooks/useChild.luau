  

local React = require(script.Parent.Parent.Parent.Shared.React);
local useSignal = require(script.Parent.useSignal);

return function(u1: userdata?, u2: string) -- Line: 12, Name: useChild
    -- upvalues: React (copy), useSignal (copy)
    local v4, u5 = React.useState(function() -- Line: 13
        -- upvalues: u1 (copy), u2 (copy)
        local v3 = u1 and u1:FindFirstChild(u2);

        return v3;
    end);
    local v6, v7 = React.useState(u1);

    if v6 ~= u1 then
        local v8;

        if u1 then
            v8 = u1:FindFirstChild(u2);
        else
            v8 = u1;
        end;

        u5(v8);
        v7(u1);
    end;

    local v9;

    if v6 then
        v9 = v6.ChildAdded;
    else
        v9 = v6;
    end;

    useSignal(v9, function(p10: userdata) -- Line: 24
        -- upvalues: u2 (copy), u5 (copy)
        if p10.Name == u2 then
            u5(p10);
        end;
    end, { v6 });

    return v4;
end;