 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), Abilities (copy), TweenService (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if u6.InBanditCloak then
        if not u5.CharValues.HasBall then
            Effects:Popup("Not usable without ball!");
            u6:ResetCD(1);

            return;
        end;

        if u2.States.PumpFake then
            Effects:Popup("Can\'t use after a fake!");
            u6:ResetCD(1);

            return;
        end;

        u6.CDS[2] = Abilities.ChrolloV2[2];
        u6.InBanditCloak = nil;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Creator\'s Dribble";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Creator Cloak";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        u1.Ability:Fire("Bandit Cloak", {
            State = "Snatchback",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "Snatchback", Enum.AnimationPriority.Action3);
        u4:PlayBall("ChrolloV2", "SnatchbackBall", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -100;
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(0.25, function() -- Line: 70
            -- upvalues: LinearVelocity (copy), u2 (ref), Effects (ref)
            LinearVelocity:Destroy();
            u2.States.Ability = false;
            u2.States.NoWalk = false;
            Effects:Popup("Increased speed on next dribble.", 3);
        end);
        u6.OneTimeBoost = (u6.OneTimeBoost or 1) + 0.35;

        return;
    end;

    if u6.CutPosition then
        local CutPosition = u6.CutPosition;
        u6.CutPosition = nil;
        u1.Ability:Fire("Bandit Dribble", {
            State = "Cut Back",
            TimeSent = workspace:GetServerTimeNow(),
            Position = CutPosition
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "BanditCutShift", Enum.AnimationPriority.Action3);
        u2.States.Ability = true;
        local LinearVelocity = HumanoidRootPart:FindFirstChild("LinearVelocity");
        local v7 = u6.AC:Add(Instance.new("LinearVelocity"));
        v7.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        v7.MaxAxesForce = Vector3.new(20000, 0, 20000);
        v7.Attachment0 = HumanoidRootPart.RootAttachment;
        v7.Parent = HumanoidRootPart;

        if LinearVelocity then
            v7.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 90;
            TweenService:Create(v7, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                VectorVelocity = Vector3.new(0, 0, 0)
            }):Play();
        end;

        task.wait(0.55);
        v7.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -60;
        task.wait(0.26666666666666666);
        v7:Destroy();
        u2.States.Ability = false;

        if u5.CharValues.Stunned then
            return;
        end;

        HumanoidRootPart.CFrame = CFrame.new(CutPosition) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

        return;
    end;

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.GameValues.Scoring.Value then
            u6:ResetCD(1);
            Effects:Popup("Can\'t use after a goal!");

            return;
        end;

        u1.Ability:Fire("Bandit Dribble", {
            State = "Cut",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "BanditCut", Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        local u8 = nil;
        local Position = HumanoidRootPart.Position;
        local u14 = RunService.Heartbeat:Connect(function() -- Line: 323
            -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), u8 (ref), u5 (ref), u6 (copy), Position (copy), LocalPlayer (ref), Abilities (ref), RunService (ref)
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 90;

            if not u8 and u5.CharValues.Inside then
                u8 = true;
                u6.CutPosition = Position;
                u6:ResetCD(1);
                local u9 = nil;
                task.delay(1.5, function() -- Line: 333
                    -- upvalues: u9 (ref)
                    u9 = true;
                end);
                local u10 = 1;
                local u11 = false;
                local u12 = nil;

                local function End() -- Line: 342
                    -- upvalues: u6 (ref), LocalPlayer (ref), Abilities (ref), u5 (ref), LinearVelocity (ref), u12 (ref)
                    if not (u6.InBanditCloak or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                        u6.CDS[1] = tick() + Abilities.ChrolloV2[1];
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

                    if u5.CharValues.HasBall then
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Creator\'s Dribble";
                    else
                        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Creator\'s Cut";
                    end;

                    LinearVelocity:Destroy();
                    u12:Disconnect();

                    if u6.CutPosition then
                        u6.CutPosition = nil;
                        u6.AC:Clean();
                    end;

                    u6:ResetCopy();
                end;

                u12 = RunService.Heartbeat:Connect(function(p13) -- Line: 368
                    -- upvalues: u6 (ref), u9 (ref), End (copy), LocalPlayer (ref), u10 (ref), u11 (ref)
                    if not u6.CutPosition or (u6.InBanditCloak or u9) then
                        End();

                        return;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u10;

                    if u10 > 0.5 and not u11 then
                        p13 = -p13 or p13;
                    end;

                    u10 = u10 + p13;

                    if u10 <= 0.5 then
                        u11 = true;
                    end;

                    if u10 >= 1 then
                        u11 = false;
                    end;

                    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Cut Back";
                end);
            end;
        end);
        task.delay(0.65, function() -- Line: 390
            -- upvalues: u14 (copy), LinearVelocity (copy), u8 (ref), u6 (copy)
            u14:Disconnect();
            LinearVelocity:Destroy();

            if not u8 then
                u6:ResetCopy();
            end;
        end);

        return;
    end;

    local v15 = u6:CheckInfront(27.5);

    if u6.Dribble then
        if not v15 then
            u6:ResetCD(1);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;
    elseif u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 143
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);

    if u6.Dribble then
        u6.Dribble = nil;
        u6.AC:Add(task.delay(0.6666666666666666, function() -- Line: 150
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Bandit Dribble", {
            State = "Dribble Spin",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v15
        });
        u4:StopAll();
        u4:PlayChar("ChrolloV2", "BanditDribbleSpin", Enum.AnimationPriority.Action3);
        u4:PlayBall("ChrolloV2", "BanditDribbleSpinBall", Enum.AnimationPriority.Action3);
        local u16 = u6.AC:Add(Instance.new("LinearVelocity"));
        u16.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u16.MaxAxesForce = Vector3.new(20000, 0, 20000);
        u16.Attachment0 = HumanoidRootPart.RootAttachment;
        u16.Parent = HumanoidRootPart;
        u16.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 5;
        TweenService:Create(u16, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 40 + HumanoidRootPart.CFrame.RightVector * -40
        }):Play();
        local v17 = u2;
        v17.Boost = v17.Boost + 25;
        task.delay(0.3333333333333333, function() -- Line: 171
            -- upvalues: TweenService (ref), u16 (copy), HumanoidRootPart (copy), u2 (ref)
            TweenService:Create(u16, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = HumanoidRootPart.CFrame.LookVector * 80 + HumanoidRootPart.CFrame.RightVector * 80
            }):Play();
            local v18 = u2;
            v18.Boost = v18.Boost - 25;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
        local u19 = nil;
        u19 = u1.Ability:Connect(function() -- Line: 181
            -- upvalues: u19 (ref), ReplicatedStorage (ref), u3 (ref), HumanoidRootPart (copy)
            u19:Disconnect();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
            Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector + HumanoidRootPart.CFrame.RightVector / 2 - Vector3.new(0, 1, 0)).Unit * 80;
        end);
        u6.AC:Add(u19);

        return;
    end;

    u6.AC:Add(task.delay(1, function() -- Line: 196
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u1.Ability:Fire("Bandit Dribble", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("ChrolloV2", "BanditDribble", Enum.AnimationPriority.Action3);
    u4:PlayBall("ChrolloV2", "BanditDribbleBall", Enum.AnimationPriority.Action3);
    local u20 = nil;
    local NumberValue = Instance.new("NumberValue");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(NumberValue);
    u6.AC:Add(LinearVelocity);
    u6.AC:Connect(RunService.Heartbeat, function(p21) -- Line: 219
        -- upvalues: LinearVelocity (copy), u20 (ref), HumanoidRootPart (copy), NumberValue (copy)
        if LinearVelocity then
            if u20 then
                LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.RightVector * u20 * NumberValue.Value + HumanoidRootPart.CFrame.LookVector * NumberValue.Value / 2;

                return;
            end;

            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
        end;
    end);
    NumberValue.Value = 90;
    TweenService:Create(NumberValue, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Value = 5
    }):Play();
    local v22 = u2;
    v22.Boost = v22.Boost + 25;
    task.wait(0.5833333333333334);
    u20 = 1;
    NumberValue.Value = 90;
    TweenService:Create(NumberValue, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Value = 30
    }):Play();
    local v23 = u2;
    v23.Boost = v23.Boost - 25;

    if u2.Boost < 0 then
        u2.Boost = 0;
    end;

    task.wait(0.16666666666666666);
    u20 = -3;
    NumberValue.Value = 90;
    TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Value = 15
    }):Play();
    u6.Dribble = true;
    u6:ResetCD(1);
    local u24 = nil;
    task.delay(3, function() -- Line: 255
        -- upvalues: u24 (ref)
        u24 = true;
    end);
    local u25 = 1;
    local u26 = false;
    local u27 = nil;

    local function u28() -- Line: 264
        -- upvalues: u6 (copy), LocalPlayer (ref), Abilities (ref), u27 (ref)
        if not (u6.InBanditCloak or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[1] = tick() + Abilities.ChrolloV2[1];
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        u27:Disconnect();
        u6.Dribble = nil;
        u6:ResetCopy();
    end;

    u27 = RunService.Heartbeat:Connect(function(p29) -- Line: 280
        -- upvalues: u6 (copy), u24 (ref), u28 (copy), u5 (ref), LocalPlayer (ref), u25 (ref), u26 (ref)
        if not u6.Dribble or (u6.InBanditCloak or u24) then
            u28();

            return;
        end;

        if not u5.CharValues.HasBall then
            u28();

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u25;

        if u25 > 0.5 and not u26 then
            p29 = -p29 or p29;
        end;

        u25 = u25 + p29;

        if u25 <= 0.5 then
            u26 = true;
        end;

        if u25 >= 1 then
            u26 = false;
        end;
    end);
end;