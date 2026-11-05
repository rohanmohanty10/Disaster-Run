  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);

return function(p1, p2) -- Line: 5
    -- upvalues: PathShortcuts (copy)
    if p1:GetAttribute("ChromaUnusual") then
        if typeof(p2) == "table" then
            for _, v in p2 do
                PathShortcuts.Remotes.ClientBind:Fire(p1, "Chroma", v);
            end;

            return;
        end;

        PathShortcuts.Remotes.ClientBind:Fire(p1, "Chroma", p2);
    end;
end;