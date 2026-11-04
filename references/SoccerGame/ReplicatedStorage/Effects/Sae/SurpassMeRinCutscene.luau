  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SubtitleIcons = require(ReplicatedStorage2.Modules.CutsceneUtils.SubtitleIcons);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), SubtitleIcons (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local EnemyChar = p1.EnemyChar;

    if not (Char and EnemyChar) then
        return;
    end;

    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Sae
    };
    local v3 = require(script.Subtitles)(v2);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rekysui = Char,
        ["Trial shenanigans"] = EnemyChar
    }, "SaeSurpassMeRin", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;