  

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
    SoundManager.SpawnSound("HungrySkull", 0.6, workspace, 150);
    SoundManager.SpawnSound("HungrySkullVA", 0.6, workspace, 150);
    local v2 = {
        {
            Timestamp = "3:40",
            Duration = 1.5,
            Text = "Devour him",
            Bold = true,
            Italic = false,
            TypeSpeed = 0.022,
            Speaker = {
                Icon = "rbxassetid://88803183173623",
                Name = Char.Name
            },
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(177, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.fromRGB(29, 63, 85)
        }
    };
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    local u3 = true;
    task.spawn(function() -- Line: 56
        -- upvalues: u3 (ref)
        while u3 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        TemplateR6 = Char,
        EvelynnDoesStuff = EnemyChar
    }, "Skeleton NagiHungry", script.CodeEvents, v2);
    u3 = false;
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;