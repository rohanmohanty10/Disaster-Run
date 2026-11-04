  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);
    local v4 = ReplicatedStorage.Assets.Misc.FriesBackpack:Clone();
    v4.Parent = p2.Torso;
    v4.PrimaryPart.TorsoWeld.Part1 = p2.Torso;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
end;

return v1;