  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(u1) -- Line: 8
    -- upvalues: Players (copy), SpectatorController (copy), Essentials (copy), CutsceneUtils (copy), SoundService (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    if u1 then
        u1 = u1.Char;
    end;

    if not (u1 and (u1.Parent and u1:FindFirstChild("HumanoidRootPart"))) then
        return;
    end;

    local v2 = Essentials:HideCosmetics(u1);
    local v3, v4 = xpcall(function() -- Line: 13
        -- upvalues: CutsceneUtils (ref), SoundService (ref), u1 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        SoundService.SoundGroup.OST.Volume = 0;
        CutsceneUtils.PlayCutscene({
            MoonFileName = "Barou2MVPCutscene",
            Length = 5,
            GoalFrame = 170,
            Character = u1,
            CharsToReplace = {
                Rekysui = u1
            },
            CodeEvents = script.CodeEvents,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v2);

    if not v3 then
        warn("[Barou2MVPCutscene] " .. tostring(v4));
    end;
end;