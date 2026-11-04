 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p4) -- Line: 21, Name: Freedom
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = p4.AbilityService;
    u3 = p4.Animations;
    u2 = p4.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(23.666666666666668, function() -- Line: 31
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Freedom", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;