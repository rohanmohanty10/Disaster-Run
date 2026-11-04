 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(p4) -- Line: 22, Name: Emperor
    -- upvalues: LocalPlayer (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v5 = p4:CheckInfront(35);

    if not v5 then
        p4:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude >= 120 then
        p4:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u1 = p4.AbilityService;
    u3 = p4.Animations;
    u2 = p4.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(12, function() -- Line: 46
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Emperor", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v5
    });
end;