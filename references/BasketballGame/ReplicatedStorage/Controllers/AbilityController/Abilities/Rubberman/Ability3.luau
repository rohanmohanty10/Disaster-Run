 
 

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

return function(u6) -- Line: 24, Name: TruePower
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u5 = u6.Network;

    if not u6.RubberGear then
        u6.RubberGear = "Defensive";
    end;

    if u6.Network.CharValues.InAwakening then
        if not u5.CharValues.HasBall then
            u6:ResetCD(3);
            Effects:Popup("Not usable without ball");

            return;
        end;

        local v7 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position;

        if v7:Dot(v7) > 22500 then
            Effects:Popup("Too far away from hoop!", 1);
            u6:ResetCD(3);

            return;
        end;

        u6.CDS[3] = tick() + 120;
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(18.166666666666668, function() -- Line: 50
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u3:StopAll();
        u1.Ability:Fire("Ability3", {
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    if u6.RubberGear == "Offensive" then
        if not u6.Network.CharValues.HasBall then
            u6:ResetCD(3);
            Effects:Popup("Not usable without ball");

            return;
        end;

        local v8 = u6:HoopDist();

        if v8 >= 130 then
            Effects:Popup("You are too far away from the hoop!");

            return u6:ResetCD(3);
        end;

        if v8 <= 40 then
            Effects:Popup("You are too close to the hoop!");

            return u6:ResetCD(3);
        end;

        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AimAssist = true;
        u3:StopAll();
        u3:PlayChar("Rubberman", "UndeterminedShot", Enum.AnimationPriority.Action4);
        u3:PlayBall("Rubberman", "UndeterminedShotBall", Enum.AnimationPriority.Action4);
        u1.Ability:Fire("Ability3", {
            Ability = "UndeterminedShot",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Add(task.delay(5, function() -- Line: 85
            -- upvalues: u6 (copy), u2 (ref)
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.AimAssist = false;
            u2.States.NoWalk = false;
        end));
        u6.AC:Connect(u1.Ability, function(p9) -- Line: 92
            -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), LocalPlayer (ref), u4 (ref), CalculateBallTrajectory (ref), HumanoidRootPart (copy), RunService (ref), Character (copy)
            u6.AC:Clean();

            if p9.State == "Shoot" then
                task.delay(0.48333333333333334, function() -- Line: 113
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                    u2.States.AimAssist = false;
                    u2.States.NoWalk = false;
                end);
                local Value = ReplicatedStorage.Basketball.Value;
                local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Mass = Value:GetMass();
                local Vector3_new_ret = Vector3.new(0, -0.33000000000000007 * workspace.Gravity * Mass, 0);
                local BodyForce = Instance.new("BodyForce");
                BodyForce.Name = "ExtraGravity";
                BodyForce.Force = Vector3_new_ret;
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
                local u10 = false;
                u6.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 143
                    -- upvalues: u4 (ref), Character (ref), u6 (ref), u10 (ref), BodyForce (ref)
                    if u4:GetCharacterPossessingBall() ~= nil or u4:GetLastCharacterToPossessBall() ~= Character then
                        u6.AC:Clean();
                        u10 = true;
                        BodyForce:Destroy();
                    end;
                end);
                task.wait(0.43333333333333335);
                u6.AC:Clean();

                if u10 then
                    return;
                end;

                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Hoop.Position + Vector3.new(0, 3.3, 0), 110, 1.33 * workspace.Gravity);
                local v12 = 0;

                while v12 < 3 and not ReplicatedStorage.GameValues.Scoring.Value do
                    v12 = v12 + task.wait();
                end;

                if BodyForce then
                    BodyForce:Destroy();
                    BodyForce = nil;
                end;
            end;
        end);

        return;
    end;

    if u5.CharValues.HasBall then
        Effects:Popup("Not usable with ball!");
        u6:ResetCD(3);

        return;
    end;

    local CharacterPossessingBall = u4:GetCharacterPossessingBall();
    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if not (CharacterPossessingBall and PlayerPossessingBall) then
        Effects:Popup("The ball must be on an enemy player!");

        return u6:ResetCD(3);
    end;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        Effects:Popup("The ball must be on an enemy player!");

        return u6:ResetCD(3);
    end;

    local Position = CharacterPossessingBall.HumanoidRootPart.Position;

    if (Character.HumanoidRootPart.Position - Position).Magnitude >= 34 then
        Effects:Popup("The target must be closer!");

        return u6:ResetCD(3);
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    u3:PlayChar("Rubberman", "GumSteal", Enum.AnimationPriority.Action4);
    u6.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 215
        -- upvalues: CharacterPossessingBall (copy), u4 (ref), Position (ref), HumanoidRootPart (copy)
        if CharacterPossessingBall and CharacterPossessingBall == u4:GetCharacterPossessingBall() then
            Position = CharacterPossessingBall.HumanoidRootPart.Position;
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
        end;
    end);
    task.delay(1.1666666666666667, function() -- Line: 222
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u6.AC:Clean();
    end);
    u1.Ability:Fire("Ability3", {
        Ability = "GumSteal",
        TimeSent = workspace:GetServerTimeNow(),
        Target = CharacterPossessingBall
    });
end;