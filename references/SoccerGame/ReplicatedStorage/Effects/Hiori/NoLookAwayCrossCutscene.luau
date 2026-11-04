  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), SubtitleIcons (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not (Char and Char:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Isagi
    };
    local v3 = {
        Name = "Hiori",
        Icon = SubtitleIcons.Hiori
    };
    local v4 = require(script.Subtitles)(v2, v3);
    local u5 = RunService.Heartbeat:Connect(function() -- Line: 32
        workspace.CurrentCamera.FieldOfView = 35;
    end);
    task.delay(1, function() -- Line: 35
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rekysui = Char
    }, "HioriNoLookAwayCross", script.CodeEvents, nil, v4, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;