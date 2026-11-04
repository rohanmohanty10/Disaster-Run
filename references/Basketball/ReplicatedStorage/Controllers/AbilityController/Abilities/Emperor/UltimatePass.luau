 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local CalculateBallTrajectory = require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 23, Name: UltimatePass
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u5 (ref), u4 (ref), u6 (ref), Effects (copy), Essentials (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy), CalculateBallTrajectory (copy), Players (copy), CameraShaker (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u5 = u7.CameraController;
    u4 = u7.BallController;
    u6 = u7.Pass;
    local u8 = LocalPlayer.Style.Value == "Copycat" and not u7.Network.CharValues.InAwakening or LocalPlayer.Style.Value == "Thief";

    if u7.EmperorsReach then
        if not u7.Network.CharValues.HasBall then
            Effects:Popup("Not usable without ball!");
            u7:ResetCD(u8 and 1 or 2);

            return;
        end;

        local v9 = u7:CheckInfront(25);

        if not v9 then
            u7:ResetCD(u8 and 1 or 2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u7.EmperorsReach = nil;
        u7:ResetCopy();
        u2.States.Ability = true;
        u2.Boost = 20;
        u7.AC:Add(function() -- Line: 57
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.Boost = 0;
        end);
        u7.AC:Add(task.delay(0.5, function() -- Line: 62
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u1.Ability:Fire("UltimatePass", {
            Style = "Dribble",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v9
        });
        u3:StopAll();
        u3:PlayChar("Emperor", `EmperorsSpinDribble{Essentials:ReturnRorL(u7.Network.CharValues)}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("Emperor", `EmperorsSpinDribble{Essentials:ReturnRorL(u7.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
        local u10 = Essentials:ReturnRorL(u7.Network.CharValues) == "L" and -1 or 1;
        local u11 = u7.AC:Add(Instance.new("LinearVelocity"));
        u11.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u11.MaxAxesForce = Vector3.new(20000, 0, 20000);
        u11.Attachment0 = HumanoidRootPart.RootAttachment;
        u11.Parent = HumanoidRootPart;
        u11.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5;
        TweenService:Create(u11, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 45 + HumanoidRootPart.CFrame.RightVector * u10 * 45
        }):Play();
        task.delay(0.25, function() -- Line: 83
            -- upvalues: TweenService (ref), u11 (copy), HumanoidRootPart (copy), u10 (copy), u2 (ref)
            TweenService:Create(u11, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = HumanoidRootPart.CFrame.LookVector * 90 + HumanoidRootPart.CFrame.RightVector * u10 * -90
            }):Play();
            u2.Boost = 0;
        end);
        local u12 = nil;
        u12 = u1.Ability:Connect(function() -- Line: 90
            -- upvalues: u12 (ref), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy)
            u12:Disconnect();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
            Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector - Vector3.new(0, 1, 0)).Unit * 60;
        end);
        u7.AC:Add(u12);

        return;
    end;

    if u7.UltimatePass then
        if u8 then
            require(script.Parent.EmperorDribble)(u7);

            return;
        end;

        if u7.Network.CharValues.HasBall then
            u7:ResetCD(2);
            Effects:Popup("Not usable with ball!");

            return;
        end;

        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil or PlayerPossessingBall.Team ~= LocalPlayer.Team then
            Effects:Popup("Teammate must have the ball!");
            u7:ResetCD(2);

            return;
        end;

        local v13 = HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

        if v13:Dot(v13) > 14400 then
            Effects:Popup("Too far away from hoop!");
            u7:ResetCD(2);

            return;
        end;

        if u4:LocalPlayerIsWithinDistanceOfBall(100) then
            u1.Ability:Fire("UltimatePass", {
                Style = "ReturnPass",
                TimeSent = workspace:GetServerTimeNow()
            });
            u7.AC:Connect(u1.Ability, function(p14) -- Line: 139
                -- upvalues: u7 (copy), Effects (ref), LocalPlayer (ref), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy), RunService (ref), Character (copy), u2 (ref), u3 (ref), Essentials (ref), TweenService (ref), u1 (ref), CalculateBallTrajectory (ref)
                u7.AC:Clean();

                if p14 then
                    u7:ResetCD(2);
                    Effects:Popup("Ball is on iframes!");

                    return;
                end;

                u7.UltimatePass = nil;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) and ((LocalPlayer.Style.Value ~= "Thief" or not u7.TotalTheft) and u7.FirstCooldown) then
                    if u7.Network.CharValues.InAwakening then
                        u7.CDS[4] = u7.FirstCooldown;
                    elseif not u7.WasInAwakening then
                        u7.CDS[1] = u7.FirstCooldown;
                    end;
                end;

                u7:ResetCopy();
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Unit = (HumanoidRootPart.Position - Value.Position).Unit;
                local _ = (HumanoidRootPart.Position - Value.Position).Magnitude;
                local Magnitude = (HumanoidRootPart.Position - Value.Position).Magnitude;
                Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Value.Root;
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                u7.AC:Add(LinearVelocity);
                u7.AC:Add(task.delay(0.15, function() -- Line: 184
                    -- upvalues: LinearVelocity (copy), Value (copy), RunService (ref), u4 (ref), HumanoidRootPart (ref), Character (ref), u7 (ref), u2 (ref), u3 (ref), Essentials (ref), LocalPlayer (ref), TweenService (ref), u1 (ref), ReplicatedStorage (ref), CalculateBallTrajectory (ref)
                    LinearVelocity.Parent = Value;
                    local u15 = tick();
                    local u16 = false;
                    local u17 = nil;
                    u17 = RunService.Heartbeat:Connect(function(p18) -- Line: 191
                        -- upvalues: u4 (ref), u17 (ref), u16 (ref), u15 (copy), Value (ref), HumanoidRootPart (ref), LinearVelocity (ref), Character (ref)
                        if not u4:LocalPlayerIsBallNetworkOwner() then
                            u17:Disconnect();

                            return;
                        end;

                        local v19 = -u4:GetVectorOffsetBetweenLocalPlayerAndBall(true);
                        local v20 = v19:Dot(v19);

                        if v20 >= 400 then
                            u16 = true;
                        end;

                        local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                        if u15 + 3 < tick() or (Value.Parent == nil or (CharacterPossessingBall or u16 and v20 <= 144)) or v20 <= 100 and HumanoidRootPart == HumanoidRootPart then
                            u17:Disconnect();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if CharacterPossessingBall == Character then
                            LinearVelocity.Parent = nil;
                        end;

                        LinearVelocity.Parent = Value;
                        LinearVelocity.VectorVelocity = v19.Unit * 120 * 1.8;
                    end);
                    u7.AC:Add(u17);
                    u2.States.Ability = true;
                    u3:PlayChar("Emperor", `UltimateLayup{Essentials:ReturnRorL(u7.Network.CharValues)}`, Enum.AnimationPriority.Action3);
                    u3:PlayBall("Emperor", `UltimateLayup{Essentials:ReturnRorL(u7.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
                    local LinearVelocity2 = Instance.new("LinearVelocity");
                    LinearVelocity2.Attachment0 = HumanoidRootPart.RootAttachment;
                    LinearVelocity2.MaxForce = (1 / 0);
                    LinearVelocity2.Parent = HumanoidRootPart;
                    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                    local Unit2 = (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Unit;
                    local Vector3_new_ret = Vector3.new(Unit2.X, 0, Unit2.Z);
                    local u21 = Essentials:ReturnRorL(u7.Network.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
                    LinearVelocity2.VectorVelocity = (Vector3_new_ret + -u21) * 45;
                    TweenService:Create(LinearVelocity2, TweenInfo.new(0.42, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        VectorVelocity = (Vector3_new_ret * 1.5 + u21) * 30
                    }):Play();
                    task.delay(0.62, function() -- Line: 244
                        -- upvalues: TweenService (ref), LinearVelocity2 (copy), Vector3_new_ret (ref), u21 (copy)
                        TweenService:Create(LinearVelocity2, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            VectorVelocity = ((Vector3_new_ret + -u21 / 1.5) / 2 + Vector3.new(0, 1, 0)) * 30
                        }):Play();
                    end);
                    task.delay(0.9, function() -- Line: 247
                        -- upvalues: TweenService (ref), LinearVelocity2 (copy), Vector3_new_ret (ref)
                        TweenService:Create(LinearVelocity2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            VectorVelocity = (Vector3_new_ret + Vector3.new(0, -0.25, 0)) * 45
                        }):Play();
                    end);
                    task.delay(1.2, function() -- Line: 250
                        -- upvalues: u2 (ref), LinearVelocity2 (copy)
                        u2.States.Ability = false;
                        LinearVelocity2:Destroy();
                    end);
                    local u22 = nil;
                    u22 = RunService.Heartbeat:Connect(function() -- Line: 255
                        -- upvalues: LinearVelocity2 (copy), u22 (ref), Hoop (copy), HumanoidRootPart (ref)
                        if LinearVelocity2 and LinearVelocity2.Parent then
                            if (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z) - HumanoidRootPart.Position).Magnitude < 10 then
                                LinearVelocity2.Enabled = false;
                                u22:Disconnect();
                            end;

                            return;
                        end;

                        u22:Disconnect();
                    end);
                    u7.AC:Connect(u1.Ability, function() -- Line: 269
                        -- upvalues: u7 (ref), ReplicatedStorage (ref), u4 (ref), CalculateBallTrajectory (ref), LocalPlayer (ref)
                        u7.AC:Clean();
                        local Value2 = ReplicatedStorage.Basketball.Value;
                        Value2.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                        Value2.AssemblyLinearVelocity = CalculateBallTrajectory(Value2.Position, workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position, 50);
                    end);
                end));
            end);

            return;
        end;

        u7:ResetCD(2);
        Effects:Popup("Must be close to the ball!");

        return;
    end;

    if not u7.Network.CharValues.HasBall then
        if u7.Network.CharValues.Blocked + 2 > tick() then
            u7:ResetCD(u8 and 1 or 2);
            Effects:Popup("Can\'t use after block!");

            return;
        end;

        u2.States.Ability = true;
        u1.Ability:Fire("UltimatePass", {
            Style = "Reach",
            TimeSent = workspace:GetServerTimeNow()
        });
        Effects:Popup("Emperor\'s Reach activated, Blocks everything while looking at opponent with ball.", 3, Color3.new(1, 0.482353, 0.482353), UDim2.new(0.65, 0, 0.25, 0));
        u7.AC:Connect(u7.AbilityService.Ability, function() -- Line: 301
            -- upvalues: u2 (ref), u7 (copy), u3 (ref), u8 (copy), RunService (ref), LocalPlayer (ref), HumanoidRootPart (copy)
            u2.States.NoWalk = true;
            u7.AC:Clean();
            u3:StopAll();
            u3:PlayChar("Emperor", "EmperorsReach", Enum.AnimationPriority.Action3);
            u3:PlayBall("Emperor", "EmperorsReachBall", Enum.AnimationPriority.Action3);
            task.delay(0.75, function() -- Line: 309
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end);
            u7.EmperorsReach = true;
            u7:ResetCD(u8 and 1 or 2);
            local u23 = 1;
            local u24 = false;
            local u25 = nil;
            u25 = RunService.Heartbeat:Connect(function(p26) -- Line: 321
                -- upvalues: u7 (ref), u25 (ref), LocalPlayer (ref), HumanoidRootPart (ref), u23 (ref), u24 (ref)
                if not u7.EmperorsReach then
                    u25:Disconnect();
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                    return;
                end;

                local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u23;

                if u23 > 0.5 and not u24 then
                    p26 = -p26 or p26;
                end;

                u23 = u23 + p26;

                if u23 <= 0.5 then
                    u24 = true;
                end;

                if u23 >= 1 then
                    u24 = false;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Emperor\'s Nutmeg";
            end);
            task.delay(4, function() -- Line: 338
                -- upvalues: u7 (ref), LocalPlayer (ref), u8 (ref), u25 (ref)
                if not (not u7.EmperorsReach or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[u8 and 1 or 2] = tick() + 65;
                end;

                u7.EmperorsReach = nil;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
                u25:Disconnect();
                u7:ResetCopy();
            end);
        end);
        task.delay(7, function() -- Line: 351
            -- upvalues: Effects (ref), u2 (ref), u7 (copy)
            Effects:Popup("Emperor\'s Reach ended, Automatic Block ended.");
            u2.States.Ability = false;
            u7:ResetCopy();
            u7.AC:Clean();
        end);

        return;
    end;

    local LookingAt = u6.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if RunService:IsStudio() then
        LookingAt = workspace.DefenseRig;
    elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        u7:ResetCD(u8 and 1 or 2);
        Effects:Popup("Must look at team-mate!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(0.85, function() -- Line: 377
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u3:PlayChar("Emperor", "UltimatePass", Enum.AnimationPriority.Action3);
    u3:PlayBall("Emperor", "UltimatePassBall", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("UltimatePass", {
        Style = "Pass",
        TimeSent = workspace:GetServerTimeNow(),
        Passing = LookingAt
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Name = "GyroBasketball";
    BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
    BodyGyro.Parent = HumanoidRootPart;
    u7.AC:Add(LinearVelocity);
    u7.AC:Add(BodyGyro);
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -50;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * -15
    }):Play();
    task.delay(0.5, function() -- Line: 407
        -- upvalues: LinearVelocity (copy), BodyGyro (copy)
        LinearVelocity:Destroy();
        BodyGyro:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function(p27, p28) -- Line: 412
        -- upvalues: u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), LookingAt (ref), u7 (copy), RunService (ref), HumanoidRootPart (copy), u8 (copy), LocalPlayer (ref), Character (copy)
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
        u7.AC:Add(task.delay(0.15, function() -- Line: 438
            -- upvalues: LinearVelocity2 (copy), Value (copy), Magnitude (ref), u7 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), HumanoidRootPart (ref), u8 (ref), LocalPlayer (ref), Character (ref)
            LinearVelocity2.Parent = Value;
            local u29 = tick();
            local u30 = false;
            local u31 = 150;
            u7.AC:Connect(RunService.Heartbeat, function(p32) -- Line: 444
                -- upvalues: Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u30 (ref), u7 (ref), Value (ref), LinearVelocity2 (ref), u29 (copy), u8 (ref), RunService (ref), LocalPlayer (ref), Character (ref), u31 (ref)
                Position = u4:GetServerBallPosition();
                Position2 = LookingAt.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;
                local Magnitude2 = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude2 >= 20 then
                    u30 = true;
                end;

                if Magnitude2 <= 12 and u30 then
                    u7.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity2.VectorVelocity;

                    return;
                end;

                if u29 + 2 < tick() or Magnitude <= 10 and LookingAt.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or u4:GetPlayerPossessingBall()) then
                    u7.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity2.VectorVelocity;

                    if u4:CharacterPossessesBall(LookingAt) then
                        u7.UltimatePass = LookingAt;

                        if u8 then
                            u7:ResetCD(1);
                        else
                            u7.WasInAwakening = u7.Network.CharValues.InAwakening;
                            u7.FirstCooldown = (u7.EmperorDribble1 or u7.EmperorDribble2) and tick() + 65 or (u7.Network.CharValues.InAwakening and u7.CDS[4] or u7.CDS[1]);
                            u7:ResetCD(1);
                            u7:ResetCD(2);
                            u7:ResetCD(4);
                        end;

                        local u33 = 1;
                        local u34 = false;
                        local u35 = nil;
                        u35 = RunService.Heartbeat:Connect(function(p36) -- Line: 504
                            -- upvalues: u7 (ref), u35 (ref), LocalPlayer (ref), u8 (ref), HumanoidRootPart (ref), u33 (ref), u34 (ref)
                            if not u7.UltimatePass then
                                u35:Disconnect();
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                                return;
                            end;

                            if u7.Network.CharValues.HasBall then
                                if not (not u7.UltimatePass or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                                    if u7.FirstCooldown then
                                        if u7.Network.CharValues.InAwakening then
                                            u7.CDS[4] = u7.FirstCooldown;
                                        elseif not u7.WasInAwakening then
                                            u7.CDS[1] = u7.FirstCooldown;
                                        end;
                                    end;

                                    u7.CDS[u8 and 1 or 2] = tick() + 65;
                                end;

                                u7.UltimatePass = nil;
                                u7.WasInAwakening = nil;
                                u7.FirstCooldown = nil;
                                u7:ResetCopy();

                                return;
                            end;

                            local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u33;

                            if not u8 then
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u33;
                            end;

                            if u33 > 0.5 and not u34 then
                                p36 = -p36 or p36;
                            end;

                            u33 = u33 + p36;

                            if u33 <= 0.5 then
                                u34 = true;
                            end;

                            if u33 >= 1 then
                                u34 = false;
                            end;

                            if u8 then
                                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Forced Shot";

                                return;
                            end;

                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Forced Shot";
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Ultimate Layup";
                        end);
                        task.delay(4, function() -- Line: 549
                            -- upvalues: u7 (ref), LocalPlayer (ref), u8 (ref), u35 (ref)
                            if not (not u7.UltimatePass or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                                if u7.FirstCooldown then
                                    if u7.Network.CharValues.InAwakening then
                                        u7.CDS[4] = u7.FirstCooldown;
                                    elseif not u7.WasInAwakening then
                                        u7.CDS[1] = u7.FirstCooldown;
                                    end;
                                end;

                                u7.CDS[u8 and 1 or 2] = tick() + 65;
                            end;

                            u7.UltimatePass = nil;
                            u7.WasInAwakening = nil;
                            u7.FirstCooldown = nil;
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
                            u35:Disconnect();
                            u7:ResetCopy();
                        end);
                    end;

                    return;
                end;

                if u4:CharacterPossessesBall(Character) then
                    LinearVelocity2.Parent = nil;
                end;

                LinearVelocity2.Parent = Value;
                LinearVelocity2.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u31 * 1);
            end);
        end));
    end);
end;