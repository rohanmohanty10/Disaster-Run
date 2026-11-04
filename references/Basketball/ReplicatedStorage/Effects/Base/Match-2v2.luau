 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 11
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 18
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u5:Disconnect();

            return;
        end;

        if u4 <= 0 then
            u4 = p6 * 60 * u3;
        end;

        u4 = u4 + p6 * 60;
        local v7 = script_Fov[math.ceil(u4)];

        if v7 ~= nil then
            if math.ceil(u4) >= #script_Fov then
                u5:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v7, p6 * 6);
        end;
    end);
    task.delay(10 - u3, function() -- Line: 36
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
end;