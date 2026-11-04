  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 7
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local EnemyChar = p1.EnemyChar;

    if not (Char and EnemyChar) then
        return;
    end;

    local v2 = {
        Icon = "",
        Name = Players:GetPlayerFromCharacter(EnemyChar) and (Players:GetPlayerFromCharacter(EnemyChar).Name or "Opponent") or "Opponent"
    };
    local v3 = require(script.Subtitles)({
        Name = "Rin",
        Icon = ""
    }, v2);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rekysui = Char,
        ["Trial shenanigans"] = EnemyChar
    }, "Rin2StepsBehindPart1", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;