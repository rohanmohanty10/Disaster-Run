  

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
    SoundManager.SpawnSound("FireworkRainJune", 0.6, workspace, 150);
    task.spawn(function() -- Line: 30
        -- upvalues: SoundManager (ref)
        task.wait(3.6);
        SoundManager.SpawnSound("FireworkRainVL", 1.5, workspace, 150);
    end);
    local v2 = {
        {
            Timestamp = "4:00",
            Duration = 4,
            Speaker = {
                Name = "Ego",
                Icon = "rbxassetid://113806463142487"
            },
            Dialogue = {
                {
                    Text = "But far more frightening than the countless fireworks... is the ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 248, 205)),
                    TextStrokeColor = Color3.fromRGB(74, 62, 27),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "dribbler in the sky",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 104)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 118, 53)) }),
                    TextStrokeColor = Color3.fromRGB(21, 58, 25),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    local u3 = true;
    task.spawn(function() -- Line: 80
        -- upvalues: u3 (ref)
        while u3 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 30;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Bachira = Char,
        Lavinho = EnemyChar
    }, "Firework BachiraRain", script.CodeEvents, v2);
    u3 = false;
end;