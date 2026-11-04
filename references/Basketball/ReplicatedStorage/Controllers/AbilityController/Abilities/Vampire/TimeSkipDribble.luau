 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(script.Parent.Parent);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

return function(u8) -- Line: 27, Name: TimeSkipDribble
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy), Cooldowns (copy), RaycastParams_new_ret (copy), Effects (copy), TweenService (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u8.Network;
    u2 = u8.AbilityService;
    u4 = u8.Animations;
    u3 = u8.MovementController;
    u5 = u8.BallController;
    u6 = u8.CameraController;
    u7 = Knit.GetService("CustomServerService");

    if not u5:LocalPlayerPossessesBall() then
        u8:ResetCopy();
        Effects:Popup("Anyone between your dash will get frozen in place!");
        local MoveDirection = Humanoid.MoveDirection;

        if MoveDirection.Magnitude == 0 then
            MoveDirection = HumanoidRootPart.CFrame.LookVector;
        end;

        local v9 = HumanoidRootPart.CFrame + MoveDirection * 23;
        local v10 = v9.Position - HumanoidRootPart.Position;
        local v11 = workspace:Raycast(HumanoidRootPart.Position, v10.Unit * v10.Magnitude, RaycastParams_new_ret);

        if v11 then
            v9 = CFrame.new(v11.Position) * CFrame.Angles(v9:ToOrientation());
        end;

        u2.Ability:Fire("TimeSkipDribble", {
            Mode = "Dash",
            TimeSent = workspace:GetServerTimeNow(),
            Start = HumanoidRootPart.CFrame,
            End = v9
        });
        HumanoidRootPart.CFrame = v9;

        return;
    end;

    if u8.TimeSkipReturn then
        local v12 = LocalPlayer.Zone.Value == "Vampiric" and u1.CharValues.InZone and 0.75 or 1;
        u8.TimeSkipReturn = nil;
        u8:ResetCopy();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip Dribble";

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
            u8.CDS[1] = tick() + Cooldowns.Abilities.Vampire[1] * v12;
        end;

        u2.Ability:Fire("TimeSkipDribble", {
            Mode = "DashBack",
            TimeSent = workspace:GetServerTimeNow()
        });
        local v13 = HumanoidRootPart.CFrame + HumanoidRootPart.CFrame.LookVector * -30;
        local v14 = v13.Position - HumanoidRootPart.Position;
        local v15 = workspace:Raycast(HumanoidRootPart.Position, v14.Unit * v14.Magnitude, RaycastParams_new_ret);

        if v15 then
            local _ = CFrame.new(v15.Position) * CFrame.Angles(v13:ToOrientation());
        end;

        HumanoidRootPart.CFrame = u8.PreDribbleCFrame;
        u8.PreDribbleCFrame = nil;

        return;
    end;

    if u8:CheckInfront(25) == nil then
        u8:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    u8.PreDribbleCFrame = HumanoidRootPart.CFrame;
    u4:StopAll();
    u4:PlayChar("Vampire", "TimeSkipDribble", Enum.AnimationPriority.Action3);
    u4:PlayBall("Vampire", "TimeSkipDribbleBall", Enum.AnimationPriority.Action3);
    u2.Ability:Fire("TimeSkipDribble", {
        Mode = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.RightVector * -20;
    u8.AC:Add(LinearVelocity);
    task.wait(0.23333333333333334);
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
    task.wait(0.18333333333333332);
    local v16 = HumanoidRootPart.CFrame + (HumanoidRootPart.CFrame.LookVector * 33 + HumanoidRootPart.CFrame.RightVector * 20) * Vector3.new(1, 0, 1);
    local v17 = v16.Position - HumanoidRootPart.Position;
    local v18 = workspace:Raycast(HumanoidRootPart.Position, v17.Unit * v17.Magnitude, RaycastParams_new_ret);

    if v18 then
        v16 = CFrame.new(v18.Position) * CFrame.Angles(v16:ToOrientation());
    end;

    HumanoidRootPart.CFrame = v16;
    u8.AC:Clean();
    u3.States.Ability = false;
    u3.States.NoWalk = false;
    u8:ResetCD(1);
    u8.TimeSkipReturn = true;
    local u19 = tick();
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 0.25;
    local u20 = TweenService:Create(LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    });
    u20:Play();
    Effects:Popup("Press the ability again to teleport backwards!", 4);
    local u21 = nil;
    u21 = RunService.Heartbeat:Connect(function() -- Line: 124
        -- upvalues: LocalPlayer (ref), u19 (copy), u1 (ref), u8 (copy), Cooldowns (ref), u20 (copy), u21 (ref), u5 (ref)
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Go back";

        if tick() - u19 >= 2.25 then
            local v22 = LocalPlayer.Zone.Value == "Vampiric" and u1.CharValues.InZone and 0.75 or 1;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
                u8.CDS[1] = tick() + Cooldowns.Abilities.Vampire[1] * v22;
            end;

            u8.TimeSkipReturn = nil;
            u8:ResetCopy();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip Dribble";

            if u20 then
                u20:Cancel();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                u20:Destroy();
            end;

            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;
        end;

        if not u8.TimeSkipReturn then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip Dribble";

            if u20 then
                u20:Cancel();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                u20:Destroy();
            end;

            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;
        end;

        if not u5:LocalPlayerPossessesBall() then
            local v23 = LocalPlayer.Zone.Value == "Vampiric" and u1.CharValues.InZone and 0.75 or 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip Dash";

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
                u8.CDS[1] = tick() + Cooldowns.Abilities.Vampire[1] * v23;
            end;

            u8.TimeSkipReturn = nil;
            u8:ResetCopy();

            if u20 then
                u20:Cancel();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
                u20:Destroy();
            end;

            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;
        end;
    end);
end;