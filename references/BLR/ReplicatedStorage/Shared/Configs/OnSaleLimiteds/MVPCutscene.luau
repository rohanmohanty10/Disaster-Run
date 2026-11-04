  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local Icons = require(ReplicatedStorage.Shared.Configs.Icons);
local MVPCutscenes = require(ReplicatedStorage.Shared.MVPCutscenes);

return function(p1: string, p2: any, p3: any) -- Line: 7
    -- upvalues: MVPCutscenes (copy), Assets (copy), Icons (copy)
    local v4 = {
        Type = "MVPCutscene",
        HeaderOffset = 12,
        Name = p1
    };

    if MVPCutscenes[p1] then
        p1 = MVPCutscenes[p1].Display or p1;
    end;

    v4.DisplayName = p1;
    v4.ProductId = p2;
    v4.GiftProductId = p3;
    v4.Gradient = script.MVPGradient;

    function v4.LoadVisual(p5: any, p6: userdata) -- Line: 16
        -- upvalues: Assets (ref), Icons (ref)
        local v7 = Assets.LimitedTemplates.CardTemplate:Clone();
        v7.BG.Image = Icons.MVPCutscenes and Icons.MVPCutscenes[p5.Name] or "";
        v7.Adornee = p6.Origin;
        v7.Parent = p6;
    end;

    return v4;
end;