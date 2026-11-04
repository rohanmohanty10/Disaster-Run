 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u8, p9, p10) -- Line: 23
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), LocalPlayer (copy), Players (copy), RunService (copy), Effects (copy), TweenService (copy), CameraShaker (copy), ReplicatedStorage (copy), Zones (copy), Trove (copy), SfxManager (copy), UserInputService (copy)
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.BallController;
    u4 = u8.CameraController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Pass;
    local Character = LocalPlayer.Character;
    local Humanoid = Character.Humanoid;
    local HumanoidRootPart = Character.HumanoidRootPart;

    if u6.CharValues.HasBall then
        local LookingAt = u7.LookingAt;
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

        if RunService:IsStudio() then
            LookingAt = workspace:WaitForChild("DefenseRig");
        elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
            u8:ResetCD(1);
            Effects:Popup("Must look at team-mate!");

            return;
        end;

        u1.Ability:Fire("Lockdown Target", {
            State = "Charge",
            TimeSent = workspace:GetServerTimeNow()
        });
        local u11 = tick();
        local u12 = nil;
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        local u13 = script.Bar:Clone();
        u13.Parent = LocalPlayer.PlayerGui;
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 61
            -- upvalues: u13 (copy), u11 (copy)
            local UIGradient = u13.CanvasGroup.Frame.Progress.UIGradient;
            local Vector2_new = Vector2.new;
            local v14 = 1 - (tick() - u11);
            UIGradient.Offset = Vector2_new(0, (math.clamp(v14, 0, 1)));
        end);

        if LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief" then
            u13.CanvasGroup.GroupTransparency = 1;
        end;

        u8.AC:Add(function() -- Line: 69
            -- upvalues: TweenService (ref), u13 (copy), u12 (ref), u11 (copy), LookingAt (ref), RunService (ref), PlayerFromCharacter (ref), Players (ref), LocalPlayer (ref), u7 (ref), HumanoidRootPart (copy), u2 (ref), u5 (ref), u1 (ref), u8 (copy), u4 (ref), CameraShaker (ref), ReplicatedStorage (ref), u3 (ref), Character (copy), u6 (ref), Zones (ref)
            task.spawn(function() -- Line: 70
                -- upvalues: TweenService (ref), u13 (ref), u12 (ref), u11 (ref), LookingAt (ref), RunService (ref), PlayerFromCharacter (ref), Players (ref), LocalPlayer (ref), u7 (ref), HumanoidRootPart (ref), u2 (ref), u5 (ref), u1 (ref), u8 (ref), u4 (ref), CameraShaker (ref), ReplicatedStorage (ref), u3 (ref), Character (ref), u6 (ref), Zones (ref)
                TweenService:Create(u13.CanvasGroup, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                task.delay(0.25, function() -- Line: 72
                    -- upvalues: u13 (ref)
                    u13:Destroy();
                end);
                local u15 = u12 and 0 or tick() - u11;

                if LookingAt == nil or not (LookingAt:IsDescendantOf(workspace) and (RunService:IsStudio() or PlayerFromCharacter ~= nil and (PlayerFromCharacter:IsDescendantOf(Players) and PlayerFromCharacter.Team == LocalPlayer.Team))) then
                    LookingAt = u7.LookingAt;
                    PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

                    if LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
                        local v16 = nil;

                        for _, v in LocalPlayer.Team:GetPlayers() do
                            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                                if not v16 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v16 then
                                    LookingAt = v.Character;
                                end;

                                break;
                            end;
                        end;
                    end;

                    if not LookingAt then
                        u2.States.Ability = false;
                        u2.States.NoWalk = false;
                        u5:StopAll();

                        return;
                    end;
                end;

                local HumanoidRootPart2 = LookingAt.HumanoidRootPart;
                task.delay(0.35, function() -- Line: 113
                    -- upvalues: u2 (ref)
                    u2.States.Ability = false;
                    u2.States.NoWalk = false;
                end);
                u1.Ability:Fire("Lockdown Target", {
                    State = "Pass",
                    TimeSent = workspace:GetServerTimeNow(),
                    PassingTo = LookingAt,
                    HoldForTooLong = u12,
                    TimeCharged = u15
                });
                u5:StopAll();
                u5:PlayChar("Genius", "TargetPassPass", Enum.AnimationPriority.Action3);
                u5:PlayBall("Genius", "TargetPassPassBall", Enum.AnimationPriority.Action3);
                task.wait(0.1);
                RunService.Heartbeat:Wait();
                u8.AC:Connect(u8.AbilityService.Ability, function(p17) -- Line: 127
                    -- upvalues: u8 (ref), u4 (ref), CameraShaker (ref), ReplicatedStorage (ref), u3 (ref), Character (ref), HumanoidRootPart2 (copy), u15 (copy), u12 (ref), RunService (ref), u6 (ref), Zones (ref), LocalPlayer (ref)
                    if not (p17 and p17.Pass) then
                        return;
                    end;

                    u8.AC:Clean();
                    u4.CamShake:Shake(CameraShaker.Presets.Dunk);
                    local Value = ReplicatedStorage.Basketball.Value;
                    Value.CFrame = (u3:GetLastCharacterToPossessBall() or Character).PlrBall.Anims.BALL.CFrame;
                    local Position = Value.Position;
                    local Position2 = HumanoidRootPart2.Position;
                    local Unit = (Position2 - Position).Unit;
                    local math_clamp_ret = math.clamp((Position2 - Position).Magnitude, 65, 120);
                    local math_clamp_ret2 = math.clamp(360 * u15, 95, 360);
                    Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * math_clamp_ret;

                    if u12 then
                        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * (math_clamp_ret / 2);

                        return;
                    end;

                    Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * math_clamp_ret;
                    local LinearVelocity = Instance.new("LinearVelocity", Value);
                    LinearVelocity.Attachment0 = Value.Root;
                    LinearVelocity.MaxForce = 40000;
                    LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * math_clamp_ret;
                    u8.AC:Add(LinearVelocity);
                    local u18 = tick();
                    local u19 = nil;
                    u19 = RunService.Heartbeat:Connect(function(p20) -- Line: 164
                        -- upvalues: u3 (ref), u19 (ref), LinearVelocity (copy), HumanoidRootPart2 (ref), u18 (copy), Value (copy), u6 (ref), Zones (ref), LocalPlayer (ref), math_clamp_ret2 (copy)
                        if u3:GetPlayerPossessingBall() then
                            u19:Disconnect();
                            LinearVelocity:Destroy();

                            return;
                        end;

                        local ServerBallPosition = u3:GetServerBallPosition();
                        local Magnitude = (HumanoidRootPart2.Position - ServerBallPosition).Magnitude;

                        if Magnitude <= 10 then
                            u19:Disconnect();
                            LinearVelocity:Destroy();

                            return;
                        end;

                        if u18 + 1.5 < tick() or not Value.Parent then
                            u19:Disconnect();
                            LinearVelocity:Destroy();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        local Unit2 = (HumanoidRootPart2.Position - ServerBallPosition).Unit;
                        local v21 = 1;

                        if u6.CharValues.InZone and Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value] then
                            v21 = v21 + Zones.ZoneIncreasedPassingSpeed[LocalPlayer.Zone.Value];
                        end;

                        if math_clamp_ret2 > 300 then
                            LinearVelocity.VectorVelocity = Unit2 * math_clamp_ret2 * v21;

                            return;
                        end;

                        LinearVelocity.VectorVelocity = (Unit2 + Vector3.new(0, Magnitude / math_clamp_ret2 / 2.2 - 0.05, 0)) * math_clamp_ret2 * v21;
                    end);
                end);
            end);
        end);
        u8.AC:Connect(RunService.Heartbeat, function() -- Line: 204
            -- upvalues: u6 (ref), u8 (copy)
            if not u6.CharValues.HasBall then
                u8.AC:Clean();
            end;
        end);
        u5:StopAll();
        u5:PlayChar("Genius", "TargetPassCharge", Enum.AnimationPriority.Action3);
        u5:PlayBall("Genius", "TargetPassChargeBall", Enum.AnimationPriority.Action3);
        u8.AC:Add(task.delay(0.45, function() -- Line: 214
            -- upvalues: u5 (ref)
            u5:StopAll();
            u5:PlayChar("Genius", "TargetPassCharging", Enum.AnimationPriority.Action3);
            u5:PlayBall("Genius", "TargetPassChargingBall", Enum.AnimationPriority.Action3);
        end));
        u8.AC:Add(task.delay((LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and 0 or 4, function() -- Line: 220
            -- upvalues: LocalPlayer (ref), u12 (ref), u8 (copy)
            if LocalPlayer.Style.Value ~= "Copycat" and LocalPlayer.Style.Value ~= "Thief" then
                u12 = true;
            end;

            u8.AC:Clean();
        end));

        return;
    end;

    if ReplicatedStorage.Cooldowns.LockdownTargetCD.Value > workspace:GetServerTimeNow() then
        u8:ResetCD(1);
        local v22 = ReplicatedStorage.Cooldowns.LockdownTargetCD.Value - workspace:GetServerTimeNow();
        Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v22)} seconds`, 2);

        return;
    end;

    local CharacterPossessingBall = u3:GetCharacterPossessingBall();
    local PlayerPossessingBall = u3:GetPlayerPossessingBall();

    if not CharacterPossessingBall then
        u8:ResetCD(1);
        Effects:Popup("Ball must be on enemy player!");

        return;
    end;

    if not PlayerPossessingBall then
        u8:ResetCD(1);
        Effects:Popup("Ball must be on enemy player!");

        return;
    end;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        u8:ResetCD(1);
        Effects:Popup("Ball must be on enemy player!");

        return;
    end;

    if (CharacterPossessingBall.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 50 then
        u8:ResetCD(1);
        Effects:Popup("Enemy must be close to you!");

        return;
    end;

    u1.Ability:Fire("Lockdown Target", {
        State = "Lockdown",
        TimeSent = workspace:GetServerTimeNow()
    });
    Effects:Popup("Locking onto target...");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.MaxTorque = (1 / 0);
    AlignOrientation.Responsiveness = 80;
    AlignOrientation.Parent = HumanoidRootPart;
    local Highlight = Instance.new("Highlight", workspace.Debris);
    Highlight.Adornee = CharacterPossessingBall;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(133, 255, 99);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    u8.AC:Add(LinearVelocity);
    u8.AC:Add(AlignOrientation);
    u8.AC:Add(Highlight);
    u5:StopAll();
    local u23 = {
        Idle = u5:PlayChar("Genius", "LockdownTargetIdle", Enum.AnimationPriority.Action2, true),
        Right = u5:PlayChar("Genius", "LockdownTargetRight", Enum.AnimationPriority.Action2, true),
        Left = u5:PlayChar("Genius", "LockdownTargetLeft", Enum.AnimationPriority.Action2, true),
        Front = u5:PlayChar("Genius", "LockdownTargetFront", Enum.AnimationPriority.Action2, true),
        Back = u5:PlayChar("Genius", "LockdownTargetBack", Enum.AnimationPriority.Action2, true)
    };
    local u24 = nil;
    local u25 = tick();
    u8.AC:Connect(RunService.Heartbeat, function() -- Line: 302
        -- upvalues: u3 (ref), LocalPlayer (ref), HumanoidRootPart (copy), LinearVelocity (copy), Humanoid (copy), u24 (ref), u25 (ref), u23 (copy), Highlight (copy), AlignOrientation (copy)
        local CharacterPossessingBall2 = u3:GetCharacterPossessingBall();
        local PlayerPossessingBall2 = u3:GetPlayerPossessingBall();

        if CharacterPossessingBall2 and (CharacterPossessingBall2:FindFirstChild("HumanoidRootPart") and (PlayerPossessingBall2 and PlayerPossessingBall2.Team ~= LocalPlayer.Team)) then
            local v26 = HumanoidRootPart.CFrame:VectorToObjectSpace(LinearVelocity.VectorVelocity.Magnitude > 0 and LinearVelocity.VectorVelocity.Unit or CharacterPossessingBall2.HumanoidRootPart.AssemblyLinearVelocity);
            local v27 = {};
            local math_clamp_ret = math.clamp(v26.X / Humanoid.WalkSpeed, 0.01, 1);
            v27.Right = math.abs(math_clamp_ret);
            local math_clamp_ret2 = math.clamp(v26.X / Humanoid.WalkSpeed, -1, -0.01);
            v27.Left = math.abs(math_clamp_ret2);
            local math_clamp_ret3 = math.clamp(v26.Z / Humanoid.WalkSpeed, -1, -0.01);
            v27.Front = math.abs(math_clamp_ret3);
            local math_clamp_ret4 = math.clamp(v26.Z / Humanoid.WalkSpeed, 0.01, 1);
            v27.Back = math.abs(math_clamp_ret4);
            local v28 = 0.012;
            local v29 = "Idle";

            for i, v in v27 do
                if v28 < v then
                    v29 = i;
                    v28 = v;
                end;
            end;

            if u24 ~= v29 and tick() - u25 > 0.25 then
                u25 = tick();
                u24 = v29;

                for i, v in u23 do
                    if i == v29 then
                        v:Play(0.25);
                    elseif v.IsPlaying then
                        v:Stop(0.25);
                    end;
                end;
            end;

            if Highlight.Adornee ~= CharacterPossessingBall2 then
                Highlight.Adornee = CharacterPossessingBall2;
            end;

            LinearVelocity.Enabled = true;
        else
            Highlight.Adornee = nil;
            LinearVelocity.Enabled = false;
            AlignOrientation.Enabled = false;
        end;

        if not (CharacterPossessingBall2 and CharacterPossessingBall2:FindFirstChild("HumanoidRootPart")) then
            return;
        end;

        local v30 = (CharacterPossessingBall2.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)).Position - HumanoidRootPart.Position;

        if (HumanoidRootPart.Position - CharacterPossessingBall2.HumanoidRootPart.Position).Magnitude > 0 then
            AlignOrientation.CFrame = CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(CharacterPossessingBall2.HumanoidRootPart.Position.X, HumanoidRootPart.Position.Y, CharacterPossessingBall2.HumanoidRootPart.Position.Z)));
        end;

        if math.floor(v30.Magnitude) <= 0 then
            LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);

            return;
        end;

        LinearVelocity.VectorVelocity = v30.Unit * Humanoid.WalkSpeed * 1.25;
    end);
    local u31 = Trove.new();

    for i = 1, 3 do
        u8.AC:Add(task.delay((i - 1) * 2 + math.random(25, 50) / 100, function() -- Line: 371
            -- upvalues: u31 (copy), LocalPlayer (ref), ReplicatedStorage (ref), TweenService (ref), SfxManager (ref), Effects (ref), u8 (copy), UserInputService (ref), RunService (ref)
            u31:Clean();
            local u32 = script.Circle:Clone();
            u32.Button.Position = UDim2.new(math.random(15, 85) / 100, 0, math.random(30, 70) / 100, 0);
            u32.Button.CanvasGroup.White.Rotation = math.random(-180, 180);
            u32.Button.CanvasGroup.Center.Rotation = u32.Button.CanvasGroup.White.Rotation - math.random(135, 270);
            u32.Parent = LocalPlayer.PlayerGui;

            if ReplicatedStorage.Controllers.Device.Value == "Mobile" then
                u32.Button.CanvasGroup.ImageLabel.Image = "rbxassetid://98126008779404";
            elseif ReplicatedStorage.Controllers.Device.Value == "Console" then
                u32.Button.CanvasGroup.ImageLabel.Image = "rbxassetid://95703361383221";
            end;

            local Size = u32.Button.Size;
            u32.Button.Size = UDim2.new(0, 0, 0, 0);
            TweenService:Create(u32.Button, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();

            local function Click() -- Line: 390
                -- upvalues: u31 (ref), u32 (copy), SfxManager (ref), Effects (ref), u8 (ref)
                u31:Clean();
                local math_abs_ret = math.abs(u32.Button.CanvasGroup.Center.Rotation - u32.Button.CanvasGroup.White.Rotation);

                if math_abs_ret > 180 then
                    math_abs_ret = math.abs(math_abs_ret - 360);
                end;

                if math_abs_ret <= 26 then
                    SfxManager:playSound({
                        Sound = "BBZ Genius Lockdown Success",
                        Parent = workspace
                    });
                else
                    SfxManager:playSound({
                        Sound = "BBZ Genius Lockdown Miss",
                        Parent = workspace
                    });
                end;

                if math_abs_ret <= 3 then
                    Effects:Popup("PERFECT!", 1, Color3.fromRGB(0, 255, 38));

                    return;
                end;

                if math_abs_ret <= 12 then
                    Effects:Popup("GOOD!", 1, Color3.fromRGB(0, 255, 38));

                    return;
                end;

                if math_abs_ret <= 26 then
                    Effects:Popup("OK!", 1, Color3.fromRGB(0, 255, 38));

                    return;
                end;

                u8.AC:Clean();
                Effects:Popup("MISS!", 1, Color3.fromRGB(255, 0, 38));
                u32.Button.CanvasGroup.Center.Line.ImageColor3 = Color3.fromRGB(255, 0, 38);
            end;

            u31:Add(function() -- Line: 417
                -- upvalues: TweenService (ref), u32 (copy), Size (copy)
                TweenService:Create(u32.Button, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = UDim2.new(Size.X.Scale * 2, 0, Size.Y.Scale * 2, 0)
                }):Play();
                TweenService:Create(u32.Button.CanvasGroup, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    GroupTransparency = 1
                }):Play();
                task.delay(0.25, function() -- Line: 420
                    -- upvalues: u32 (ref)
                    u32:Destroy();
                end);
            end);
            u31:Connect(UserInputService.InputBegan, function(p33, p34) -- Line: 425
                -- upvalues: Click (copy)
                if p33.KeyCode ~= Enum.KeyCode.Space and (p33.KeyCode ~= Enum.KeyCode.ButtonB and p33.KeyCode ~= Enum.KeyCode.ButtonA) then
                    return;
                end;

                Click();
            end);
            u31:Connect(u32.Button.Activated, function() -- Line: 430
                -- upvalues: Click (copy)
                Click();
            end);
            u31:Connect(RunService.RenderStepped, function(p35) -- Line: 434
                -- upvalues: u32 (copy)
                local Center = u32.Button.CanvasGroup.Center;
                Center.Rotation = Center.Rotation + 270 * p35;
            end);
            u31:Add(task.delay(1.5, function() -- Line: 438
                -- upvalues: u8 (ref), u32 (copy)
                u8.AC:Clean();
                u32.Button.CanvasGroup.Center.Line.ImageColor3 = Color3.fromRGB(255, 0, 38);
            end));
        end));
        local _ = i;
    end;

    u2.States.Ability = true;
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
    local u36 = nil;
    u8.AC:Add(function() -- Line: 449
        -- upvalues: Effects (ref), u23 (copy), Humanoid (copy), u36 (ref), u2 (ref), u1 (ref), u31 (copy)
        Effects:Popup("Lockdown ended.");

        for _, v in u23 do
            v:Stop();
        end;

        task.delay(0.25, function() -- Line: 456
            -- upvalues: Humanoid (ref)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
        end);

        if u36 then
            u2.States.Ability = false;
        else
            u2.States.NoWalk = true;
            task.delay(0.8, function() -- Line: 464
                -- upvalues: u2 (ref)
                u2.States.NoWalk = false;
                u2.States.Ability = false;
            end);
            u1.Ability:Fire("Lockdown Target", {
                State = "Cleanup",
                TimeSent = workspace:GetServerTimeNow()
            });
        end;

        u31:Clean();
    end);
    u8.AC:Connect(u8.AbilityService.Ability, function(p37) -- Line: 475
        -- upvalues: u36 (ref), u8 (copy), u5 (ref)
        if not p37 then
            return;
        end;

        u36 = p37.Steal;
        u8.AC:Clean();

        if p37.Steal then
            u5:StopAll();
            u5:PlayChar("Genius", "LockdownTargetSteal", Enum.AnimationPriority.Action3);
            u5:PlayBall("Genius", "LockdownTargetStealBall", Enum.AnimationPriority.Action3);
        end;
    end);
    u8.AC:Connect(RunService.Heartbeat, function() -- Line: 488
        -- upvalues: u6 (ref), Character (copy), u8 (copy)
        if u6.CharValues.HasBall or (u6.CharValues.Stunned or Character.IsRagdoll.Value) then
            u8.AC:Clean();
        end;
    end);
    u8.AC:Add(task.delay(7, function() -- Line: 494
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
end;