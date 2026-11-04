 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
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

return function(u6) -- Line: 19
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), TweenService (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if u5.CharValues.HasBall then
        u1.Ability:Fire("Blade Dash", {
            Task = "Tri-Slash",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(3, function() -- Line: 35
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u4:StopAll();
        u4:PlayChar("Eclipse", "TriSlash1", Enum.AnimationPriority.Action3);
        u4:PlayBall("Eclipse", "TriSlash1Ball", Enum.AnimationPriority.Action3);
        task.wait(1);
        u4:StopAll();
        u4:PlayChar("Eclipse", "TriSlash2", Enum.AnimationPriority.Action3);
        u4:PlayBall("Eclipse", "TriSlash2Ball", Enum.AnimationPriority.Action3);
        task.wait(0.75);
        u4:StopAll();
        u4:PlayChar("Eclipse", "TriSlash3", Enum.AnimationPriority.Action3);
        u4:PlayBall("Eclipse", "TriSlash3Ball", Enum.AnimationPriority.Action3);
        task.wait(1);

        return;
    end;

    local _, v7 = u3:GetEnemyWithinDistance(50, true);

    if not (v7 and (u3:GetCharacterPossessingBall() and u3:GetCharacterPossessingBall() == v7)) then
        u6:ResetCD(2);
        Effects:Popup("An enemy player with the ball must be close to you!", 4);

        return;
    end;

    local HumanoidRootPart2 = v7.HumanoidRootPart;
    u1.Ability:Fire("Blade Dash", {
        Task = "Blade Dash",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
    u4:StopAll();
    u4:PlayChar("Eclipse", "BladeDash", Enum.AnimationPriority.Action3);
    u4:PlayBall("Eclipse", "BladeDashBall", Enum.AnimationPriority.Action3);
    local LookVector = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector;
    local NumberValue = Instance.new("NumberValue");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(NumberValue);
    u6.AC:Add(LinearVelocity);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(0.5, function() -- Line: 87
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u6.AC:Add(task.delay(0.5, function() -- Line: 91
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    TweenService:Create(NumberValue, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 200
    }):Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local u8 = nil;
    tick();
    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 104
        -- upvalues: HumanoidRootPart (copy), HumanoidRootPart2 (copy), u8 (ref), LookVector (ref), LinearVelocity (copy), NumberValue (copy), RaycastParams_new_ret (copy), u9 (ref)
        if (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude > 5 and not u8 then
            LookVector = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector;
            LinearVelocity.VectorVelocity = LookVector * NumberValue.Value;
        else
            LinearVelocity.VectorVelocity = LookVector * NumberValue.Value;
            u8 = true;
        end;

        local v11 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 4, RaycastParams_new_ret);

        if v11 and not v11.Instance.Parent:FindFirstChild("Humanoid") then
            u9:Disconnect();
            LinearVelocity:Destroy();
        end;
    end);
    task.delay(0.3333333333333333, function() -- Line: 120
        -- upvalues: NumberValue (copy), LinearVelocity (copy), RunService (ref), u9 (ref)
        NumberValue.Value = 0;
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        RunService.Heartbeat:Wait();
        u9:Disconnect();
        LinearVelocity:Destroy();
    end);
end;