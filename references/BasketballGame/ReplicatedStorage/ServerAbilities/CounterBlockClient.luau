 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 19
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), TweenService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u5.AbilityService;
    u2 = u5.MovementController;
    u3 = u5.BallController;
    u4 = u5.Animations;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u5.AC:Add(function() -- Line: 31
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u5.AC:Add(task.delay(1.25, function() -- Line: 35
        -- upvalues: u5 (copy)
        u5.AC:Clean();
    end));
    task.wait(0.5666666666666667);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v6 = HumanoidRootPart.CFrame.LookVector * -12 + Vector3.new(0, 2.5, 0);
    local v7 = workspace:Raycast(HumanoidRootPart.Position, v6, RaycastParams_new_ret);

    if v7 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v7.Position - HumanoidRootPart.Position).Unit * (v7.Distance / 2), (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v6, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 45;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    BodyGyro.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    BodyGyro.Parent = HumanoidRootPart;
    local u8 = -HumanoidRootPart.CFrame.LookVector;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 15
    }):Play();
    task.delay(0.43333333333333335, function() -- Line: 72
        -- upvalues: TweenService (ref), LinearVelocity (copy), u8 (copy), BodyGyro (copy)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            VectorVelocity = (u8 - Vector3.new(0, 1, 0)) * 30
        }):Play();
        task.wait(0.2);
        LinearVelocity:Destroy();
        BodyGyro:Destroy();
    end);
    u5.AC:Connect(u1.Ability, function() -- Line: 79
        -- upvalues: u5 (copy), u2 (ref), ReplicatedStorage (ref), u3 (ref), Position (copy), HumanoidRootPart (copy)
        u5.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        local Value = ReplicatedStorage.Basketball.Value;
        local LastCharacterToPossessBall = u3:GetLastCharacterToPossessBall();
        Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Position);
        local v9 = Position;
        local v10 = v9 - Value.Position;
        local v11, v12;

        if (HumanoidRootPart.Position - v9).Magnitude <= 30 then
            v11 = v10.Magnitude * 0.0455;
            v12 = 1.35;
        else
            v11 = v10.Magnitude * 0.04;
            v12 = 0.5;
        end;

        local math_log_ret = math.log(v12 + v11);
        Value.AssemblyLinearVelocity = v10 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;