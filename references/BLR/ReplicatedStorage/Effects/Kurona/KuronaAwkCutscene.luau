  

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
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("KuronaAwkNew", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "1:00",
            Duration = 1,
            Speaker = "Noel Noa",
            Dialogue = {
                {
                    Text = "You\'re up, ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.026,
                    Color = ColorSequence.new(Color3.fromRGB(255, 134, 220)),
                    TextStrokeColor = Color3.fromRGB(78, 18, 63),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 0.5
                    }
                },
                {
                    Text = "Shark",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 134, 220)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 27, 55)) }),
                    TextStrokeColor = Color3.fromRGB(44, 10, 35),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 0.35
                    }
                }
            }
        },
        {
            Timestamp = "12:00",
            Duration = 2.5,
            Text = "Hey you\'re off the field, you\'ve done enough",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = Char.Name,
            Color = ColorSequence.new(Color3.fromRGB(255, 144, 225)),
            TextStrokeColor = Color3.fromRGB(78, 18, 63)
        }
    };
    local u3 = RunService.Heartbeat:Connect(function() -- Line: 80
        workspace.CurrentCamera.FieldOfView = 25;
    end);
    task.delay(1, function() -- Line: 83
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);

    for _, v in Players:GetPlayers() do
        if v.Team == PlayerFromCharacter.Team and (v ~= PlayerFromCharacter and (v.Character and v.Character:FindFirstChild("HumanoidRootPart"))) then
            local _ = v.Character;
            break;
        end;
    end;

    CutsceneUtils.PlayCutscene(Char, {
        Kurona = Char
    }, "KuronaAwk", script.CodeEvents, 20.3, v2);

    if u3 then
        u3:Disconnect();
    end;

    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;