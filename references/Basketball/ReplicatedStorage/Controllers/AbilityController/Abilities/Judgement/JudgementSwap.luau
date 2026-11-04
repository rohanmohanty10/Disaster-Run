 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(script.Parent.Parent);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u6) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), Essentials (copy), TweenService (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        local v7 = u6:CheckInfront(25);
        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if PlayerPossessingBall and (PlayerPossessingBall.Team ~= LocalPlayer.Team and (PlayerPossessingBall.Character and (PlayerPossessingBall.Character:FindFirstChild("HumanoidRootPart") and (PlayerPossessingBall.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25))) then
            v7 = PlayerPossessingBall.Character;
        end;

        if v7 then
            u6:ResetCopy();
            u1.Ability:Fire("Judgement Swap", {
                State = "Judgement Swap",
                TimeSent = workspace:GetServerTimeNow(),
                Other = v7
            });

            return;
        end;

        u6:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 42
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    local u8 = 32;
    local Vector3Value = Instance.new("Vector3Value");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(Vector3Value);
    u6.AC:Add(LinearVelocity);
    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    u6.AC:Connect(RunService.Heartbeat, function(p9) -- Line: 60
        -- upvalues: u5 (ref), u4 (ref), u6 (copy), HumanoidRootPart (copy), Vector3Value (copy), LinearVelocity (copy), u8 (ref), FieldOfView (ref), Essentials (ref)
        if not u5.CharValues.HasBall then
            u4:StopAll();
            u6.AC:Clean();

            return;
        end;

        LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector + Vector3Value.Value * 3) * Vector3.new(1, 0, 1) * (u8 / 1.7);
        FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p9 * 4);
        workspace.CurrentCamera.FieldOfView = FieldOfView;
        u8 = u8 - p9 * 4;
    end);

    if u6.Dribble then
        u6.Dribble = nil;
        u6:ResetCopy();
        u1.Ability:Fire("Judgement Swap", {
            State = "Forward",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        local v10 = u4:PlayChar("Judgement", "JudgementDribbleForward", Enum.AnimationPriority.Action3, true);
        local v11 = u4:PlayBall("Judgement", "JudgementDribbleForwardBall", Enum.AnimationPriority.Action3, true);
        v10:AdjustSpeed(1.5);
        v11:AdjustSpeed(1.5);
        task.spawn(function() -- Line: 92
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector * 1.5;
            u8 = 10;
        end);
        task.delay(0.39999999999999997, function() -- Line: 96
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u8 (ref)
            Vector3Value.Value = HumanoidRootPart.CFrame.RightVector * 1.5;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u8 = 30;
        end);
        task.delay(0.6666666666666666, function() -- Line: 101
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u8 (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector * 1.25;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u8 = 30;
        end);
        task.delay(0.9333333333333332, function() -- Line: 106
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u8 (ref)
            Vector3Value.Value = HumanoidRootPart.CFrame.RightVector / 1.5;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
            u8 = 60;
        end);
        task.delay(1.4555555555555555, function() -- Line: 111
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref), TweenService (ref)
            Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector * 1.25;
            u8 = 60;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
        end);
        task.delay(1.5222222222222221, function() -- Line: 116
            -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref), TweenService (ref)
            Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
            u8 = 40;
            TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = Vector3.new(0, 0, 0)
            }):Play();
        end);
        u6.AC:Add(task.delay(2, function() -- Line: 122
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));

        return;
    end;

    u6.Dribble = true;
    u6:ResetCD(1);
    u1.Ability:Fire("Judgement Swap", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    local v12 = u4:PlayChar("Judgement", "JudgementDribble", Enum.AnimationPriority.Action3, true);
    local v13 = u4:PlayBall("Judgement", "JudgementDribbleBall", Enum.AnimationPriority.Action3, true);
    v12:AdjustSpeed(1.5);
    v13:AdjustSpeed(1.5);
    task.spawn(function() -- Line: 140
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.RightVector * 1.25;
        u8 = 20;
    end);
    task.delay(0.13333333333333333, function() -- Line: 144
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u8 (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.RightVector * 1.5;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
        u8 = 20;
    end);
    task.delay(0.39999999999999997, function() -- Line: 149
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), TweenService (ref), u8 (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.LookVector;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
        u8 = 20;
    end);
    task.delay(0.7999999999999999, function() -- Line: 154
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref), TweenService (ref)
        Vector3Value.Value = -HumanoidRootPart.CFrame.LookVector;
        u8 = 20;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    task.delay(1.0777777777777777, function() -- Line: 159
        -- upvalues: Vector3Value (copy), HumanoidRootPart (copy), u8 (ref), TweenService (ref)
        Vector3Value.Value = HumanoidRootPart.CFrame.LookVector;
        u8 = 30;
        TweenService:Create(Vector3Value, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        }):Play();
    end);
    u6.AC:Add(task.delay(1.5444444444444445, function() -- Line: 165
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local u14 = nil;
    task.delay(3, function() -- Line: 173
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    local u15 = 1;
    local u16 = false;
    local u17 = nil;

    local function End() -- Line: 182
        -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u5 (ref), u17 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[1] = tick() + Abilities.Judgement[1];
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

        if u5.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Judgement Dribble";
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Judgement Swap";
        end;

        u17:Disconnect();

        if u6.Dribble then
            u6.AC:Clean();
            u6.Dribble = nil;
            u6:ResetCopy();
        end;
    end;

    u17 = RunService.Heartbeat:Connect(function(p18) -- Line: 204
        -- upvalues: u6 (copy), u14 (ref), End (copy), u5 (ref), LocalPlayer (ref), u15 (ref), u16 (ref)
        if not u6.Dribble or u14 then
            End();

            return;
        end;

        if not u5.CharValues.HasBall then
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

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Judgement Drive";
    end);
end;