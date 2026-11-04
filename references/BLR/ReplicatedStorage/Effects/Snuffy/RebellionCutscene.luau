  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);

return function(p1) -- Line: 8
    -- upvalues: Players (copy), SpectatorController (copy), CameraController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
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
        Rekysui = u2
    };
    local u4 = {
        [u2] = true
    };

    local function addCharacter(p5, p6) -- Line: 20
        -- upvalues: u4 (copy), u3 (copy)
        if typeof(p6) == "Instance" and (p6:IsA("Model") and (p6.Parent and (p6:FindFirstChild("HumanoidRootPart") and (p6:FindFirstChildOfClass("Humanoid") and not u4[p6])))) then
            u4[p6] = true;
            u3[p5] = p6;
        end;
    end;

    local v7 = p1.EnemyChars or {};
    addCharacter("barou", p1.BarouChar);
    addCharacter("npc1", v7[1]);
    addCharacter("npc2", v7[2]);
    local u8 = require(script.Subtitles)({
        Name = "Snuffy",
        Icon = ""
    });
    local v9 = {
        Finished = false
    };
    CameraController.RebellionPlayback = v9;
    local v10, v11 = xpcall(function() -- Line: 40
        -- upvalues: CutsceneUtils (ref), u2 (copy), u3 (copy), u8 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene({
            MoonFileName = "SnuffyRebellion",
            Length = 10,
            Character = u2,
            CharsToReplace = u3,
            CodeEvents = script.CodeEvents,
            Subtitles = u8,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    local success, result = pcall(function() -- Line: 52
        -- upvalues: CutsceneUtils (ref), ReplicatedStorage (ref)
        CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    end);
    v9.Finished = true;

    if CameraController.RebellionPlayback == v9 then
        CameraController.RebellionPlayback = nil;
    end;

    if not success then
        warn("[SnuffyRebellion] lighting restore failed: " .. tostring(result));
    end;

    if not v10 then
        warn("[SnuffyRebellion] " .. tostring(v11));
    end;
end;