  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.TableUtil);
local Promise = require(PathShortcuts.KnitPath.Promise);
local u1 = {
    Crafting = {},
    Abilities = {}
};
local u2 = game:GetService("RunService"):IsStudio();

local function Load(p3) -- Line: 65
    -- upvalues: u1 (copy), u2 (copy)
    for i, v in require(p3) do
        for i2, v2 in v do
            if u1[i][i2] and u2 then
                warn(i2, "ALREADY FOUND");
            end;

            u1[i][i2] = v2;
        end;
    end;
end;

for _, descendant in ipairs(script:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        Promise.try(Load, descendant):catch(warn);
    end;
end;

for i, v in u1.Crafting do
    if v.Testing and game.GameId == 1782832995 then
        u1.Crafting[i] = nil;
    end;
end;

return u1;