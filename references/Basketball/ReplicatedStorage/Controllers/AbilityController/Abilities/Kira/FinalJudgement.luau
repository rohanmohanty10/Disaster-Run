 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p6) -- Line: 17
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), LocalPlayer (copy)
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.Network;
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(24, function() -- Line: 30
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Final Judgement", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;