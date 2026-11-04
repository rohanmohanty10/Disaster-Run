 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), ReplicatedStorage (copy), TweenService (copy), RunService (copy), CalculateBallTrajectory (copy), Essentials (copy), Abilities (copy), Players (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u6.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.DismantleCD.Value > workspace:GetServerTimeNow() then
            local v8 = ReplicatedStorage.Cooldowns.DismantleCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v8);
            Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
            u7:ResetCD(2);

            return;
        end;

        if u7.Network.CharValues.Blocked + 2 > tick() then
            u7:ResetCD(2);
            Effects:Popup("Can\'t use after block!");

            return;
        end;

        local PlayerPossessingBall = u3:GetPlayerPossessingBall();
        local LastCharacterToPossessBall = u3:GetLastCharacterToPossessBall();

        if PlayerPossessingBall or not (LastCharacterToPossessBall and (Players:GetPlayerFromCharacter(LastCharacterToPossessBall) and Players:GetPlayerFromCharacter(LastCharacterToPossessBall).Team ~= LocalPlayer.Team)) then
            u7:ResetCD(2);
            Effects:Popup("Ball must just have been shot by an enemy player!");

            return;
        end;

        if LastCharacterToPossessBall:GetAttribute("Unblockable") and LastCharacterToPossessBall:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
            u7:ResetCD(2);
            Effects:Popup("Can\'t block shot!");

            return;
        end;

        local ServerBallPosition = u3:GetServerBallPosition();

        if (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - ServerBallPosition * Vector3.new(1, 0, 1)).Magnitude > 40 or ServerBallPosition.Y > 30 then
            u7:ResetCD(2);
            Effects:Popup("Ball is too far away!");

            return;
        end;

        if (LastCharacterToPossessBall.HumanoidRootPart.Position - ServerBallPosition).Magnitude > 20 then
            u7:ResetCD(2);
            Effects:Popup("Ball has travelled too far!");

            return;
        end;

        u7:ResetCopy();
        u1.Ability:Fire("Red Line", {
            State = "Dismantle",
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.AC:Connect(u1.Ability, function(p9) -- Line: 404
            -- upvalues: u7 (copy), Effects (ref)
            u7.AC:Clean();

            if not p9 or p9.State ~= "Fail" then
                return;
            end;

            u7:ResetCD(2);
            Effects:Popup("Ball must just have been shot!");
        end);

        return;
    end;

    if u6.CharValues.InAwakening and LocalPlayer.Style.Value ~= "Thief" then
        if u7:HoopDist() > 120 then
            Effects:Popup("Too far away from hoop!");
            u7:ResetCD(2);

            return;
        end;

        u1.Ability:Fire("Red Line", {
            State = "Cleave",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AimAssist = true;
        task.delay(1.8333333333333333, function() -- Line: 49
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.States.AimAssist = false;
        end);
        u5:StopAll();
        u5:PlayChar("CurseKing", "CleaveThrow", Enum.AnimationPriority.Action3);
        u5:PlayBall("CurseKing", "CleaveThrowBall", Enum.AnimationPriority.Action3);
        u7.AC:Connect(u1.Ability, function(p10) -- Line: 59
            -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy), LocalPlayer (ref)
            if not p10 or p10.State ~= "Shot" then
                return;
            end;

            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local v11 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Value.Position;
            local v12, v13;

            if (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude <= 30 then
                v12 = v11.Magnitude * 0.0455;
                v13 = 1.35;
            else
                v12 = v11.Magnitude * 0.04;
                v13 = 0.5;
            end;

            local v14 = math.log(v13 + v12) * 1.4142135623730951;
            Value.AssemblyLinearVelocity = v11 / v14 + Vector3.new(0, workspace.Gravity * v14 * 0.5, 0);
        end);

        return;
    end;

    if not u7.Dribble then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u7:ResetCD(2);

            return;
        end;

        u1.Ability:Fire("Red Line", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("CurseKing", "RedLineDribble", Enum.AnimationPriority.Action3);
        u5:PlayBall("CurseKing", "RedLineDribbleBall", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 226
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        local u15 = 32;
        local Vector3Value = Instance.new("Vector3Value");
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(Vector3Value);
        u7.AC:Add(LinearVelocity);
        task.delay(0.11666666666666667, function() -- Line: 243
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u15 (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector / 1.25;
            u15 = 30;
        end);
        task.delay(0.2833333333333333, function() -- Line: 247
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u15 (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector / 1.5;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u15 = 30;
        end);
        task.delay(0.5333333333333333, function() -- Line: 252
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u15 (ref)
            Vector3Value.Value = HumanoidRootPart.CFrame.RightVector / 1.25;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u15 = 30;
        end);
        task.delay(1.45, function() -- Line: 257
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u15 (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector / 1.5;
            u15 = 30;
        end);
        task.delay(2, function() -- Line: 261
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u15 (ref), TweenService (ref)
            Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
            u15 = 60;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
        end);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        RaycastParams_new_ret.CollisionGroup = "Player";
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        u7.AC:Connect(RunService.Heartbeat, function(p16) -- Line: 273
            -- upvalues: u6 (ref), u5 (ref), u7 (copy), HumanoidRootPart (copy), Vector3Value (copy), RaycastParams_new_ret (copy), u15 (ref), LinearVelocity (copy), FieldOfView (ref), Essentials (ref)
            if not u6.CharValues.HasBall then
                u5:StopAll();
                u7.AC:Clean();

                return;
            end;

            local v17 = (HumanoidRootPart.CFrame.LookVector + Vector3Value.Value * 3) * Vector3.new(1, 0, 1);
            local v18 = workspace:Raycast(HumanoidRootPart.Position, v17.Unit * 4, RaycastParams_new_ret);

            if v18 and not v18.Instance.Parent:FindFirstChild("Humanoid") then
                u15 = 0;
            end;

            LinearVelocity.VectorVelocity = v17 * (u15 / 1.7);
            FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p16 * 4);
            workspace.CurrentCamera.FieldOfView = FieldOfView;
            u15 = u15 - p16 * 4;
        end);
        u7.AC:Add(task.delay(2.5, function() -- Line: 297
            -- upvalues: u7 (copy), LocalPlayer (ref), u6 (ref), Abilities (ref), RunService (ref)
            u7.AC:Clean();

            if u7:HoopDist() > 115 then
                u7:ResetCopy();

                return;
            end;

            u7.Dribble = true;
            u7:ResetCD(2);
            local u19 = 1;
            local u20 = false;
            local u21 = (LocalPlayer.Style.Value == "Copycat" and not u6.CharValues.InAwakening or LocalPlayer.Style.Value == "Thief") and 1 or 2;
            u7.AC:Add(function() -- Line: 315
                -- upvalues: u7 (ref), LocalPlayer (ref), u21 (copy), Abilities (ref), u6 (ref)
                task.delay(0.25, function() -- Line: 316
                    -- upvalues: u7 (ref)
                    u7.Dribble = nil;
                    u7:ResetCopy();
                end);

                if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                    u7.CDS[u21] = tick() + Abilities.CurseKing[2];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u21}`].Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u21}`].AbilityName.Text = "Red Line Dribble";

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u21}`].AbilityName.Text = "Dismantle";
            end);
            u7.AC:Connect(RunService.Heartbeat, function(p22) -- Line: 334
                -- upvalues: u6 (ref), u7 (ref), LocalPlayer (ref), u21 (copy), u19 (ref), u20 (ref)
                if not u6.CharValues.HasBall then
                    u7.AC:Clean();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u21}`].Flash.BackgroundTransparency = u19;

                if u19 > 0.5 and not u20 then
                    p22 = -p22 or p22;
                end;

                u19 = u19 + p22;

                if u19 <= 0.5 then
                    u20 = true;
                end;

                if u19 >= 1 then
                    u20 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u21}`].AbilityName.Text = "Red Line Shot";
            end);
            u7.AC:Add(task.delay(3, function() -- Line: 354
                -- upvalues: u7 (ref)
                u7.Dribble = nil;
                u7:ResetCopy();
                u7.AC:Clean();
            end));
        end));

        return;
    end;

    u7.Dribble = nil;
    u7:ResetCopy();
    u1.Ability:Fire("Red Line", {
        State = "Shot",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    task.delay(1.8333333333333333, function() -- Line: 102
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
    end);
    u5:StopAll();
    u5:PlayChar("CurseKing", "RedLineShot", Enum.AnimationPriority.Action3);
    u5:PlayBall("CurseKing", "RedLineShotBall", Enum.AnimationPriority.Action3);
    local v23 = Humanoid.MoveDirection:Dot(HumanoidRootPart.CFrame.RightVector);
    local v24 = v23 > 0 and 1 or (v23 < 0 and -1 or (math.random(1, 2) == 1 and 1 or -1));
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v25 = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z))).RightVector * v24 * 16;
    local v26 = workspace:Raycast(HumanoidRootPart.Position, v25, RaycastParams_new_ret);

    if v26 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v25.Unit * (v26.Distance / 2)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v25) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    end;

    task.wait(0.1);
    local u27 = -HumanoidRootPart.CFrame.LookVector;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.VectorVelocity = u27 * 160;
    LinearVelocity.Parent = HumanoidRootPart;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    local RaycastParams_new_ret2 = RaycastParams.new();
    RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret2.FilterDescendantsInstances = { Character };
    RaycastParams_new_ret2.CollisionGroup = "Player";
    tick();
    local u28 = nil;
    u28 = RunService.Heartbeat:Connect(function(p29) -- Line: 150
        -- upvalues: HumanoidRootPart (copy), u27 (copy), RaycastParams_new_ret2 (copy), u28 (ref), LinearVelocity (copy)
        local v30 = workspace:Raycast(HumanoidRootPart.Position, u27.Unit * 4, RaycastParams_new_ret2);

        if v30 and not v30.Instance.Parent:FindFirstChild("Humanoid") then
            u28:Disconnect();
            LinearVelocity:Destroy();
        end;
    end);
    task.wait(0.7333333333333333);
    LinearVelocity:Destroy();
    u28:Disconnect();
    local u31 = 30;
    local u32 = 0.75;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local u33 = tick();
    local u35 = RunService.Heartbeat:Connect(function(p34) -- Line: 173
        -- upvalues: u31 (ref), u33 (copy), BodyVelocity (copy), HumanoidRootPart (copy), u32 (ref)
        if u31 >= 10 then
            if u33 + 0.125 < tick() then
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, u32, 0)) * u31;
                u32 = u32 - p34 * 1.75;
            else
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, 0, 0)) * u31;
            end;

            u31 = u31 - p34;
        end;
    end);
    task.delay(1, function() -- Line: 185
        -- upvalues: u35 (ref), BodyVelocity (copy)
        if u35 then
            u35:Disconnect();
        end;

        BodyVelocity:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function(p36) -- Line: 193
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        if not p36 or p36.State ~= "Shot" then
            return;
        end;

        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
end;