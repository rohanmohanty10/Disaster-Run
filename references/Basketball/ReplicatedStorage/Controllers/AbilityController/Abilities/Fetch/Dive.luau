 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 18, Name: Dive
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy)
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;

    if u4:GetPlayerPossessingBall() then
        u6:ResetCD(1);
        Effects:Popup("Ball must have been just blocked or missed a shot!");

        return;
    end;

    if u4:GetLastPlayerToPossessBall() == nil then
        u6:ResetCD(1);
        Effects:Popup("Ball must have been just blocked or missed a shot!");

        return;
    end;

    local Value = ReplicatedStorage.Basketball.Value;
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local ServerBallPosition = u4:GetServerBallPosition();

    if (ServerBallPosition - HumanoidRootPart.Position).Magnitude >= 80 then
        u6:ResetCD(1);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    if ServerBallPosition.Y > 15 then
        u6:ResetCD(1);
        Effects:Popup("Ball is too far up!");

        return;
    end;

    u1.Ability:Fire("Dive", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Connect(u1.Ability, function(p7) -- Line: 52
        -- upvalues: Effects (ref), u6 (copy), u2 (ref), u3 (ref), u4 (ref), Value (copy), HumanoidRootPart (copy), TweenService (ref)
        if p7.Fail then
            Effects:Popup("Ball must have been just blocked or missed a shot!");
            u6.CDS[1] = tick() + 1;

            return;
        end;

        u6:ResetCopy();
        u2.States.Ability = true;
        u3:StopAll();
        local v8 = u3:PlayChar("Fetch", "Dive", Enum.AnimationPriority.Action3, true);
        local v9 = u3:PlayBall("Fetch", "DiveBall", Enum.AnimationPriority.Action3, true);
        v8:AdjustSpeed(1.25);
        v9:AdjustSpeed(1.25);
        local v10 = u4:GetServerBallPosition() + Value.AssemblyLinearVelocity * 0.125;
        local Unit = (Vector3.new(v10.X, HumanoidRootPart.Position.Y, v10.Z) - HumanoidRootPart.Position).Unit;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u6.AC:Add(LinearVelocity);
        LinearVelocity.VectorVelocity = Unit * 225;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = Unit * 185
        }):Play();
        task.wait(0.2);
        u2.States.Ability = false;
        u6.AC:Clean();
    end);
end;