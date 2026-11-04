 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), RunService (copy), Zones (copy), TweenService (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u7.Isolation then
        if u7.MagicDrive then
            u1.Ability:Fire("Isolation", {
                Task = "Magic Drive Shot",
                TimeSent = workspace:GetServerTimeNow()
            });
            u2.States.Ability = true;
            u2.States.NoWalk = true;
            u7.AC:Add(function() -- Line: 177
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end);
            u7.AC:Connect(u1.Ability, function(p8) -- Line: 182
                -- upvalues: u5 (ref), Zones (ref), LocalPlayer (ref), u6 (ref), HumanoidRootPart (copy), Character (copy), RunService (ref), TweenService (ref), workspace_CurrentCamera (ref), u7 (copy), ReplicatedStorage (ref)
                if not p8 then
                    return;
                end;

                if not p8.Number then
                    if p8.Pos2 then
                        u7.AC:Clean();
                        local Pos2 = p8.Pos2;
                        local Value = ReplicatedStorage.Basketball.Value;
                        Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;
                        local Magnitude = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;

                        if Magnitude <= 115 then
                            Pos2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
                        end;

                        local v9 = Pos2 - Value.Position;
                        local v10, v11;

                        if Magnitude <= 30 then
                            v10 = v9.Magnitude * 0.0455;
                            v11 = 1.35;
                        else
                            v10 = v9.Magnitude * 0.04;
                            v11 = 0.5;
                        end;

                        local math_log_ret = math.log(v11 + v10);
                        Value.AssemblyLinearVelocity = v9 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
                    end;

                    return;
                end;

                local v12 = p8.Speed or 1;
                u5:StopAll();
                local v13 = u5:PlayChar("LukaDoncic", `MagicDriveShot{p8.Number}`, Enum.AnimationPriority.Action3, true);
                local v14 = u5:PlayBall("LukaDoncic", `MagicDriveShot{p8.Number}Ball`, Enum.AnimationPriority.Action3, true);
                v13:AdjustSpeed(v12);
                v14:AdjustSpeed(v12);
                local u15 = 30;
                local u16 = (Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2;
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Name = "BodyVelocityBasketball";
                BodyVelocity.Parent = HumanoidRootPart;
                BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret.FilterDescendantsInstances = { Character };
                local u17 = tick();
                local v20 = RunService.Heartbeat:Connect(function(p18) -- Line: 209
                    -- upvalues: HumanoidRootPart (ref), RaycastParams_new_ret (copy), u15 (ref), u17 (copy), BodyVelocity (copy), u16 (ref)
                    local v19 = workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * 4, RaycastParams_new_ret);

                    if u15 >= 10 then
                        if u17 + 0.125 < tick() then
                            BodyVelocity.Velocity = ((v19 and not v19.Instance.Parent:FindFirstChild("Humanoid") and Vector3.new(0, 0, 0) or (HumanoidRootPart.CFrame.LookVector or Vector3.new(0, 0, 0))) + Vector3.new(0, u16, 0)) * u15;
                            u16 = u16 - p18 * 1.75;
                        else
                            BodyVelocity.Velocity = ((v19 and not v19.Instance.Parent:FindFirstChild("Humanoid") and Vector3.new(0, 0, 0) or (HumanoidRootPart.CFrame.LookVector or Vector3.new(0, 0, 0))) + Vector3.new(0, 0, 0)) * u15;
                        end;

                        u15 = u15 - p18;
                    end;
                end);

                if p8.Number == 1 then
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.7333333333333333), {
                        FieldOfView = 100
                    }):Play();
                    task.wait(0.7333333333333333 / v12);

                    if v20 then
                        v20:Disconnect();
                    end;

                    BodyVelocity:Destroy();
                elseif p8.Number == 2 then
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6166666666666667), {
                        FieldOfView = 100
                    }):Play();
                    task.wait(0.6166666666666667 / v12);
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.26666666666666666 / v12), {
                        FieldOfView = 80
                    }):Play();
                    task.wait(0.26666666666666666);
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.13333333333333333), {
                        FieldOfView = 100
                    }):Play();
                    task.wait(0.13333333333333333 / v12);

                    if v20 then
                        v20:Disconnect();
                    end;

                    BodyVelocity:Destroy();
                end;

                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                    FieldOfView = 70
                }):Play();
            end);

            return;
        end;

        u1.Ability:Fire("Isolation", {
            Task = "Isolation",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u5:PlayChar("LukaDoncic", "Isolation", Enum.AnimationPriority.Action3);
        u5:PlayBall("LukaDoncic", "IsolationBall", Enum.AnimationPriority.Action3);
        u7.Isolation = true;
        u7.SecCooldown = u7.CDS[2];
        u7:ResetCD(1);
        u7:ResetCD(2);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AbilitiesUsable = -1;
        u7.AC:Add(function() -- Line: 297
            -- upvalues: u2 (ref), u1 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.States.AbilitiesUsable = 0;
            u1.Ability:Fire("Isolation", {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow()
            });
        end);
        local u21 = nil;
        u7.AC:Add(task.delay(2, function() -- Line: 306
            -- upvalues: u7 (copy), u21 (ref)
            u7.AC:Clean();
            u21 = true;
        end));
        local u22 = 1;
        local u23 = false;
        local u24 = nil;
        u24 = RunService.Heartbeat:Connect(function(p25) -- Line: 315
            -- upvalues: u7 (copy), u24 (ref), LocalPlayer (ref), u6 (ref), u21 (ref), Abilities (ref), u22 (ref), u23 (ref)
            if not u7.Isolation then
                u24:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u6.CharValues.HasBall or u21 then
                u24:Disconnect();
                u7.AC:Clean();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Abilities.LukaDoncic[1];
                    u7.CDS[2] = u7.SecCooldown;
                end;

                u7.SecCooldown = nil;
                u7.Isolation = nil;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u22;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u22;

            if u22 > 0.5 and not u23 then
                p25 = -p25 or p25;
            end;

            u22 = u22 + p25;

            if u22 <= 0.5 then
                u23 = true;
            end;

            if u22 >= 1 then
                u23 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Stepback";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Magic Drive";
        end);

        return;
    end;

    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
        u7.CDS[2] = u7.SecCooldown;
    end;

    u7.SecCooldown = nil;
    u7.Isolation = nil;
    u1.Ability:Fire("Isolation", {
        Task = "Stepback",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    u2.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Isolation";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Luka Illusion";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    task.wait(0.1);
    RunService.Heartbeat:Wait();
    u7.AC:Clean();
    local Shiftlock = u4.Shiftlock;
    u4:SetShiftlock(true);
    local u26 = 1;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
        u26 = u26 + 0.15;
    end;

    u5:StopAll();
    local v27 = u5:PlayChar("LukaDoncic", "Stepback", Enum.AnimationPriority.Action3, true);
    local v28 = u5:PlayBall("LukaDoncic", "StepbackBall", Enum.AnimationPriority.Action3, true);
    v27:AdjustSpeed(u26);
    v28:AdjustSpeed(u26);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 60;
    LinearVelocity.Parent = HumanoidRootPart;
    TweenService:Create(LinearVelocity, TweenInfo.new(0.6666666666666666 / u26, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = Vector3.new(0, 0, 0)
    }):Play();
    task.delay(0.6666666666666666 / u26, function() -- Line: 81
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
    task.delay(1.15 / u26, function() -- Line: 85
        -- upvalues: HumanoidRootPart (copy), RunService (ref), u26 (ref)
        local u29 = 30;
        local u30 = 0.75;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BodyVelocityBasketball";
        BodyVelocity.Parent = HumanoidRootPart;
        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
        local u31 = tick();
        local u33 = RunService.Heartbeat:Connect(function(p32) -- Line: 96
            -- upvalues: u29 (ref), u31 (copy), BodyVelocity (copy), HumanoidRootPart (ref), u30 (ref)
            if u29 >= 10 then
                if u31 + 0.125 < tick() then
                    BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, u30, 0)) * u29;
                    u30 = u30 - p32 * 1.75;
                else
                    BodyVelocity.Velocity = -HumanoidRootPart.CFrame.LookVector * u29;
                end;

                u29 = u29 - p32;
            end;
        end);
        task.delay(0.8333333333333334 / u26, function() -- Line: 108
            -- upvalues: u33 (ref), BodyVelocity (copy)
            if u33 then
                u33:Disconnect();
            end;

            BodyVelocity:Destroy();
        end);
    end);
    u7.AC:Connect(u1.Ability, function(p34) -- Line: 117
        -- upvalues: ReplicatedStorage (ref), Character (copy), HumanoidRootPart (copy), LocalPlayer (ref)
        if not (p34 and p34.Pos2) then
            return;
        end;

        local Pos2 = p34.Pos2;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;
        local Magnitude = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;

        if Magnitude <= 115 then
            Pos2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        end;

        local v35 = Pos2 - Value.Position;
        local v36, v37;

        if Magnitude <= 30 then
            v36 = v35.Magnitude * 0.0455;
            v37 = 1.35;
        else
            v36 = v35.Magnitude * 0.04;
            v37 = 0.5;
        end;

        local math_log_ret = math.log(v37 + v36);
        Value.AssemblyLinearVelocity = v35 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
    u7.AC:Add(function() -- Line: 150
        -- upvalues: u2 (ref), u4 (ref), Shiftlock (copy)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
        u4:SetShiftlock(Shiftlock);
    end);
    u7.AC:Add(task.delay(2.466666666666667 / u26, function() -- Line: 158
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    task.spawn(function() -- Line: 162
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u26 (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6666666666666666 / u26), {
            FieldOfView = 50
        }):Play();
        task.wait(1.15 / u26);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6), {
            FieldOfView = 100
        }):Play();
        task.wait(0.6 / u26);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
    end);
end;