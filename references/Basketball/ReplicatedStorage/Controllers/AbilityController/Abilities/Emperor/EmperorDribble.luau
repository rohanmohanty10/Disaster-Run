 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20, Name: EmperorsDribble
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy), RunService (copy), TweenService (copy), CalculateBallTrajectory (copy), Essentials (copy), Players (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Attribute = LocalPlayer:GetAttribute("TrueEmperor");
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;
    local v7 = LocalPlayer.Style.Value == "Copycat" and not u6.Network.CharValues.InAwakening or LocalPlayer.Style.Value == "Thief";

    if u6.UltimatePass then
        if not u4:CharacterPossessesBall(u6.UltimatePass) then
            Effects:Popup("Team-mate doesn\'t have the ball!");
            u6:ResetCD((v7 or not u6.Network.InAwakening) and 1 or 4);

            return;
        end;

        local v8 = u6.UltimatePass.HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

        if v8:Dot(v8) > 14400 then
            Effects:Popup("Team-mate too far away from hoop!");
            u6:ResetCD((v7 or not u6.Network.InAwakening) and 1 or 4);

            return;
        end;

        u6.UltimatePass = nil;

        if not (v7 or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[2] = tick() + 65;
        end;

        u6:ResetCopy();
        u1.Ability:Fire("UltimatePass", {
            Style = "Force",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Connect(u1.Ability, function() -- Line: 60
            -- upvalues: ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
            local v9 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
            local math_log_ret = math.log(2.5 + v9.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v9 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);

        return;
    end;

    if not u6.Network.CharValues.HasBall then
        Effects:Popup("Not usable without ball!");
        u6:ResetCD(1);

        return;
    end;

    if Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        u6:ResetCD(1);

        return;
    end;

    if u6.EmperorDribble2 then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(1);

            return;
        end;

        u6.EmperorDribble2 = nil;
        u6:ResetCopy();
        u2.States.Ability = true;
        u2.Boost = 5;
        u1.Ability:Fire("EmperorsDribble", {
            Style = "Fade",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.1);
        RunService.Heartbeat:Wait();
        u2.States.NoWalk = true;
        u6.AC:Add(function() -- Line: 104
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.Boost = 0;
        end);
        u6.AC:Add(task.delay(1.7166666666666666, function() -- Line: 110
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        local Position = HumanoidRootPart.Position;
        u3:StopAll();
        u3:PlayChar("Emperor", "EmperorsFade", Enum.AnimationPriority.Action3);
        u3:PlayBall("Emperor", "EmperorsFadeBall", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
        BodyGyro.Parent = HumanoidRootPart;
        u6.AC:Add(LinearVelocity);
        u6.AC:Add(BodyGyro);
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            FieldOfView = 45
        }):Play();
        LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.CFrame.RightVector / 1.5) * Vector3.new(1, 0, 1) * 45;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector / 1.5 + HumanoidRootPart.CFrame.RightVector) * Vector3.new(1, 0, 1) * 60
        }):Play();
        task.wait(0.5833333333333334);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.2);
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 70
        }):Play();
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        RaycastParams_new_ret.CollisionGroup = "Player";
        local Position2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        local v10 = (HumanoidRootPart.Position - Vector3.new(Position2.X, HumanoidRootPart.Position.Y, Position2.Z)).Unit * 15 + Vector3.new(0, 0.25, 0);
        local v11 = workspace:Raycast(Position, v10, RaycastParams_new_ret);

        if v11 then
            HumanoidRootPart.CFrame = CFrame.new(Position + (v11.Position - Position).Unit * (v11.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        else
            HumanoidRootPart.CFrame = CFrame.new(Position + v10) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        end;

        LinearVelocity.VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 45;
        BodyGyro.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position2.X, HumanoidRootPart.Position.Y, Position2.Z)));
        local u12 = -HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 8
        }):Play();
        task.delay(0.75, function() -- Line: 167
            -- upvalues: TweenService (ref), LinearVelocity (copy), u12 (copy), BodyGyro (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                VectorVelocity = (u12 - Vector3.new(0, 1, 0)) * 55
            }):Play();
            task.wait(0.175);
            LinearVelocity:Destroy();
            BodyGyro:Destroy();
        end);
        u6.AC:Connect(u1.Ability, function() -- Line: 174
            -- upvalues: u6 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
            u6.AC:Clean();
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
        end);

        return;
    end;

    if u6.EmperorDribble1 then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(1);

            return;
        end;

        u6.EmperorDribble1 = nil;
        u2.States.Ability = true;
        u2.Boost = 5;
        u1.Ability:Fire("EmperorsDribble", {
            Style = "Forward",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.1);
        RunService.Heartbeat:Wait();
        u3:StopAll();
        u3:PlayChar("Emperor", "EmperorsDribbleForward", Enum.AnimationPriority.Action3);
        u3:PlayBall("Emperor", "EmperorsDribbleForwardBall", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
        BodyGyro.Parent = HumanoidRootPart;
        u6.AC:Add(LinearVelocity);
        u6.AC:Add(BodyGyro);
        local v13 = Essentials:ReturnRorL(u6.Network.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        LinearVelocity.VectorVelocity = Vector3_new_ret * 30;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (Vector3_new_ret * 1.11 + -v13 * 1.5) * 45
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3_new_ret * 35
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (Vector3_new_ret + v13 * 3) * 45
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3_new_ret * 35
        }):Play();
        task.wait(0.25);
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.Boost = 0;
        u6.AC:Add(task.delay(0.25, function() -- Line: 246
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));

        if not Attribute and u6:HoopDist() > 120 then
            u6:ResetCopy();

            return;
        end;

        u6.EmperorDribble2 = true;
        u6:ResetCD(1);
        local u14 = 1;
        local u15 = false;
        local u16 = nil;
        u16 = RunService.Heartbeat:Connect(function(p17) -- Line: 263
            -- upvalues: u6 (copy), u16 (ref), LocalPlayer (ref), HumanoidRootPart (copy), u14 (ref), u15 (ref)
            if not u6.EmperorDribble2 then
                u16:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u6.Network.CharValues.HasBall then
                if not (not u6.EmperorDribble2 or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[1] = tick() + 70;
                end;

                u6.EmperorDribble2 = nil;
                u6:ResetCopy();

                return;
            end;

            local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u14;

            if u14 > 0.5 and not u15 then
                p17 = -p17 or p17;
            end;

            u14 = u14 + p17;

            if u14 <= 0.5 then
                u15 = true;
            end;

            if u14 >= 1 then
                u15 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Emperor\'s Fade";
        end);
        task.delay(2, function() -- Line: 290
            -- upvalues: u6 (copy), LocalPlayer (ref), u16 (ref)
            if not (not u6.EmperorDribble2 or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 70;
            end;

            u6.EmperorDribble2 = nil;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            u16:Disconnect();
            u6:ResetCopy();
        end);

        return;
    end;

    local v18 = RunService:IsStudio();

    for _, v in (Attribute and Players or game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]):GetPlayers() do
        if v ~= LocalPlayer and (v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25))) then
            v18 = true;
            break;
        end;
    end;

    if not v18 then
        Effects:Popup("Enemy player must be close to you!");
        u6:ResetCD(1);

        return;
    end;

    if u6.MovementController.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u6.EmperorDribble1 = true;
    u2.States.Ability = true;
    task.delay(0.75, function() -- Line: 323
        -- upvalues: u6 (copy), u2 (ref), RunService (ref), LocalPlayer (ref), HumanoidRootPart (copy)
        u6.AC:Clean();
        u2.States.Ability = false;
        u6:ResetCD(1);
        local u19 = 1;
        local u20 = false;
        local u21 = nil;
        u21 = RunService.Heartbeat:Connect(function(p22) -- Line: 331
            -- upvalues: u6 (ref), u21 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u19 (ref), u20 (ref)
            if not u6.EmperorDribble1 then
                u21:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u6.Network.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                u6.EmperorDribble1 = nil;
                u6.CDS[1] = tick() + 70;

                return;
            end;

            local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u19;

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

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Emperor\'s Drive";
        end);
        task.delay(4, function() -- Line: 346
            -- upvalues: u6 (ref), LocalPlayer (ref), u21 (ref)
            if not (not u6.EmperorDribble1 or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 70;
            end;

            u6.EmperorDribble1 = nil;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            u21:Disconnect();
            u6:ResetCopy();
        end);
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
    BodyGyro.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    u6.AC:Add(BodyGyro);
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -50;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * -15
    }):Play();
    u3:StopAll();
    u3:PlayChar("Emperor", "EmperorsDribble", Enum.AnimationPriority.Action3);
    u3:PlayBall("Emperor", "EmperorsDribbleBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("EmperorsDribble", {
        Style = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
end;