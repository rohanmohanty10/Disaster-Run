 
 

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
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), RunService (copy), TweenService (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        u1.Ability:Fire("Chimimin", {
            State = "Defense",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Your stand is ready to defend a shot or a pass.");
        u6.AC:Connect(RunService.Heartbeat, function() -- Line: 96
            -- upvalues: u5 (ref), u6 (copy)
            if u5.CharValues.HasBall then
                u6.AC:Clean();
            end;
        end);
        u6.AC:Add(function() -- Line: 102
            -- upvalues: Effects (ref)
            Effects:Popup("Ability ended.");
        end);
        u6.AC:Add(task.delay(15, function() -- Line: 106
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));

        return;
    end;

    u4:StopAll();
    u4:PlayChar("Johnny", "TuskDribble", Enum.AnimationPriority.Action3, true);
    u4:PlayBall("Johnny", "TuskDribbleBall", Enum.AnimationPriority.Action3, true);
    u1.Ability:Fire("Chimimin", {
        State = "Dribble",
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
    u6.AC:Add(NumberValue);
    u6.AC:Add(LinearVelocity);
    u2.States.Ability = true;
    task.delay(5.55, function() -- Line: 54
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Connect(RunService.Heartbeat, function() -- Line: 58
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
    end);
    task.wait(2.3833333333333333);
    NumberValue.Value = 100;
    local u7 = TweenService:Create(NumberValue, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 50
    });
    u7:Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    tick();
    local u8 = nil;
    u8 = RunService.RenderStepped:Connect(function() -- Line: 74
        -- upvalues: HumanoidRootPart (copy), RaycastParams_new_ret (copy), u8 (ref), u7 (copy), NumberValue (copy)
        local v9 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 5, RaycastParams_new_ret);

        if v9 and not v9.Instance.Parent:FindFirstChild("Humanoid") then
            u8:Disconnect();

            if u7 then
                u7:Cancel();
            end;

            if NumberValue then
                NumberValue.Value = 0;
            end;
        end;
    end);
    task.wait(1.8);
    u8:Disconnect();
    u6.AC:Clean();
end;