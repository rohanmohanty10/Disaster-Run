  

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
local Ripple = require(Shared.Ripple);
local useHeartbeat = require(script.Parent.useHeartbeat);

return function(u1) -- Line: 20, Name: useMotion
    -- upvalues: React (copy), Ripple (copy), useHeartbeat (copy)
    local u2 = React.useMemo(function() -- Line: 21
        -- upvalues: Ripple (ref), u1 (copy)
        return Ripple.createMotion(u1);
    end, {});
    local u3, u4 = React.useBinding(u1);
    useHeartbeat(function(p5) -- Line: 27
        -- upvalues: u2 (copy), u3 (copy), u4 (copy)
        local v6 = u2:step(p5);

        if v6 ~= u3:getValue() then
            u4(v6);
        end;
    end, {});

    return u3, u2;
end;