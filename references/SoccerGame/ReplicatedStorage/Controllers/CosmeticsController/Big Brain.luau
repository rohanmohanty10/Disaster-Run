  

local v1 = {};
game:GetService("RunService");
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);
    local v4 = script.Brain:Clone();
    v4.Parent = p2;
    v4.Head.Part0 = p2.Head;
    CollectionService:AddTag(v4, (`Cosmetic{p3}`));

    for _, child in script.Torso:GetChildren() do
        local v5 = child:Clone();
        v5.Parent = p2.Torso;
        CollectionService:AddTag(v5, (`Cosmetic{p3}`));
    end;
end;

return v1;