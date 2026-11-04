  

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
    SoundManager.SpawnSound("BeeFreestyle", 0.6, workspace, 150);
    task.delay(11, function() -- Line: 30
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("BeeFreestyleVoiceline", 1.5, workspace, 150);
    end);
    local v2 = {
        {
            Timestamp = "12:00",
            Duration = 1,
            Speaker = {
                Icon = "rbxassetid://110236362600449",
                Name = Char.Name
            },
            Dialogue = {
                {
                    Text = "How do I become the ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 247, 176)),
                    TextStrokeColor = Color3.fromRGB(75, 63, 19),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "best in the world",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 59, 22)) }),
                    TextStrokeColor = Color3.fromRGB(39, 31, 10),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    workspace.CurrentCamera.FieldOfView = 35;
    CutsceneUtils.PlayCutscene(Char, {
        ["bachira anims"] = Char
    }, "Bachira NEL BeeFreestyle", script.CodeEvents, 18, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;