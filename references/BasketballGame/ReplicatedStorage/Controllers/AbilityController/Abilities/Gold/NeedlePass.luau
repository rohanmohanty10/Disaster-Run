 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7, p8) -- Line: 24, Name: NeedlePass
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), u6 (ref), Knit (copy), Effects (copy), ReplicatedStorage (copy), TweenService (copy), Players (copy), Essentials (copy), CameraShaker (copy), RunService (copy), workspace_CurrentCamera (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;
    Knit.GetController("EmotesController"):CancelPlayingEmote();

    if not u7.ChainHandles then
        if u6.CharValues.InAwakening then
            local v9;

            if RunService:IsStudio() then
                v9 = workspace.DefenseRig;
            else
                local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();

                if LastPlayerToPossessBall == nil or LastPlayerToPossessBall.Team == LocalPlayer.Team then
                    u7:ResetCD(2);
                    Effects:Popup("Ball must have been just passed by enemy player!");

                    return;
                end;

                v9 = LastPlayerToPossessBall.Character;

                if v9 == nil or u4:GetPlayerPossessingBall() then
                    u7:ResetCD(2);
                    Effects:Popup("Ball must have been just passed!");

                    return;
                end;

                if v9 == Character then
                    u7:ResetCD(2);
                    Effects:Popup("Ball must have been just passed by enemy player!");

                    return;
                end;

                if v9:GetAttribute("Unblockable") and v9:GetAttribute("Unblockable") > workspace:GetServerTimeNow() then
                    u7:ResetCD(2);
                    Effects:Popup("Can\'t block pass!");

                    return;
                end;

                if (u4:GetServerBallPosition() - HumanoidRootPart.Position).Magnitude >= 75 then
                    u7:ResetCD(2);
                    Effects:Popup("Ball is too far away!");

                    return;
                end;
            end;

            u1.Ability:Fire("NeedlePass", {
                State = "GoldenEye",
                TimeSent = workspace:GetServerTimeNow(),
                Other = v9
            });
            u7.AC:Connect(u1.Ability, function(p10) -- Line: 322
                -- upvalues: u7 (copy), Effects (ref), LocalPlayer (ref), u2 (ref), u5 (ref), CameraShaker (ref), TweenService (ref), workspace_CurrentCamera (ref), u3 (ref), HumanoidRootPart (copy), u4 (ref)
                u7.AC:Clean();

                if p10 and p10.Fail then
                    u7:ResetCD(2);
                    Effects:Popup("Ball must have been just passed!");

                    return;
                end;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[2] = tick() + 120;
                end;

                u2.States.Ability = true;
                u2.States.NoWalk = true;
                task.delay(1.967, function() -- Line: 338
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                    u2.States.NoWalk = false;
                end);
                u5.CamShake:Shake(CameraShaker.Presets.Dunk);
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 120
                }):Play();
                u3:StopAll();
                u3:PlayChar("Gold", "Dash", Enum.AnimationPriority.Action3);
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
                LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
                LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
                LinearVelocity.Parent = HumanoidRootPart;
                local ServerBallPosition = u4:GetServerBallPosition();
                local Unit = (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z) - HumanoidRootPart.Position).Unit;
                LinearVelocity.VectorVelocity = Unit * 120;
                TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VectorVelocity = Unit * 90
                }):Play();
                task.delay(0.3333333333333333, function() -- Line: 360
                    -- upvalues: LinearVelocity (copy)
                    LinearVelocity:Destroy();
                end);
            end);

            return;
        end;

        if u6.CharValues.HasBall then
            local LookingAt = u7.Pass.LookingAt;
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

            if PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
                u7:ResetCD(2);
                Effects:Popup("Must look at team-mate!");

                return;
            end;

            if LookingAt == nil then
                u7:ResetCD(2);
                Effects:Popup("Must look at team-mate!");

                return;
            end;

            u7:ResetCopy();
            u2.States.Ability = true;
            u2.States.NoWalk = true;
            task.delay(0.21666666666666667, function() -- Line: 388
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end);
            local u11 = Essentials:ReturnRorL(u6.CharValues);
            u3:StopAll();
            u3:PlayChar("Gold", `NeedlePass{u11}`, Enum.AnimationPriority.Action3);
            u3:PlayBall("Gold", `NeedlePass{u11}Ball`, Enum.AnimationPriority.Action3);
            u1.Ability:Fire("NeedlePass", {
                State = "Pass",
                TimeSent = workspace:GetServerTimeNow(),
                Passing = LookingAt
            });
            local LinearVelocity = Instance.new("LinearVelocity");
            local CFrame = HumanoidRootPart.CFrame;
            u7.AC:Add(LinearVelocity);
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
            task.spawn(function() -- Line: 412
                -- upvalues: TweenService (ref), LinearVelocity (copy), CFrame (copy), u11 (copy)
                TweenService:Create(LinearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VectorVelocity = CFrame.RightVector * (u11 == "L" and -90 or 90) + CFrame.LookVector * 90
                }):Play();
                task.wait(0.1);
                TweenService:Create(LinearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    VectorVelocity = CFrame.RightVector * (u11 == "L" and 5 or -5) + CFrame.LookVector * 90
                }):Play();
                task.wait(0.1);
                LinearVelocity:Destroy();
            end);
            u7.AC:Connect(u1.Ability, function(p12, p13) -- Line: 424
                -- upvalues: u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), LookingAt (copy), u7 (copy), RunService (ref), HumanoidRootPart (copy), Character (copy)
                u5.CamShake:Shake(CameraShaker.Presets.Dunk);
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Unit = (LookingAt.HumanoidRootPart.Position - Value.Position).Unit;
                local _ = (LookingAt.HumanoidRootPart.Position - Value.Position).Magnitude;
                local Position = Value.Position;
                local Position2 = LookingAt.HumanoidRootPart.Position;
                local Magnitude = (Position2 - Position).Magnitude;
                Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                local LinearVelocity2 = Instance.new("LinearVelocity");
                LinearVelocity2.Attachment0 = Value.Root;
                LinearVelocity2.MaxForce = 40000;
                LinearVelocity2.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                u7.AC:Add(LinearVelocity2);
                u7.AC:Add(task.delay(0.15, function() -- Line: 449
                    -- upvalues: LinearVelocity2 (copy), Value (ref), Magnitude (ref), u7 (ref), RunService (ref), ReplicatedStorage (ref), Position (ref), Position2 (ref), LookingAt (ref), HumanoidRootPart (ref), u4 (ref), Character (ref)
                    LinearVelocity2.Parent = Value;
                    local u14 = tick();
                    local u15 = false;
                    local u16 = 150;
                    u7.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 455
                        -- upvalues: Value (ref), ReplicatedStorage (ref), Position (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u15 (ref), u4 (ref), u7 (ref), Character (ref), LinearVelocity2 (ref), u14 (copy), u16 (ref)
                        Value = ReplicatedStorage.Basketball.Value;
                        Position = Value.Position;
                        Position2 = LookingAt.HumanoidRootPart.Position;
                        Magnitude = (Position2 - Position).Magnitude;

                        if (HumanoidRootPart.Position - Value.Position).Magnitude >= 20 then
                            u15 = true;
                        end;

                        if not u4:LocalPlayerIsBallNetworkOwner() then
                            u7.AC:Clean();

                            return;
                        end;

                        local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                        if CharacterPossessingBall == Character then
                            LinearVelocity2.Parent = nil;
                        end;

                        if u14 + 3 < tick() or Magnitude <= 10 and LookingAt.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or CharacterPossessingBall) then
                            u7.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity2.VectorVelocity;

                            return;
                        end;

                        LinearVelocity2.Parent = Value;
                        LinearVelocity2.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Value.Position).Unit + Vector3.new(0, 0, 0)) * (u16 * 1);
                    end);
                end));
            end);

            return;
        end;

        if u7.Pressure then
            u7.Pressure = nil;
            u7:ResetCopy();
            u3:StopAll();
            u3:PlayChar("Gold", "Catch", Enum.AnimationPriority.Action3, true);
            u3:PlayBall("Gold", "CatchBall", Enum.AnimationPriority.Action3, true);
            u2.Boost = 10;
            u2.States.Ability = true;
            task.delay(1, function() -- Line: 497
                -- upvalues: u2 (ref)
                u2.Boost = 0;
                u2.States.Ability = false;
            end);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.Parent = HumanoidRootPart;
            task.delay(0.05, function() -- Line: 506
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
            local ServerBallPosition = u4:GetServerBallPosition();
            local Vector3_new_ret = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z);
            local v18;

            if Vector3_new_ret:FuzzyEq(HumanoidRootPart.Position) then
                v18 = Vector3.new();
            else
                v18 = (Vector3_new_ret - HumanoidRootPart.Position).Unit;
            end;

            LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector / 5 + Vector3.new(0, 1, 0) + v18) * 60;
            u1.Ability:Fire("NeedlePass", {
                State = "Catch",
                TimeSent = workspace:GetServerTimeNow()
            });

            return;
        end;

        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil then
            Effects:Popup("Enemy player must have the ball!");
            u7:ResetCD(2);

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            Effects:Popup("Enemy player must have the ball!");
            u7:ResetCD(2);

            return;
        end;

        if not u4:LocalPlayerIsWithinDistanceOfBall(60) then
            u7:ResetCD(2);
            Effects:Popup("Must be close to the ball!");

            return;
        end;

        u2.States.Ability = true;
        u3:StopAll();
        local u19 = u3:PlayChar("Gold", "Pressure", Enum.AnimationPriority.Action3, true);
        u1.Ability:Fire("NeedlePass", {
            State = "Pressure",
            TimeSent = workspace:GetServerTimeNow()
        });
        local Shiftlock = u7.CameraController.Shiftlock;
        u7.CameraController:SetShiftlock(false);
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.MaxTorque = 40000;
        AlignOrientation.Responsiveness = 200;
        AlignOrientation.Parent = HumanoidRootPart;
        local VectorOffsetBetweenLocalPlayerAndBall = u4:GetVectorOffsetBetweenLocalPlayerAndBall();
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = VectorOffsetBetweenLocalPlayerAndBall * 4.2;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Connect(RunService.Heartbeat, function() -- Line: 565
            -- upvalues: u4 (ref), u19 (copy), u7 (copy), Shiftlock (copy), u2 (ref), VectorOffsetBetweenLocalPlayerAndBall (ref), TweenService (ref), LinearVelocity (copy)
            if u4:GetPlayerPossessingBall() == nil then
                u19:Stop(0.5);

                if not u7.CameraController.Shiftlock then
                    u7.CameraController:SetShiftlock(Shiftlock);
                end;

                u7.AC:Clean();
                task.delay(0.08333333333333333, function() -- Line: 574
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                end);

                return;
            end;

            VectorOffsetBetweenLocalPlayerAndBall = u4:GetVectorOffsetBetweenLocalPlayerAndBall();

            if VectorOffsetBetweenLocalPlayerAndBall:Dot(VectorOffsetBetweenLocalPlayerAndBall) > 25 then
                TweenService:Create(LinearVelocity, TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    VectorVelocity = VectorOffsetBetweenLocalPlayerAndBall * 0.1
                }):Play();

                return;
            end;

            TweenService:Create(LinearVelocity, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3.new(0, 0, 0)
            }):Play();
            u7.AC:Clean();

            if not u7.CameraController.Shiftlock then
                u7.CameraController:SetShiftlock(Shiftlock);
            end;

            task.delay(0.08333333333333333, function() -- Line: 599
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end);
        end);
        u7.AC:Add(AlignOrientation);
        u7.AC:Add(LinearVelocity);
        u7.AC:Add(task.delay(0.5, function() -- Line: 608
            -- upvalues: u2 (ref), u7 (copy), Shiftlock (copy)
            u2.States.Ability = false;
            u7.AC:Clean();

            if not u7.CameraController.Shiftlock then
                u7.CameraController:SetShiftlock(Shiftlock);
            end;
        end));
        local u20 = nil;
        u20 = u1.Ability:Connect(function(p21) -- Line: 617
            -- upvalues: u20 (ref), u4 (ref), u7 (copy), LocalPlayer (ref), u6 (ref), Abilities (ref), RunService (ref)
            if p21 and p21.Pressure then
                u20:Disconnect();
                task.wait(0.5);

                if u4:GetPlayerPossessingBall() then
                    return;
                end;

                u7.Pressure = true;
                u7:ResetCD(2);
                local u22 = nil;
                task.delay(1, function() -- Line: 629
                    -- upvalues: u22 (ref)
                    u22 = true;
                end);
                local u23 = 1;
                local u24 = false;
                local u25 = nil;
                local u26 = (LocalPlayer.Style.Value == "Copycat" and not u6.CharValues.InAwakening or LocalPlayer.Style.Value == "Thief") and 1 or 2;

                local function End() -- Line: 640
                    -- upvalues: LocalPlayer (ref), u7 (ref), u26 (copy), Abilities (ref), u25 (ref)
                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                        u7.CDS[u26] = tick() + Abilities.Gold[2];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u26}`].Flash.BackgroundTransparency = 1;
                    LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u26}`].AbilityName.Text = "Catch";
                    u25:Disconnect();

                    if u7.Pressure then
                        u7.Pressure = nil;
                    end;
                end;

                u25 = RunService.Heartbeat:Connect(function(p27) -- Line: 655
                    -- upvalues: u7 (ref), u22 (ref), End (copy), u4 (ref), LocalPlayer (ref), u26 (copy), u23 (ref), u24 (ref)
                    if not u7.Pressure or u22 then
                        End();

                        return;
                    end;

                    if u4:GetPlayerPossessingBall() then
                        End();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u26}`].Flash.BackgroundTransparency = u23;

                    if u23 > 0.5 and not u24 then
                        p27 = -p27 or p27;
                    end;

                    u23 = u23 + p27;

                    if u23 <= 0.5 then
                        u24 = true;
                    end;

                    if u23 >= 1 then
                        u24 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom[`Ability{u26}`].AbilityName.Text = "Catch";
                end);
            end;
        end);
        task.delay(0.5, function() -- Line: 669
            -- upvalues: u20 (ref)
            u20:Disconnect();
        end);

        return;
    end;

    u7.ChainHandles = nil;

    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
        u7.CDS[2] = u7.SecCooldown;
    end;

    u7.SecCooldown = nil;
    u2.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

    if #LocalPlayer.Team:GetPlayers() <= 1 then
        u7.CDS[4] = tick() + 35;
        Effects:Popup("No team-mates found to pass to");
        u2.States.Ability = false;

        return;
    end;

    u7.CDS[4] = tick() + 30;

    if u7:HoopDist() < 100 or #LocalPlayer.Team:GetPlayers() <= 1 then
        if #LocalPlayer.Team:GetPlayers() <= 1 then
            Effects:Popup("UNLIMITED RANGE SHOT!");
            Effects:Popup("(you have no team-mates to pass to so you get some help)");
        end;

        u1.Ability:Fire("ChainHandles", {
            Style = "Stepback",
            TimeSent = workspace:GetServerTimeNow()
        });
        u3:StopAll();
        u3:PlayChar("Gold", "ChainHandlesStepback", Enum.AnimationPriority.Action3);
        u3:PlayBall("Gold", "ChainHandlesStepbackBall", Enum.AnimationPriority.Action3);
        u2.States.AbilitiesUsable = 0;
        u2.States.AimAssist = true;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Chain Handles";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Needle Pass";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        local LinearVelocity = Instance.new("LinearVelocity");
        local _ = HumanoidRootPart.CFrame;
        u7.AC:Add(LinearVelocity);
        u7.AC:Add(task.delay(1.6, function() -- Line: 88
            -- upvalues: u2 (ref), u7 (copy)
            u2.States.Ability = false;
            u2.States.AbilitiesUsable = 0;
            u2.States.NoWalk = false;
            u2.States.AimAssist = false;
            u7.AC:Clean();
        end));
        u7.AC:Connect(u1.Ability, function() -- Line: 96
            -- upvalues: ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
            local v28 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
            local math_log_ret = math.log(1 + v28.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v28 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.17, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60
        }):Play();
        task.wait(0.17);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * -80
        }):Play();
        task.wait(0.5);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        task.wait(0.1);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -160 + Vector3.new(0, 30, 0);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * -30 + Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.5);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * -125 + Vector3.new(0, -18, 0)
        }):Play();
        task.wait(0.3);

        return;
    end;

    local LookingAt = u7.Pass.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        local v29 = nil;

        for _, v in LocalPlayer.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                if not v29 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v29 then
                    LookingAt = v.Character;
                end;

                break;
            end;
        end;
    end;

    if not LookingAt then
        Effects:Popup("No teammates to pass to!");
        u7:ResetCD(2);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(0.21666666666666667, function() -- Line: 170
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    local u30 = Essentials:ReturnRorL(u6.CharValues);
    u3:StopAll();
    u3:PlayChar("Gold", `NeedlePass{u30}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Gold", `NeedlePass{u30}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("ChainHandles", {
        Style = "Pass",
        TimeSent = workspace:GetServerTimeNow(),
        Passing = LookingAt
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    local CFrame = HumanoidRootPart.CFrame;
    u7.AC:Add(LinearVelocity);
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    task.spawn(function() -- Line: 194
        -- upvalues: TweenService (ref), LinearVelocity (copy), CFrame (copy), u30 (copy)
        TweenService:Create(LinearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = CFrame.RightVector * (u30 == "L" and -90 or 90) + CFrame.LookVector * 90
        }):Play();
        task.wait(0.1);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            VectorVelocity = CFrame.RightVector * (u30 == "L" and 5 or -5) + CFrame.LookVector * 90
        }):Play();
        task.wait(0.1);
        LinearVelocity:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function(p31, p32) -- Line: 206
        -- upvalues: u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), LookingAt (ref), u7 (copy), RunService (ref), HumanoidRootPart (copy), Character (copy)
        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Unit = (LookingAt.HumanoidRootPart.Position - Value.Position).Unit;
        local _ = (LookingAt.HumanoidRootPart.Position - Value.Position).Magnitude;
        local Position = Value.Position;
        local Position2 = LookingAt.HumanoidRootPart.Position;
        local Magnitude = (Position2 - Position).Magnitude;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity2 = Instance.new("LinearVelocity");
        LinearVelocity2.Attachment0 = Value.Root;
        LinearVelocity2.MaxForce = 40000;
        LinearVelocity2.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u7.AC:Add(LinearVelocity2);
        u7.AC:Add(task.delay(0.15, function() -- Line: 231
            -- upvalues: LinearVelocity2 (copy), Value (copy), Magnitude (ref), u7 (ref), RunService (ref), Position (ref), Position2 (ref), LookingAt (ref), HumanoidRootPart (ref), u4 (ref), Character (ref)
            LinearVelocity2.Parent = Value;
            local u33 = tick();
            local u34 = false;
            local u35 = 150;
            u7.AC:Connect(RunService.Heartbeat, function(p36) -- Line: 237
                -- upvalues: Position (ref), Value (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u34 (ref), u4 (ref), u7 (ref), Character (ref), LinearVelocity2 (ref), u33 (copy), u35 (ref)
                Position = Value.Position;
                Position2 = LookingAt.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;

                if (HumanoidRootPart.Position - Value.Position).Magnitude >= 20 then
                    u34 = true;
                end;

                if not u4:LocalPlayerIsBallNetworkOwner() then
                    u7.AC:Clean();

                    return;
                end;

                local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                if CharacterPossessingBall == Character then
                    LinearVelocity2.Parent = nil;
                end;

                if u33 + 3 < tick() or Magnitude <= 10 and LookingAt.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or CharacterPossessingBall) then
                    u7.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity2.VectorVelocity;

                    return;
                end;

                LinearVelocity2.Parent = Value;
                LinearVelocity2.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Value.Position).Unit + Vector3.new(0, 0, 0)) * (u35 * 1);
            end);
        end));
    end);
end;