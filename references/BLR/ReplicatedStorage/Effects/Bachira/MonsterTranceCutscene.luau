  

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
    -- upvalues: SpectatorController (copy), SoundManager (copy), CutsceneUtils (copy), RunService (copy), ReplicatedStorage2 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local EnemyChar = p1.EnemyChar;
    SoundManager.SpawnSound("MonsterTrance", 0.6, workspace, 150);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    local u2 = true;
    task.spawn(function() -- Line: 34
        -- upvalues: u2 (ref)
        while u2 do
            workspace.CurrentCamera.FieldOfView = 40;
            task.wait();
        end;
    end);

    if RunService:IsStudio() then
        EnemyChar = nil;
    end;

    CutsceneUtils.PlayCutscene(Char, {
        bachira = Char,
        Npc = EnemyChar
    }, "BachiraMonsterTrance", script.CodeEvents);
    u2 = false;
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;