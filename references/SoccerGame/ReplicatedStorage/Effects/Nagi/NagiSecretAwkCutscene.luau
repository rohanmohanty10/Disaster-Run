  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 8
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = require(script.Subtitles)({
        Name = "Nagi",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v3, v4 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        reekais = Char
    }, "NagiSecretAwk", script.CodeEvents, nil, v2, script.SoundEvents);
    CutsceneUtils.UnhideMap(v3, v4);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;