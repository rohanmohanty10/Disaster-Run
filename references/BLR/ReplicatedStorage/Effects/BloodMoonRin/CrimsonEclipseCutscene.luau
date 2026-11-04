  

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
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), AnimationController (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    local v2 = {
        Icon = "rbxassetid://89044443686312",
        Name = Char.Name
    };
    SoundManager.SpawnSound("CrimsonEclipse", 1, workspace, 150);
    local v3 = {
        {
            Timestamp = "1:30",
            Duration = 1,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Don\'t Move.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(91, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(179, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "4:80",
            Duration = 2,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "The ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(28, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "moon",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(28, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                },
                {
                    Text = " has already decided your ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(28, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "fate.",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(28, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.45
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local BallTrack = AnimationController:GetBallTrack("Hide");
    BallTrack:Play();
    local u4 = true;
    task.spawn(function() -- Line: 139
        -- upvalues: u4 (ref)
        while u4 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 40;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        rin = Char,
        Borou = EnemyChar
    }, "Blood Moon RinCrimsonEclipse", script.CodeEvents, v3);
    u4 = false;
    BallTrack:Stop();
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;