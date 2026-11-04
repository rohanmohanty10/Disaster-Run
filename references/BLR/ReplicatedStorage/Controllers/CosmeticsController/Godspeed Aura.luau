  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    game.Players:GetPlayerFromCharacter(p2);

    for _, child in script.Extra:GetChildren() do
        local v4 = p2:FindFirstChild(child.Name);

        if v4 then
            local v5 = child:Clone();
            v5.Parent = v4;
            v5.CFrame = v4.CFrame;
            Essentials:Weld(v4, v5);
            CollectionService:AddTag(v5, (`Cosmetic{p3}`));
        end;
    end;

    for _, child in script.Particles:GetChildren() do
        local v6 = p2:FindFirstChild(child.Name);

        if v6 then
            local v7 = child:Clone();
            v7.Parent = v6;
            v7.CFrame = v6.CFrame;
            Essentials:Weld(v6, v7);
            CollectionService:AddTag(v7, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;