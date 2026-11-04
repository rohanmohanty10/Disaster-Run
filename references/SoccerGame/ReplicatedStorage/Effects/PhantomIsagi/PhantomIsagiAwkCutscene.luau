  

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

    SoundManager.SpawnSound("PhantomIsagiAwk", 1, workspace, 150);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    ({
        Icon = "rbxassetid://84770760336721"
    }).Name = Char.Name;
    local v2 = {
        {
            Timestamp = "3:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "To become the worlds greatest striker",
            Color = Color3.fromRGB(8, 0, 255)
        },
        {
            Timestamp = "7:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "We need someone who will climb above 299 corpses...",
            Color = Color3.fromRGB(8, 0, 255)
        },
        {
            Timestamp = "11:00",
            Duration = 2,
            Speaker = "Ego",
            Text = "The phantom",
            TextTransparency = 0.5,
            TextStrokeColor = Color3.fromRGB(16, 16, 16),
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 13, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 38, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        }
    };
    local v3, v4 = CutsceneUtils.HideMap();
    local u5 = true;
    task.spawn(function() -- Line: 70
        -- upvalues: u5 (ref)
        while u5 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 40;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        ["phantom isagi"] = Char
    }, "Phantom IsagiAwk", nil, v2);
    u5 = false;
    CutsceneUtils.UnhideMap(v3, v4);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;