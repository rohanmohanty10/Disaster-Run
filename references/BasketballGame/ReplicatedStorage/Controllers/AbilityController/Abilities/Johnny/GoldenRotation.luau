 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p5) -- Line: 15
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), LocalPlayer (copy), Effects (copy)
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.BallController;
    local v6 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position;

    if v6:Dot(v6) >= 14400 then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9.983, function() -- Line: 34
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Golden Rotation", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;