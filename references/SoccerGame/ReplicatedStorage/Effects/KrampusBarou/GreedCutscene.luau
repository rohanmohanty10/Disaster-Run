  

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
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("KrampusGreed", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "2:50",
            Duration = 1,
            Speaker = EnemyChar and (EnemyChar.Name or "Isagi") or "Isagi",
            Dialogue = {
                {
                    Text = "HAH ",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.022,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 151, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 84, 173)) }),
                    TextStrokeColor = Color3.fromRGB(15, 27, 67),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Barous",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 59, 59)), ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 13, 13)) }),
                    TextStrokeColor = Color3.fromRGB(45, 5, 5),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                },
                {
                    Text = " nowhere near...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.024,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 151, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 84, 173)) }),
                    TextStrokeColor = Color3.fromRGB(15, 27, 67),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                }
            }
        }
    };
    local script_CamAnim = script.CamAnim;
    local u3 = script.Cam:Clone();
    u3:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
    u3.Parent = workspace.Debris;
    u3.AnimationController.Animator:LoadAnimation(script_CamAnim):Play();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 99
        -- upvalues: u3 (copy)
        workspace.CurrentCamera.FieldOfView = 35;
        workspace.CurrentCamera.CFrame = u3.CamPart.CFrame;
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        krampus = Char,
        reekais = EnemyChar
    }, "Krampus BarouGreed", script.CodeEvents, v2);
    u3:Destroy();
    v4:Disconnect();
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;