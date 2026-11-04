  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: SpectatorController (copy), SoundManager (copy), Popup (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    SoundManager.SpawnSound("BearClawSFX", 0.6, workspace, 150);
    task.delay(0.4, function() -- Line: 21
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Jump, synapses");
    end);
    task.delay(2.3, function() -- Line: 24
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Here\'s my super reaction.");
    end);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    workspace_CurrentCamera.FieldOfView = 33;
    task.spawn(function() -- Line: 31
        -- upvalues: workspace_CurrentCamera (copy)
        for i = 1, 10 do
            workspace_CurrentCamera.FieldOfView = 33;
            task.wait(0.05);
            local _ = i;
        end;
    end);
    workspace:FindFirstChild("NagiCam");
    Char:FindFirstChild("BALL", true);
end;