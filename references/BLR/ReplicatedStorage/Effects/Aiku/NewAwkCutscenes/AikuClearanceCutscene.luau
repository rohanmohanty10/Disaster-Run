  

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
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("Aiku100Clearance", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://120584416494906",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "1:00",
            Duration = 0.8,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "100% WIN RATE",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new(Color3.fromRGB(120, 255, 140)),
                    TextStrokeColor = Color3.fromRGB(93, 0, 255),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "2:00",
            Duration = 0.5,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "THIS BALL",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.024,
                    Color = ColorSequence.new(Color3.fromRGB(120, 255, 140)),
                    TextStrokeColor = Color3.fromRGB(93, 0, 255),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "3:00",
            Duration = 0.5,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "BELONGS TO ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new(Color3.fromRGB(120, 255, 140)),
                    TextStrokeColor = Color3.fromRGB(93, 0, 255),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "ME",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 81)) }),
                    TextStrokeColor = Color3.fromRGB(58, 0, 144),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    Char:SetAttribute("SnakeVision", nil);
    local u4 = true;
    task.spawn(function() -- Line: 119
        -- upvalues: u4 (ref)
        while u4 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Aiku = Char,
        R6 = EnemyChar
    }, "AikuClearance", script.CodeEvents, v3);
    u4 = false;
end;