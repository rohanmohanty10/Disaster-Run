  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), SubtitleIcons (copy), Players (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local TeammateChar = p1.TeammateChar;
    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Isagi
    };
    local v3;

    if TeammateChar then
        v3 = Players:GetPlayerFromCharacter(TeammateChar);
    else
        v3 = TeammateChar;
    end;

    local v4 = {
        Name = v3 and v3.Name or (TeammateChar and (TeammateChar.Name or "Bachira") or "Bachira"),
        Icon = SubtitleIcons.Bachira
    };
    local v5 = require(script.Subtitles)(v2, v4);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        isagi = Char,
        bachira = TeammateChar
    }, "IsagiBachiraCR", script.CodeEvents, nil, v5, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;