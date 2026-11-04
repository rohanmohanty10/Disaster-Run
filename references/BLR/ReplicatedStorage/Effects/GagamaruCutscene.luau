  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 10
    -- upvalues: SoundManager (copy), Popup (copy)
    local Character = p1.Plr.Character;
    SoundManager.SpawnSound("GagamaruAwake", 0.6, workspace, 150);
    task.delay(2, function() -- Line: 15
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Darn. I\'ll try again.");
    end);

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    workspace_CurrentCamera.FieldOfView = 33;
    task.spawn(function() -- Line: 25
        -- upvalues: workspace_CurrentCamera (copy)
        for i = 1, 10 do
            workspace_CurrentCamera.FieldOfView = 33;
            task.wait(0.05);
            local _ = i;
        end;
    end);
end;