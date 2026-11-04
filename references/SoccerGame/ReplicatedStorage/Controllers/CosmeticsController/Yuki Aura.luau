  

local v1 = {};
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);

    for _, child in ReplicatedStorage.Assets.Misc.YukiAura:GetChildren() do
        if p2:FindFirstChild(child.Name) and child:IsA("BasePart") then
            local v4 = child;

            for _, child2 in child:GetChildren() do
                if child2:IsA("Attachment") or (child2:IsA("ParticleEmitter") or child2:IsA("Beam")) then
                    local v5 = child2:Clone();
                    v5.Parent = p2[v4.Name];
                    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
                end;
            end;
        end;
    end;
end;

return v1;