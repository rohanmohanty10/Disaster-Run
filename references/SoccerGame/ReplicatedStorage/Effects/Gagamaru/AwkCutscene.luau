  

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

    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Gagamaru
    };
    local v3 = require(script.Subtitles)(v2);
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 24
        workspace.CurrentCamera.FieldOfView = 30;
    end);
    task.delay(1, function() -- Line: 27
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rekysui = Char
    }, "GagamaruAwk", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;