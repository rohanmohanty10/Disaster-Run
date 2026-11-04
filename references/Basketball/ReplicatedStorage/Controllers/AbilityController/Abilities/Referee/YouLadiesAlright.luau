 
 

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
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), Effects (copy)
    u1 = p5.MovementController;
    u2 = p5.BallController;
    u3 = p5.AbilityService;
    u4 = p5.Animations;
    local v6 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position;

    if v6:Dot(v6) >= 22500 then
        p5:ResetCD(4);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u1.States.Ability = true;
    u1.States.NoWalk = true;
    task.delay(9.65, function() -- Line: 34
        -- upvalues: u1 (ref)
        u1.States.Ability = false;
        u1.States.NoWalk = false;
    end);
    u4:StopAll();
    u3.Ability:Fire("You Ladies Alright?", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;