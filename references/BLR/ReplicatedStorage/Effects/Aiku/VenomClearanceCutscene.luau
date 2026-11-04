  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 6
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local u2;

    if p1 then
        u2 = p1.Char;
    else
        u2 = p1;
    end;

    if not (u2 and (u2.Parent and u2:FindFirstChild("HumanoidRootPart"))) then
        return;
    end;

    local EnemyChar = p1.EnemyChar;

    if not (EnemyChar and (EnemyChar.Parent and EnemyChar:FindFirstChild("HumanoidRootPart"))) then
        EnemyChar = script.EnemyFallback;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u3 = require(script.Subtitles)({
        Name = "Aiku",
        Icon = ""
    });
    local v4, v5 = xpcall(function() -- Line: 15
        -- upvalues: CutsceneUtils (ref), workspace_CurrentCamera (copy), FieldOfView (copy), u2 (copy), EnemyChar (ref), u3 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        workspace_CurrentCamera.FieldOfView = script:GetAttribute("InitialFov") or FieldOfView;
        CutsceneUtils.PlayCutscene({
            MoonFileName = "AikuVenomClearance",
            Length = 8.016666666666667,
            Character = u2,
            CharsToReplace = {
                rig = u2,
                R6 = EnemyChar
            },
            CodeEvents = script.CodeEvents,
            Subtitles = u3,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    local success, result = pcall(CutsceneUtils.ChangeLighting, ReplicatedStorage.Assets.MainLighting);
    workspace_CurrentCamera.FieldOfView = FieldOfView;

    if not success then
        warn("[AikuVenomClearance] lighting: " .. tostring(result));
    end;

    if not v4 then
        warn("[AikuVenomClearance] " .. tostring(v5));
    end;
end;