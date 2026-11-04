 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u8) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Players (copy), RunService (copy), Effects (copy), CameraShaker (copy), ReplicatedStorage (copy), Zones (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.CameraController;
    u4 = u8.BallController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Network;

    if not u6.CharValues.HasBall then
        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            u8:ResetCD(2);
            Effects:Popup("Not usable in air");

            return;
        end;

        u5:StopAll();
        u5:PlayChar("Dealer", "BlinkDeal", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Blink Deal", {
            Task = "Blink Deal",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(LinearVelocity);
        task.delay(1.3333333333333333, function() -- Line: 255
            -- upvalues: u8 (copy), u2 (ref)
            u8.AC:Clean();
            u2.States.Ability = false;
        end);
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector * 90 + HumanoidRootPart.CFrame.RightVector * 60) * Vector3.new(1, 0, 1)
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.16666666666666666);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector * 90 + HumanoidRootPart.CFrame.RightVector * -60) * Vector3.new(1, 0, 1)
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.16666666666666666);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (HumanoidRootPart.CFrame.LookVector * 90 + HumanoidRootPart.CFrame.RightVector * 60) * Vector3.new(1, 0, 1)
        }):Play();

        return;
    end;

    if not u8.FalseDeal then
        if u2.States.PumpFake then
            u8:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            u8:ResetCD(2);
            Effects:Popup("Not usable in air");

            return;
        end;

        u5:StopAll();
        u5:PlayChar("Dealer", "DeckBreak", Enum.AnimationPriority.Action3);
        u5:PlayBall("Dealer", "DeckBreakBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("Blink Deal", {
            Task = "Deck Break",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2.States.Ability = true;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Parent = HumanoidRootPart;
        u8.AC:Add(LinearVelocity);
        task.delay(2.3333333333333335, function() -- Line: 205
            -- upvalues: u8 (copy), u2 (ref)
            u8.AC:Clean();
            u2.States.Ability = false;
        end);
        task.wait(0.16666666666666666);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 120 * Vector3.new(1, 0, 1)
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.4166666666666667);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * -120 * Vector3.new(1, 0, 1)
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.4166666666666667);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 120 * Vector3.new(1, 0, 1)
        }):Play();
        task.wait(0.25);
        TweenService:Create(LinearVelocity, TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            VectorVelocity = Vector3.new(0, 0, 0)
        }):Play();

        return;
    end;

    local TimePosition = u8.FalseDeal.CharAnim.TimePosition;
    local TimePosition2 = u8.FalseDeal.BallAnim.TimePosition;

    if not (not u8.SecCooldown or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
        u8.CDS[2] = u8.SecCooldown;
    end;

    u8.SecCooldown = nil;
    u8.FalseDeal = nil;
    local LookingAt = u7.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if RunService:IsStudio() then
        LookingAt = workspace:WaitForChild("DefenseRig");
    elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        local v9 = nil;

        for _, v in LocalPlayer.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                if not v9 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v9 then
                    LookingAt = v.Character;
                end;

                break;
            end;
        end;
    end;

    if not LookingAt then
        Effects:Popup("No teammates to pass to!");

        return;
    end;

    local HumanoidRootPart2 = LookingAt.HumanoidRootPart;
    u1.Ability:Fire("Blink Deal", {
        Task = "No Look Deal",
        TimeSent = workspace:GetServerTimeNow(),
        PassingTo = LookingAt,
        TimePosition = TimePosition <= 0.5 and TimePosition and TimePosition or 0.6
    });
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(0.7166666666666667, function() -- Line: 88
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u2.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "False Deal";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Deck Break";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    u5:StopAll();
    local v10 = u5:PlayChar("Dealer", "NoLookDeal", Enum.AnimationPriority.Action3, true);
    local v11 = u5:PlayBall("Dealer", "NoLookDealBall", Enum.AnimationPriority.Action3, true);

    if TimePosition <= 0.5 then
        v10.TimePosition = TimePosition;
        v11.TimePosition = TimePosition2;
    else
        v10.TimePosition = 0.6;
        v11.TimePosition = 0.6;
    end;

    u8.AC:Connect(u1.Ability, function() -- Line: 112
        -- upvalues: u3 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), Character (copy), HumanoidRootPart2 (copy), u8 (copy), RunService (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
        u3.CamShake:Shake(CameraShaker.Presets.Dunk);
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = (u4:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
        local Position = Value.Position;
        local Position2 = HumanoidRootPart2.Position;
        local Unit = (Position2 - Position).Unit;
        local Magnitude = (Position2 - Position).Magnitude;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity = Instance.new("LinearVelocity", Value);
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u8.AC:Add(LinearVelocity);
        local u12 = tick();
        local u13 = nil;
        task.delay(0.15, function() -- Line: 138
            -- upvalues: u13 (ref), RunService (ref), u4 (ref), LinearVelocity (copy), HumanoidRootPart2 (ref), u12 (copy), Value (copy), u6 (ref), Zones (ref), LocalPlayer (ref)
            u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 139
                -- upvalues: u4 (ref), u13 (ref), LinearVelocity (ref), HumanoidRootPart2 (ref), u12 (ref), Value (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
                if u4:GetPlayerPossessingBall() then
                    u13:Disconnect();
                    LinearVelocity:Destroy();

                    return;
                end;

                local ServerBallPosition = u4:GetServerBallPosition();

                if (HumanoidRootPart2.Position - ServerBallPosition).Magnitude <= 10 then
                    u13:Disconnect();
                    LinearVelocity:Destroy();

                    return;
                end;

                if u12 + 1.5 < tick() or not Value.Parent then
                    u13:Disconnect();
                    LinearVelocity:Destroy();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                local v15 = 1;

                if u6.CharValues.InZone and Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
                    v15 = v15 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
                end;

                LinearVelocity.VectorVelocity = (HumanoidRootPart2.Position - ServerBallPosition).Unit * 150 * v15;
            end);
        end);
    end);
end;