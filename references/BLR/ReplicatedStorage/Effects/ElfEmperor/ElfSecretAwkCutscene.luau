  

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
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("ElfSecretAwk", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://83550703729526",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "4:00",
            Duration = 1,
            Text = "Thank you for your hard work my...",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.028,
            Speaker = {
                Name = "Isagi"
            },
            Color = Color3.fromRGB(34, 78, 171),
            TextStrokeColor = Color3.fromRGB(7, 17, 41)
        },
        {
            Timestamp = "28:00",
            Duration = 1,
            Text = "Thank you my finest elf",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = Color3.fromRGB(165, 255, 170),
            TextStrokeColor = Color3.fromRGB(27, 87, 34)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    local v4, v5 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        Kaizer = Char
    }, "Elf EmperorSecretAwk", script.CodeEvents, 34, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
    CutsceneUtils.UnhideMap(v4, v5);
end;