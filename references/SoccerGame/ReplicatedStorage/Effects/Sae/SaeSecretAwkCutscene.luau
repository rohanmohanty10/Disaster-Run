  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 8
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local v2 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and v.Team ~= PlayerFromCharacter.Team then
            v2 = v.Character;
            break;
        end;
    end;

    local v3 = {
        Icon = "rbxassetid://112452371794681",
        Name = Char.Name
    };
    local v4 = require(script.Subtitles)(v3);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v5 = {
        sae = Char
    };

    if v2 then
        v5.rin = v2;
    end;

    CutsceneUtils.PlayCutscene(Char, v5, "SaeSecretAwk", script.CodeEvents, 11, v4, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;