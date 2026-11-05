  

 

local Mounts = script:WaitForChild("Mounts");
local u1 = {};
(function() -- Line: 13, Name: LoadMounts
    -- upvalues: Mounts (copy), u1 (copy)
    for _, descendant in Mounts:GetDescendants() do
        if descendant:IsA("ModuleScript") then
            local v2 = require(descendant);
            local Name = descendant.Name;

            if typeof(v2) == "table" then
                u1[Name] = v2;
            end;
        end;
    end;
end)();

return u1;