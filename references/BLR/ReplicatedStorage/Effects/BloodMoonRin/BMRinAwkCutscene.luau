  

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

    local v2 = {
        Icon = "rbxassetid://89044443686312",
        Name = Char.Name
    };
    SoundManager.SpawnSound("BMRAwk", 1, workspace, 150);
    local v3 = {
        {
            Timestamp = "2:00",
            Duration = 2,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Under the ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.028,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(18, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "blood moon",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.024,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(18, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "4:70",
            Duration = 2,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "I will ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(20, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "annihilate",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(49, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(20, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 0.45
                    }
                },
                {
                    Text = " everyone on this field",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(20, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v4, v5 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        rin = Char
    }, "Blood Moon RinAwk", nil, 7.5, v3);
    CutsceneUtils.UnhideMap(v4, v5);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;