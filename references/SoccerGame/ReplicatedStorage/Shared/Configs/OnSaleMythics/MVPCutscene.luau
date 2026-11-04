  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local Icons = require(ReplicatedStorage.Shared.Configs.Icons);
local MVPCutscenes = require(ReplicatedStorage.Shared.MVPCutscenes);

return function(p1: string, p2: any, p3: string?, p4: number?) -- Line: 7
    -- upvalues: MVPCutscenes (copy), Assets (copy), Icons (copy)
    local v5 = {
        Type = "MVPCutscene",
        PodiumName = p3,
        Name = p1
    };

    if MVPCutscenes[p1] then
        p1 = MVPCutscenes[p1].Display or p1;
    end;

    v5.DisplayName = p1;
    local v6;

    if p2 then
        v6 = p2.ID;
    else
        v6 = p2;
    end;

    v5.GamepassId = v6;
    local v7;

    if p2 then
        v7 = p2.CatalogAssetID;
    else
        v7 = p2;
    end;

    v5.CatalogAssetID = v7;

    if p2 then
        p2 = p2.ProductId;
    end;

    v5.ProductId = p2;
    v5.Gradient = script.MVPGradient;
    v5.HeaderOffset = p4 or 12;

    function v5.LoadVisual(p8: any, p9: userdata) -- Line: 18
        -- upvalues: Assets (ref), Icons (ref)
        for _, descendant in p9:GetDescendants() do
            if descendant:IsA("Animation") and descendant.Name == "PodiumAnimation" then
                local Parent = descendant.Parent;

                if Parent then
                    Parent = Parent:FindFirstChildWhichIsA("Humanoid") or Parent:FindFirstChildWhichIsA("AnimationController");
                end;

                if Parent then
                    local v10 = Parent:FindFirstChildOfClass("Animator");

                    if not v10 then
                        v10 = Instance.new("Animator");
                        v10.Parent = Parent;
                    end;

                    local v11 = v10:LoadAnimation(descendant);
                    v11.Looped = true;
                    v11:Play();
                end;
            end;
        end;

        local IconAnchor = p9:FindFirstChild("IconAnchor");

        if not IconAnchor then
            return;
        end;

        local v12 = Assets.LimitedTemplates.CardTemplate:Clone();
        v12.BG.Image = Icons.MVPCutscenes and Icons.MVPCutscenes[p8.Name] or "";
        v12.Adornee = IconAnchor;
        v12.Parent = p9;
    end;

    return v5;
end;