 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u1 (ref), Essentials (copy), TweenService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), RunService (copy), Effects (copy), Cooldowns (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    local Attribute = LocalPlayer:GetAttribute("TrueSkarp");
    u2 = u7.AbilityService;
    u4 = u7.Animations;
    u3 = u7.MovementController;
    u5 = u7.BallController;
    u6 = u7.CameraController;
    u1 = u7.Network;

    if not u1.CharValues.HasBall then
        u3.States.Ability = true;
        task.delay(0.75, function() -- Line: 347
            -- upvalues: u3 (ref), HumanoidRootPart (copy), Character (copy)
            u3.States.Ability = false;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 50;
            LinearVelocity.Parent = Character;
            task.delay(0.25, function() -- Line: 357
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
        end);
        u4:PlayChar("LazyWorker", "TrapForward", Enum.AnimationPriority.Action3);
        u2.Ability:Fire("Slap", {
            State = "Slap",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    if not u7.Dribble then
        if u3.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u7:ResetCD(1);

            return;
        end;

        u2.Ability:Fire("Slap", {
            State = "Forward",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("Gold", "StreetDribble", Enum.AnimationPriority.Action3);
        u4:PlayBall("Gold", "StreetDribbleBall", Enum.AnimationPriority.Action3);
        u3.States.Ability = true;
        u7.AC:Add(function() -- Line: 199
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u8 = 60;
        local u9 = tick();
        u7.AC:Connect(RunService.Heartbeat, function(p10) -- Line: 214
            -- upvalues: u8 (ref), u9 (ref), LinearVelocity (copy), HumanoidRootPart (copy)
            u8 = 60 - (tick() - u9) * 30;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * u8;
        end);
        u7.AC:Add(task.delay(0.43333333333333335, function() -- Line: 219
            -- upvalues: HumanoidRootPart (copy), u7 (copy), Essentials (ref), LocalPlayer (ref), u2 (ref), LinearVelocity (copy), TweenService (ref), u9 (ref)
            local LookVector = HumanoidRootPart.CFrame.LookVector;
            local v11 = u7:CheckInfront(25);

            if v11 then
                LookVector = (v11.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
            else
                for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
                    if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 15)) then
                        v11 = v.Character;
                        break;
                    end;
                end;
            end;

            if not v11 then
                return;
            end;

            local v12 = LookVector:Cross(Vector3.new(0, 1, 0));
            u2.Ability:Fire("Slap", {
                State = "Dribble",
                TimeSent = workspace:GetServerTimeNow(),
                Other = v11
            });
            LinearVelocity.Enabled = false;
            local LinearVelocity2 = Instance.new("LinearVelocity");
            LinearVelocity2.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity2.MaxAxesForce = Vector3.new(40000, 0, 40000);
            LinearVelocity2.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity2.Parent = HumanoidRootPart;
            u7.AC:Add(LinearVelocity2);
            LinearVelocity2.VectorVelocity = LookVector * 30;
            TweenService:Create(LinearVelocity2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = (LookVector + v12 * 1.5) * 40
            }):Play();
            task.wait(0.2);
            TweenService:Create(LinearVelocity2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = (LookVector * 1.5 + -v12 * 1.05) * 50
            }):Play();
            task.wait(0.2);
            TweenService:Create(LinearVelocity2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = LookVector * 50
            }):Play();
            task.wait(0.2);
            u9 = tick() - 0.3333333333333333;
            LinearVelocity.Enabled = true;
            LinearVelocity2:Destroy();
        end));
        u7.AC:Add(task.delay(1.5, function() -- Line: 268
            -- upvalues: u7 (copy), Attribute (copy), HumanoidRootPart (copy), LocalPlayer (ref), Cooldowns (ref), u1 (ref), RunService (ref)
            u7.AC:Clean();

            if Attribute then
                if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145 then
                    return;
                end;
            elseif u7:HoopDist() > 125 then
                return;
            end;

            u7.Dribble = true;
            u7:ResetCD(1);
            u7.AC:Add(function() -- Line: 286
                -- upvalues: u7 (ref), LocalPlayer (ref), Cooldowns (ref), u1 (ref)
                task.delay(0.25, function() -- Line: 287
                    -- upvalues: u7 (ref)
                    u7.Dribble = nil;
                end);

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Cooldowns.Abilities.Skarp[1];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u1.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Thunder Swarm";

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Thunderclap and Flash";
            end);
            u7.AC:Add(task.delay(3, function() -- Line: 304
                -- upvalues: u7 (ref)
                u7.Dribble = nil;
                u7.AC:Clean();
            end));
            local u13 = 1;
            local u14 = false;
            u7.AC:Connect(RunService.Heartbeat, function(p15) -- Line: 312
                -- upvalues: u1 (ref), LocalPlayer (ref), u7 (ref), Cooldowns (ref), u13 (ref), u14 (ref)
                if not u1.CharValues.HasBall then
                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                        u7.CDS[1] = tick() + Cooldowns.Abilities.Skarp[1];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    if u1.CharValues.HasBall then
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Thunder Swarm";
                    else
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Thunderclap and Flash";
                    end;

                    u7.Dribble = nil;

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u13;

                if u13 > 0.5 and not u14 then
                    p15 = -p15 or p15;
                end;

                u13 = u13 + p15;

                if u13 <= 0.5 then
                    u14 = true;
                end;

                if u13 >= 1 then
                    u14 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Rumble and Flash";
            end);
        end));

        return;
    end;

    u7.Dribble = nil;
    local v16 = u7:HoopDist();
    u7:ResetCopy();

    if v16 < 70 then
        u2.Ability:Fire("Slap", {
            Style = "Euro",
            State = "Shot",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.delay(0.3, function() -- Line: 124
            -- upvalues: u2 (ref)
            u2.Ability:Fire("Slap", {
                State = "Shot",
                TimeSent = workspace:GetServerTimeNow()
            });
        end);
        u3.States.Ability = true;
        u4:PlayChar("Perfection", `PDLayup{Essentials:ReturnRorL(u1.CharValues)}`, Enum.AnimationPriority.Action3, true);
        u4:PlayBall("Perfection", `PDLayup{Essentials:ReturnRorL(u1.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        local Unit = (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Unit;
        local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
        local u17 = Essentials:ReturnRorL(u1.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
        LinearVelocity.VectorVelocity = (Vector3_new_ret + u17 / 2) * 55;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (Vector3_new_ret * 1.55 + u17 / 2) * 30
        }):Play();
        task.delay(0.42, function() -- Line: 147
            -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref), u17 (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = ((Vector3_new_ret + -u17 / 1.5) / 2 + Vector3.new(0, 1, 0)) * 40
            }):Play();
        end);
        task.delay(0.7, function() -- Line: 150
            -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = (Vector3_new_ret + Vector3.new(0, -0.25, 0)) * 50
            }):Play();
        end);
        task.delay(1, function() -- Line: 153
            -- upvalues: u3 (ref), LinearVelocity (copy)
            u3.States.Ability = false;
            LinearVelocity:Destroy();
        end);
        local u18 = nil;
        u18 = RunService.Heartbeat:Connect(function() -- Line: 158
            -- upvalues: Hoop (copy), HumanoidRootPart (copy), LinearVelocity (copy), u18 (ref)
            if (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Magnitude < 10 then
                LinearVelocity.Enabled = false;
                u18:Disconnect();
            end;
        end);
        u7.AC:Add(u18);
        u7.AC:Connect(u2.Ability, function() -- Line: 168
            -- upvalues: u7 (copy), ReplicatedStorage (ref), u5 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
            u7.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u5:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 50);
        end);

        return;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u7.AC:Add(task.delay(1.25, function() -- Line: 48
        -- upvalues: u3 (ref), u7 (copy)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        u7.AC:Clean();
    end));
    local v19 = u4:PlayChar("Perfection", `PDPoint{Essentials:ReturnRorL(u1.CharValues)}`, Enum.AnimationPriority.Action3, true);
    local v20 = u4:PlayBall("Perfection", `PDPoint{Essentials:ReturnRorL(u1.CharValues)}Ball`, Enum.AnimationPriority.Action3, true);
    v19.TimePosition = 0.7;
    v20.TimePosition = 0.7;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local v21 = HumanoidRootPart.CFrame.LookVector * -15 + Vector3.new(0, 2.5, 0);
    local v22 = workspace:Raycast(HumanoidRootPart.Position, v21, RaycastParams_new_ret);
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if v22 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v22.Position - HumanoidRootPart.Position) * (v22.Distance / 2), (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v21, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    end;

    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 45;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
    BodyGyro.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    BodyGyro.Parent = HumanoidRootPart;
    local u23 = -HumanoidRootPart.CFrame.LookVector;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.25, 0)) * 8
    }):Play();
    task.delay(0.75, function() -- Line: 96
        -- upvalues: TweenService (ref), LinearVelocity (copy), u23 (copy), BodyGyro (copy)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            VectorVelocity = (u23 - Vector3.new(0, 1, 0)) * 55
        }):Play();
        task.wait(0.175);
        LinearVelocity:Destroy();
        BodyGyro:Destroy();
    end);
    u7.AC:Connect(u2.Ability, function() -- Line: 103
        -- upvalues: u7 (copy), u3 (ref), ReplicatedStorage (ref), u5 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
        u7.AC:Clean();
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u5:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 70);
    end);
    u2.Ability:Fire("Slap", {
        Style = "Fadeaway",
        State = "Shot",
        TimeSent = workspace:GetServerTimeNow()
    });
end;