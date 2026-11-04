 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 20, Name: Trap
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u1 (ref), ReplicatedStorage (copy), Effects (copy), RunService (copy), TweenService (copy), CalculateBallTrajectory (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u2 = u7.AbilityService;
    u4 = u7.Animations;
    u3 = u7.MovementController;
    u5 = u7.BallController;
    u6 = u7.CameraController;
    u1 = u7.Network;
    local Value = ReplicatedStorage.Basketball.Value;

    if ReplicatedStorage.GameValues.Scoring.Value then
        u7:ResetCD(1);
        Effects:Popup("Can\'t use after a goal!");

        return;
    end;

    if u5:GetPlayerPossessingBall() then
        u7:ResetCD(1);
        Effects:Popup("Ball must not be on player!");

        return;
    end;

    if u7:HoopDist() > 125 then
        u7:ResetCD(1);
        Effects:Popup("Must be closer to the hoop!");

        return;
    end;

    if Value.Position.Y > 17 then
        u7:ResetCD(1);
        Effects:Popup("Ball is too high up in the air!");

        return;
    end;

    local ServerBallPosition = u5:GetServerBallPosition();
    local Unit = (ServerBallPosition - HumanoidRootPart.Position).Unit;

    if (ServerBallPosition - HumanoidRootPart.Position).Magnitude >= 35 then
        u7:ResetCD(1);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    u3.States.Ability = true;
    u7.AC:Connect(u2.Ability, function(p8) -- Line: 46
        -- upvalues: u7 (copy), Effects (ref), u3 (ref), HumanoidRootPart (copy), Unit (copy), u4 (ref), RunService (ref), u5 (ref), Character (copy), TweenService (ref), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), CalculateBallTrajectory (ref)
        if p8 == "Fail" then
            u7.AC:Clean();
            u7:ResetCD(1);
            Effects:Popup("Ball is on iframe!");
            u3.States.Ability = false;

            return;
        end;

        local u9 = true;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = 2000000000;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000);
        BodyGyro.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Unit * 50;
        local u10 = u4:PlayChar("LazyWorker", "TrapForward", Enum.AnimationPriority.Action3, true);
        local u11 = u4:PlayBall("LazyWorker", "TrapForwardBall", Enum.AnimationPriority.Action3, true);
        local u12 = tick();
        u7.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 73
            -- upvalues: u5 (ref), Character (ref), u7 (ref), u9 (ref), TweenService (ref), LinearVelocity (copy), Unit (ref), u10 (copy), u11 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), CalculateBallTrajectory (ref), BodyGyro (copy), u3 (ref), Effects (ref), u12 (copy)
            local CharacterPossessingBall = u5:GetCharacterPossessingBall();

            if CharacterPossessingBall ~= Character then
                if CharacterPossessingBall == nil then
                    if u12 - tick() > 0.27 then
                        u10:AdjustSpeed(0.01);
                        u11:AdjustSpeed(0.01);
                    end;

                    return;
                end;

                u7.AC:Clean();
                u9 = nil;
                u7:ResetCD(1);
                Effects:Popup(tostring(CharacterPossessingBall) .. " caught the ball!");
                LinearVelocity:Destroy();
                BodyGyro:Destroy();
                u3.States.Ability = false;

                return;
            end;

            u7.AC:Clean();
            u9 = nil;
            TweenService:Create(LinearVelocity, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Unit
            }):Play();
            u10:Play();
            u11:Play();
            u10.TimePosition = 0.27;
            u11.TimePosition = 0.27;
            u10:AdjustSpeed(1);
            u11:AdjustSpeed(1);
            u7.AC:Connect(u2.Ability, function() -- Line: 89
                -- upvalues: u7 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u5 (ref), CalculateBallTrajectory (ref)
                u7.AC:Clean();
                local Value2 = ReplicatedStorage.Basketball.Value;
                local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                Value2.CFrame = u5:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                Value2.AssemblyLinearVelocity = CalculateBallTrajectory(Value2.Position, Hoop.Position, 70);
            end);
            u7.AC:Add(function() -- Line: 101
                -- upvalues: LinearVelocity (ref), BodyGyro (ref), u3 (ref)
                LinearVelocity:Destroy();
                BodyGyro:Destroy();
                u3.States.Ability = false;
            end);
            u7.AC:Add(task.delay(1, function() -- Line: 107
                -- upvalues: u7 (ref)
                u7.AC:Clean();
            end));
        end);
        task.delay(1.5, function() -- Line: 128
            -- upvalues: u9 (ref), LinearVelocity (copy), BodyGyro (copy), u3 (ref), u7 (ref)
            if u9 then
                LinearVelocity:Destroy();
                BodyGyro:Destroy();
                u3.States.Ability = false;
                u7.AC:Clean();
            end;
        end);
    end);
    u2.Ability:Fire("Trap", {
        State = "Start",
        TimeSent = workspace:GetServerTimeNow()
    });
    task.delay(1.5, function() -- Line: 141
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
end;