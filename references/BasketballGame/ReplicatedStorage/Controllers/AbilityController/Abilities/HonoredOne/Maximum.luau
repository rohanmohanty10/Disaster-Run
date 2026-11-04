 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p5) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), Effects (copy), RunService (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p5.AbilityService;
    u2 = p5.MovementController;
    u3 = p5.BallController;
    u4 = p5.Animations;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        p5:ResetCD(4);

        return;
    end;

    u4:StopAll();
    u4:PlayChar("HonoredOne", "MaximumDribble", Enum.AnimationPriority.Action3);
    u4:PlayBall("HonoredOne", "MaximumDribbleBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Maximum", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local NumberValue = Instance.new("NumberValue", HumanoidRootPart);
    NumberValue.Value = 0;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(400000, 0, 400000);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    p5.AC:Add(NumberValue);
    p5.AC:Add(LinearVelocity);
    u2.States.Ability = true;
    task.delay(2.8, function() -- Line: 57
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    p5.AC:Connect(RunService.Heartbeat, function() -- Line: 61
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
    end);
    task.wait(1.5166666666666666);
    NumberValue.Value = 400;
    local u6 = TweenService:Create(NumberValue, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 50
    });
    u6:Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    tick();
    local u7 = nil;
    u7 = RunService.RenderStepped:Connect(function() -- Line: 77
        -- upvalues: HumanoidRootPart (copy), RaycastParams_new_ret (copy), u7 (ref), u6 (copy), NumberValue (copy)
        local v8 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 5, RaycastParams_new_ret);

        if v8 and not v8.Instance.Parent:FindFirstChild("Humanoid") then
            u7:Disconnect();

            if u6 then
                u6:Cancel();
            end;

            if NumberValue then
                NumberValue.Value = 0;
            end;
        end;
    end);
    task.wait(0.75);
    u7:Disconnect();
    p5.AC:Clean();
end;