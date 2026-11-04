 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
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
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if u5.CharValues.HasBall then
        local v7 = u6:HoopDist();

        if v7 >= 130 then
            Effects:Popup("You are too far away from the hoop!");

            return u6:ResetCD(2);
        end;

        if v7 <= 40 then
            Effects:Popup("You are too close to the hoop!");

            return u6:ResetCD(2);
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AimAssist = true;
        u3:StopAll();
        u3:PlayChar("Rubberman", "UndeterminedShot", Enum.AnimationPriority.Action4);
        u3:PlayBall("Rubberman", "UndeterminedShotBall", Enum.AnimationPriority.Action4);
        u1.Ability:Fire("GearAbility", {
            Ability = "UndeterminedShot",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Add(task.delay(5, function() -- Line: 56
            -- upvalues: u6 (copy), u2 (ref)
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.AimAssist = false;
            u2.States.NoWalk = false;
        end));
        u6.AC:Connect(u1.Ability, function(p8) -- Line: 63
            -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), CalculateBallTrajectory (ref), HumanoidRootPart (copy)
            u6.AC:Clean();

            if p8.State == "Shoot" then
                task.delay(0.48333333333333334, function() -- Line: 84
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                    u2.States.AimAssist = false;
                    u2.States.NoWalk = false;
                end);
                local Value = ReplicatedStorage.Basketball.Value;
                local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local BodyForce = Instance.new("BodyForce");
                BodyForce.Name = "ExtraGravity";
                BodyForce.Force = Vector3.new(0, -0.33000000000000007 * workspace.Gravity * Value.AssemblyMass, 0);
                BodyForce.Parent = Value;
                Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, (HumanoidRootPart.CFrame * CFrame.new(
                    -0.159966707,
                    4.84376001,
                    -10.3462467,
                    -0.995870888,
                    0.0667230114,
                    0.0615567155,
                    0.00859027542,
                    -0.605774581,
                    0.795590103,
                    0.0903736353,
                    0.792833686,
                    0.602699935
                )).Position, 33, 1.33 * workspace.Gravity);
                task.wait(0.43333333333333335);

                if BodyForce then
                    BodyForce:Destroy();
                end;

                Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Hoop.Position, 90, 1 * workspace.Gravity);
            end;
        end);

        return;
    end;

    local CharacterPossessingBall = u4:GetCharacterPossessingBall();
    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if not (CharacterPossessingBall and PlayerPossessingBall) then
        Effects:Popup("The ball must be on an enemy player!");

        return u6:ResetCD(2);
    end;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        Effects:Popup("The ball must be on an enemy player!");

        return u6:ResetCD(2);
    end;

    local Position = CharacterPossessingBall.HumanoidRootPart.Position;

    if (Character.HumanoidRootPart.Position - Position).Magnitude >= 34 then
        Effects:Popup("The target must be closer!");

        return u6:ResetCD(2);
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("Rubberman", "GumSteal", Enum.AnimationPriority.Action3);
    u6.AC:Connect(RunService.Heartbeat, function(p9) -- Line: 150
        -- upvalues: CharacterPossessingBall (copy), u4 (ref), Position (ref), HumanoidRootPart (copy)
        if CharacterPossessingBall and CharacterPossessingBall == u4:GetCharacterPossessingBall() then
            Position = CharacterPossessingBall.HumanoidRootPart.Position;
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
        end;
    end);
    task.delay(1.1666666666666667, function() -- Line: 157
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u6.AC:Clean();
    end);
    u1.Ability:Fire("GearAbility", {
        Ability = "GumSteal",
        TimeSent = workspace:GetServerTimeNow(),
        Target = CharacterPossessingBall
    });
end;