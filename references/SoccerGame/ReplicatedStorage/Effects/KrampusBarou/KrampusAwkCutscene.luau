  

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
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), SoundManager (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    LocalPlayer.Character:SetAttribute("PredatorKrampus", nil);
    SoundManager.SpawnSound("KrampusAwk", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://97649781728962",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "1:00",
            Duration = 2,
            Text = "Let\'s 1v1 Barou, I\'ll prove im number 1",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = EnemyChar and EnemyChar.Name or "Isagi",
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 151, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 84, 173)) }),
            TextStrokeColor = Color3.fromRGB(15, 27, 67)
        },
        {
            Timestamp = "4:00",
            Duration = 2,
            Text = "Is that so?",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 59, 59)), ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 13, 13)) }),
            TextStrokeColor = Color3.fromRGB(45, 5, 5),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.3
            }
        }
    };
    local v4, v5 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        Barou_pro24 = Char
    }, "Krampus BarouAwk", script.CodeEvents, 20, v3);
    CutsceneUtils.UnhideMap(v4, v5);
end;