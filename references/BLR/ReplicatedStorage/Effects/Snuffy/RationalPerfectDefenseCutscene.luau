  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 7
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

    local u3 = {
        rig2 = u2
    };
    local u4 = {
        [u2] = true
    };
    (function(p5, p6) -- Line: 19, Name: addCharacter
        -- upvalues: u4 (copy), u3 (copy)
        if typeof(p6) == "Instance" and (p6:IsA("Model") and (p6.Parent and (p6:FindFirstChild("HumanoidRootPart") and (p6:FindFirstChildOfClass("Humanoid") and not u4[p6])))) then
            u4[p6] = true;
            u3[p5] = p6;
        end;
    end)("victim", p1.EnemyChar);
    local u7 = require(script.Subtitles)({
        Name = "Snuffy",
        Icon = ""
    });
    local v8, v9 = xpcall(function() -- Line: 32
        -- upvalues: CutsceneUtils (ref), u2 (copy), u3 (copy), u7 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SnuffyRationalPerfectDefense",
            Length = 4,
            Character = u2,
            CharsToReplace = u3,
            CodeEvents = script.CodeEvents,
            Subtitles = u7,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if not v8 then
        warn("[SnuffyRationalPerfectDefense] " .. tostring(v9));
    end;
end;