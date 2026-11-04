  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Assets = ReplicatedStorage.Assets;

return function(p1: string, p2: any, p3: any) -- Line: 5
    -- upvalues: Assets (copy), CollectionService (copy)
    return {
        Type = "PlayerCard",
        HeaderOffset = 12,
        Name = p1,
        ProductId = p2,
        GiftProductId = p3,
        Gradient = script.CardGradient,

        LoadVisual = function(p4: any, p5: userdata) -- Line: 13, Name: LoadVisual
            -- upvalues: Assets (ref), CollectionService (ref)
            local Name = p4.Name;
            local v6 = Assets.LimitedTemplates.CardTemplate:Clone();
            local v7 = Assets.Customization.Cards[Name];

            for _, v in v7:GetTags() do
                CollectionService:AddTag(v6.BG, v);
            end;

            for i, v in v7:GetAttributes() do
                v6.BG:SetAttribute(i, v);
            end;

            v6.BG.Image = v7:GetAttribute("DisplayImage") or v7.Image;
            v6.Adornee = p5.Origin;
            v6.Parent = p5;
        end
    };
end;