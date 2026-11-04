  

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
local SubtitleIcons = require(ReplicatedStorage2.Modules.CutsceneUtils.SubtitleIcons);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), SoundManager (copy), SubtitleIcons (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("McNagiAwk", 0.6, workspace, 150);
    local v2 = {
        Name = Char.Name,
        Icon = SubtitleIcons.McNagi
    };
    local v3 = {
        {
            Timestamp = "0:05",
            Duration = 1,
            Text = "*bruh*",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 111, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 214, 93)) }),
            TextStrokeColor = Color3.fromRGB(94, 37, 20)
        },
        {
            Timestamp = "4:07",
            Duration = 1,
            Text = "Hi I\'m Nagi, how can I help you?",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 111, 94)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 214, 93)) }),
            TextStrokeColor = Color3.fromRGB(94, 37, 20)
        },
        {
            Timestamp = "7:35",
            Duration = 2,
            Speaker = "Customer",
            Text = "Yea, I just want a burger and a sod-",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Color = ColorSequence.new(Color3.fromRGB(255, 246, 226)),
            TextStrokeColor = Color3.fromRGB(71, 61, 44)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        AfkWorldNpc = Char
    }, "McNagi FryshiroAwk", script.CodeEvents, 20, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;