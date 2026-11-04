  

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
    SoundManager.SpawnSound("EmporersCatapult", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "3:00",
            Duration = 1,
            Speaker = {
                Icon = "rbxassetid://83550703729526",
                Name = Char.Name
            },
            Dialogue = {
                {
                    Text = "LAUNCH IT MY ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.024,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 115, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(8, 24, 12),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "ELVES",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 115, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 66, 66)) }),
                    TextStrokeColor = Color3.fromRGB(11, 24, 14),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    local u3 = true;
    task.spawn(function() -- Line: 79
        -- upvalues: u3 (ref)
        while u3 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 35;
        end;
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        ["Elf kaiser"] = Char,
        reekais = EnemyChar
    }, "Elf EmperorCatapult", script.CodeEvents, v2);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
    u3 = false;
end;