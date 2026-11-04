  

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

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("BachiraxLavinhoCR", 0.6, workspace, 150);
    task.delay(11, function() -- Line: 30
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("LavinhoCRVoiceline", 0.8, workspace, 150);
    end);
    local v2 = {
        {
            Timestamp = "12:00",
            Duration = 1,
            Speaker = "Lavinho",
            Text = "Well Well, on to you",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Color = ColorSequence.new(Color3.fromRGB(188, 255, 87)),
            TextStrokeColor = Color3.fromRGB(56, 94, 18)
        },
        {
            Timestamp = "13:50",
            Duration = 1,
            Speaker = "Lavinho",
            Dialogue = {
                {
                    Text = "The ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(188, 255, 87)),
                    TextStrokeColor = Color3.fromRGB(56, 94, 18),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "future dancer of Barcha",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 237, 90)), ColorSequenceKeypoint.new(1, Color3.fromRGB(67, 67, 24)) }),
                    TextStrokeColor = Color3.fromRGB(44, 37, 12),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    workspace.CurrentCamera.FieldOfView = 40;
    CutsceneUtils.PlayCutscene(Char, {
        bachira = Char,
        Lahvino = EnemyChar
    }, "BachiraLavinhoCR", script.CodeEvents, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;