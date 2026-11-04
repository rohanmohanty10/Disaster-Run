 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p6) -- Line: 18
    -- upvalues: u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), LocalPlayer (copy), Effects (copy)
    u1 = p6.Network;
    u2 = p6.AbilityService;
    u4 = p6.Animations;
    u3 = p6.MovementController;
    u5 = p6.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v7 = p6:CheckInfront(35);

    if not v7 then
        p6:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    local v8 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;

    if v8:Dot(v8) >= 10000 then
        p6:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(14.5, function() -- Line: 45
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u4:StopAll();
    u2.Ability:Fire("Silver Posterizer", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
end;