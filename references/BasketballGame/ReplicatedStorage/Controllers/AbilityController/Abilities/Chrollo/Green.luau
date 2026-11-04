 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
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

function Green(u7)
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u1 (ref), Effects (copy), RunService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u2 = u7.AbilityService;
    u4 = u7.Animations;
    u3 = u7.MovementController;
    u5 = u7.BallController;
    u6 = u7.CameraController;
    u1 = u7.Network;

    if not u1.CharValues.HasBall then
        local PlayerPossessingBall = u5:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil or PlayerPossessingBall.Team ~= LocalPlayer.Team then
            Effects:Popup("Teammate must have the ball!");
            u7:ResetCD(2);

            return;
        end;

        if u5:LocalPlayerIsWithinDistanceOfBall(100) then
            u2.Ability:Fire("Green", {
                state = "Pass",
                TimeSent = workspace:GetServerTimeNow()
            });
            u7.AC:Connect(u2.Ability, function(p8) -- Line: 207
                -- upvalues: u7 (copy), Effects (ref), ReplicatedStorage (ref), u5 (ref), HumanoidRootPart (copy), RunService (ref), Character (copy)
                u7.AC:Clean();

                if p8 then
                    u7:ResetCD(2);
                    Effects:Popup("Ball is on iframes!");

                    return;
                end;

                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u5:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Unit = (HumanoidRootPart.Position - Value.Position).Unit;
                local _ = (HumanoidRootPart.Position - Value.Position).Magnitude;
                local Magnitude = (HumanoidRootPart.Position - Value.Position).Magnitude;
                Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Value.Root;
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                u7.AC:Add(LinearVelocity);
                u7.AC:Add(task.delay(0.15, function() -- Line: 239
                    -- upvalues: LinearVelocity (copy), Value (copy), u7 (ref), RunService (ref), u5 (ref), HumanoidRootPart (ref), Character (ref)
                    LinearVelocity.Parent = Value;
                    local u9 = tick();
                    local u10 = false;
                    u7.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 246
                        -- upvalues: u5 (ref), u7 (ref), u10 (ref), u9 (copy), Value (ref), HumanoidRootPart (ref), LinearVelocity (ref), Character (ref)
                        if not u5:LocalPlayerIsBallNetworkOwner() then
                            u7.AC:Clean();

                            return;
                        end;

                        local v12 = -u5:GetVectorOffsetBetweenLocalPlayerAndBall(true);
                        local v13 = v12:Dot(v12);

                        if v13 >= 400 then
                            u10 = true;
                        end;

                        local CharacterPossessingBall = u5:GetCharacterPossessingBall();

                        if u9 + 3 < tick() or (Value.Parent == nil or (CharacterPossessingBall or u10 and v13 <= 144)) or v13 <= 100 and HumanoidRootPart == HumanoidRootPart then
                            u7.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if CharacterPossessingBall == Character then
                            LinearVelocity.Parent = nil;
                        end;

                        LinearVelocity.Parent = Value;
                        LinearVelocity.VectorVelocity = v12.Unit * 120 * 1.8;
                    end);
                end));
            end);

            return;
        end;

        u7:ResetCD(2);
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    local v14 = u7:HoopDist();

    if v14 > 290 then
        Effects:Popup("Too far away");
        u7:ResetCD(2);

        return;
    end;

    local u15 = u7.ChaosMode and {
        Fadeaway = 100,
        ["Half-Court"] = 100,
        ["Full-Court"] = 100
    } or {
        Fadeaway = 100,
        ["Half-Court"] = 70,
        ["Full-Court"] = 65
    };
    local u16;

    if v14 <= 120 then
        u16 = "Fadeaway";
    elseif v14 > 120 and v14 <= 180 then
        u16 = "Half-Court";
    else
        if not u7.ChaosMode then
            Effects:Popup("Must be in chaos mode to use full court!", 1, Color3.new(0.427451, 0.223529, 0.223529));
            u7:ResetCD(2);

            return;
        end;

        u16 = "Full-Court";
    end;

    u4:StopAll();
    local v17 = u4:PlayChar("Chrollo", `Green{u16}`, Enum.AnimationPriority.Action3, true);
    local v18 = u4:PlayBall("Chrollo", `Green{u16}Ball`, Enum.AnimationPriority.Action3, true);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
    BodyGyro.CFrame = CFrame.new((HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Unit);
    u7.AC:Add(BodyGyro);
    u3.States.Ability = true;

    if u16 == "Fadeaway" then
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 80;
        game:GetService("TweenService"):Create(LinearVelocity, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.delay(0.6666666666666666, function() -- Line: 88
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), RunService (ref)
            LinearVelocity:Destroy();
            local u19 = 30;
            local u20 = 0.75;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "BodyVelocityBasketball";
            BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * (1 / 0);
            BodyVelocity.Parent = HumanoidRootPart;
            local u21 = tick();
            local u23 = RunService.Heartbeat:Connect(function(p22) -- Line: 98
                -- upvalues: u19 (ref), u21 (copy), BodyVelocity (copy), HumanoidRootPart (ref), u20 (ref)
                if u19 >= 10 then
                    if u21 + 0.125 < tick() then
                        BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector * -1 + Vector3.new(0, u20, 0)) * u19;
                        u20 = u20 - p22 * 1.75;
                    else
                        BodyVelocity.Velocity = (HumanoidRootPart.CFrame.LookVector * -1 + Vector3.new(0, 0, 0)) * u19;
                    end;

                    u19 = u19 - p22;
                end;
            end);
            task.delay(0.9833333333333333, function() -- Line: 110
                -- upvalues: u23 (ref), BodyVelocity (copy)
                if u23 then
                    u23:Disconnect();
                    u23 = nil;
                end;

                BodyVelocity:Destroy();
            end);
        end);
    elseif u16 == "Half-Court" then
        v17:AdjustSpeed(0.65);
        v18:AdjustSpeed(0.65);
    end;

    Effects:Popup((`{u15[u16]}% Chance to go in!`));
    u7.AC:Add(task.delay(1.1666666666666667, function() -- Line: 125
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end));
    u7.AC:Connect(u2.Ability, function() -- Line: 129
        -- upvalues: u7 (copy), u3 (ref), ReplicatedStorage (ref), u5 (ref), LocalPlayer (ref), u15 (ref), u16 (ref), HumanoidRootPart (copy), CalculateBallTrajectory (ref)
        u7.AC:Clean();
        u3.States.Ability = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u5:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        local v24 = Hoop.Position - Value.Position;
        local v25 = math.random(1, 100) <= u15[u16] and 1 or 0.5;
        local v26, v27;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v26 = v24.Magnitude * 0.0455;
            v27 = 1.35;
        else
            v26 = v24.Magnitude * 0.04;
            v27 = 0.5;
        end;

        math.log(v27 + v26);
        Value.AssemblyLinearVelocity = v25 * CalculateBallTrajectory(Value.Position, Hoop.Position, 80);
    end);
    u2.Ability:Fire("Green", {
        TimeSent = workspace:GetServerTimeNow(),
        state = u16
    });
end;

return Green;