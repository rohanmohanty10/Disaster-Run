  

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
    SoundManager.SpawnSound("AikuAwkNew", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://120584416494906",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "4:40",
            Duration = 3,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "This sensation created a new world",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(198, 255, 208)),
                    TextStrokeColor = Color3.fromRGB(37, 112, 60),
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
            Duration = 0.5,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "I am now...",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new(Color3.fromRGB(182, 255, 198)),
                    TextStrokeColor = Color3.fromRGB(27, 99, 54),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "11:40",
            Duration = 1,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "UNSTOPPABLE",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(146, 255, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(53, 158, 84),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.45
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    local u4 = true;
    task.spawn(function() -- Line: 105
        -- upvalues: u4 (ref)
        while u4 do
            workspace.CurrentCamera.FieldOfView = 30;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Aiku = Char
    }, "AikuAwk", script.CodeEvents, v3);
    u4 = false;
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;