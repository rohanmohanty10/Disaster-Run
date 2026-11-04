  

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
    SoundManager.SpawnSound("CookieDefense", 0.6, workspace, 150);
    local u2 = true;
    task.spawn(function() -- Line: 31
        -- upvalues: u2 (ref)
        while u2 do
            task.wait();
            workspace.CurrentCamera.FieldOfView = 25;
        end;
    end);
    local u3 = nil;
    task.spawn(function() -- Line: 39
        -- upvalues: u3 (ref)
        local script_GBMan = script.GBMan;

        repeat
            task.wait();
        until workspace:FindFirstChild("VFX") and workspace.VFX:FindFirstChild("Army");

        u3 = workspace.VFX.Army.BigBoiGB.AnimationController.Animator:LoadAnimation(script_GBMan);
        u3:Play();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig, false);
    CutsceneUtils.PlayCutscene(Char, {
        ["cookie charles"] = Char,
        Isagi = EnemyChar
    }, "Gingerbread CharlesCookieD", script.CodeEvents);
    u2 = false;
    u3:Stop();
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting, false);
end;