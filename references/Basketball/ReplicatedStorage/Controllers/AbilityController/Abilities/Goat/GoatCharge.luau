 
 

game:GetService("Players");
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
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), RunService (copy), ReplicatedStorage (copy), CalculateBallTrajectory (copy), Essentials (copy), Abilities (copy)
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
        u1.Ability:Fire("Goat Charge", {
            State = "Charge",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("Goat", "GoatCharge", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 274
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u8 = 0;
        task.delay(0.25, function() -- Line: 287
            -- upvalues: u8 (ref)
            u8 = 30;
        end);
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 291
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), Humanoid (copy), u8 (ref)
            if not LinearVelocity then
                return;
            end;

            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * (Humanoid.WalkSpeed + u8);
        end);
        u7.AC:Add(task.delay(2, function() -- Line: 296
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

        u1.Ability:Fire("Goat Charge", {
            State = "Forward",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("Goat", "GoatDribble", Enum.AnimationPriority.Action3);
        u5:PlayBall("Goat", "GoatDribbleBall", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 129
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        local u9 = 60;
        local u10 = tick();
        u7.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 144
            -- upvalues: u9 (ref), u10 (ref), LinearVelocity (copy), HumanoidRootPart (copy)
            u9 = 60 - (tick() - u10) * 30;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1) * u9;
        end);
        u7.AC:Add(task.delay(0.43333333333333335, function() -- Line: 149
            -- upvalues: HumanoidRootPart (copy), u7 (copy), Essentials (ref), LocalPlayer (ref), u1 (ref), LinearVelocity (copy), TweenService (ref), u10 (ref)
            local LookVector = HumanoidRootPart.CFrame.LookVector;
            local v12 = u7:CheckInfront(25);

            if v12 then
                LookVector = (v12.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
            else
                for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
                    if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 15)) then
                        v12 = v.Character;
                        break;
                    end;
                end;
            end;

            if not v12 then
                return;
            end;

            local v13 = LookVector:Cross(Vector3.new(0, 1, 0));
            u1.Ability:Fire("Goat Charge", {
                State = "Dribble",
                TimeSent = workspace:GetServerTimeNow(),
                Other = v12
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
                VectorVelocity = (LookVector + v13 * 1.5) * 40
            }):Play();
            task.wait(0.2);
            TweenService:Create(LinearVelocity2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = (LookVector * 1.5 + -v13 * 1.05) * 50
            }):Play();
            task.wait(0.2);
            TweenService:Create(LinearVelocity2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = LookVector * 50
            }):Play();
            task.wait(0.2);
            u10 = tick() - 0.3333333333333333;
            LinearVelocity.Enabled = true;
            LinearVelocity2:Destroy();
        end));
        u7.AC:Add(task.delay(1.5, function() -- Line: 198
            -- upvalues: u7 (copy), LocalPlayer (ref), Effects (ref), Abilities (ref), u6 (ref), RunService (ref)
            u7.AC:Clean();

            if LocalPlayer.Style.Value == "CopyCat" or LocalPlayer.Style.Value == "Thief" then
                return;
            end;

            if u7:HoopDist() > 125 then
                return;
            end;

            u7.Dribble = true;
            u7:ResetCD(1);
            local u14 = nil;
            task.delay(5, function() -- Line: 210
                -- upvalues: u14 (ref)
                u14 = true;
            end);
            local u15 = 1;
            local u16 = false;
            local u17 = nil;

            local function End() -- Line: 219
                -- upvalues: u14 (ref), Effects (ref), LocalPlayer (ref), u7 (ref), Abilities (ref), u6 (ref), u17 (ref)
                if u14 then
                    Effects:Popup("You miss 100% of the shots you don\'t take!");
                end;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Abilities.Goat[1];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Goat Dribble";
                else
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Goat Charge";
                end;

                u17:Disconnect();
                u7.Dribble = nil;
                u7:ResetCopy();
            end;

            u17 = RunService.Heartbeat:Connect(function(p18) -- Line: 242
                -- upvalues: u7 (ref), u14 (ref), End (copy), u6 (ref), LocalPlayer (ref), u15 (ref), u16 (ref)
                if not u7.Dribble or u14 then
                    End();

                    return;
                end;

                if not u6.CharValues.HasBall then
                    End();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u15;

                if u15 > 0.5 and not u16 then
                    p18 = -p18 or p18;
                end;

                u15 = u15 + p18;

                if u15 <= 0.5 then
                    u16 = true;
                end;

                if u15 >= 1 then
                    u16 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Sky Lob Layup";
            end);
        end));

        return;
    end;

    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u7:ResetCD(1);

        return;
    end;

    if u7:HoopDist() > 80 then
        u7:ResetCD(1);
        Effects:Popup("Too for away from hoop!");

        return;
    end;

    u7.Dribble = nil;
    u7:ResetCopy();
    u1.Ability:Fire("Goat Charge", {
        State = "Layup",
        TimeSent = workspace:GetServerTimeNow()
    });
    u5:StopAll();
    u5:PlayChar("Goat", "SkyLobLayup", Enum.AnimationPriority.Action3);
    u5:PlayBall("Goat", "SkyLobLayupBall", Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, inf, inf);
    LinearVelocity.Parent = HumanoidRootPart;
    local Unit = (Position - HumanoidRootPart.Position).Unit;
    local u19 = Unit:Cross(Vector3.new(0, 1, 0));
    local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
    LinearVelocity.VectorVelocity = (Vector3_new_ret - u19 / 2) * 55;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = (Vector3_new_ret * 1.55 - u19 / 2) * 30
    }):Play();
    task.delay(0.3333333333333333, function() -- Line: 74
        -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref), u19 (copy)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (Vector3_new_ret + u19 / 2) * 40
        }):Play();
    end);
    task.delay(0.6666666666666666, function() -- Line: 77
        -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (Vector3_new_ret + Vector3.new(0, 1, 0)) * 30
        }):Play();
    end);
    task.delay(1, function() -- Line: 80
        -- upvalues: TweenService (ref), LinearVelocity (copy), Vector3_new_ret (ref)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (Vector3_new_ret + Vector3.new(0, -0.5, 0)) * 20
        }):Play();
    end);
    u2.States.Ability = true;
    task.delay(1.3333333333333333, function() -- Line: 85
        -- upvalues: u2 (ref), LinearVelocity (copy)
        u2.States.Ability = false;
        LinearVelocity:Destroy();
    end);
    local u20 = nil;
    u20 = RunService.Heartbeat:Connect(function() -- Line: 91
        -- upvalues: Position (copy), HumanoidRootPart (copy), LinearVelocity (copy), u20 (ref)
        if (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Magnitude < 10 then
            LinearVelocity.MaxAxesForce = Vector3.new(0, inf, 0);
            u20:Disconnect();
        end;
    end);
    u7.AC:Add(u20);
    u7.AC:Connect(u1.Ability, function() -- Line: 99
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), CalculateBallTrajectory (ref), Position (copy)
        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        Value.AssemblyLinearVelocity = CalculateBallTrajectory(Value.Position, Position, 90);
    end);
end;