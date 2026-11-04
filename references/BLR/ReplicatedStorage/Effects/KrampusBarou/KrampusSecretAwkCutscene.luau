  

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

    local _ = p1.EnemyChar;
    SoundManager.SpawnSound("KrampusSecretAwk", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "2:50",
            Duration = 3,
            Text = "Christmas isn\'t a time for joy",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = {
                Icon = "rbxassetid://97649781728962",
                Name = Char.Name
            },
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 59, 59)), ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 13, 13)) }),
            TextStrokeColor = Color3.fromRGB(45, 5, 5)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        krampus = Char
    }, "Krampus BarouSecretAwk", script.CodeEvents, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;