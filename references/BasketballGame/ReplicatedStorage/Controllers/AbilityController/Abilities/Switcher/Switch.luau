 
 

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
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 19, Name: Switch
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.BallController;
    local LookingAt = u5.Pass.LookingAt;

    if not LookingAt then
        Effects:Popup("Look at person you wanna switch with!", 2);

        return u5:ResetCD(2);
    end;

    if (u5.Network.CharValues.HasBall and 95 or 130) < (HumanoidRootPart.Position - LookingAt.HumanoidRootPart.Position).Magnitude then
        Effects:Popup("Your target is too far away!", 4);

        return u5:ResetCD(2);
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    local math_random_ret = math.random(1, 3);
    u3:StopAll();
    u3:PlayChar("Switcher", `Switch{math_random_ret}`, Enum.AnimationPriority.Action4);
    u1.Ability:Fire("Switch", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = LookingAt
    });
    u5.AC:Connect(u1.Ability, function() -- Line: 57
        -- upvalues: u5 (copy), Effects (ref)
        u5:ResetCD(2);
        Effects:Popup("COULDN\'T SWITCH WITH PLAYER");
    end);
    task.wait(0.6666666666666666);
    u2.States.Ability = false;
    u2.States.NoWalk = false;
end;