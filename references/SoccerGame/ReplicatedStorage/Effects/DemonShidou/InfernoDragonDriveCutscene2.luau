  

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
    SoundManager.SpawnSound("InfernoDragonDriveSfx2", 0.6, workspace, 150);
    task.delay(18, function() -- Line: 29
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("InfernoDragonDriveVoiceLine", 2, workspace, 150);
    end);
    local v2 = {
        [Char] = "Shidou"
    };

    if EnemyChar then
        v2[EnemyChar] = "Isagi";
    end;

    local u3 = true;
    task.spawn(function() -- Line: 42
        -- upvalues: u3 (ref)
        while u3 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    local v4 = {
        {
            Timestamp = "19:17",
            Duration = 2,
            Speaker = {
                Name = "Ego",
                Icon = "rbxassetid://113806463142487"
            },
            Dialogue = {
                {
                    Text = "He has now entered the ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 126, 212)),
                    TextStrokeColor = Color3.fromRGB(82, 20, 62),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Demon Stage",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 126, 212)), ColorSequenceKeypoint.new(1, Color3.fromRGB(156, 45, 123)) }),
                    TextStrokeColor = Color3.fromRGB(74, 17, 56),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    CutsceneUtils.PlayCutscene(Char, {
        Shidou = Char,
        Isagi = EnemyChar
    }, "Demon ShidouInfernoDragonDrive2", script.CodeEvents, v4);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, true);
    u3 = false;
end;