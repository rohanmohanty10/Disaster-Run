  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);

return function(p1: string, p2: any, p3: any) -- Line: 7
    -- upvalues: makePlayerModel (copy), ReplicatedStorage (copy), KnitClient (copy), Assets (copy)
    return {
        Type = "Cosmetic",
        HeaderOffset = 10,
        Name = p1,
        ProductId = p2,
        GiftProductId = p3,
        Gradient = script.CosmeticGradient,

        LoadVisual = function(p4, p5) -- Line: 15, Name: LoadVisual
            -- upvalues: makePlayerModel (ref), ReplicatedStorage (ref), KnitClient (ref), Assets (ref)
            local v6 = makePlayerModel();
            v6:PivotTo(p5.Origin.CFrame);
            v6.Parent = p5;
            local Humanoid = v6.Humanoid;
            local v7 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(p4.Name);

            if v7 and v7:IsA("Accessory") then
                Humanoid:AddAccessory(v7:Clone());
            else
                KnitClient.GetController("CosmeticsController"):setupCosmetic(v6, p4.Name);
            end;

            v6.Humanoid:LoadAnimation(Assets.Emotes["Banana Song"]):Play();
        end
    };
end;