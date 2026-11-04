  

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

    local v2 = p1.EnemyChar and (p1.EnemyChar:FindFirstChild("HumanoidRootPart") and p1.EnemyChar) or nil;
    local v3 = {
        Icon = "rbxassetid://89044443686312",
        Name = Char.Name
    };
    SoundManager.SpawnSound("ScarletOrbit", 1, workspace, 150);
    local v4 = {
        {
            Timestamp = "1:10",
            Duration = 1,
            Speaker = v3,
            Dialogue = {
                {
                    Text = "Even the ",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.027,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(24, 0, 0),
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
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(61, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(24, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                },
                {
                    Text = " bends...",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(24, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "2:90",
            Duration = 1,
            Speaker = v3,
            Dialogue = {
                {
                    Text = "When I decide its ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(24, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "path",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 18, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)) }),
                    TextStrokeColor = Color3.fromRGB(24, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.4
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local v5 = workspace.Maps:GetChildren()[1];
    v5.Parent = ReplicatedStorage2;
    local v6 = {};

    for _, descendant in workspace.Field:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("Texture")) and descendant.Transparency ~= 1 then
            v6[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;

    CutsceneUtils.PlayCutscene(Char, {
        EvelynnDoesStuff = Char,
        TemplateR6 = v2
    }, "Blood Moon RinScarletOrbit", script.CodeEvents, v4);
    v5.Parent = workspace.Maps;

    for i, v in v6 do
        i.Transparency = v;
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;