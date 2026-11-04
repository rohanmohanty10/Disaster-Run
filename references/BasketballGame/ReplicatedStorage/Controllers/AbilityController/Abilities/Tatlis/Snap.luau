 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
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
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 19, Name: Snap
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.CameraController;
    local _ = p6.Network;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        p6:ResetCD(1);
        Effects:Popup("Can\'t use in air!");

        return;
    end;

    HumanoidRootPart.Anchored = true;
    Effects:Popup("(anyone inside the paint gets stunned + guaranteed steal inside paint)");
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.Boost = 6;
    u3:StopAll();
    u3:PlayChar("Tatlis", "Snap", Enum.AnimationPriority.Action3);
    u3:PlayBall("Tatlis", "SnapBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Snap", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.delay(0.5, function() -- Line: 51
        -- upvalues: HumanoidRootPart (copy), u2 (ref)
        HumanoidRootPart.Anchored = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    task.delay(2, function() -- Line: 56
        -- upvalues: u2 (ref)
        u2.Boost = 0;
    end);
end;