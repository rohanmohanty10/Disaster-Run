 
 

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
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), Effects (copy)
    u1 = p5.AbilityService;
    u2 = p5.Animations;
    u3 = p5.MovementController;
    u4 = p5.BallController;
    local v6 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position;

    if v6:Dot(v6) >= 14400 then
        p5:ResetCD(4);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(7.617, function() -- Line: 35
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u2:StopAll();
    u1.Ability:Fire("Flying Dunk", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;