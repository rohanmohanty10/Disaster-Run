 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), ReplicatedStorage (copy), Cooldowns (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.Animations;
    u3 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u6.CharValues.HasBall then
        if not u7.Dribble then
            if u7.MovementController.States.PumpFake then
                u7:ResetCD(1);
                Effects:Popup("Can\'t use after a fake!");

                return;
            end;

            local v8 = u7:CheckInfront(25);

            if not v8 then
                u7:ResetCD(1);
                Effects:Popup("Someone must be infront of you!");

                return;
            end;

            u3.States.Ability = true;
            u7.AC:Add(function() -- Line: 98
                -- upvalues: u3 (ref)
                u3.States.Ability = false;
            end);
            u7.AC:Add(task.delay(2.4166666666666665, function() -- Line: 102
                -- upvalues: u7 (copy)
                u7.AC:Clean();
            end));
            u2:StopAll();
            u2:PlayChar("Kira", "WrittenFate", Enum.AnimationPriority.Action3);
            u2:PlayBall("Kira", "WrittenFateBall", Enum.AnimationPriority.Action3);
            Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.WrittenFateBook):Play();
            Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.WrittenFatePen):Play();
            u1.Ability:Fire("Heart Attack", {
                State = "Dribble",
                TimeSent = workspace:GetServerTimeNow(),
                Other = v8
            });
            u7.AC:Connect(u1.Ability, function() -- Line: 115
                -- upvalues: u7 (copy), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy), LocalPlayer (ref), Cooldowns (ref), u6 (ref), RunService (ref)
                u7.AC:Clean();
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                Value.AssemblyLinearVelocity = Vector3.new(0, workspace.Gravity * 1.3666666666666667, 0);
                task.wait(0.6833333333333333);
                Value.AssemblyLinearVelocity = Value.AssemblyLinearVelocity + (Vector3.new(0, -workspace.Gravity * 1.3666666666666667, 0) + (HumanoidRootPart.Position * Vector3.new(1, 0, 1) - Value.Position * Vector3.new(1, 0, 1)) / 0.6833333333333333);
                u7.Dribble = true;
                u7:ResetCD(1);
                local u9 = nil;
                task.delay(3, function() -- Line: 132
                    -- upvalues: u9 (ref)
                    u9 = true;
                end);
                local u10 = 1;
                local u11 = false;
                local u12 = nil;

                local function End() -- Line: 141
                    -- upvalues: LocalPlayer (ref), u7 (ref), Cooldowns (ref), u6 (ref), u12 (ref)
                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                        u7.CDS[1] = tick() + Cooldowns.Abilities.Kira[1];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    if u6.CharValues.HasBall then
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Written Fate";
                    else
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Heart Attack";
                    end;

                    u12:Disconnect();
                    u7.Dribble = nil;
                    u7:ResetCopy();
                end;

                u12 = RunService.Heartbeat:Connect(function(p13) -- Line: 160
                    -- upvalues: u7 (ref), u9 (ref), End (copy), LocalPlayer (ref), u10 (ref), u11 (ref)
                    if not u7.Dribble or u9 then
                        End();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u10;

                    if u10 > 0.5 and not u11 then
                        p13 = -p13 or p13;
                    end;

                    u10 = u10 + p13;

                    if u10 <= 0.5 then
                        u11 = true;
                    end;

                    if u10 >= 1 then
                        u11 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Fate Drive";
                end);
            end);

            return;
        end;

        if u7.MovementController.States.PumpFake then
            u7:ResetCD(1);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        u7:ResetCopy();
        u7.Dribble = nil;
        u3.Boost = 15;
        u3.States.Ability = true;
        u7.AC:Add(function() -- Line: 47
            -- upvalues: u3 (ref)
            u3.Boost = 0;
            u3.States.Ability = false;
        end);
        u7.AC:Add(task.delay(0.8333333333333334, function() -- Line: 52
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u7.AC:Add(task.delay(0.5, function() -- Line: 56
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
        end));
        u2:StopAll();
        u2:PlayChar("Kira", "FateDrive", Enum.AnimationPriority.Action3);
        u2:PlayBall("Kira", "FateDriveBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Heart Attack", {
            State = "Forward",
            TimeSent = workspace:GetServerTimeNow()
        });
        local v14 = u7.AC:Add(Instance.new("LinearVelocity"));
        v14.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        v14.MaxAxesForce = Vector3.new(40000, 0, 40000);
        v14.Attachment0 = HumanoidRootPart.RootAttachment;
        v14.Parent = HumanoidRootPart;
        v14.VectorVelocity = (HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.CFrame.RightVector) * 50;
        TweenService:Create(v14, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.CFrame.RightVector) * 25
        }):Play();
        task.wait(0.3333333333333333);
        TweenService:Create(v14, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector + HumanoidRootPart.CFrame.RightVector * 2) * 75
        }):Play();
        task.wait(0.16666666666666666);
        TweenService:Create(v14, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector + HumanoidRootPart.CFrame.RightVector / 2) * 75
        }):Play();
        task.wait(0.13333333333333333);
        TweenService:Create(v14, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.CFrame.RightVector * 2) * 50
        }):Play();

        return;
    end;

    if not u7.Marked then
        local CharacterPossessingBall = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if not CharacterPossessingBall then
            u7:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            u7:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            u7:ResetCD(1);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if (CharacterPossessingBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 100 then
            u7:ResetCD(1);
            Effects:Popup("Enemy must be close to you!");

            return;
        end;

        if CharacterPossessingBall:GetAttribute("MarkedBy") then
            u7:ResetCD(1);
            Effects:Popup("Enemy player is already marked!");

            return;
        end;

        u3.Boost = -15;
        u3.States.Ability = true;
        u7.AC:Add(function() -- Line: 299
            -- upvalues: u3 (ref)
            u3.Boost = 0;
            u3.States.Ability = false;
        end);
        u7.AC:Add(task.delay(1.8833333333333333, function() -- Line: 304
            -- upvalues: u7 (copy), LocalPlayer (ref), Cooldowns (ref), u6 (ref), RunService (ref)
            u7.AC:Clean();
            u7.Marked = true;
            u7:ResetCD(1);
            local u15 = nil;
            task.delay(3, function() -- Line: 311
                -- upvalues: u15 (ref)
                u15 = true;
            end);
            local u16 = 1;
            local u17 = false;
            local u18 = nil;

            local function u19() -- Line: 320
                -- upvalues: LocalPlayer (ref), u7 (ref), Cooldowns (ref), u6 (ref), u18 (ref)
                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Cooldowns.Abilities.Kira[1];
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Written Fate";
                else
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Heart Attack";
                end;

                u18:Disconnect();
                u7.Marked = nil;
                u7:ResetCopy();
            end;

            u18 = RunService.Heartbeat:Connect(function(p20) -- Line: 339
                -- upvalues: u7 (ref), u15 (ref), u19 (copy), u6 (ref), LocalPlayer (ref), u16 (ref), u17 (ref)
                if not u7.Marked or u15 then
                    u19();

                    return;
                end;

                if u6.CharValues.HasBall then
                    u19();

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u16;

                if u16 > 0.5 and not u17 then
                    p20 = -p20 or p20;
                end;

                u16 = u16 + p20;

                if u16 <= 0.5 then
                    u17 = true;
                end;

                if u16 >= 1 then
                    u17 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Book Dash";
            end);
        end));
        u2:StopAll();
        u2:PlayChar("Kira", "HeartAttack", Enum.AnimationPriority.Action3);
        Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.HeartAttackBook):Play();
        Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.HeartAttackPen):Play();
        u1.Ability:Fire("Heart Attack", {
            State = "Heart Attack",
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    u7:ResetCopy();
    u7.Marked = nil;
    u2:StopAll();
    local u21 = u2:PlayChar("Kira", "BookDash", Enum.AnimationPriority.Action3, true);
    local u22 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.BookDashBook);
    u22:Play();
    local Shiftlock = u7.CameraController.Shiftlock;
    u7.CameraController:SetShiftlock(false);
    u3.Boost = 15;
    u3.States.Ability = true;
    u7.AC:Add(function() -- Line: 196
        -- upvalues: u21 (copy), u22 (copy), u3 (ref), u7 (copy), Shiftlock (copy)
        if u21 then
            u21:Stop(0.5);
        end;

        if u22 then
            u22:Stop(0.5);
        end;

        u3.States.Ability = false;
        u3.Boost = 0;

        if not u7.CameraController.Shiftlock then
            u7.CameraController:SetShiftlock(Shiftlock);
        end;
    end);
    u7.AC:Add(task.delay(0.5, function() -- Line: 213
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    local Value = ReplicatedStorage.Basketball.Value;
    local ServerBallPosition = u4:GetServerBallPosition();
    local v23 = (ServerBallPosition + Vector3.new(Value.AssemblyLinearVelocity.X + 1, 0, Value.AssemblyLinearVelocity.Z + 1).Unit / 10 - HumanoidRootPart.Position) * Vector3.new(1, 0, 1);

    if v23.Magnitude <= 0 or not v23.Unit then
        local _ = HumanoidRootPart.CFrame.LookVector;
    end;

    local u24 = u7.AC:Add(Instance.new("NumberValue"));
    u24.Value = 150;
    local u25 = u7.AC:Add(Instance.new("LinearVelocity"));
    u25.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u25.MaxAxesForce = Vector3.new(40000, 0, 40000);
    u25.Attachment0 = HumanoidRootPart.RootAttachment;
    u25.Parent = HumanoidRootPart;
    local u26 = u7.AC:Add(Instance.new("BodyGyro"));
    u26.Name = "GyroBasketball";
    u26.MaxTorque = Vector3.new(0, 9000000000, 0);
    u26.P = 1000;
    u26.CFrame = CFrame.lookAt(HumanoidRootPart.Position, ServerBallPosition);
    u26.Parent = HumanoidRootPart;
    u7.AC:Connect(RunService.Heartbeat, function(p27) -- Line: 240
        -- upvalues: u4 (ref), Value (copy), HumanoidRootPart (copy), u6 (ref), u7 (copy), u26 (copy), u25 (copy), u24 (copy)
        local ServerBallPosition2 = u4:GetServerBallPosition();
        local v28 = (ServerBallPosition2 + Vector3.new(Value.AssemblyLinearVelocity.X + 1, 0, Value.AssemblyLinearVelocity.Z + 1).Unit / 10 - HumanoidRootPart.Position) * Vector3.new(1, 0, 1);
        local v29 = v28.Magnitude > 0 and v28.Unit or HumanoidRootPart.CFrame.LookVector;

        if u6.CharValues.HasBall or (HumanoidRootPart.Position - ServerBallPosition2).Magnitude <= 5 then
            u7.AC:Clean();

            return;
        end;

        u26.CFrame = CFrame.lookAt(HumanoidRootPart.Position, ServerBallPosition2);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition2.X, HumanoidRootPart.Position.Y, ServerBallPosition2.Z)));
        u25.VectorVelocity = v29 * u24.Value;
    end);
    TweenService:Create(u24, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 25
    });
    u1.Ability:Fire("Heart Attack", {
        State = "Book",
        TimeSent = workspace:GetServerTimeNow()
    });
end;