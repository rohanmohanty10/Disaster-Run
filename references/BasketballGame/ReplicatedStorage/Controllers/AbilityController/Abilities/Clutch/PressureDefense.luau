 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 20, Name: PressureDefense
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u4 (ref), u2 (ref), u6 (ref), u5 (ref), Effects (copy), Essentials (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u4 = u7.BallController;
    u2 = u7.MovementController;
    u6 = u7.CameraController;
    u5 = u7.Network;
    local ServerBallPosition = u4:GetServerBallPosition();
    local v8 = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z) - HumanoidRootPart.Position;

    if v8:Dot(v8) >= 2500 then
        u7:ResetCD(2);
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall and PlayerPossessingBall.Team == LocalPlayer.Team then
        u7:ResetCD(2);
        Effects:Popup("Enemy team must have the ball!");

        return;
    end;

    local v9 = workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position - ServerBallPosition;

    if v9:Dot(v9) <= (ServerBallPosition.Y >= 16 and 60 or 30) ^ 2 and PlayerPossessingBall == nil then
        u7:ResetCD(2);
        Effects:Popup("Can\'t use ability while ball is near the hoop!");

        return;
    end;

    if PlayerPossessingBall then
        u3:StopAll();
        u3:PlayChar("Clutch", "Ability2", Enum.AnimationPriority.Action3, true);
    elseif HumanoidRootPart.CFrame.LookVector:Dot(v8) <= 0 then
        u3:StopAll();
        u3:PlayChar("Clutch", "Ability2L", Enum.AnimationPriority.Action3, true);
    else
        u3:StopAll();
        u3:PlayChar("Clutch", "Ability2R", Enum.AnimationPriority.Action3, true);
    end;

    u2.States.Ability = true;
    task.delay(0.5, function() -- Line: 83
        -- upvalues: u2 (ref), u7 (copy)
        u2.States.Ability = false;
        u7.AC:Clean();
    end);
    u1.Ability:Fire("PressureDefense", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.CFrame = HumanoidRootPart.CFrame;
    AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
    AlignOrientation.MaxTorque = 40000;
    AlignOrientation.Responsiveness = 200;
    AlignOrientation.Parent = HumanoidRootPart;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.VectorVelocity = v8 * 2.5;
    LinearVelocity.Parent = HumanoidRootPart;
    u7.AC:Add(AlignOrientation);
    u7.AC:Add(LinearVelocity);
end;