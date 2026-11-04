 
 

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
require(Shared.Ripple);
local script_Parent = script.Parent;
local useMotion = require(script_Parent.useMotion);
local useHeartbeat = require(script_Parent.useHeartbeat);

local function getBindingValue(p1) -- Line: 29
    if type(p1) == "table" then
        return p1:getValue();
    end;

    return p1;
end;

return function(u2: any, u3: table?) -- Line: 47, Name: useSpring
    -- upvalues: useMotion (copy), React (copy), useHeartbeat (copy)
    local u4;

    if type(u2) == "table" then
        u4 = u2:getValue();
    else
        u4 = u2;
    end;

    local v5, u6 = useMotion(u4);
    local u7 = React.useRef(u4);
    useHeartbeat(function() -- Line: 52
        -- upvalues: u4 (ref), u2 (copy), u7 (copy), u6 (copy), u3 (copy)
        local v8 = u2;

        if type(v8) == "table" then
            v8 = v8:getValue();
        end;

        u4 = v8;

        if u4 ~= u7.current then
            u7.current = u4;
            u6:spring(u4, u3);
        end;
    end, {});

    return v5, u6;
end;