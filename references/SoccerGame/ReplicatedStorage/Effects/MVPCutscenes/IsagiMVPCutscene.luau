  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(p1) -- Line: 12
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), SoundService (copy), Essentials (copy), ReplicatedStorage (copy)
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
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v3 = p1.Teammates or {};
    SoundService.SoundGroup.OST.Volume = 0;
    local v4 = Essentials:HideCosmetics(Char);
    local v5 = {};

    for _, v in v3 do
        v5[v] = Essentials:HideCosmetics(v);
    end;

    CutsceneUtils.PlayCutscene(Char, {
        mainguy = Char,
        secondguy = v3[1],
        thirdguy = v3[2],
        fourthguy = v3[3]
    }, "IsagiMVPCutscene", script.CodeEvents, nil, nil, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v4);

    for _, v in v5 do
        Essentials:UnhideCosmetics(v);
    end;
end;