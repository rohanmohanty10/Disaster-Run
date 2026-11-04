 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u8, p9) -- Line: 21, Name: ChainHandles
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), RunService (copy), TweenService (copy), u7 (ref)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u8.AbilityService;
    u3 = u8.Animations;
    u2 = u8.MovementController;
    u4 = u8.BallController;
    u5 = u8.CameraController;
    u6 = u8.Network;

    if u2.States.PumpFake then
        u8:ResetCD(4);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if not u8.ChainHandles then
        u8.ChainHandles = true;
        u8.SecCooldown = u8.CDS[2];

        if #LocalPlayer.Team:GetPlayers() >= 2 then
            u8:ResetCD(2);
        end;

        u8:ResetCD(4);
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = -1;
        u2.States.NoWalk = true;
        u1.Ability:Fire("ChainHandles", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u3:StopAll();
        local v10 = u3:PlayChar("Gold", "ChainHandles", Enum.AnimationPriority.Action3, true);
        u3:PlayBall("Gold", "ChainHandlesBall", Enum.AnimationPriority.Action3);

        if u7 then
            u7:Disconnect();
        end;

        u7 = v10.Stopped:Connect(function() -- Line: 145
            -- upvalues: LocalPlayer (ref)
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        end);
        task.delay(4, function() -- Line: 150
            -- upvalues: u8 (copy), LocalPlayer (ref), u2 (ref)
            if u8.ChainHandles then
                u8.AC:Clean();

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
                    u8.CDS[2] = u8.SecCooldown;
                end;

                u8.SecCooldown = nil;
                u8.ChainHandles = nil;
                u2.States.Ability = false;
                u2.States.AbilitiesUsable = 0;
                u2.States.NoWalk = false;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
                u8.CDS[4] = tick() + 30;
            end;
        end);

        if #LocalPlayer.Team:GetPlayers() <= 1 then
            task.delay(4, function() -- Line: 170
                -- upvalues: u2 (ref)
                u2.States.NoWalk = false;
            end);
        end;

        for i = 1, #LocalPlayer.Team:GetPlayers() >= 2 and 2 or 1 do
            local u11 = i == 1 and LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1 or LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2;
            local u12 = 1;
            local u13 = false;
            u8.AC:Connect(RunService.Heartbeat, function(p14) -- Line: 181
                -- upvalues: u6 (ref), u11 (copy), u12 (ref), u13 (ref), i (copy)
                if not u6.CharValues.HasBall then
                    u11.Flash.BackgroundTransparency = 1;

                    return;
                end;

                u11.Flash.BackgroundTransparency = u12;

                if u12 > 0.5 and not u13 then
                    p14 = -p14 or p14;
                end;

                u12 = u12 + p14;

                if u12 <= 0.5 then
                    u13 = true;
                end;

                if u12 >= 1 then
                    u13 = false;
                end;

                u11.AbilityName.Text = i == 1 and "Drive" or "Fake Drive";
            end);
            local _ = i;
        end;

        return;
    end;

    u8.ChainHandles = nil;

    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
        u8.CDS[2] = u8.SecCooldown;
    end;

    u8.SecCooldown = nil;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    u1.Ability:Fire("ChainHandles", {
        Style = "Drive",
        TimeSent = workspace:GetServerTimeNow()
    });
    u3:StopAll();
    u3:PlayChar("Gold", "ChainHandlesDrive", Enum.AnimationPriority.Action3);
    u3:PlayBall("Gold", "ChainHandlesDriveBall", Enum.AnimationPriority.Action3);
    u2.States.AbilitiesUsable = 0;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Chain Handles";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Needle Pass";
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
    local LinearVelocity = Instance.new("LinearVelocity");
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(task.delay(0.95, function() -- Line: 68
        -- upvalues: u2 (ref), u8 (copy)
        u2.States.Ability = false;
        u2.States.AbilitiesUsable = 0;
        u2.States.NoWalk = false;
        u8.AC:Clean();
    end));
    local _ = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1;
    u8.AC:Connect(RunService.Heartbeat, function(p15) -- Line: 80
        -- upvalues: u8 (copy), u2 (ref), u1 (ref), u6 (ref), u4 (ref)
        if u8:HoopDist() > 60 then
            return;
        end;

        u8.AC:Clean();
        u2.States.Ability = false;
        u2.States.AbilitiesUsable = 0;
        u2.States.NoWalk = false;
        u1.Ability:Fire("ChainHandles", {
            Style = "Dunk",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.CharValues.DunkTick = workspace:GetServerTimeNow() + 1;
        u4:Dunk("TwohandHanging", "TwohandHanging", true);
    end);
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * 50 + HumanoidRootPart.CFrame.LookVector * 40
    }):Play();
    task.wait(0.08);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * -50 + HumanoidRootPart.CFrame.LookVector * 40
    }):Play();
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * 50 + HumanoidRootPart.CFrame.LookVector * 40
    }):Play();
    task.wait(0.2);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * -90 + HumanoidRootPart.CFrame.LookVector * 85
    }):Play();
    task.wait(0.25);
    TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = HumanoidRootPart.CFrame.RightVector * 90 + HumanoidRootPart.CFrame.LookVector * 85
    }):Play();
end;