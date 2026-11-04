  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), SubtitleIcons (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Reo
    };
    local v3 = require(script.Subtitles)(v2);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        reo = Char,
        victim = EnemyChar
    }, "ReoMetaDefense", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;