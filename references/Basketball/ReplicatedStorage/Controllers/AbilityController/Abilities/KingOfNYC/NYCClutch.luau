 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p5) -- Line: 16
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), LocalPlayer (copy), Effects (copy)
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v6 = p5:CheckInfront(50);

    if not v6 then
        p5:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    local v7 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;

    if v7:Dot(v7) >= 14400 then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(11.667, function() -- Line: 42
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("NYC Clutch", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;