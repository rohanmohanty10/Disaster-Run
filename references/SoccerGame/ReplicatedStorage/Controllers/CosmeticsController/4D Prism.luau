  

game:GetService("RunService");
game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

return {
    SetupCosmetic = function(p1, p2) -- Line: 9, Name: SetupCosmetic
        -- upvalues: CollectionService (copy)
        game.Players:GetPlayerFromCharacter(p1);
        local v3 = script.Torso:Clone();
        local Weld = Instance.new("Weld", v3.Torso);
        Weld.Part0 = v3.Torso;
        Weld.Part1 = p1.Torso;
        v3.Parent = p1;
        CollectionService:AddTag(v3, (`Cosmetic{p2}`));
    end
};