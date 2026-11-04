 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u8) -- Line: 24
    -- upvalues: LocalPlayer (copy), u3 (ref), u5 (ref), u4 (ref), u6 (ref), u7 (ref), u1 (ref), u2 (ref), Effects (copy), RunService (copy), CameraShaker (copy), TweenService (copy), Zones (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), Essentials (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u3 = u8.AbilityService;
    u5 = u8.Animations;
    u4 = u8.MovementController;
    u6 = u8.BallController;
    u7 = u8.CameraController;
    u1 = u8.Network;
    u2 = u8.BallService;
    local u9 = LocalPlayer.Style.Value == "Copycat" and true or LocalPlayer.Style.Value == "Thief";

    if not u1.CharValues.HasBall then
        if not u8.Skyhand then
            u6:GetServerBallPosition();
            local v10 = Humanoid.MoveDirection * Vector3.new(60, 0, 60) + Vector3.new(0, 60 * ((Zones.JumpHeight[LocalPlayer.Zone.Value] and (u1.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2), 0);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.Parent = HumanoidRootPart;
            task.delay(0.05, function() -- Line: 364
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
            LinearVelocity.VectorVelocity = v10;
            u5:StopAll();
            u5:PlayChar("Blocks", "JumpBlock2", Enum.AnimationPriority.Action3, true):AdjustSpeed(0.5);
            u3.Ability:Fire("Skyhand", {
                State = "Block",
                TimeSent = workspace:GetServerTimeNow()
            });
            u8.AC:Add(task.delay(0.5, function() -- Line: 376
                -- upvalues: HumanoidRootPart (copy), u8 (copy)
                while HumanoidRootPart.Position.Y >= 20 do
                    task.wait();
                end;

                u8:ResetCopy();
            end));
            u8.AC:Connect(u3.Ability, function() -- Line: 384
                -- upvalues: u8 (copy), u5 (ref), Humanoid (copy), Character (copy), LocalPlayer (ref), Abilities (ref), u1 (ref), RunService (ref)
                u8.AC:Clean();
                u5:StopAll();
                u5:PlayChar("Blocks", "Blocked", Enum.AnimationPriority.Action3);
                u8.Skyhand = true;

                while (Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping) and Character.Parent do
                    task.wait();
                end;

                u8:ResetCD(1);
                local u11 = nil;
                task.delay(1, function() -- Line: 402
                    -- upvalues: u11 (ref)
                    u11 = true;
                end);
                local u12 = 1;
                local u13 = false;
                local u14 = nil;

                local function End() -- Line: 411
                    -- upvalues: u8 (ref), LocalPlayer (ref), Abilities (ref), u1 (ref), u14 (ref)
                    u8.AC:Clean();

                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
                        u8.CDS[1] = tick() + Abilities.Silver[1];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    if u1.CharValues.HasBall then
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Silver Push";
                    else
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Skyhand";
                    end;

                    u14:Disconnect();

                    if u8.Skyhand then
                        u8.Skyhand = nil;
                    end;

                    u8:ResetCopy();
                end;

                u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 435
                    -- upvalues: u8 (ref), u11 (ref), End (copy), u1 (ref), LocalPlayer (ref), u12 (ref), u13 (ref)
                    if not u8.Skyhand or u11 then
                        End();

                        return;
                    end;

                    if u1.CharValues.HasBall then
                        End();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u12;

                    if u12 > 0.5 and not u13 then
                        p15 = -p15 or p15;
                    end;

                    u12 = u12 + p15;

                    if u12 <= 0.5 then
                        u13 = true;
                    end;

                    if u12 >= 1 then
                        u13 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Juggernaut";
                end);
            end);

            return;
        end;

        u8.Skyhand = nil;
        u5:StopAll();
        u5:PlayChar("Silver", "Juggernaut", Enum.AnimationPriority.Action3);
        u3.Ability:Fire("Skyhand", {
            State = "Juggernaut",
            TimeSent = workspace:GetServerTimeNow()
        });
        local v16 = RunService.Heartbeat:Connect(function() -- Line: 329
            -- upvalues: Humanoid (copy), HumanoidRootPart (copy)
            if Humanoid.MoveDirection.X == 0 and Humanoid.MoveDirection.Z == 0 then
                HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector * Humanoid.WalkSpeed + Vector3.new(0, HumanoidRootPart.AssemblyLinearVelocity.Y, 0);
            end;
        end);
        u4.States.Ability = true;
        u4.Boost = 20;
        task.wait(1);
        u7.CamShake:Shake(CameraShaker.Presets.Dunk);
        u4.States.Ability = false;
        Humanoid.JumpHeight = Zones.JumpHeight[LocalPlayer.Zone.Value] and (u1.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2;
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        task.wait(1);
        v16:Disconnect();
        u4.Boost = 0;

        return;
    end;

    if u8.InPush then
        if u9 then
            require(script.Parent.DirtyShove)(u8);

            return;
        end;

        local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
        local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
        local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

        if Magnitude <= 25 then
            u8:ResetCD(1);
            Effects:Popup("Too close to Hoop!");

            return;
        end;

        if Magnitude >= 110 then
            u8:ResetCD(1);
            Effects:Popup("Too far away from hoop!");

            return;
        end;

        if u8.SecCooldown then
            u8.CDS[2] = u8.SecCooldown;
        end;

        u8.InPush = nil;
        u8.SecCooldown = nil;
        u4.States.Ability = true;
        u4.States.NoWalk = true;
        u4.States.AimAssist = true;
        u4.States.AbilitiesUsable = 0;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Silver Push";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Titan Smash";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        u3.Ability:Fire("Skyhand", {
            State = "Fade",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.1);
        RunService.Heartbeat:Wait();
        u8.AC:Clean();
        local Shiftlock = u7.Shiftlock;
        u7:SetShiftlock(true);
        u7.CamShake:Shake(CameraShaker.Presets.Dunk);
        u5:StopAll();
        u5:PlayChar("Silver", "PushFade", Enum.AnimationPriority.Action3);
        u5:PlayBall("Silver", "PushFadeBall", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 40;
        LinearVelocity.Parent = HumanoidRootPart;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5
        }):Play();
        task.delay(0.25, function() -- Line: 103
            -- upvalues: TweenService (ref), LinearVelocity (copy), HumanoidRootPart (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 40
            }):Play();
        end);
        task.delay(0.5833333333333334, function() -- Line: 107
            -- upvalues: LinearVelocity (copy), Zones (ref), LocalPlayer (ref), u1 (ref), HumanoidRootPart (copy), RunService (ref)
            LinearVelocity:Destroy();
            local u17 = 30;
            local u18 = 0.75 * ((Zones.JumpHeight[LocalPlayer.Zone.Value] and (u1.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "BodyVelocityBasketball";
            BodyVelocity.Parent = HumanoidRootPart;
            BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
            local u19 = tick();
            local u21 = RunService.Heartbeat:Connect(function(p20) -- Line: 120
                -- upvalues: u17 (ref), u19 (copy), BodyVelocity (copy), HumanoidRootPart (ref), u18 (ref)
                if u17 >= 10 then
                    if u19 + 0.125 < tick() then
                        BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector + Vector3.new(0, u18, 0)) * u17;
                        u18 = u18 - p20 * 1.75;
                    else
                        BodyVelocity.Velocity = -HumanoidRootPart.CFrame.LookVector * u17;
                    end;

                    u17 = u17 - p20;
                end;
            end);
            task.delay(0.5, function() -- Line: 132
                -- upvalues: u21 (ref), BodyVelocity (copy)
                if u21 then
                    u21:Disconnect();
                end;

                BodyVelocity:Destroy();
            end);
        end);
        u8.AC:Connect(u3.Ability, function() -- Line: 141
            -- upvalues: ReplicatedStorage (ref), u6 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
            local Value = ReplicatedStorage.Basketball.Value;
            local LastCharacterToPossessBall = u6:GetLastCharacterToPossessBall();
            Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
            local _ = Value.Position;
            local v22 = Hoop.Position - Value.Position;
            local v23, v24;

            if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
                v23 = v22.Magnitude * 0.0455;
                v24 = 1.35;
            else
                v23 = v22.Magnitude * 0.04;
                v24 = 0.5;
            end;

            local math_log_ret = math.log(v24 + v23);
            Value.AssemblyLinearVelocity = v22 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);
        u8.AC:Add(function() -- Line: 168
            -- upvalues: u4 (ref), u7 (ref), Shiftlock (copy)
            u4.States.Ability = false;
            u4.States.NoWalk = false;
            u4.States.AimAssist = false;
            u7:SetShiftlock(Shiftlock);
        end);
        u8.AC:Add(task.delay(1.5833333333333333, function() -- Line: 176
            -- upvalues: u8 (copy)
            u8.AC:Clean();
        end));
        task.spawn(function() -- Line: 180
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u7 (ref), CameraShaker (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5833333333333334), {
                FieldOfView = 40
            }):Play();
            task.wait(0.5833333333333334);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4666666666666667), {
                FieldOfView = 100
            }):Play();
            task.wait(0.4666666666666667);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
            u7.CamShake:Shake(CameraShaker.Presets.Ankle);
        end);

        return;
    end;

    local v25 = RunService:IsStudio();

    for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25)) then
            v25 = true;
            break;
        end;
    end;

    if not v25 then
        Effects:Popup("Enemy player must be close to you!");
        u8:ResetCD(1);

        return;
    end;

    if u8.MovementController.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u8:ResetCD(1);

        return;
    end;

    u8.InPush = true;
    u8.SecCooldown = u8.CDS[2];
    u8:ResetCD(1);
    u8:ResetCD(2);
    u4.States.Ability = true;
    u4.States.NoWalk = true;
    u4.States.AbilitiesUsable = -1;
    u5:StopAll();
    u5:PlayChar("Silver", "SilverPush", Enum.AnimationPriority.Action3);
    u5:PlayBall("Silver", "SilverPushBall", Enum.AnimationPriority.Action3);
    u3.Ability:Fire("Skyhand", {
        State = "Push",
        TimeSent = workspace:GetServerTimeNow()
    });
    local u26 = nil;
    task.delay(1.5, function() -- Line: 233
        -- upvalues: u26 (ref)
        u26 = true;
    end);
    local u27 = 1;
    local u28 = false;
    local u29 = nil;
    local u30 = nil;

    local function u31() -- Line: 243
        -- upvalues: u8 (copy), LocalPlayer (ref), Abilities (ref), u9 (copy), u1 (ref), u29 (ref), u30 (ref), u5 (ref), u4 (ref)
        u8.AC:Clean();

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
            u8.CDS[1] = tick() + Abilities.Silver[1];

            if not u9 and u8.SecCooldown then
                u8.CDS[2] = u8.SecCooldown;
            end;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

        if not u9 then
            if u1.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Silver Push";
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Titan Smash";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Skyhand";
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dirty Shove";
            end;
        end;

        u29:Disconnect();
        u30:Disconnect();

        if u8.InPush then
            u8.InPush = nil;
            u5:StopAll();
            u4.States.Ability = false;
            u4.States.NoWalk = false;
        end;

        u4.States.AbilitiesUsable = 0;
        u8:ResetCopy();
    end;

    u29 = RunService.Heartbeat:Connect(function(p32) -- Line: 283
        -- upvalues: u8 (copy), u26 (ref), u31 (copy), u1 (ref), LocalPlayer (ref), u27 (ref), u9 (copy), u28 (ref)
        if not u8.InPush or u26 then
            u31();

            return;
        end;

        if not u1.CharValues.HasBall then
            u31();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u27;

        if not u9 then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u27;
        end;

        if u27 > 0.5 and not u28 then
            p32 = -p32 or p32;
        end;

        u27 = u27 + p32;

        if u27 <= 0.5 then
            u28 = true;
        end;

        if u27 >= 1 then
            u28 = false;
        end;

        if u9 then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Dribble Push";

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Push Fade";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dribble Push";
    end);
    u30 = u3.Ability:Connect(function() -- Line: 317
        -- upvalues: u31 (copy)
        u31();
    end);
end;