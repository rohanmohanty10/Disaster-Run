  

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
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), LocalPlayer (copy), AnimationController (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local Teammate1 = p1.Teammate1;
    local Teammate2 = p1.Teammate2;
    local Teammate3 = p1.Teammate3;
    SoundManager.SpawnSound("Raichi awakening CS (1)", 0.6, workspace, 150);
    print("Here");
    task.spawn(function() -- Line: 46
        -- upvalues: CutsceneUtils (ref), Char (copy), Teammate1 (copy), Teammate2 (copy), Teammate3 (copy)
        CutsceneUtils.PlayCutscene(Char, {
            snuffy = nil,
            enemy1 = Teammate1,
            enemy2 = Teammate2,
            gk = Teammate3
        }, "Raichi matchup victory", script.CodeEvents);
    end);
    task.wait();

    if Char == LocalPlayer.Character then
        local Track = AnimationController:GetTrack("Abilities", "MatchupVictoryPlayer");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
    end;
end;