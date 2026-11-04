  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);
    local v4 = script.Torso:Clone();
    v4.Parent = p2;

    for _, child in v4:GetChildren() do
        CollectionService:AddTag(child, (`Cosmetic{p3}`));
        child.Parent = p2.Torso;
    end;

    v4:Destroy();
end;

return v1;