  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 6
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if u1 then
        u1 = u1.Char;
    end;

    if not (u1 and (u1.Parent and u1:FindFirstChild("HumanoidRootPart"))) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u2 = require(script.Subtitles)({
        Name = "Aiku",
        Icon = ""
    });
    local v3, v4 = xpcall(function() -- Line: 14
        -- upvalues: CutsceneUtils (ref), workspace_CurrentCamera (copy), FieldOfView (copy), u1 (copy), u2 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        workspace_CurrentCamera.FieldOfView = script:GetAttribute("InitialFov") or FieldOfView;
        CutsceneUtils.PlayCutscene({
            MoonFileName = "AikuEvolutionAwk",
            Length = 9.666666666666666,
            Character = u1,
            CharsToReplace = {
                Rekysui = u1
            },
            CodeEvents = script.CodeEvents,
            Subtitles = u2,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    local success, result = pcall(CutsceneUtils.ChangeLighting, ReplicatedStorage.Assets.MainLighting);
    workspace_CurrentCamera.FieldOfView = FieldOfView;

    if not success then
        warn("[AikuEvolutionAwk] lighting: " .. tostring(result));
    end;

    if not v3 then
        warn("[AikuEvolutionAwk] " .. tostring(v4));
    end;
end;