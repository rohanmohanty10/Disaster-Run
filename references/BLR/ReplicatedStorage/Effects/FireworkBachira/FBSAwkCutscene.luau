  

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
    SoundManager.SpawnSound("FBSecretAwk", 0.6, workspace, 150);
    task.spawn(function() -- Line: 31
        -- upvalues: SoundManager (ref)
        task.wait(2);
        local v2 = SoundManager.SpawnSound("FBSAwkVL1", 2, workspace, 150);
        task.wait(2.5);
        v2:Destroy();
        task.wait(1);
        SoundManager.SpawnSound("FBSAwkVL2", 1, workspace, 150);
    end);
    local v3 = {
        Icon = "rbxassetid://99597463816978",
        Name = Char.Name
    };
    local v4 = {
        {
            Timestamp = "3:00",
            Duration = 2,
            Text = "I think its time you get revenge for what happened on christmas",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.026,
            Speaker = {
                Name = "Isagi",
                Icon = "rbxassetid://96797711723599"
            },
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(96, 136, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 88, 176)) }),
            TextStrokeColor = Color3.fromRGB(12, 24, 59)
        },
        {
            Timestamp = "5:00",
            Duration = 1,
            Text = "Let\'s go",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = v3,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 104)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 118, 53)) }),
            TextStrokeColor = Color3.fromRGB(21, 58, 25),
            Shake = {
                Enabled = true,
                Intensity = 1,
                Lifetime = 0.3
            }
        }
    };
    local u5 = true;
    task.spawn(function() -- Line: 88
        -- upvalues: u5 (ref)
        while u5 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 35;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Bachira = Char
    }, "Firework BachiraSecretAwk", script.CodeEvents, v4);
    u5 = false;
end;