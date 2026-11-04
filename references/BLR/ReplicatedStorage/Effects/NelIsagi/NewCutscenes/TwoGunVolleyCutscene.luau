  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

local function changeLighting(p1) -- Line: 9
    -- upvalues: Lighting (copy)
    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for i, v in p1:GetAttributes() do
        Lighting[i] = v;
    end;

    for _, child in p1:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

return function(p2) -- Line: 22
    -- upvalues: Players (copy), SpectatorController (copy), changeLighting (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p2.Char;

    if not Char then
        return;
    end;

    local v3 = require(script.Subtitles)({
        Name = "Isagi",
        Icon = ""
    });
    print("two gun volley cutscene ");
    changeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Isagi = Char
    }, "IsagiTwoGunVolley", script.CodeEvents, 14, v3, script.SoundEvents);
    changeLighting(ReplicatedStorage.Assets.MainLighting);
end;