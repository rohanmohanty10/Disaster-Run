  

local script_Parent = script.Parent;
local useTagged = require(script_Parent.useTagged);
local useChild = require(script_Parent.useChild);
require(script_Parent.Parent.Parent.Shared.React);

return function(p1: string, p2: any) -- Line: 12, Name: useComponent
    -- upvalues: useTagged (copy), useChild (copy)
    local v3 = useChild(useTagged("RelicsComponents")[1], p1);

    if v3 and v3:IsA("ModuleScript") then
        local v4 = require(v3);

        if type(v4) == "function" then
            return v4;
        end;
    end;

    return p2;
end;