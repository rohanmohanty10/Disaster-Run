  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v1 = {
    Moveset = {
        DefaultMoveState = "SubPowers",
        Groups = {}
    },
    Stats = {},
    Animations = {},
    Sounds = {}
};

for _, descendant in script:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        for i, v in require(descendant) do
            if v1[i] then
                v1[i] = TableUtil.Reconcile(v1[i], v);
            end;
        end;
    end;
end;

return v1;