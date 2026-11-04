 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: Quickstep
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), TweenService (copy), Essentials (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;

    if u6:HoopDist() > 80 then
        u6:ResetCD(2);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(20000, 20000, 20000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local Vector3_new_ret = Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z);
    LinearVelocity.VectorVelocity = ((Vector3_new_ret - HumanoidRootPart.Position).Unit + HumanoidRootPart.CFrame.RightVector) * 35;
    task.delay(0.4, function() -- Line: 43
        -- upvalues: LinearVelocity (copy), Vector3_new_ret (copy), HumanoidRootPart (copy), TweenService (ref)
        LinearVelocity.VectorVelocity = ((Vector3_new_ret - HumanoidRootPart.Position).Unit + -HumanoidRootPart.CFrame.RightVector + Vector3.new(0, 1, 0)) * 30;
        task.wait(0.3);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = ((Vector3_new_ret - HumanoidRootPart.Position).Unit + -HumanoidRootPart.CFrame.RightVector + Vector3.new(0, -2, 0)) * 20
        }):Play();
    end);
    task.delay(1, function() -- Line: 48
        -- upvalues: LinearVelocity (copy), u2 (ref)
        LinearVelocity:Destroy();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("Fetch", `Floater{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Fetch", `Floater{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Floater", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 63
        -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.Dunking = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v7 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(2 + v7.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v7 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;