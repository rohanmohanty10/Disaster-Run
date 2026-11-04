  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
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
    -- upvalues: SpectatorController (copy), Players (copy), SoundManager (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("NELRinAwk", 1.25, workspace, 150);
    local v2 = {
        Name = "Ego",
        Icon = "rbxassetid://113806463142487"
    };
    local v3 = {
        {
            Timestamp = "7:00",
            Duration = 1,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Before the world cup...",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new(Color3.fromRGB(171, 240, 255)),
                    TextStrokeColor = Color3.fromRGB(6, 15, 22),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        },
        {
            Timestamp = "9:00",
            Duration = 2,
            Speaker = v2,
            Dialogue = {
                {
                    Text = "Take another look at your ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.028,
                    Color = ColorSequence.new(Color3.fromRGB(171, 240, 255)),
                    TextStrokeColor = Color3.fromRGB(6, 15, 22),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "EGO",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 221, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 20, 28)) }),
                    TextStrokeColor = Color3.fromRGB(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 0.35
                    }
                }
            }
        }
    };
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 94
        workspace.CurrentCamera.FieldOfView = 40;
    end);
    task.delay(1, function() -- Line: 97
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        Rin = Char,
        R6 = p1.EnemyChar
    }, "RinNELAwk", script.CodeEvents, v3);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;