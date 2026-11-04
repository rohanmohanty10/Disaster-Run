 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 21, Name: UltimatePassClient
    -- upvalues: LocalPlayer (copy), u5 (ref), u1 (ref), u3 (ref), u2 (ref), u4 (ref)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u5 = p6.Network;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u2.States.Ability = true;
    task.delay(0.5, function() -- Line: 32
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u3:StopAll();
    u3:PlayChar("Shots", "ShootF", Enum.AnimationPriority.Action3);
    u3:PlayBall("Shots", "ShootF", Enum.AnimationPriority.Action3);
end;