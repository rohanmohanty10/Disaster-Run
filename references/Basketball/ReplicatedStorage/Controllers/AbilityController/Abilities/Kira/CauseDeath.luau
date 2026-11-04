 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), TweenService (copy), ReplicatedStorage (copy), Effects (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.CauseDeathCD.Value > workspace:GetServerTimeNow() then
            local v8 = ReplicatedStorage.Cooldowns.CauseDeathCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v8);
            Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
            u7:ResetCD(2);

            return;
        end;

        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
            Effects:Popup("Enemy player must have the ball!");
            u7:ResetCD(2);

            return;
        end;

        if not u3:LocalPlayerIsWithinDistanceOfBall(25) then
            u7:ResetCD(2);
            Effects:Popup("Must be close to the ball!");

            return;
        end;

        u1.Ability:Fire("Cause of Death", {
            State = "Cause of Death",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 88
            -- upvalues: u2 (ref)
            u2.Boost = 0;
            task.delay(0.25, function() -- Line: 90
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end);
        end);
        u7.AC:Add(task.delay(2.3, function() -- Line: 95
            -- upvalues: u2 (ref), HumanoidRootPart (copy)
            u2.Boost = 15;
            u2.States.Ability = false;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -100;
            task.delay(0.15, function() -- Line: 106
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
        end));
        u7.AC:Add(task.delay(2.533333333333333, function() -- Line: 111
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u7.AC:Connect(u1.Ability, function(p9) -- Line: 115
            -- upvalues: u7 (copy), Effects (ref), u2 (ref)
            if p9 then
                if p9.Fail then
                    u7.AC:Clean();
                    u7:ResetCD(2);
                    Effects:Popup("Unable to cause death on enemy!");

                    return;
                end;

                u2.Boost = -15;
            end;
        end);

        return;
    end;

    u2.Boost = 15;
    u2.States.Ability = true;
    u7.AC:Add(function() -- Line: 38
        -- upvalues: u2 (ref)
        u2.Boost = 0;
        u2.States.Ability = false;
    end);
    u7.AC:Add(task.delay(1.0166666666666666, function() -- Line: 43
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    u7.AC:Add(task.delay(0.5166666666666667, function() -- Line: 47
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end));
    u5:StopAll();
    u5:PlayChar("Kira", "DeathDrive", Enum.AnimationPriority.Action3);
    u5:PlayBall("Kira", "DeathDriveBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Cause of Death", {
        State = "Forward",
        TimeSent = workspace:GetServerTimeNow(),
        Direction = HumanoidRootPart.CFrame.LookVector
    });
    local v10 = u7.AC:Add(Instance.new("LinearVelocity"));
    v10.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    v10.MaxAxesForce = Vector3.new(40000, 0, 40000);
    v10.Attachment0 = HumanoidRootPart.RootAttachment;
    v10.Parent = HumanoidRootPart;
    v10.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 75;
    TweenService:Create(v10, TweenInfo.new(1.0166666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * 25
    }):Play();
end;