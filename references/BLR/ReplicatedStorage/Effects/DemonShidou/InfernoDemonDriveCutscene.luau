  

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

    local TeammateChar = p1.TeammateChar;
    SoundManager.SpawnSound("InfernoDragonDrive", 0.6, workspace, 150);
    task.delay(4.4, function() -- Line: 36
        -- upvalues: SoundManager (ref)
        SoundManager.SpawnSound("InfernoDragonDriveVoiceLine", 2, workspace, 150);
    end);
    CutsceneUtils.PlayCutscene(Char, {
        Shidou = Char,
        Sae = TeammateChar
    }, "Demon ShidouInfernoDrive", script.CodeEvents, 10, {
        {
            Timestamp = "5:38",
            Duration = 2,
            Text = "He has now entered the Demon Stage",
            Speaker = Char.Name
        }
    });
end;