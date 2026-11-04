  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local Emotes = require(ReplicatedStorage.Shared.Emotes.Emotes);

return function(p1: string, p2: any, p3: string?) -- Line: 7
    -- upvalues: makePlayerModel (copy), Emotes (copy), SoundService (copy)
    local v4 = {
        Type = "Emote",
        HeaderOffset = 12,
        PodiumName = p3,
        Name = p1
    };
    local v5;

    if p2 then
        v5 = p2.ID;
    else
        v5 = p2;
    end;

    v4.GamepassId = v5;
    local v6;

    if p2 then
        v6 = p2.CatalogAssetID;
    else
        v6 = p2;
    end;

    v4.CatalogAssetID = v6;

    if p2 then
        p2 = p2.ProductId;
    end;

    v4.ProductId = p2;
    v4.Gradient = script.EmoteGradient;

    function v4.LoadVisual(p7, p8) -- Line: 17
        -- upvalues: makePlayerModel (ref), Emotes (ref), SoundService (ref)
        local v9 = makePlayerModel();
        local v10 = p8:FindFirstChild("Main") or p8:FindFirstChild("Origin");
        v9:PivotTo(v10 and v10.CFrame or p8:GetPivot());
        v9.Parent = p8;
        local v11 = Emotes[p7.Name];

        if not (v11 and v11.play) then
            warn((`no emote named "{p7.Name}" for the mythic podium`));

            return;
        end;

        local u12 = v11.play(v9, "VisualWorld");
        local DisplayEmotes = SoundService:FindFirstChild("DisplayEmotes");

        if DisplayEmotes then
            for _, descendant in v9:GetDescendants() do
                if descendant:IsA("Sound") then
                    descendant.SoundGroup = DisplayEmotes;
                end;
            end;
        end;

        v9.Destroying:Once(function() -- Line: 44
            -- upvalues: u12 (copy)
            if u12 then
                u12();
            end;
        end);
    end;

    return v4;
end;