  

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
    SoundManager.SpawnSound("TheGate", 0.6, workspace, 150);
    task.delay(6.3, function() -- Line: 29
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("TheGateVoiceline", 2, workspace, 150);
    end);
    local v2 = {
        Icon = "rbxassetid://140303852298284",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "6:43",
            Duration = 3,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Welcome to my ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 122, 207)),
                    TextStrokeColor = Color3.fromRGB(82, 20, 62),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "gate",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 122, 207)), ColorSequenceKeypoint.new(1, Color3.fromRGB(154, 47, 126)) }),
                    TextStrokeColor = Color3.fromRGB(74, 17, 56),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                },
                {
                    Text = ", to ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 122, 207)),
                    TextStrokeColor = Color3.fromRGB(82, 20, 62),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Hades",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(162, 51, 129)) }),
                    TextStrokeColor = Color3.fromRGB(74, 17, 56),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "12:08",
            Duration = 2,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "You\'re ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 122, 207)),
                    TextStrokeColor = Color3.fromRGB(82, 20, 62),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Garbage",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(155, 43, 121)) }),
                    TextStrokeColor = Color3.fromRGB(74, 17, 56),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, true);
    CutsceneUtils.PlayCutscene(Char, {
        R6 = Char,
        EvelynnDoesStuff = EnemyChar
    }, "Demon ShidouGate", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, true);

    if EnemyChar then
        for _, child in EnemyChar:GetChildren() do
            if child:FindFirstChild("Ring") then
                child:FindFirstChild("Ring").LocalTransparencyModifier = 0;
            end;
        end;
    end;
end;