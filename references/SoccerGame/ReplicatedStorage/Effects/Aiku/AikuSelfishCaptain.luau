  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);
local u1 = false;

return function(p2) -- Line: 8
    -- upvalues: u1 (ref), Players (copy), SpectatorController (copy), SubtitleIcons (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    local v3 = game:GetService("RunService"):IsStudio();

    if v3 then
        if p2 then
            v3 = p2.StudioPreview == true;
        else
            v3 = p2;
        end;
    end;

    if u1 or Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or v3) then
        return;
    end;

    local u4;

    if p2 then
        u4 = p2.Char;
    else
        u4 = p2;
    end;

    if p2 then
        p2 = p2.TeammateChar;
    end;

    if not (u4 and (u4.Parent and (u4:FindFirstChild("HumanoidRootPart") and (p2 and (p2.Parent and p2:FindFirstChild("HumanoidRootPart")))))) then
        return;
    end;

    u1 = true;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local Attribute = u4:GetAttribute("AikuSelfishCaptainActor");
    local Attribute2 = p2:GetAttribute("AikuSelfishCaptainSupport");
    u4:SetAttribute("AikuSelfishCaptainActor", true);
    p2:SetAttribute("AikuSelfishCaptainSupport", true);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);
    local script_Subtitles = require(script.Subtitles);
    local v5 = {
        Name = u4.Name,
        Icon = SubtitleIcons.Aiku
    };
    local v6 = {};
    local v7;

    if PlayerFromCharacter then
        v7 = PlayerFromCharacter.Name;
    else
        v7 = p2.Name;
    end;

    v6.Name = v7;
    v6.Icon = SubtitleIcons.Sae;
    local u8 = script_Subtitles(v5, v6);
    local v9, v10 = xpcall(function() -- Line: 26
        -- upvalues: CutsceneUtils (ref), workspace_CurrentCamera (copy), u4 (copy), u8 (copy)
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        workspace_CurrentCamera.FieldOfView = script:GetAttribute("InitialFov") or 25;
        CutsceneUtils.PlayCutscene({
            MoonFileName = "AikuSelfishCaptain",
            Length = 13.433333333333334,
            Character = u4,
            CharsToReplace = {
                rig = u4
            },
            CodeEvents = script.CodeEvents,
            Subtitles = u8,
            SoundCues = script.SoundEvents
        });
    end, debug.traceback);
    local success, result = pcall(CutsceneUtils.ChangeLighting, ReplicatedStorage.Assets.MainLighting);
    workspace_CurrentCamera.FieldOfView = FieldOfView;

    if u4.Parent then
        u4:SetAttribute("AikuSelfishCaptainActor", Attribute);
    end;

    if p2.Parent then
        p2:SetAttribute("AikuSelfishCaptainSupport", Attribute2);
    end;

    u1 = false;

    if not success then
        warn("[AikuSelfishCaptain] Lighting restore: " .. tostring(result));
    end;

    if not v9 then
        warn("[AikuSelfishCaptain] " .. tostring(v10));
    end;
end;