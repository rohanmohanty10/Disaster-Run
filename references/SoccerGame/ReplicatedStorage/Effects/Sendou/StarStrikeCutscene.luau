  

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

    local u3 = p1 and p1.Enemy;

    if not (u3 and (u3.Parent and u3:FindFirstChild("HumanoidRootPart"))) then
        u3 = script.EnemyFallback;
    end;

    local u4 = require(script.Subtitles)({
        Name = "Sendou",
        Icon = ""
    });
    local v5, v6 = xpcall(function() -- Line: 15
        -- upvalues: CutsceneUtils (ref), u2 (copy), u3 (ref), u4 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SendouStarStrike",
            Length = 8.7,
            Character = u2,
            CharsToReplace = {
                rig = u2,
                R6 = u3
            },
            CodeEvents = script.CodeEvents,
            Subtitles = u4,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if not v5 then
        warn("[SendouStarStrike] " .. tostring(v6));
    end;
end;