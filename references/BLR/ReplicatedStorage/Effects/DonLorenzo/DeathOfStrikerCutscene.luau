  

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
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("DeathOfStriker", 0.6, workspace, 150);
    local u2 = true;
    task.spawn(function() -- Line: 29
        -- upvalues: u2 (ref)
        while u2 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        ["Don lorenzo"] = Char,
        Rin = EnemyChar
    }, "Don LorenzoDeathOfStriker", script.CodeEvents);
    u2 = false;
end;