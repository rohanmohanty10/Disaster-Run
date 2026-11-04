 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), RunService (copy), ReplicatedStorage (copy), Effects (copy), Essentials (copy), TweenService (copy), Abilities (copy)
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
        u1.Ability:Fire("Collision", {
            State = "Dash",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("AMG", "Collision", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 232
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u8 = 200;
        u7.AC:Connect(RunService.Heartbeat, function(p9) -- Line: 246
            -- upvalues: u8 (ref), LinearVelocity (copy), HumanoidRootPart (copy)
            u8 = u8 - p9 * 200 / 0.5833333333333334;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * u8;
        end);
        u7.AC:Add(task.delay(0.5833333333333334, function() -- Line: 251
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));

        return;
    end;

    if not u7.Dribble then
        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u7:ResetCD(1);

            return;
        end;

        u1.Ability:Fire("Collision", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("AMG", "Slipstream", Enum.AnimationPriority.Action3);
        u5:PlayBall("AMG", "SlipstreamBall", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 136
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
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
        u7.AC:Add(LinearVelocity);
        u7.AC:Add(BodyGyro);
        local u10 = Essentials:ReturnRorL(u7.Network.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        LinearVelocity.VectorVelocity = Vector3_new_ret * 30;
        task.spawn(function() -- Line: 159
            -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref), u10 (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = (Vector3_new_ret * 1.11 + -u10 * 1.5) * 45
            }):Play();
            task.wait(0.25);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3_new_ret * 35
            }):Play();
            task.wait(0.25);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = (Vector3_new_ret + u10 * 3) * 45
            }):Play();
            task.wait(0.25);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3_new_ret * 35
            }):Play();
        end);
        u7.AC:Add(task.delay(1.0166666666666666, function() -- Line: 169
            -- upvalues: u7 (copy), LocalPlayer (ref), Abilities (ref), u6 (ref), RunService (ref)
            u7.AC:Clean();

            if u7:HoopDist() > 125 then
                return;
            end;

            u7.Dribble = true;
            u7:ResetCD(1);
            local u11 = 1;
            local u12 = false;
            u7.AC:Add(function() -- Line: 182
                -- upvalues: u7 (ref), LocalPlayer (ref), Abilities (ref), u6 (ref)
                task.delay(0.25, function() -- Line: 183
                    -- upvalues: u7 (ref)
                    u7.Dribble = nil;
                end);

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Abilities.AMG[1];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Slipstream";

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Collision";
            end);
            u7.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 200
                -- upvalues: u6 (ref), u7 (ref), LocalPlayer (ref), u11 (ref), u12 (ref)
                if not u6.CharValues.HasBall then
                    u7.AC:Clean();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u11;

                if u11 > 0.5 and not u12 then
                    p13 = -p13 or p13;
                end;

                u11 = u11 + p13;

                if u11 <= 0.5 then
                    u12 = true;
                end;

                if u11 >= 1 then
                    u12 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Clean Air";
            end);
            u7.AC:Add(task.delay(3, function() -- Line: 220
                -- upvalues: u7 (ref)
                u7.Dribble = nil;
                u7.AC:Clean();
            end));
        end));

        return;
    end;

    u7.Dribble = nil;
    u1.Ability:Fire("Collision", {
        State = "Layup",
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    u5:PlayChar("AMG", "CleanAir", Enum.AnimationPriority.Action3);
    u5:PlayBall("AMG", "CleanAirBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u7.AC:Add(function() -- Line: 46
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    local v14 = CFrame.new(Position, (Vector3.new(0, Position.Y, Position.Z))) * CFrame.new(0, 0, 10);
    local CFrame_new_ret = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local LookVector = CFrame_new_ret.LookVector;
    local v15;

    if v14:ToObjectSpace(HumanoidRootPart.CFrame).X > 0 then
        v15 = LookVector + CFrame_new_ret.RightVector;
    else
        v15 = LookVector - CFrame_new_ret.RightVector;
    end;

    local Unit = v15.Unit;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.Parent = HumanoidRootPart;
    u7.AC:Add(LinearVelocity);
    local v16 = RunService.Heartbeat:Connect(function() -- Line: 72
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(15, 0, 15);
    end);
    u7.AC:Add(v16);
    task.wait(0.8333333333333334);
    v16:Disconnect();
    local u17 = 75;
    local u18 = 0.75;
    u7.AC:Connect(RunService.Heartbeat, function(p19) -- Line: 85
        -- upvalues: u6 (ref), u7 (copy), LinearVelocity (copy), Unit (ref), u18 (ref), u17 (ref)
        if not u6.CharValues.HasBall then
            u7.AC:Clean();

            return;
        end;

        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, u18, 0)) * u17;
        u17 = u17 - p19 * 5;

        if u18 > 0 then
            u18 = u18 - p19;
        end;
    end);
    u7.AC:Connect(u1.Ability, function(p20) -- Line: 99
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), LocalPlayer (ref)
        if not p20 or p20.State ~= "Shot" then
            return;
        end;

        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v21 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(1 + v21.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v21 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;