 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), Essentials (copy), Zones (copy), TweenService (copy), ReplicatedStorage (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;
    local u7 = LocalPlayer.Style.Value == "Copycat" and true or LocalPlayer.Style.Value == "Thief";

    if u5.CharValues.InAwakening and not u6.CounterDribble then
        if not u5.CharValues.HasBall then
            Effects:Popup("Not usable without ball!");
            u6:ResetCD(2);

            return;
        end;

        Effects:Popup("AUTOMICALLY COUNTERING STEALS AND BLOCKS FOR 15 SECONDS");
        u1.Ability:Fire("Bandit Cloak", {
            State = "Counter Activate",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AwakeningAbility2Used = true;
        local u8 = nil;
        u8 = RunService.Heartbeat:Connect(function() -- Line: 49
            -- upvalues: u5 (ref), u8 (ref), u6 (copy)
            if not u5.CharValues.InAwakening then
                u8:Disconnect();
                u6.AwakeningAbility2Used = nil;
            end;
        end);

        return;
    end;

    if u6.InBanditCloak then
        if u7 then
            require(script.Parent.BanditDribble)(u6);

            return;
        end;

        if not u5.CharValues.HasBall then
            Effects:Popup("Not usable without ball!");
            u6:ResetCD(2);

            return;
        end;

        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(2);

            return;
        end;

        if u6:HoopDist() > 85 then
            Effects:Popup("Too far away from hoop!");
            u6:ResetCD(2);

            return;
        end;

        if u6.FirstCooldown then
            u6.CDS[1] = u6.FirstCooldown;
        end;

        u6.InBanditCloak = nil;
        u6.FirstCooldown = nil;
        u1.Ability:Fire("Bandit Cloak", {
            State = "Floater",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "Floater", Enum.AnimationPriority.Action3);
        u4:PlayBall("ChrolloV2", "FloaterBall", Enum.AnimationPriority.Action3);
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        u6.AC:Connect(RunService.Heartbeat, function(p9) -- Line: 99
            -- upvalues: FieldOfView (ref), Essentials (ref)
            FieldOfView = Essentials:Lerp(FieldOfView, 40, p9 * 5);
            workspace.CurrentCamera.FieldOfView = FieldOfView;
        end);
        u6.AC:Add(task.delay(1.5, function() -- Line: 104
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = 20000;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        local u10 = (Zones.JumpHeight[LocalPlayer.Zone.Value] and (u5.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.RightVector * 15 + HumanoidRootPart.CFrame.LookVector * -15;
        task.delay(0.25, function() -- Line: 116
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u10 (copy), TweenService (ref)
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -30 + Vector3.new(0, 60 * u10, 0);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = HumanoidRootPart.CFrame.LookVector * -15 + Vector3.new(0, 30 * u10, 0)
            }):Play();
        end);
        task.delay(0.5666666666666667, function() -- Line: 121
            -- upvalues: TweenService (ref), LinearVelocity (copy), HumanoidRootPart (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = HumanoidRootPart.CFrame.RightVector * -15 + Vector3.new(0, -15, 0)
            }):Play();
        end);
        task.delay(0.8166666666666667, function() -- Line: 125
            -- upvalues: LinearVelocity (copy), u2 (ref)
            LinearVelocity:Destroy();
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u6.AC:Connect(u1.Ability, function() -- Line: 135
            -- upvalues: u6 (copy), ReplicatedStorage (ref), u3 (ref), LocalPlayer (ref)
            u6.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
            local v11 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
            local math_log_ret = math.log(2 + v11.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v11 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);

        return;
    end;

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.PhantomInterceptCD.Value <= workspace:GetServerTimeNow() then
            if not RunService:IsStudio() then
                local LastPlayerToPossessBall = u3:GetLastPlayerToPossessBall();

                if LastPlayerToPossessBall == nil or LastPlayerToPossessBall.Team == LocalPlayer.Team then
                    u6:ResetCD(2);
                    Effects:Popup("Ball must have been just passed by enemy player!");

                    return;
                end;

                local Character2 = LastPlayerToPossessBall.Character;

                if Character2 == nil or u3:GetPlayerPossessingBall() then
                    u6:ResetCD(2);
                    Effects:Popup("Ball must have been just passed!");

                    return;
                end;

                if Character2 == Character then
                    u6:ResetCD(2);
                    Effects:Popup("Ball must have been just passed by enemy player!");

                    return;
                end;

                if Character2:GetAttribute("Unblockable") and Character2:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
                    u6:ResetCD(2);
                    Effects:Popup("Can\'t block pass!");

                    return;
                end;

                if (u3:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude >= 35 then
                    u6:ResetCD(2);
                    Effects:Popup("Ball is too far away!");

                    return;
                end;
            end;

            u1.Ability:Fire("Bandit Cloak", {
                State = "Intercept",
                TimeSent = workspace:GetServerTimeNow()
            });
            u6.AC:Connect(u1.Ability, function(p12) -- Line: 365
                -- upvalues: u6 (copy), Effects (ref), LocalPlayer (ref), Abilities (ref), u2 (ref), u4 (ref), HumanoidRootPart (copy), u3 (ref), RunService (ref), Humanoid (copy)
                u6.AC:Clean();

                if p12 and p12.Fail then
                    u6:ResetCD(2);
                    Effects:Popup("Ball must have been just passed!");

                    return;
                end;

                u6:ResetCopy();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[2] = tick() + Abilities.ChrolloV2[2];
                end;

                u2.States.NoWalk = true;
                u2.States.Ability = true;
                task.delay(0.5, function() -- Line: 383
                    -- upvalues: u2 (ref)
                    u2.States.NoWalk = false;
                end);
                task.delay(2.5833333333333335, function() -- Line: 387
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                end);
                u4:StopAll();
                local v13 = u4:PlayChar("ChrolloV2", "PhantomIntercept", Enum.AnimationPriority.Action3, true);
                local v14 = u4:PlayBall("ChrolloV2", "PhantomInterceptBall", Enum.AnimationPriority.Action3, true);
                v13.TimePosition = 0.4166666666666667;
                v14.TimePosition = 0.4166666666666667;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
                LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.Parent = HumanoidRootPart;
                local ServerBallPosition = u3:GetServerBallPosition();
                LinearVelocity.VectorVelocity = (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z) - HumanoidRootPart.Position).Unit * 90;
                task.delay(0.3333333333333333, function() -- Line: 407
                    -- upvalues: LinearVelocity (copy)
                    LinearVelocity:Destroy();
                end);
                task.wait(0.5);
                local v15 = RunService.Heartbeat:Connect(function() -- Line: 413
                    -- upvalues: Humanoid (ref), HumanoidRootPart (ref)
                    if Humanoid.MoveDirection.X == 0 and Humanoid.MoveDirection.Z == 0 then
                        HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector * Humanoid.WalkSpeed + Vector3.new(0, HumanoidRootPart.AssemblyLinearVelocity.Y, 0);
                    end;
                end);
                local v16 = u2;
                v16.Boost = v16.Boost + 20;
                task.wait(0.5833333333333334);
                local v17 = u4:PlayChar("ChrolloV2", "PhantomInterceptLoop", Enum.AnimationPriority.Action3, true);
                local v18 = u4:PlayBall("ChrolloV2", "PhantomInterceptLoopBall", Enum.AnimationPriority.Action3, true);
                task.wait(1.5);
                v15:Disconnect();
                local v19 = u2;
                v19.Boost = v19.Boost - 20;

                if u2.Boost < 0 then
                    u2.Boost = 0;
                end;

                v17:Stop();
                v18:Stop();
            end);

            return;
        end;

        local v20 = ReplicatedStorage.Cooldowns.PhantomInterceptCD.Value - workspace:GetServerTimeNow();
        local math_abs_ret = math.abs(v20);
        Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
        u6:ResetCD(2);

        return;
    end;

    if u6.CounterDribble then
        u6.CounterDribble = nil;
        local v21 = u6:CheckInfront(50);

        if not v21 then
            u6:ResetCD(1);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u2.States.Ability = true;
        u6.AC:Add(function() -- Line: 169
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u6.AC:Add(task.delay(0.95, function() -- Line: 172
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Bandit Cloak", {
            State = "Counter Dribble",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v21
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "CounterDribble", Enum.AnimationPriority.Action3);
        u4:PlayBall("ChrolloV2", "CounterDribbleBall", Enum.AnimationPriority.Action3);
        local u22 = u6.AC:Add(Instance.new("LinearVelocity"));
        u22.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u22.MaxAxesForce = Vector3.new(20000, 0, 20000);
        u22.Attachment0 = HumanoidRootPart.RootAttachment;
        u22.Parent = HumanoidRootPart;
        u22.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5;
        TweenService:Create(u22, TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 45 + HumanoidRootPart.CFrame.RightVector * -45
        }):Play();
        local v23 = u2;
        v23.Boost = v23.Boost + 25;
        task.delay(0.4666666666666667, function() -- Line: 193
            -- upvalues: TweenService (ref), u22 (copy), HumanoidRootPart (copy), u2 (ref)
            TweenService:Create(u22, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60 + HumanoidRootPart.CFrame.RightVector * 60
            }):Play();
            local v24 = u2;
            v24.Boost = v24.Boost - 25;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
        local u25 = nil;
        u25 = u1.Ability:Connect(function() -- Line: 203
            -- upvalues: u25 (ref), ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy)
            u25:Disconnect();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
            Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector - Vector3.new(0, 1, 0)).Unit * 90;
        end);
        u6.AC:Add(u25);

        return;
    end;

    u6.InBanditCloak = true;
    u6.FirstCooldown = (u6.Dribble or u6.CutPosition) and tick() + Abilities.ChrolloV2[1] or u6.CDS[1];
    u6:ResetCD(1);
    u6:ResetCD(2);
    local v26 = u2;
    v26.Boost = v26.Boost + 20;
    u4:StopAll();
    u4:PlayChar("ChrolloV2", "BanditCloak", Enum.AnimationPriority.Action3);
    u4:PlayBall("ChrolloV2", "BanditCloakBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Bandit Cloak", {
        State = "Cloak",
        TimeSent = workspace:GetServerTimeNow()
    });
    local u27 = u6.AC:Add(Instance.new("LinearVelocity"));
    u27.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u27.MaxAxesForce = Vector3.new(20000, 0, 20000);
    u27.Attachment0 = HumanoidRootPart.RootAttachment;
    u27.Parent = HumanoidRootPart;
    u27.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60;
    task.delay(0.25, function() -- Line: 239
        -- upvalues: u27 (copy)
        u27:Destroy();
    end);
    local u28 = nil;
    task.delay(1.5, function() -- Line: 244
        -- upvalues: u28 (ref)
        u28 = true;
    end);
    local u29 = 1;
    local u30 = false;
    local u31 = nil;

    local function End() -- Line: 253
        -- upvalues: LocalPlayer (ref), u6 (copy), u7 (copy), Abilities (ref), u2 (ref), u5 (ref), u31 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            if not u7 and u6.FirstCooldown then
                u6.CDS[1] = u6.FirstCooldown;
            end;

            u6.CDS[u7 and 1 or 2] = tick() + Abilities.ChrolloV2[2];
        end;

        local v32 = u2;
        v32.Boost = v32.Boost - 20;

        if u2.Boost < 0 then
            u2.Boost = 0;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

        if not u7 then
            if u5.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Creator\'s Dribble";
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Cloak";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Creator\'s Cut";
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Intercept";
            end;
        end;

        u31:Disconnect();

        if u6.InBanditCloak then
            u6.InBanditCloak = nil;
        end;

        u6:ResetCopy();
    end;

    u31 = RunService.Heartbeat:Connect(function(p33) -- Line: 288
        -- upvalues: u6 (copy), u28 (ref), End (copy), u5 (ref), LocalPlayer (ref), u29 (ref), u7 (copy), u30 (ref)
        if not u6.InBanditCloak or u28 then
            End();

            return;
        end;

        if not u5.CharValues.HasBall then
            End();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u29;

        if not u7 then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u29;
        end;

        if u29 > 0.5 and not u30 then
            p33 = -p33 or p33;
        end;

        u29 = u29 + p33;

        if u29 <= 0.5 then
            u30 = true;
        end;

        if u29 >= 1 then
            u30 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Snatchback";

        if not u7 then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Delayed Floater";
        end;
    end);
end;