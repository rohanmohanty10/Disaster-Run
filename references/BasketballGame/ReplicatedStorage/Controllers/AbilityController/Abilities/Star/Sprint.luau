 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u7) -- Line: 20, Name: Dash
    -- upvalues: LocalPlayer (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), u6 (ref), u5 (ref), Effects (copy), RunService (copy), ReplicatedStorage (copy), TweenService (copy), Essentials (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u4 = u7.BallController;
    u1 = u7.AbilityService;
    u3 = u7.Animations;
    u2 = u7.MovementController;
    u6 = u7.CameraController;
    u5 = u7.Network;

    if u5.CharValues.InAwakening and LocalPlayer.Style.Value ~= "Thief" then
        if not u7.StarDrive then
            if not u5.CharValues.HasBall then
                u7:ResetCD(2);
                Effects:Popup("Not usable without ball!");
                u7.StarDrive = nil;

                return;
            end;

            u7.StarDrive = true;
            u7.Passes = 5;
            u3:StopAll();
            u2.States.Ability = true;
            u1.Ability:Fire("Sprint", {
                Drive = true,
                TimeSent = workspace:GetServerTimeNow()
            });
            u7.AC:Connect(u7.AbilityService.Ability, function() -- Line: 190
                -- upvalues: u7 (copy), Effects (ref)
                u7.AC:Clean();
                u7:ResetCD(2);
                Effects:Popup("Use ability again to force passes at you!");
            end);

            return;
        end;

        if u5.CharValues.HasBall then
            u7:ResetCD(2);
            Effects:Popup("Not usable with ball!");

            return;
        end;

        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if PlayerPossessingBall == nil or PlayerPossessingBall.Team ~= LocalPlayer.Team then
            u7:ResetCD(2);
            Effects:Popup("Ball must be on team-mate!");

            return;
        end;

        u1.Ability:Fire("Sprint", {
            Pass = true,
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.Passes = u7.Passes - 1;
        u2.States.Ability = true;
        local Passes = u7.Passes;
        local u8 = 1;
        local u9 = false;
        local u10 = nil;
        u10 = RunService.Heartbeat:Connect(function(p11) -- Line: 62
            -- upvalues: u7 (copy), Passes (copy), u10 (ref), LocalPlayer (ref), u5 (ref), u8 (ref), u9 (ref)
            if u7.Passes ~= Passes then
                u10:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            if u7.Passes <= 0 then
                u10:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u7.StarDrive then
                u10:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u5.CharValues.InAwakening then
                u10:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u8;

            if u8 > 0.5 and not u9 then
                p11 = -p11 or p11;
            end;

            u8 = u8 + p11;

            if u8 <= 0.5 then
                u9 = true;
            end;

            if u8 >= 1 then
                u9 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Star Pass";
        end);
        u7.AC:Connect(u7.AbilityService.Ability, function() -- Line: 76
            -- upvalues: u2 (ref), ReplicatedStorage (ref), HumanoidRootPart (copy), u4 (ref), RunService (ref), u5 (ref), u7 (copy), LocalPlayer (ref), u3 (ref), u1 (ref), Effects (ref)
            u2.States.Ability = false;
            local Value = ReplicatedStorage.Basketball.Value;
            local u12 = HumanoidRootPart;
            local ServerBallPosition = u4:GetServerBallPosition();
            local Unit = (u12.Position - ServerBallPosition).Unit;
            local _ = (u12.Position - ServerBallPosition).Magnitude;
            local u13 = ServerBallPosition;
            local u14 = u12.Position + u12.AssemblyLinearVelocity * 0.1;
            local Magnitude = (u14 - u13).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            task.delay(0.05, function() -- Line: 99
                -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), RunService (ref), u13 (ref), u4 (ref), u14 (ref), u12 (copy), HumanoidRootPart (ref), u5 (ref), u7 (ref), LocalPlayer (ref), u2 (ref), u3 (ref), u1 (ref), Effects (ref)
                local u15 = nil;
                LinearVelocity.Parent = Value;
                local u16 = tick();
                local math_clamp_ret = math.clamp(Magnitude, 65, 120);
                u15 = RunService.Heartbeat:Connect(function(p17) -- Line: 105
                    -- upvalues: u13 (ref), u4 (ref), u14 (ref), u12 (ref), Magnitude (ref), u16 (copy), HumanoidRootPart (ref), Value (ref), u15 (ref), LinearVelocity (ref), u5 (ref), u7 (ref), LocalPlayer (ref), u2 (ref), u3 (ref), u1 (ref), Effects (ref), math_clamp_ret (ref)
                    u13 = u4:GetServerBallPosition();
                    u14 = u12.Position;
                    Magnitude = (u14 - u13).Magnitude;

                    if not (u16 + 1.5 < tick() or Magnitude <= 15 and u12 == HumanoidRootPart or (Magnitude <= 3 or (Value.Parent == nil or u4:GetPlayerPossessingBall()))) then
                        LinearVelocity.VectorVelocity = ((u12.Position - u13).Unit + Vector3.new(0, Magnitude / math_clamp_ret / 2.2 - 0.05, 0)) * (math_clamp_ret * 1.725);

                        return;
                    end;

                    u15:Disconnect();
                    LinearVelocity:Destroy();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;
                    task.delay(0.5, function() -- Line: 121
                        -- upvalues: u5 (ref), u7 (ref), LocalPlayer (ref), u2 (ref), u3 (ref), u1 (ref), Effects (ref)
                        if not u5.CharValues.HasBall then
                            Effects:Popup("Didn\'t catch ball, ability ended!");
                            u7.Passes = 0;
                            u7.StarDrive = nil;
                            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                            return;
                        end;

                        if u7:HoopDist() <= 50 then
                            u7.Passes = 0;
                            u7.StarDrive = nil;

                            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                                u7.CDS[2] = tick() + 80;
                            end;

                            u2.States.Ability = true;
                            task.delay(5, function() -- Line: 134
                                -- upvalues: u2 (ref)
                                u2.States.Ability = false;
                            end);
                            u3:StopAll();
                            u1.Ability:Fire("Sprint", {
                                Dunk = true,
                                TimeSent = workspace:GetServerTimeNow()
                            });
                            u7.AC:Connect(u7.AbilityService.Ability, function() -- Line: 144
                                -- upvalues: u7 (ref), u2 (ref)
                                u7.AC:Clean();
                                u2.States.Ability = false;
                            end);
                        end;

                        if u7.Passes > 0 then
                            u7:ResetCD(2);
                            Effects:Popup((`Caught pass! {tostring(u7.Passes)} passes left!`));

                            return;
                        end;

                        Effects:Popup("Ability ended!");
                        u7.Passes = 0;
                        u7.StarDrive = nil;

                        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                            u7.CDS[2] = tick() + 80;
                        end;

                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
                    end);
                end);
            end);
        end);

        return;
    end;

    if not u5.CharValues.HasBall then
        u2.States.Ability = true;
        u3:StopAll();
        u3:PlayChar("Star", "Ability2", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Sprint", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u7.AC:Add(function() -- Line: 355
            -- upvalues: u2 (ref), u5 (ref), u3 (ref), Essentials (ref)
            u2.States.Ability = false;
            u2.Boost = 0;

            if u5.CharValues.HasBall == false then
                return;
            end;

            u3:StopAll();
            u3:PlayChar("Blocks", `Steal{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action2);
            u3:PlayBall("Blocks", `Steal{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action2);
        end);
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        local u18 = FieldOfView;
        local u19 = tick();
        local _ = HumanoidRootPart.CFrame.LookVector;
        local u20 = 40;
        local u21 = 1;
        local u22 = tick();
        u7.AC:Connect(RunService.Heartbeat, function(p23) -- Line: 378
            -- upvalues: u19 (copy), u7 (copy), u5 (ref), u18 (ref), Essentials (ref), FieldOfView (copy), HumanoidRootPart (copy), u22 (copy), u21 (ref), u20 (ref), u2 (ref), Character (copy)
            if u19 + 4 < tick() then
                u7.AC:Clean();

                return;
            end;

            if u5.CharValues.HasBall then
                u7.AC:Clean();

                return;
            end;

            if u5.CharValues.Stunned then
                u7.AC:Clean();

                return;
            end;

            if u19 + 0.2 > tick() then
                u18 = Essentials:Lerp(u18, 40, p23 * 5);
            else
                u18 = Essentials:Lerp(u18, FieldOfView + HumanoidRootPart.AssemblyLinearVelocity.Magnitude / 1.25, p23 * 12);
            end;

            workspace.CurrentCamera.FieldOfView = u18;

            if u19 + 0.2 > tick() then
                return;
            end;

            if u22 + 4 - tick() > 0.75 then
                u21 = u21 + p23 * 6;
                u20 = u20 + p23 * u21;
            else
                u21 = u21 - p23 * 125;
                u20 = u20 + p23 * u21;
            end;

            if u20 >= 50 then
                u20 = 50;
            end;

            u2.Boost = u20 / 3;

            if Character.IsRagdoll.Value or (u5.CharValues.HasBall or u22 + 4 < tick()) then
                u7.AC:Clean();
            end;
        end);

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u7:ResetCD(2);

        return;
    end;

    if Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Character.Humanoid.FloorMaterial == Enum.Material.Air then
        Effects:Popup("Can\'t use in air!");
        u7:ResetCD(2);

        return;
    end;

    local v24 = u7:CheckInfront(28);

    if not v24 then
        u2.States.Ability = true;
        u7.AC:Add(function() -- Line: 206
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u3:StopAll();
        u3:PlayChar("Star", "DirectDrive", Enum.AnimationPriority.Action3);
        u3:PlayBall("Star", "DirectDriveBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Sprint", {
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.1);
        RunService.Heartbeat:Wait();
        tick();
        tick();
        local u25 = 32;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = 20000;
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        RaycastParams.new();
        local Vector3Value = Instance.new("Vector3Value");
        u7.AC:Add(Vector3Value);
        Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
        local Vector3Value2 = Instance.new("Vector3Value");
        u7.AC:Add(Vector3Value2);
        u7.AC:Add(task.delay(2, function() -- Line: 244
            -- upvalues: u7 (copy), LocalPlayer (ref), HumanoidRootPart (copy)
            u7.AC:Clean();

            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 5 and (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude <= 35 then
                u7.BallController:Dunk("OneHandHanging", "OneHandHanging");
            end;
        end));
        task.delay(0.12, function() -- Line: 255
            -- upvalues: Vector3Value2 (copy), HumanoidRootPart (copy), u25 (ref)
            Vector3Value2.Value = -HumanoidRootPart.CFrame.RightVector / 1.125;
            u25 = 30;
        end);
        task.delay(0.23, function() -- Line: 259
            -- upvalues: Vector3Value2 (copy), HumanoidRootPart (copy), TweenService (ref), u25 (ref)
            Vector3Value2.Value = HumanoidRootPart.CFrame.RightVector * 1.1;
            TweenService:Create(Vector3Value2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u25 = 45;
        end);
        task.delay(0.93, function() -- Line: 264
            -- upvalues: Vector3Value2 (copy), HumanoidRootPart (copy), TweenService (ref), u25 (ref)
            Vector3Value2.Value = -HumanoidRootPart.CFrame.RightVector / 2;
            TweenService:Create(Vector3Value2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u25 = 40;
        end);
        task.delay(1.3, function() -- Line: 269
            -- upvalues: Vector3Value2 (copy), HumanoidRootPart (copy), u25 (ref)
            Vector3Value2.Value = HumanoidRootPart.CFrame.LookVector;
            u25 = 50;
        end);
        task.delay(1.53, function() -- Line: 273
            -- upvalues: Vector3Value2 (copy), HumanoidRootPart (copy), u25 (ref)
            Vector3Value2.Value = -HumanoidRootPart.CFrame.RightVector / 2;
            u25 = 35;
        end);
        task.delay(1.63, function() -- Line: 277
            -- upvalues: u25 (ref), TweenService (ref), Vector3Value2 (copy)
            u25 = 60;
            TweenService:Create(Vector3Value2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
        end);
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        u7.AC:Connect(RunService.Heartbeat, function(p26) -- Line: 284
            -- upvalues: u5 (ref), u3 (ref), u7 (copy), Vector3Value (copy), HumanoidRootPart (copy), Vector3Value2 (copy), LinearVelocity (ref), u25 (ref), FieldOfView (ref), Essentials (ref)
            if not u5.CharValues.HasBall then
                u3:StopAll();
                u7.AC:Clean();

                return;
            end;

            Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
            local v27 = Vector3Value;
            v27.Value = v27.Value + Vector3Value2.Value * 3;
            Vector3Value.Value = Vector3.new(Vector3Value.Value.X, 0, Vector3Value.Value.Z);
            LinearVelocity.VectorVelocity = Vector3Value.Value * (u25 / 1.7);
            FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p26 * 4);
            workspace.CurrentCamera.FieldOfView = FieldOfView;
            u25 = u25 - p26 * 4;
        end);

        return;
    end;

    u2.States.Ability = true;
    u7.AC:Add(function() -- Line: 301
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u7.AC:Add(task.delay(0.7, function() -- Line: 304
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end));
    u1.Ability:Fire("Sprint", {
        Style = "Dribbling",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v24
    });
    u3:StopAll();
    u3:PlayChar("Star", "DDVar1Start", Enum.AnimationPriority.Action3, false);
    u3:PlayBall("Star", "DDVar1StartBall", Enum.AnimationPriority.Action3, false);
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
    local v28 = Essentials:ReturnRorL(u5.CharValues) == "L" and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector;
    local Unit = (v24.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
    local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);
    LinearVelocity.VectorVelocity = Vector3_new_ret * 30;
    task.wait(0.2);
    u3:StopAll();
    u3:PlayChar("Star", "DDVar1Dash", Enum.AnimationPriority.Action3, false);
    u3:PlayBall("Star", "DDVar1DashBall", Enum.AnimationPriority.Action3, false);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = ((v24.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit + v28 * 1.5) * 40
    }):Play();
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (Vector3_new_ret * 1.5 + -v28 * 1.05) * 50
    }):Play();
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = Vector3_new_ret * 40
    }):Play();
    task.wait(0.2);
    u7.AC:Clean();
end;