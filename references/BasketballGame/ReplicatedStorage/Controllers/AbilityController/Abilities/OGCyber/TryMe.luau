 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 21, Name: TryMe
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), RunService (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if u5.CharValues.HasBall then
        u2.States.Ability = true;
        Effects:Popup("Make enemy player steal the ball!", 3, Color3.new(1, 0.388235, 0.388235));
        u1.Ability:Fire("OGTryMe", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Add(task.delay(3, function() -- Line: 40
            -- upvalues: Effects (ref), u2 (ref), u3 (ref)
            Effects:Popup("Failed to get attacked..");
            u2.States.Ability = false;
            u2.States.NoWalk = true;
            u3:StopAll();
            u3:PlayChar("Cyber", "TryMe", Enum.AnimationPriority.Action3);
            task.delay(3, function() -- Line: 48
                -- upvalues: u2 (ref)
                u2.States.NoWalk = false;
            end);
        end));
        u6.AC:Connect(u1.Ability, function() -- Line: 54
            -- upvalues: Effects (ref), u6 (copy), u2 (ref)
            Effects:Popup("TRY ME.");
            u6.AC:Clean();
            u2.States.NoWalk = false;
            u2.States.Ability = false;
            local v7 = u2;
            v7.Boost = v7.Boost + 7;
            task.delay(4, function() -- Line: 60
                -- upvalues: u2 (ref)
                local v8 = u2;
                v8.Boost = v8.Boost - 7;

                if u2.Boost < 0 then
                    u2.Boost = 0;
                end;
            end);
        end);

        return;
    end;

    local EnemyWithBallWithinDistance, u9 = u4:GetEnemyWithBallWithinDistance(75);

    if EnemyWithBallWithinDistance == nil then
        Effects:Popup("An enemy player with the ball must be close to you!", 4);
        u6:ResetCD(2);

        return;
    end;

    u1.Ability:Fire("OGTryMe", {
        TimeSent = workspace:GetServerTimeNow(),
        Target = u9
    });
    u6.AC:Connect(u1.Ability, function(p10) -- Line: 112
        -- upvalues: u2 (ref)
        if p10 and p10.State == "Success" then
            local v11 = u2;
            v11.Boost = v11.Boost + 7.5;
            task.delay(4, function() -- Line: 115
                -- upvalues: u2 (ref)
                local v12 = u2;
                v12.Boost = v12.Boost - 7.5;

                if u2.Boost < 0 then
                    u2.Boost = 0;
                end;
            end);
        end;
    end);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    local u13 = u3:PlayChar("Cyber", "Mine", Enum.AnimationPriority.Action3, true);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    BodyGyro.P = 1250;
    BodyGyro.Parent = HumanoidRootPart;
    u6.AC:Add(BodyGyro);
    local Shiftlock = u6.CameraController.Shiftlock;
    u6.CameraController:SetShiftlock(false);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 400;
    u6.AC:Add(NumberValue);
    local Position = u9.HumanoidRootPart.Position;
    local Unit = (Position + u9.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
    local u14 = Position;

    local function EndAbility() -- Line: 159
        -- upvalues: u13 (copy), u6 (copy), u2 (ref), Shiftlock (copy)
        u13:Stop(0.5);
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.NoWalk = false;

        if not u6.CameraController.Shiftlock then
            u6.CameraController:SetShiftlock(Shiftlock);
        end;
    end;

    u6.AC:Connect(RunService.Heartbeat, function(p15) -- Line: 170
        -- upvalues: u9 (copy), u5 (ref), Character (copy), u13 (copy), u6 (copy), u2 (ref), Shiftlock (copy), Position (ref), Unit (ref), HumanoidRootPart (copy), u14 (ref), BodyGyro (copy), LinearVelocity (copy), NumberValue (copy)
        if not u9 or (u5.CharValues.HasBall or Character.IsRagdoll.Value) then
            u13:Stop(0.5);
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.NoWalk = false;

            if not u6.CameraController.Shiftlock then
                u6.CameraController:SetShiftlock(Shiftlock);
            end;
        end;

        Position = u9.HumanoidRootPart.Position;
        Unit = (Position + u9.HumanoidRootPart.AssemblyLinearVelocity / 6 - HumanoidRootPart.Position).Unit;
        u14 = Position;
        BodyGyro.CFrame = CFrame.lookAt(HumanoidRootPart.Position, u14);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(u14.X, HumanoidRootPart.Position.Y, u14.Z)));
        LinearVelocity.VectorVelocity = Unit * NumberValue.Value * Vector3.new(1, 0, 1);

        if (HumanoidRootPart.Position - Position).Magnitude < 2 then
            u13:Stop(0.5);
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.NoWalk = false;

            if not u6.CameraController.Shiftlock then
                u6.CameraController:SetShiftlock(Shiftlock);
            end;
        end;
    end);
    TweenService:Create(NumberValue, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine), {
        Value = 1
    }):Play();
    u6.AC:Add(task.delay(0.75, EndAbility));
end;