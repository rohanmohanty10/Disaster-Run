  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 10
    -- upvalues: Players (copy), SpectatorController (copy), SubtitleIcons (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
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
        Icon = SubtitleIcons.Gagamaru
    };
    local v3 = {
        Name = EnemyChar.Name,
        Icon = SubtitleIcons.Isagi
    };
    local v4 = require(script.Subtitles)(v3, v2);
    local u5 = RunService.Heartbeat:Connect(function() -- Line: 31
        workspace.CurrentCamera.FieldOfView = 40;
    end);
    task.delay(1, function() -- Line: 34
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v6 = {
        ["Trial shenanigans"] = Char
    };

    if EnemyChar then
        v6.Rekysui = EnemyChar;
    end;

    CutsceneUtils.PlayCutscene(Char, v6, "GagamaruAddressMe", script.CodeEvents, nil, v4, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;