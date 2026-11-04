  

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

    local _ = p1.EnemyChar;
    SoundManager.SpawnSound("ElfKaiserAwk", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "6:50",
            Duration = 1,
            Speaker = {
                Icon = "rbxassetid://83550703729526",
                Name = Char.Name
            },
            Dialogue = {
                {
                    Text = "Thank you my ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.028,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 115, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.fromRGB(8, 24, 12),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "elves",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(33, 115, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 66, 66)) }),
                    TextStrokeColor = Color3.fromRGB(11, 24, 14),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    local v3, v4 = CutsceneUtils.HideMap();
    CutsceneUtils.PlayCutscene(Char, {
        Kaizer = Char
    }, "Elf EmperorAwk", script.CodeEvents, 14, v2);
    CutsceneUtils.UnhideMap(v3, v4);
end;