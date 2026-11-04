  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.SoundManager);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);

return function(p1) -- Line: 10
    -- upvalues: Players (copy), SpectatorController (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local u2 = RunService.Heartbeat:Connect(function() -- Line: 17
        workspace.CurrentCamera.FieldOfView = 5;
    end);
    task.delay(0.5, function() -- Line: 20
        -- upvalues: u2 (ref)
        u2:Disconnect();
    end);
    local v3 = require(script.Subtitles)({
        Name = "Ness",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene({
        MoonFileName = "NessAwk",
        Length = 10.4,
        Character = Char,
        CharsToReplace = {
            rig = Char
        },
        CodeEvents = script.CodeEvents,
        Subtitles = v3,
        SoundCues = script.SoundEvents,
        OriginCFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, 0.6, 0)
    });
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;