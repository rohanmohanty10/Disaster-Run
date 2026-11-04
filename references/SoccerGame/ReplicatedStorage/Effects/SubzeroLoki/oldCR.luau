  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local _ = p1.OtherChar and (p1.OtherChar:FindFirstChild("HumanoidRootPart") and p1.OtherChar);
    local v2 = {
        {
            Timestamp = "1:30",
            Duration = 1,
            Text = "Even the moon bends...",
            Speaker = Char.Name,
            Color = Color3.fromRGB(90, 0, 0)
        },
        {
            Timestamp = "3:00",
            Duration = 1,
            Text = "When I decide its path",
            Speaker = Char.Name,
            Color = Color3.fromRGB(90, 0, 0)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        loki = Char,
        CharlesMasterPasser = p1.OtherChar
    }, "Subzero LokiCharlesCR", script.CodeEvents, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;