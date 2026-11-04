  

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
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), AnimationController (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("PILoser", 0.6, workspace, 150);
    ({
        Icon = "rbxassetid://84770760336721"
    }).Name = Char.Name;
    local v2 = {
        {
            Timestamp = "9:00",
            Duration = 1,
            Text = "Loser.",
            Speaker = Char.Name,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 26, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 26, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local BallTrack = AnimationController:GetBallTrack("Hide");
    BallTrack:Play();
    local u3 = true;
    task.spawn(function() -- Line: 57
        -- upvalues: u3 (ref)
        while u3 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 40;
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        TemplateR6 = Char,
        EvelynnDoesStuff = EnemyChar
    }, "Phantom IsagiLoser", script.CodeEvents, 14, v2);
    u3 = false;
    BallTrack:Stop();
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;