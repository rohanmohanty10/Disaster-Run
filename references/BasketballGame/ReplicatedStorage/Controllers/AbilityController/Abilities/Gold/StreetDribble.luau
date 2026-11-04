 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6, p7) -- Line: 19, Name: StreetDribble
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (ref), u4 (ref), u1 (ref), u3 (ref), Effects (copy), ReplicatedStorage (copy), RunService (copy), Players (copy), Essentials (copy), CameraShaker (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u2 = u6.MovementController;
    u5 = u6.CameraController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;

    if u2.States.PumpFake then
        u6:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        u6:ResetCD(1);
        Effects:Popup("Not usable in air");

        return;
    end;

    if u6.ElbowPass then
        if not u4:CharacterPossessesBall(u6.ElbowPass) then
            Effects:Popup("Team-mate doesn\'t have the ball!");
            u6:ResetCD(1);

            return;
        end;

        if not u4:LocalPlayerIsWithinDistanceOfBall(100) then
            u6:ResetCD(1);
            Effects:Popup("Must be close to the ball!");

            return;
        end;

        u6:ResetCopy();
        u1.Ability:Fire("StreetDribble", {
            Style = "ReturnPass",
            TimeSent = workspace:GetServerTimeNow()
        });
        u6.AC:Connect(u1.Ability, function(p8) -- Line: 53
            -- upvalues: u6 (copy), Effects (ref), u2 (ref), ReplicatedStorage (ref), u4 (ref), HumanoidRootPart (copy), RunService (ref), Character (copy)
            u6.AC:Clean();

            if p8 then
                u6:ResetCD(1);
                Effects:Popup("Ball is on iframes!");

                return;
            end;

            u6.ElbowPass = nil;
            u2.States.AbilitiesUsable = 0;
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Unit = (HumanoidRootPart.Position - Value.Position).Unit;
            local _ = (HumanoidRootPart.Position - Value.Position).Magnitude;
            local Magnitude = (HumanoidRootPart.Position - Value.Position).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u6.AC:Add(LinearVelocity);
            u6.AC:Add(task.delay(0.15, function() -- Line: 88
                -- upvalues: LinearVelocity (copy), Value (copy), u6 (ref), RunService (ref), u4 (ref), HumanoidRootPart (ref), Character (ref)
                LinearVelocity.Parent = Value;
                local u9 = tick();
                local u10 = false;
                u6.AC:Connect(RunService.Heartbeat, function(p11) -- Line: 95
                    -- upvalues: u4 (ref), u6 (ref), u10 (ref), u9 (copy), Value (ref), HumanoidRootPart (ref), LinearVelocity (ref), Character (ref)
                    if not u4:LocalPlayerIsBallNetworkOwner() then
                        u6.AC:Clean();

                        return;
                    end;

                    local v12 = -u4:GetVectorOffsetBetweenLocalPlayerAndBall(true);
                    local v13 = v12:Dot(v12);

                    if v13 >= 400 then
                        u10 = true;
                    end;

                    local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                    if u9 + 3 < tick() or (Value.Parent == nil or (CharacterPossessingBall or u10 and v13 <= 144)) or v13 <= 100 and HumanoidRootPart == HumanoidRootPart then
                        u6.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if CharacterPossessingBall == Character then
                        LinearVelocity.Parent = nil;
                    end;

                    LinearVelocity.Parent = Value;
                    LinearVelocity.VectorVelocity = v12.Unit * 120 * 1.8;
                end);
            end));
        end);

        return;
    end;

    if not u6.Network.CharValues.HasBall then
        u6:ResetCD(1);
        Effects:Popup("Not usable without ball!");

        return;
    end;

    if not u6.StreetDribble then
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = p7;
        u3:StopAll();
        u3:PlayChar("Gold", "StreetDribble", Enum.AnimationPriority.Action3);
        u3:PlayBall("Gold", "StreetDribbleBall", Enum.AnimationPriority.Action3);
        u1.Ability:Fire("StreetDribble", {
            TimeSent = workspace:GetServerTimeNow()
        });
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Name = "GyroBasketball";
        BodyGyro.MaxTorque = Vector3.new(1, 1, 1) * (1 / 0);
        BodyGyro.Parent = HumanoidRootPart;
        local CFrame = HumanoidRootPart.CFrame;
        task.delay(1.2, function() -- Line: 352
            -- upvalues: u2 (ref), LinearVelocity (ref), BodyGyro (copy)
            u2.States.Ability = false;

            if LinearVelocity then
                LinearVelocity:Destroy();
                LinearVelocity = nil;
            end;

            BodyGyro:Destroy();
        end);
        task.delay(2, function() -- Line: 361
            -- upvalues: u2 (ref), u6 (copy), LocalPlayer (ref)
            u2.States.AbilitiesUsable = 0;

            if u6.StreetDribble then
                u6.StreetDribble = nil;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[1] = tick() + 75;
                end;

                u6:ResetCopy();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            end;
        end);
        u6:ResetCD(1);
        u6.StreetDribble = true;
        local u14 = nil;
        local Ability1 = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1;
        local u15 = 1;
        local u16 = false;
        u14 = RunService.Heartbeat:Connect(function(p17) -- Line: 384
            -- upvalues: u6 (copy), u14 (ref), LinearVelocity (ref), BodyGyro (copy), LocalPlayer (ref), Ability1 (copy), u15 (ref), u16 (ref)
            if not u6.StreetDribble then
                u14:Disconnect();

                if LinearVelocity then
                    LinearVelocity.Attachment0 = nil;
                end;

                if BodyGyro then
                    BodyGyro.Parent = nil;
                end;

                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            if not u6.Network.CharValues.HasBall then
                u14:Disconnect();
                u6.StreetDribble = nil;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                    u6.CDS[1] = tick() + 75;
                end;

                u6:ResetCopy();
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                return;
            end;

            Ability1.Flash.BackgroundTransparency = u15;

            if u15 > 0.5 and not u16 then
                p17 = -p17 or p17;
            end;

            u15 = u15 + p17;

            if u15 <= 0.5 then
                u16 = true;
            end;

            if u15 >= 1 then
                u16 = false;
            end;

            Ability1.AbilityName.Text = "Elbow Pass";
        end);
        u6.AC:Add(task.spawn(function() -- Line: 420
            -- upvalues: TweenService (ref), LinearVelocity (ref), CFrame (copy)
            TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = CFrame.RightVector * -50 + CFrame.LookVector * 36
            }):Play();
            task.wait(0.19999999999999998);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = CFrame.RightVector * 50 + CFrame.LookVector * 36
            }):Play();
            task.wait(0.13333333333333333);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3.new(0, 0, 0)
            }):Play();
            task.wait(0.16666666666666666);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = CFrame.RightVector * -50 + CFrame.LookVector * 36
            }):Play();
            task.wait(0.16666666666666666);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = CFrame.RightVector * 90 + CFrame.LookVector * 90
            }):Play();
            task.wait(0.25);
            TweenService:Create(LinearVelocity, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                VectorVelocity = CFrame.RightVector * -5 + CFrame.LookVector * 90
            }):Play();
        end));

        return;
    end;

    local LookingAt = u6.Pass.LookingAt;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingAt);

    if RunService:IsStudio() then
        LookingAt = workspace:WaitForChild("DefenseRig");
    elseif LookingAt == nil or PlayerFromCharacter ~= nil and PlayerFromCharacter.Team ~= LocalPlayer.Team then
        local v18 = nil;

        for _, v in LocalPlayer.Team:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Team == LocalPlayer.Team and v ~= LocalPlayer)) then
                if not v18 or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < v18 then
                    LookingAt = v.Character;
                end;

                break;
            end;
        end;
    end;

    if not LookingAt then
        Effects:Popup("No teammates to pass to!");
        u6:ResetCD(1);

        return;
    end;

    u6.StreetDribble = nil;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u2.States.AbilitiesUsable = 0;
    task.delay(0.75, function() -- Line: 175
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    local v19 = Essentials:ReturnRorL(u6.Network.CharValues);
    u3:StopAll();
    u3:PlayChar("Gold", `StreetDribblePass{v19}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Gold", `StreetDribblePass{v19}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("StreetDribble", {
        Style = "Pass",
        TimeSent = workspace:GetServerTimeNow(),
        Passing = LookingAt,
        Direction = v19
    });
    u6.AC:Connect(u1.Ability, function() -- Line: 193
        -- upvalues: u5 (ref), CameraShaker (ref), ReplicatedStorage (ref), u4 (ref), LookingAt (ref), u6 (copy), RunService (ref), HumanoidRootPart (copy), Character (copy)
        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
        local Value = ReplicatedStorage.Basketball.Value;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Unit = (LookingAt.HumanoidRootPart.Position - Value.Position).Unit;
        local _ = (LookingAt.HumanoidRootPart.Position - Value.Position).Magnitude;
        local Position = Value.Position;
        local Position2 = LookingAt.HumanoidRootPart.Position;
        local Magnitude = (Position2 - Position).Magnitude;
        Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = Value.Root;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
        u6.AC:Add(LinearVelocity);
        u6.AC:Add(task.delay(0.15, function() -- Line: 219
            -- upvalues: LinearVelocity (copy), Value (ref), u6 (ref), RunService (ref), ReplicatedStorage (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), Character (ref)
            LinearVelocity.Parent = Value;
            local u20 = tick();
            local u21 = false;
            u6.AC:Connect(RunService.Heartbeat, function(p22) -- Line: 225
                -- upvalues: Value (ref), ReplicatedStorage (ref), Position (ref), u4 (ref), Position2 (ref), LookingAt (ref), Magnitude (ref), HumanoidRootPart (ref), u21 (ref), u6 (ref), Character (ref), LinearVelocity (ref), u20 (copy)
                Value = ReplicatedStorage.Basketball.Value;
                Position = u4:GetServerBallPosition();
                Position2 = LookingAt.HumanoidRootPart.Position;
                Magnitude = (Position2 - Position).Magnitude;

                if (HumanoidRootPart.Position - Position).Magnitude >= 20 then
                    u21 = true;
                end;

                if not u4:LocalPlayerIsBallNetworkOwner() then
                    u6.AC:Clean();

                    return;
                end;

                local CharacterPossessingBall = u4:GetCharacterPossessingBall();

                if CharacterPossessingBall == Character then
                    LinearVelocity.Parent = nil;
                end;

                if u20 + 3 < tick() or Magnitude <= 10 and LookingAt.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or CharacterPossessingBall) then
                    u6.AC:Clean();
                    Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                    return;
                end;

                LinearVelocity.Parent = Value;
                LinearVelocity.VectorVelocity = ((LookingAt.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * 150;
            end);
        end));
    end);
    task.delay(4, function() -- Line: 264
        -- upvalues: u2 (ref), u6 (copy), LocalPlayer (ref)
        u2.States.AbilitiesUsable = 0;

        if u6.ElbowPass then
            u6.ElbowPass = nil;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 75;
            end;

            u6:ResetCopy();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        end;
    end);
    u6.ElbowPass = LookingAt;

    while u6.ElbowPass and u6.Network.CharValues.HasBall do
        task.wait();
    end;

    if not u6.ElbowPass then
        return;
    end;

    u6:ResetCD(1);
    local u23 = nil;
    local Ability1 = LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1;
    local u24 = 1;
    local u25 = false;
    u23 = RunService.Heartbeat:Connect(function(p26) -- Line: 293
        -- upvalues: u6 (copy), u23 (ref), LocalPlayer (ref), Ability1 (copy), u24 (ref), u25 (ref)
        if not u6.ElbowPass then
            u23:Disconnect();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Street Dribble";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            return;
        end;

        if u6.Network.CharValues.HasBall then
            u23:Disconnect();
            u6.ElbowPass = nil;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + 75;
            end;

            u6:ResetCopy();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Street Dribble";
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            return;
        end;

        Ability1.Flash.BackgroundTransparency = u24;

        if u24 > 0.5 and not u25 then
            p26 = -p26 or p26;
        end;

        u24 = u24 + p26;

        if u24 <= 0.5 then
            u25 = true;
        end;

        if u24 >= 1 then
            u25 = false;
        end;

        Ability1.AbilityName.Text = "Return Pass";
    end);
end;