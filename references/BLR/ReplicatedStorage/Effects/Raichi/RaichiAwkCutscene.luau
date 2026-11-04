  

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

    local EnemyChar1 = p1.EnemyChar1;
    local EnemyChar2 = p1.EnemyChar2;
    SoundManager.SpawnSound("Raichi awakening move CS", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://81327674694036",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "0:00",
            Duration = 1,
            Speaker = {
                Name = "Ego",
                Icon = "rbxassetid://113806463142487"
            },
            Dialogue = {
                {
                    Text = "Bring me the ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
                    TextStrokeColor = Color3.fromRGB(38, 38, 38),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "shark",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 112, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(118, 34, 103)) }),
                    TextStrokeColor = Color3.fromRGB(61, 14, 53),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                },
                {
                    Text = " and the stamina freak",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
                    TextStrokeColor = Color3.fromRGB(38, 38, 38),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "10:00",
            Duration = 3,
            Text = "I\'m going to stop them all",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.024,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 176, 79)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 108, 24)) }),
            TextStrokeColor = Color3.fromRGB(94, 43, 9)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        raichi = Char,
        kurona = EnemyChar1,
        Ego = EnemyChar2
    }, "raichi awakening", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;