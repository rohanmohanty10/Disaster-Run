  

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

    local TargetChar = p1.TargetChar;

    if not TargetChar then
        return;
    end;

    local v2 = require(script.Subtitles)({
        Name = "Kunigami",
        Icon = ""
    });
    local v3 = RunService.Heartbeat:Connect(function() -- Line: 25
        workspace.CurrentCamera.FieldOfView = 20;
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        steal = Char,
        kunigami = TargetChar
    }, "KunigamiDarkHorse", script.CodeEvents, nil, v2, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    v3:Disconnect();
end;