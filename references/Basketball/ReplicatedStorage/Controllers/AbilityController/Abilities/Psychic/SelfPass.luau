 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
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

return function(u6) -- Line: 21, Name: OrdinaryShot
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), RunService (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if u5.CharValues.HasBall then
        if u6.SelfPassUses then
            if u6.SelfPassUses <= 0 then
                Effects:Popup("You can\'t use this ability any more times!");

                if not u6.PsychicBlitz then
                    u6:ResetCD(4);
                end;

                return;
            end;
        else
            u6.SelfPassUses = 2;
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        u3:PlayChar("Psychic", "SelfPass", Enum.AnimationPriority.Action3);
        u3:PlayBall("Psychic", "SelfPassBall", Enum.AnimationPriority.Action3);
        u6.SelfPassUses = u6.SelfPassUses - 1;
        Effects:Popup((`{u6.SelfPassUses} Use{u6.SelfPassUses == 1 and "" or "s"} left!`));
        local u7 = u6.SelfPassUses <= 0 and true or false;
        task.delay(1.95, function() -- Line: 60
            -- upvalues: u2 (ref), u7 (ref), u6 (copy)
            u2.States.Ability = false;
            u2.States.NoWalk = false;

            if not u7 then
                u6:ResetCD(4);
            end;
        end);
        u1.Ability:Fire("SelfPass", {
            State = "SelfPass",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Connect(u1.Ability, function(p8) -- Line: 70
            -- upvalues: u6 (copy), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy)
            u6.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.Parent = Value;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 200;
            task.delay(0.5333333333333333, function() -- Line: 83
                -- upvalues: LinearVelocity (copy)
                if LinearVelocity then
                    LinearVelocity:Destroy();
                end;
            end);
        end);

        return;
    end;

    if not u6.PsychicBlitz then
        u6.PsychicBlitz = false;
    end;

    if u6.SelfPassUses and u6.SelfPassUses <= 0 then
        Effects:Popup("You can\'t use this ability any more!");

        return u6:ResetCD(4);
    end;

    u6.PsychicBlitz = true;
    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.fromOrientation(0, 3.141592653589793, 0);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u1.Ability:Fire("SelfPass", {
        State = "PsychicBlitz",
        TimeSent = workspace:GetServerTimeNow()
    });
    u3:StopAll();
    u3:PlayChar("Psychic", "PsychicBlitzTurn", Enum.AnimationPriority.Action3);
    task.wait(0.6333333333333333);
    u2.States.NoWalk = false;
    local u9 = u3:PlayChar("Psychic", "PsychicBlitzFly", Enum.AnimationPriority.Action3, true);
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
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 100 * Vector3.new(1, 0, 1);
    u6.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 130
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), BodyGyro (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 100 * Vector3.new(1, 0, 1);
        BodyGyro.CFrame = HumanoidRootPart.CFrame;
    end);
    u6.AC:Connect(u1.Ability, function(p11) -- Line: 135
        -- upvalues: u6 (copy), u9 (copy), u3 (ref), u2 (ref)
        u6.AC:Clean();
        u9:Stop(0.5);

        if not p11.Success then
            u2.States.Ability = false;
            u2.States.NoWalk = false;

            return;
        end;

        u3:PlayChar("Psychic", "PsychicBlitzDunk", Enum.AnimationPriority.Action3);
        u3:PlayBall("Psychic", "PsychicBlitzDunkBall", Enum.AnimationPriority.Action3);
        task.delay(2.2333333333333334, function() -- Line: 141
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
    end);
    u6.AC:Add(task.delay(3, function() -- Line: 151
        -- upvalues: u6 (copy), u9 (copy), u2 (ref)
        u6.AC:Clean();
        u9:Stop(0.5);
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end));
end;