 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), TweenService (copy), Abilities (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;
    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 32
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Add(task.delay(0.4, function() -- Line: 36
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local u7 = u6.AC:Add(Instance.new("LinearVelocity"));
    u7.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u7.MaxAxesForce = Vector3.new(20000, 0, 20000);
    u7.Attachment0 = HumanoidRootPart.RootAttachment;
    u7.Parent = HumanoidRootPart;
    TweenService:Create(u7, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * -60
    }):Play();
    task.delay(0.2, function() -- Line: 47
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
    task.wait(0.4);
    u6.CounterDribble = true;
    u6:ResetCD(2);
    local u8 = nil;
    task.delay(3, function() -- Line: 57
        -- upvalues: u8 (ref)
        u8 = true;
    end);
    local u9 = 1;
    local u10 = false;
    local u11 = nil;

    local function End() -- Line: 66
        -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u5 (ref), u11 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[2] = tick() + Abilities.ChrolloV2[2];
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

        if u5.CharValues.InAwakening then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Counter";
        elseif u5.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Cloak";
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Intercept";
        end;

        u11:Disconnect();
        u6.CounterDribble = nil;
        u6:ResetCopy();
    end;

    u11 = RunService.Heartbeat:Connect(function(p12) -- Line: 90
        -- upvalues: u6 (copy), u8 (ref), End (copy), u5 (ref), LocalPlayer (ref), u9 (ref), u10 (ref)
        if not u6.CounterDribble or u8 then
            End();

            return;
        end;

        if not u5.CharValues.HasBall then
            End();

            return;
        end;

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

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Counter Dribble";
    end);
end;