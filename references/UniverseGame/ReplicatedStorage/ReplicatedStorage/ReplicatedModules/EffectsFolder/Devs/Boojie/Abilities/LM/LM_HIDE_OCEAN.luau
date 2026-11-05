  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local u1 = {};

for _, child in pairs(game.Workspace.Map.Layout.Collision:GetChildren()) do
    if child.Name == "Ocean" or child.Name == "OceanFloor" then
        u1[child] = child.Transparency;
    end;
end;

return function(p2) -- Line: 15
    -- upvalues: u1 (copy)
    for i, v in pairs(u1) do
        i.Transparency = p2 == false and v and v or 1;
    end;
end;