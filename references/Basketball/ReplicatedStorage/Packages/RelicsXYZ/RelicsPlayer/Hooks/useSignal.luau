 
 

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
require(Shared.Signal);

return function(u1: any, u2: function, p3: table?) -- Line: 12, Name: useSignal
    -- upvalues: React (copy)
    React.useEffect(function() -- Line: 13
        -- upvalues: u1 (copy), u2 (copy)
        local u4 = u1;

        if u4 then
            u4 = u4:Connect(u2);
        end;

        return function() -- Line: 17
            -- upvalues: u4 (copy)
            if u4 then
                u4:Disconnect();
            end;
        end;
    end, p3);
end;