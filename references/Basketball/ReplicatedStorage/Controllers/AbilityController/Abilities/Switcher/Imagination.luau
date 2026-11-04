 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p4) -- Line: 21, Name: Imagination
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), Effects (copy)
    u1 = p4.AbilityService;
    u3 = p4.Animations;
    u2 = p4.MovementController;

    if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 150 then
        p4:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(16, function() -- Line: 33
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Imagination", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;