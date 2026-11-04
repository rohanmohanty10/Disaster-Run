 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local workspace_CurrentCamera = workspace.CurrentCamera;
local _ = Players.LocalPlayer;

return function(u1) -- Line: 14
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), Essentials (copy)
    u1.AbilityService.Ability:Fire("Boost", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local MovementController = u1.MovementController;
    MovementController.Boost = MovementController.Boost + 12;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u3 = RunService.RenderStepped:Connect(function(p2) -- Line: 22
        -- upvalues: u1 (copy), FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
        if u1.MovementController.Boost >= 27 then
            return;
        end;

        FieldOfView = Essentials:Lerp(FieldOfView, 95, p2 * 3);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    task.delay(5, function() -- Line: 29
        -- upvalues: u1 (copy), u3 (copy)
        local MovementController2 = u1.MovementController;
        MovementController2.Boost = MovementController2.Boost - 12;

        if u1.MovementController.Boost < 0 then
            u1.MovementController.Boost = 0;
        end;

        if u3 then
            u3:Disconnect();
        end;
    end);
end;