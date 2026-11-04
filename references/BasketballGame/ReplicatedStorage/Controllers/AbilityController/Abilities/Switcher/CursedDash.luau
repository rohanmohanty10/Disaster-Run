 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 19, Name: Switch
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.BallController;

    if Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        u5:ResetCD(1);

        return;
    end;

    u2.States.Ability = true;
    u3:StopAll();
    u3:PlayChar("Switcher", "CursedDash", Enum.AnimationPriority.Action3);
    u3:PlayBall("Switcher", "CursedDashBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("CursedDash", {
        TimeSent = workspace:GetServerTimeNow()
    });
    Effects:Popup("I AM THE EXCEPTION! (50% chance of attack at the end, enemy must be close!)", 1);
    u5.AC:Add(task.delay(1.6, function() -- Line: 44
        -- upvalues: u5 (copy), u2 (ref)
        u5.AC:Clean();
        u2.States.Ability = false;
    end));
    task.delay(0.16666666666666666, function() -- Line: 51
        -- upvalues: HumanoidRootPart (copy), u5 (copy), RunService (ref)
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u5.AC:Add(LinearVelocity);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 1;
        u5.AC:Add(NumberValue);
        task.delay(0.3333333333333333, function() -- Line: 61
            -- upvalues: NumberValue (copy)
            game:GetService("TweenService"):Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                Value = 0.05
            }):Play();
        end);
        u5.AC:Connect(RunService.Heartbeat, function(p6) -- Line: 66
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (ref), NumberValue (copy)
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * (165 * NumberValue.Value) * Vector3.new(1, 0, 1);
        end);
        u5.AC:Add(task.delay(0.84, function() -- Line: 69
            -- upvalues: LinearVelocity (copy)
            LinearVelocity.Enabled = false;
        end));
    end);
    u5.AC:Connect(u1.Ability, function(p7) -- Line: 74
        -- upvalues: u5 (copy), u2 (ref), u3 (ref)
        u5.AC:Clean();

        if p7.Finished then
            u2.States.Ability = false;

            return;
        end;

        if p7.Finished2 then
            u3:StopAll();
            local v8 = u3:PlayChar("Switcher", "CursedDashHIT", Enum.AnimationPriority.Action3, true);
            local v9 = u3:PlayBall("Switcher", "CursedDashHITBall", Enum.AnimationPriority.Action3, true);
            local v10 = workspace:GetServerTimeNow() - p7.SentTime;
            v8.TimePosition = v10;
            v9.TimePosition = v10;
            u2.States.NoWalk = true;
            task.wait(1.0666666666666667 - v10);
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end;
    end);
end;