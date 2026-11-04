  

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

    local u2 = require(script.Subtitles)({
        Name = "Sendou",
        Icon = ""
    });
    local v3, v4 = xpcall(function() -- Line: 11
        -- upvalues: CutsceneUtils (ref), u1 (copy), u2 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SendouAwk",
            Length = 6.666666666666667,
            Character = u1,
            CharsToReplace = {
                Rekysui = u1
            },
            CodeEvents = script.CodeEvents,
            Subtitles = u2,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if not v3 then
        warn("[SendouAwk] " .. tostring(v4));
    end;
end;