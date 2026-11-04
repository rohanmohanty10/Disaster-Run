 
 

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
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), RunService (copy), Zones (copy), TweenService (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;

    if not u7.FalseDeal then
        u1.Ability:Fire("False Deal", {
            Task = "False Deal",
            TimeSent = workspace:GetServerTimeNow()
        });
        u5:StopAll();
        u7.FalseDeal = {
            CharAnim = u5:PlayChar("Dealer", "FalseDeal", Enum.AnimationPriority.Action3, true),
            BallAnim = u5:PlayBall("Dealer", "FalseDealBall", Enum.AnimationPriority.Action3, true)
        };
        u7.SecCooldown = u7.CDS[2];
        u7:ResetCD(1);
        u7:ResetCD(2);
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u2.States.AbilitiesUsable = -1;
        u7.AC:Add(task.delay(2, function() -- Line: 167
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end));
        u7.AC:Add(function() -- Line: 172
            -- upvalues: LocalPlayer (ref), u7 (copy), Abilities (ref), u2 (ref), u1 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                u7.CDS[1] = tick() + Abilities.Dealer[1];
            end;

            u2.States.Ability = false;
            u2.States.NoWalk = false;
            u2.States.AbilitiesUsable = 0;
            u1.Ability:Fire("False Deal", {
                Task = "Cleanup",
                TimeSent = workspace:GetServerTimeNow()
            });
        end);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u7.AC:Add(LinearVelocity);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -50;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * -15
        }):Play();
        task.delay(0.5, function() -- Line: 194
            -- upvalues: LinearVelocity (copy)
            LinearVelocity:Destroy();
        end);
        local u8 = nil;
        u7.AC:Add(task.delay(3, function() -- Line: 199
            -- upvalues: u7 (copy), u8 (ref)
            u7.AC:Clean();
            u8 = true;
        end));
        local u9 = 1;
        local u10 = false;
        local u11 = nil;
        u11 = RunService.Heartbeat:Connect(function(p12) -- Line: 208
            -- upvalues: u7 (copy), u11 (ref), LocalPlayer (ref), u6 (ref), u8 (ref), Abilities (ref), u9 (ref), u10 (ref)
            if not u7.FalseDeal then
                u11:Disconnect();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "False Deal";

                if u6.CharValues.HasBall then
                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Deck Break";

                    return;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Blink Deal";

                return;
            end;

            if not u6.CharValues.HasBall or u8 then
                u11:Disconnect();
                u7.AC:Clean();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
                    u7.CDS[1] = tick() + Abilities.Dealer[1];

                    if u7.SecCooldown then
                        u7.CDS[2] = u7.SecCooldown;
                    end;
                end;

                u7.SecCooldown = nil;
                u7.FalseDeal = nil;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u9;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u9;

            if u9 > 0.5 and not u10 then
                p12 = -p12 or p12;
            end;

            u9 = u9 + p12;

            if u9 <= 0.5 then
                u10 = true;
            end;

            if u9 >= 1 then
                u10 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "High Stakes";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "No Look Deal";
        end);

        return;
    end;

    if not (not u7.SecCooldown or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
        u7.CDS[2] = u7.SecCooldown;
    end;

    u7.SecCooldown = nil;
    u7.FalseDeal = nil;
    u1.Ability:Fire("False Deal", {
        Task = "High Stakes",
        TimeSent = workspace:GetServerTimeNow()
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AimAssist = true;
    task.delay(2.0833333333333335, function() -- Line: 49
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.AimAssist = false;
    end);
    u2.States.AbilitiesUsable = 0;
    task.wait(0.1);
    RunService.Heartbeat:Wait();
    u7.AC:Clean();
    local _ = u4.Shiftlock;
    u4:SetShiftlock(true);
    local u13 = 1;

    if Zones.ZoneIncreasedShootingSpeed[LocalPlayer.Zone.Value] and u6.CharValues.InZone then
        u13 = u13 + 0.15;
    end;

    u5:StopAll();
    local v14 = u5:PlayChar("Dealer", "HighStakes", Enum.AnimationPriority.Action3, true);
    local v15 = u5:PlayBall("Dealer", "HighStakesBall", Enum.AnimationPriority.Action3, true);
    v14:AdjustSpeed(u13);
    v15:AdjustSpeed(u13);
    task.spawn(function() -- Line: 75
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u13 (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5 / u13), {
            FieldOfView = 50
        }):Play();
        task.wait(0.75 / u13);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6), {
            FieldOfView = 100
        }):Play();
        task.wait(0.6 / u13);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
    end);
    task.wait(0.5 / u13);
    local u16 = 30;
    local u17 = 1.15 * ((Zones.JumpHeight[LocalPlayer.Zone.Value] and (u6.CharValues.InZone and Zones.JumpHeight[LocalPlayer.Zone.Value]) or 7.2) / 7.2);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local u18 = tick();
    local u20 = RunService.Heartbeat:Connect(function(p19) -- Line: 95
        -- upvalues: u16 (ref), u18 (copy), BodyVelocity (copy), HumanoidRootPart (copy), u17 (ref)
        if u16 >= 10 then
            if u18 + 0.125 < tick() then
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, u17, 0)) * u16;
                u17 = u17 - p19 * 1.75;
            else
                BodyVelocity.Velocity = (-HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, 0, 0)) * u16;
            end;

            u16 = u16 - p19;
        end;
    end);
    task.delay(1 / u13, function() -- Line: 107
        -- upvalues: u20 (ref), BodyVelocity (copy)
        if u20 then
            u20:Disconnect();
        end;

        BodyVelocity:Destroy();
    end);
    u7.AC:Connect(u1.Ability, function(p21) -- Line: 115
        -- upvalues: u7 (copy), ReplicatedStorage (ref), Character (copy), HumanoidRootPart (copy), LocalPlayer (ref)
        u7.AC:Clean();

        if not (p21 and p21.Pos2) then
            return;
        end;

        local Pos2 = p21.Pos2;
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = Character.PlrBall.Anims.BALL.CFrame;
        local Magnitude = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;

        if Magnitude <= 115 then
            Pos2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        end;

        local v22 = Pos2 - Value.Position;
        local v23, v24;

        if Magnitude <= 30 then
            v23 = v22.Magnitude * 0.0455;
            v24 = 1.35;
        else
            v23 = v22.Magnitude * 0.04;
            v24 = 0.5;
        end;

        local v25 = math.log(v24 + v23) * 1.4142135623730951;
        Value.AssemblyLinearVelocity = v22 / v25 + Vector3.new(0, workspace.Gravity * v25 * 0.5, 0);
    end);
end;