 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Essentials (copy), Effects (copy), TweenService (copy), Abilities (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;
    local v7 = Essentials:ReturnRorL(u5.CharValues);

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.InstantGrabCD.Value > workspace:GetServerTimeNow() then
            u6:ResetCD(1);
            local v8 = ReplicatedStorage.Cooldowns.InstantGrabCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v8);
            Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);

            return;
        end;

        local CharacterPossessingBall = u3:GetCharacterPossessingBall();
        local PlayerPossessingBall = u3:GetPlayerPossessingBall();

        if not (CharacterPossessingBall and (PlayerPossessingBall and PlayerPossessingBall.Team ~= LocalPlayer.Team)) then
            u6:ResetCD(1);
            Effects:Popup("Ball must be on opponent!");

            return;
        end;

        if (CharacterPossessingBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 45 then
            u6:ResetCD(1);
            Effects:Popup("Opponent must be close to you!");

            return;
        end;

        u2.States.Ability = true;
        u6.AC:Add(function() -- Line: 269
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        u6.AC:Add(task.delay(1.15, function() -- Line: 274
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Perfect Dribble", {
            State = "Grab",
            TimeSent = workspace:GetServerTimeNow(),
            Other = CharacterPossessingBall
        });
        u6.AC:Connect(u1.Ability, function(p9) -- Line: 280
            -- upvalues: u6 (copy), Effects (ref), u2 (ref)
            if not p9 then
                u6.AC:Clean();

                return;
            end;

            if not p9.Fail then
                u2.States.NoWalk = true;

                return;
            end;

            u6.AC:Clean();
            Effects:Popup("Ability missed.");
        end);

        return;
    end;

    if u6.Dribble then
        if u2.States.PumpFake then
            u6:ResetCD(1);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        local v10 = u6:CheckInfront(25);

        if u6.SecCooldown then
            u6.CDS[2] = u6.SecCooldown;
        end;

        u6.Dribble = nil;
        u6.SecCooldown = nil;
        u1.Ability:Fire("Perfect Dribble", {
            State = "Move",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v10
        });
        u4:StopAll();
        u4:PlayChar("PerfectionV2", `PerfectMove{v7}`, Enum.AnimationPriority.Action3);
        u4:PlayBall("PerfectionV2", `PerfectMove{v7}Ball`, Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        u6.AC:Add(function() -- Line: 56
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u6.AC:Add(task.delay(0.6, function() -- Line: 59
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        local v11 = u6.AC:Add(Instance.new("LinearVelocity"));
        v11.Attachment0 = HumanoidRootPart.RootAttachment;
        v11.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        v11.MaxAxesForce = Vector3.new(40000, 0, 40000);
        v11.Parent = HumanoidRootPart;
        local v12 = v7 == "R" and HumanoidRootPart.CFrame.RightVector or -HumanoidRootPart.CFrame.RightVector;
        local v13 = v10 and (v10.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit or HumanoidRootPart.CFrame.LookVector;
        v11.VectorVelocity = v13 * 30;
        TweenService:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = (v13 + v12 * 1.5) * 40
        }):Play();
        task.wait(0.2);
        TweenService:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = (v13 * 1.5 + -v12 * 1.05) * 50
        }):Play();
        task.wait(0.2);
        TweenService:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = v13 * 40
        }):Play();

        return;
    end;

    if u2.States.PumpFake then
        u6:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    local v14 = u6:CheckInfront(25);

    if not v14 then
        u6:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u1.Ability:Fire("Perfect Dribble", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow(),
        Other = v14
    });
    u4:StopAll();
    u4:PlayChar("PerfectionV2", `PerfectDribble{v7}`, Enum.AnimationPriority.Action3);
    u4:PlayBall("PerfectionV2", `PerfectDribble{v7}Ball`, Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 102
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Add(task.delay(1, function() -- Line: 105
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local v15 = u6.AC:Add(Instance.new("LinearVelocity"));
    v15.Attachment0 = HumanoidRootPart.RootAttachment;
    v15.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    v15.MaxAxesForce = Vector3.new(40000, 0, 40000);
    v15.Parent = HumanoidRootPart;
    local v16 = u6.AC:Add(Instance.new("BodyGyro"));
    v16.Name = "GyroBasketball";
    v16.MaxTorque = Vector3.new(inf, inf, inf);
    v16.Parent = HumanoidRootPart;
    local v17 = v7 == "R" and HumanoidRootPart.CFrame.RightVector or -HumanoidRootPart.CFrame.RightVector;
    local Unit = (v14.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit;
    v15.VectorVelocity = Unit * 30;
    task.wait(0.25);
    TweenService:Create(v15, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = -v17 * 80
    }):Play();
    task.wait(0.25);
    TweenService:Create(v15, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        VectorVelocity = (Unit + v17) * 40
    }):Play();
    task.wait(0.25);
    u1.Ability:Fire("Perfect Dribble", {
        State = "Afterimage",
        TimeSent = workspace:GetServerTimeNow(),
        CFrame = HumanoidRootPart.CFrame
    });
    u6.Dribble = "Too Far";
    u6:ResetCD(1);

    if u6:HoopDist() <= 115 then
        u6.Dribble = true;
        u6.SecCooldown = u6.ThePerfectShot and tick() + Abilities.PerfectionV2[2] or u6.CDS[2];
        u6:ResetCD(2);
    else
        u6.SecCooldown = nil;
    end;

    v15.VectorVelocity = Unit * 40;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    RaycastParams_new_ret.CollisionGroup = "Player";
    local v18 = v17 * 20;
    local v19 = workspace:Raycast(HumanoidRootPart.Position, v18, RaycastParams_new_ret);

    if v19 then
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v19.Position - HumanoidRootPart.Position).Unit * (v19.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    else
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v18) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
    end;

    task.delay(0.25, function() -- Line: 166
        -- upvalues: u6 (copy), Abilities (ref)
        if u6.Dribble == "Too Far" then
            if u6:HoopDist() <= 115 then
                u6.Dribble = true;
                u6.SecCooldown = u6.ThePerfectShot and tick() + Abilities.PerfectionV2[2] or u6.CDS[2];
                u6:ResetCD(2);

                return;
            end;

            u6.SecCooldown = nil;
        end;
    end);
    local u20 = nil;
    task.delay(5, function() -- Line: 180
        -- upvalues: u20 (ref)
        u20 = true;
    end);
    local u21 = 1;
    local u22 = false;
    local u23 = nil;

    local function End() -- Line: 189
        -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u5 (ref), u23 (ref)
        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[1] = tick() + Abilities.PerfectionV2[1];

            if u6.SecCooldown then
                u6.CDS[2] = u6.SecCooldown;
            end;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

        if u5.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Perfect Dribble";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "The Perfect Shot";
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Instant Grab";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Perfect Defense";
        end;

        u23:Disconnect();

        if u6.Dribble then
            u6.Dribble = nil;
        end;

        u6:ResetCopy();
    end;

    u23 = RunService.Heartbeat:Connect(function(p24) -- Line: 217
        -- upvalues: u6 (copy), u20 (ref), End (copy), u5 (ref), LocalPlayer (ref), u21 (ref), u22 (ref)
        if not u6.Dribble or u20 then
            End();

            return;
        end;

        if not u5.CharValues.HasBall then
            End();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u21;

        if u6.Dribble ~= "Too Far" then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u21;
        end;

        if u21 > 0.5 and not u22 then
            p24 = -p24 or p24;
        end;

        u21 = u21 + p24;

        if u21 <= 0.5 then
            u22 = true;
        end;

        if u21 >= 1 then
            u22 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Perfect Move";

        if u6.Dribble ~= "Too Far" then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Perfect Slam";
        end;
    end);
end;