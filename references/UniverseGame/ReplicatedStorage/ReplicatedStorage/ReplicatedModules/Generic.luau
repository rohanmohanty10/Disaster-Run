  

 

require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = {};

local function Load(p2) -- Line: 5
    -- upvalues: u1 (copy), Load (copy)
    for _, child in pairs(p2:GetChildren()) do
        if child:IsA("ModuleScript") then
            require(child)(u1);
        end;
    end;

    for _, child in pairs(p2:GetChildren()) do
        if not child:IsA("ModuleScript") then
            Load(child);
        end;
    end;
end;

Load(script);

return u1;