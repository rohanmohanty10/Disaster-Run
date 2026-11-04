  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), Essentials (copy), CutsceneUtils (copy), SoundService (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = (p1.Teammates or {})[1];
    local v3 = {
        Icon = "",
        Name = Char.Name
    };
    require(script.Subtitles)(v3);
    local v4 = Essentials:HideCosmetics(Char);
    local v5;

    if v2 then
        v5 = Essentials:HideCosmetics(v2);
    else
        v5 = v2;
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    SoundService.SoundGroup.OST.Volume = 0;
    CutsceneUtils.PlayCutscene(Char, {
        rig = Char,
        R6 = v2
    }, "ClownMVPCutscene", script.CodeEvents, nil, nil, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v4);

    if v5 then
        Essentials:UnhideCosmetics(v5);
    end;
end;