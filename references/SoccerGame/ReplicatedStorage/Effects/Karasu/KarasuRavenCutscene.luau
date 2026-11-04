  

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
    -- upvalues: SpectatorController (copy), Players (copy), SoundManager (copy), RunService (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    Players:GetPlayerFromCharacter(p1.Char);

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("RavenAwaken", 0.6, workspace, 150);
    local v2 = {
        Icon = "rbxassetid://138503608927658",
        Name = Char.Name
    };
    local v3 = {
        {
            Timestamp = "0:01",
            Duration = 3,
            Text = "We gotta change for blue locks sake",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(35, 0, 78),
            Shake = {
                Enabled = false,
                Intensity = 1,
                Lifetime = 0.5
            }
        },
        {
            Timestamp = "7:00",
            Duration = 2,
            Text = "I\'m going to make us win",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = v2,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(106, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(35, 0, 78)
        }
    };
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 77
        workspace.CurrentCamera.FieldOfView = 50;
    end);
    task.delay(1, function() -- Line: 80
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Karasu = Char
    }, "KarasuRaven", script.CodeEvents, v3);

    if u4 then
        u4:Disconnect();
    end;
end;