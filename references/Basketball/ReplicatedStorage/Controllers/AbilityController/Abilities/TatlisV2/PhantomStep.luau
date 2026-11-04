 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), ReplicatedStorage (copy), Abilities (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;
    local v8 = u7:CheckInfront(27.5, true);

    if not v8 then
        u7:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u2.States.Ability = true;
    u2.Boost = 20;
    u7.AC:Add(function() -- Line: 44
        -- upvalues: u2 (ref)
        u2.States.Ability = false;

        if u2.Boost >= 20 then
            local v9 = u2;
            v9.Boost = v9.Boost - 20;
        end;
    end);
    u7.AC:Add(task.delay(0.23333333333333334, function() -- Line: 51
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end));
    u7.AC:Add(task.delay(0.6833333333333333, function() -- Line: 55
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    u1.Ability:Fire("Phantom Step", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v8
    });
    u5:StopAll();
    u5:PlayChar("TatlisV2", "PhantomStep", Enum.AnimationPriority.Action3);
    u5:PlayBall("TatlisV2", "PhantomStepBall", Enum.AnimationPriority.Action3);
    local u10 = u7.AC:Add(Instance.new("LinearVelocity"));
    u10.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u10.MaxAxesForce = Vector3.new(20000, 0, 20000);
    u10.Attachment0 = HumanoidRootPart.RootAttachment;
    u10.Parent = HumanoidRootPart;
    u10.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5;
    TweenService:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60 + HumanoidRootPart.CFrame.RightVector * 30
    }):Play();
    task.delay(0.25, function() -- Line: 74
        -- upvalues: TweenService (ref), u10 (copy), HumanoidRootPart (copy), u2 (ref)
        TweenService:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 60 + HumanoidRootPart.CFrame.RightVector * -30
        }):Play();

        if u2.Boost >= 20 then
            local v11 = u2;
            v11.Boost = v11.Boost - 20;
        end;
    end);
    local u12 = nil;
    u12 = u1.Ability:Connect(function() -- Line: 83
        -- upvalues: u12 (ref), ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy)
        u12:Disconnect();
        local Value = ReplicatedStorage.Basketball.Value;
        local CharacterPossessingBall = u3:GetCharacterPossessingBall();

        if CharacterPossessingBall then
            Value.CFrame = CharacterPossessingBall.PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
        end;

        Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector - (Value.Position.Y >= 8 and Vector3.new(0, 1, 0) or Vector3.new(0, 0.33333334, 0))).Unit * 90;
    end);
    u7.AC:Add(u12);

    if u7.Dribble then
        u7.Dribble = nil;

        return;
    end;

    u7.Dribble = true;
    u7:ResetCD(1);
    local u13 = nil;
    task.delay(3, function() -- Line: 106
        -- upvalues: u13 (ref)
        u13 = true;
    end);
    local u14 = 1;
    local u15 = false;
    local u16 = nil;

    local function End() -- Line: 115
        -- upvalues: LocalPlayer (ref), u7 (copy), Abilities (ref), u16 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u7.TotalTheft) then
            u7.CDS[1] = tick() + Abilities.ChrolloV2[1];
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        u16:Disconnect();
        u7.Dribble = nil;
        u7:ResetCopy();
    end;

    u16 = RunService.Heartbeat:Connect(function(p17) -- Line: 125
        -- upvalues: u7 (copy), u13 (ref), End (copy), LocalPlayer (ref), u14 (ref), u15 (ref)
        if not u7.Dribble or u13 then
            End();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u14;

        if u14 > 0.5 and not u15 then
            p17 = -p17 or p17;
        end;

        u14 = u14 + p17;

        if u14 <= 0.5 then
            u15 = true;
        end;

        if u14 >= 1 then
            u15 = false;
        end;
    end);
end;