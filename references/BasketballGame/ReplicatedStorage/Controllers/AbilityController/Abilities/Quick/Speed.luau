 
 

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
    u1.AbilityService.Ability:Fire("SPEED.", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u1.AC:Connect(u1.AbilityService.Ability, function() -- Line: 17
        -- upvalues: u1 (copy), workspace_CurrentCamera (ref), RunService (ref), Essentials (ref)
        u1.AC:Clean();
        local MovementController = u1.MovementController;
        MovementController.Boost = MovementController.Boost + 15;
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        local u2 = nil;
        u2 = RunService.RenderStepped:Connect(function(p3) -- Line: 27
            -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref), u1 (ref), u2 (ref)
            FieldOfView = Essentials:Lerp(FieldOfView, 110, p3 * 6);
            workspace_CurrentCamera.FieldOfView = FieldOfView;

            if not u1.Network.CharValues.InAwakening then
                u2:Disconnect();
            end;
        end);
        task.delay(20, function() -- Line: 37
            -- upvalues: u1 (ref), u2 (ref)
            local MovementController2 = u1.MovementController;
            MovementController2.Boost = MovementController2.Boost - 15;

            if u1.MovementController.Boost < 0 then
                u1.MovementController.Boost = 0;
            end;

            if u2 then
                u2:Disconnect();
            end;
        end);
    end);
end;