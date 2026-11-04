 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p6.AbilityService;
    u2 = p6.MovementController;
    u3 = p6.BallController;
    u4 = p6.Animations;
    u5 = p6.Network;

    if not u5.CharValues.HasBall then
        u1.Ability:Fire("Scream", {
            State = "Scream",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("TatlisV2", "Scream", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(1.3166666666666667, function() -- Line: 61
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);

    if (HumanoidRootPart.Position - Vector3_new_ret).Magnitude >= 110 then
        p6:ResetCD(3);
        Effects:Popup("Too far away from hoop.");

        return;
    end;

    u1.Ability:Fire("Scream", {
        State = "Deadly Distance",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("TatlisV2", "DeadlyDistance", Enum.AnimationPriority.Action3);
    u4:PlayBall("TatlisV2", "DeadlyDistanceBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(1.85, function() -- Line: 49
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
end;