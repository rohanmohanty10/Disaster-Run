 
 

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
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);

    if (HumanoidRootPart.Position - Vector3_new_ret).Magnitude >= 110 then
        p6:ResetCD(3);
        Effects:Popup("Too far away from hoop.");

        return;
    end;

    u1.Ability:Fire("Dirty Dunks Done Dirt Cheap", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Valentine", "DirtyDunksDoneDirtCheap", Enum.AnimationPriority.Action3);
    u4:PlayBall("Valentine", "DirtyDunksDoneDirtCheapBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(3.3333333333333335, function() -- Line: 48
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
end;