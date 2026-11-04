  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 9
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

    if PlayerFromCharacter then
        for _, v in Players:GetPlayers() do
            if v ~= PlayerFromCharacter and (v.Character and (v.Team ~= game.Teams.Visitor and v.Team ~= PlayerFromCharacter.Team)) then
                v2 = v.Character;
                break;
            end;
        end;
    end;

    local v3 = {
        Rekysui = Char
    };

    if v2 then
        v3["isagi or mvp"] = v2;
    end;

    local v4 = require(script.Subtitles)({
        Name = "Barou",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, v3, "KingAwk", script.CodeEvents, 18.333333333333332, v4, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;