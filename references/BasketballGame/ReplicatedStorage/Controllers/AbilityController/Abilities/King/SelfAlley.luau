 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p7.BallController;
    u2 = p7.CameraController;
    u3 = p7.MovementController;
    u4 = p7.AbilityService;
    u5 = p7.Animations;
    u6 = p7.Network;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude <= 20 then
        p7:ResetCD(2);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 100 then
        p7:ResetCD(2);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if p7.MovementController.States.PumpFake then
        p7:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u3.States.NoWalk = true;
    u3.States.Ability = true;
    task.delay(3.033333333333333, function() -- Line: 55
        -- upvalues: u3 (ref)
        u3.States.NoWalk = false;
        u3.States.Ability = false;
    end);
    u4.Ability:Fire("Self Alley", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    u5:PlayChar("King", "SelfAlley", Enum.AnimationPriority.Action3);
    u5:PlayBall("King", "SelfAlleyBall", Enum.AnimationPriority.Action3);
end;