 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u3) -- Line: 13
    -- upvalues: u1 (ref), u2 (ref), LocalPlayer (copy), Effects (copy)
    u1 = u3.AbilityService;
    u2 = u3.MovementController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude <= 20 then
        u3:ResetCD(4);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 100 then
        u3:ResetCD(4);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    u1.Ability:Fire("Spirit Shot", {
        Task = "Activate",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.PumpFake = true;
    local Shiftlock = u3.CameraController.Shiftlock;
    u3.CameraController:SetShiftlock(false);
    u3.AC:Add(function() -- Line: 41
        -- upvalues: u1 (ref), u2 (ref), u3 (copy), Shiftlock (copy)
        u1.Ability:Fire("Spirit Shot", {
            Task = "Cleanup",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.PumpFake = false;

        if not u3.CameraController.Shiftlock then
            u3.CameraController:SetShiftlock(Shiftlock);
        end;
    end);
    u3.AC:Connect(u1.Ability, function() -- Line: 51
        -- upvalues: u3 (copy)
        u3.AC:Clean();
    end);
    u3.AC:Add(task.delay(10, function() -- Line: 55
        -- upvalues: u3 (copy)
        u3.AC:Clean();
    end));
end;