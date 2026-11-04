 
 

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

return function(p7) -- Line: 23
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
    local v8 = p7:CheckInfront(70);

    if not v8 then
        p7:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    local Vector3_new_ret = Vector3.new(Hoop.Position.X, v8.HumanoidRootPart.Position.Y, Hoop.Position.Z);

    if (v8.HumanoidRootPart.Position - Vector3_new_ret).Magnitude >= 70 then
        p7:ResetCD(1);
        Effects:Popup("Enemy player too far away from hoop.");

        return;
    end;

    local Vector3_new_ret2 = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret2).Magnitude;

    if Magnitude <= 25 then
        p7:ResetCD(1);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if Magnitude >= 110 then
        p7:ResetCD(1);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    if p7.MovementController.States.PumpFake then
        p7:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u3.States.NoWalk = true;
    u3.States.Ability = true;
    task.delay(1.5256410256410255, function() -- Line: 72
        -- upvalues: u3 (ref)
        u3.States.NoWalk = false;
        u3.States.Ability = false;
    end);
    u4.Ability:Fire("Sky Katana", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v8
    });
    u5:StopAll();
    local v9 = u5:PlayChar("Eclipse", "SkyKatana", Enum.AnimationPriority.Action3, true);
    local v10 = u5:PlayBall("Eclipse", "SkyKatanaBall", Enum.AnimationPriority.Action3, true);
    v9:AdjustSpeed(1.3);
    v10:AdjustSpeed(1.3);
end;