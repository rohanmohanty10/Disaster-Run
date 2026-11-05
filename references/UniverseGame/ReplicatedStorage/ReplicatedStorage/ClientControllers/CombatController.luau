  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).CreateController({
    Name = "CombatController"
});
local u2 = {};

local function Load(p3) -- Line: 18
    -- upvalues: u2 (copy), Load (copy)
    for _, child in pairs(p3:GetChildren()) do
        if child:IsA("ModuleScript") then
            table.insert(u2, require(child));
        end;
    end;

    for _, child in pairs(p3:GetChildren()) do
        if not child:IsA("ModuleScript") then
            Load(child);
        end;
    end;
end;

function u1.KnitInit(p4) -- Line: 32
    -- upvalues: Load (copy), u2 (copy), u1 (copy)
    Load(script);

    for _, v in pairs(u2) do
        if v.Init then
            v.Init(u1);
        end;
    end;
end;

function u1.KnitStart(p5) -- Line: 42
    -- upvalues: u2 (copy), u1 (copy)
    for _, v in pairs(u2) do
        if v.Start then
            v.Start(u1);
        end;
    end;
end;

return u1;