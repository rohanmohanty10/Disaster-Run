 
 

local React = require(script.Parent.Parent.Parent.Shared.React);
local useSignal = require(script.Parent.useSignal);

return function(u1: userdata?, u2: string, p3: function) -- Line: 10, Name: useAttribute
    -- upvalues: React (copy), useSignal (copy)
    local v5, u6 = React.useState(function() -- Line: 11
        -- upvalues: u1 (copy), u2 (copy)
        local v4 = u1 and u1:GetAttribute(u2);

        return v4;
    end);
    local v7;

    if u1 then
        v7 = u1:GetAttributeChangedSignal(u2);
    else
        v7 = u1;
    end;

    local v8;

    if u1 then
        v8 = u1:GetAttribute(u2);
    else
        v8 = u1;
    end;

    if v5 ~= v8 then
        u6(v8);
    end;

    useSignal(v7, function() -- Line: 22
        -- upvalues: u6 (copy), u1 (copy), u2 (copy)
        local v9 = u1 and u1:GetAttribute(u2);
        u6(v9);
    end, { u1 });

    return p3(v8);
end;