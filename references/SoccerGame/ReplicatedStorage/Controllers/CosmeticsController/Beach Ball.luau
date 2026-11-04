  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);
    local v4 = script.Model:Clone();
    v4.Parent = p2;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));
    v4.Weld.Part1 = p2.Head;
end;

return v1;