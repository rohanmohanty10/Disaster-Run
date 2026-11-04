  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = require(script.Subtitles)({
        Name = "Shidou",
        Icon = ""
    });
    local u3 = RunService.Heartbeat:Connect(function() -- Line: 22
        workspace.CurrentCamera.FieldOfView = 20;
    end);
    task.delay(1, function() -- Line: 25
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        ["Trial shenanigans"] = Char
    }, "NEL ShidouUnstoppableDemonHeader", script.CodeEvents, 5, v2, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;