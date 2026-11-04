 
 

local Shared = script:FindFirstAncestor("RelicsXYZ").Shared;
local React = require(Shared.React);
require(Shared.Signal);

return function(p1, u2) -- Line: 9, Name: useChanged
    -- upvalues: React (copy)
    local u3, u4 = React.useState(p1);

    return u3, function(p5: userdata) -- Line: 12, Name: setChanged
        -- upvalues: u3 (copy), u4 (copy), u2 (copy)
        if u3 ~= p5 then
            u4(p5);
            u2:FireDeferred(p5);
        end;
    end;
end;