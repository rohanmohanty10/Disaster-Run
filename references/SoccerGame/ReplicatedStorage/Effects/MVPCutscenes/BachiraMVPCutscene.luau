  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(p1) -- Line: 10
    -- upvalues: Players (copy), SpectatorController (copy), Essentials (copy), CutsceneUtils (copy), SoundService (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = {
        Icon = "",
        Name = Char.Name
    };
    require(script.Subtitles)(v2);
    local v3 = Essentials:HideCosmetics(Char);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    SoundService.SoundGroup.OST.Volume = 0;
    CutsceneUtils.PlayCutscene(Char, {
        rig = Char
    }, "BachiraMVPCutscene", script.CodeEvents, 6, nil, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v3);
end;