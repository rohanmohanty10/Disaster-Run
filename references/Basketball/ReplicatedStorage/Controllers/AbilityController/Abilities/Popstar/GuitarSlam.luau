 
 

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

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), ReplicatedStorage (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.BallController;
    u2 = u7.CameraController;
    u3 = u7.MovementController;
    u4 = u7.AbilityService;
    u5 = u7.Animations;
    u6 = u7.Network;
    local Value = ReplicatedStorage.Basketball.Value;
    local LastPlayerToPossessBall = u1:GetLastPlayerToPossessBall();

    if LastPlayerToPossessBall then
        LastPlayerToPossessBall = LastPlayerToPossessBall.Character;
    end;

    if not u7.Network.CharValues.HasBall then
        if u1:GetPlayerPossessingBall() then
            u7:ResetCD(4);
            Effects:Popup("Ball must not be on another player!");

            return;
        end;

        if Value.Parent ~= workspace then
            u7:ResetCD(4);
            Effects:Popup("Ball must be in air!");

            return;
        end;

        if Value.Position.Y > 17 then
            u7:ResetCD(4);
            Effects:Popup("Ball is too high up in the air!");

            return;
        end;

        if LastPlayerToPossessBall and (LastPlayerToPossessBall:GetAttribute("Unblockable") and LastPlayerToPossessBall:GetAttribute("Unblockable") > workspace:GetServerTimeNow()) then
            u7:ResetCD(4);
            Effects:Popup("Ball is unblockable!");

            return;
        end;

        if (u1:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude >= 30 then
            u7:ResetCD(4);
            Effects:Popup("Ball is too far away!");

            return;
        end;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);

    if (HumanoidRootPart.Position - Vector3_new_ret).Magnitude <= 50 then
        u7:ResetCD(4);
        Effects:Popup("Too close to Hoop!");

        return;
    end;

    if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
        u7:ResetCD(4);
        Effects:Popup("Only shootable from your half of the court!");

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        u7:ResetCD(4);
        Effects:Popup("Can\'t shoot while in the air!");

        return;
    end;

    u3.States.NoWalk = true;
    u3.States.Ability = true;
    task.delay(1, function() -- Line: 94
        -- upvalues: u3 (ref)
        u3.States.NoWalk = false;
        u3.States.Ability = false;
    end);
    u4.Ability:Fire("Guitar Slam", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    u5:PlayChar("Popstar", "GuitarSwing", Enum.AnimationPriority.Action3);
    u5:PlayBall("Popstar", "GuitarSwingBall", Enum.AnimationPriority.Action3);
    u7.AC:Connect(u4.Ability, function(p8) -- Line: 105
        -- upvalues: u7 (copy), Effects (ref), u3 (ref), u5 (ref)
        u7.AC:Clean();

        if p8 and p8.Fail then
            u7:ResetCD(4);
            Effects:Popup("Ball must not be on another player!");

            return;
        end;

        u3.States.Dunking = true;
        task.delay(2.05, function() -- Line: 115
            -- upvalues: u3 (ref)
            u3.States.NoWalk = false;
            u3.States.Ability = false;
            u3.States.Dunking = false;
        end);
        u5:PlayChar("Popstar", "GuitarSlam", Enum.AnimationPriority.Action3);
        u5:PlayBall("Popstar", "GuitarSlamBall", Enum.AnimationPriority.Action3);
    end);
end;