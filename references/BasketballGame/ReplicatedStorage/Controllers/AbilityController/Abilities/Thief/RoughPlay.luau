 
 

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
local _ = workspace.CurrentCamera;
LocalPlayer:GetMouse();

return function(u6) -- Line: 22
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), ReplicatedStorage (copy), TweenService (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        u2.States.Ability = true;
        u6.AC:Add(function() -- Line: 211
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u6.AC:Add(task.delay(0.25, function() -- Line: 215
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u4:StopAll();
        u4:PlayChar("Thief", "RoughPlay", Enum.AnimationPriority.Action3, true);
        u1.Ability:Fire("Rough Play", {
            State = "Push",
            TimeSent = workspace:GetServerTimeNow()
        });
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.MaxTorque = (1 / 0);
        AlignOrientation.Responsiveness = 16;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Parent = HumanoidRootPart;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u6.AC:Add(AlignOrientation);
        u6.AC:Add(LinearVelocity);
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 160;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = HumanoidRootPart.CFrame.LookVector * 80
        }):Play();

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(2);

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 41
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 15;
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(NumberValue);
    u6.AC:Add(LinearVelocity);

    if not u6.ThiefDribble then
        u6.ThiefDribble = true;
        u6.CDS[2] = tick() - 1;
        u6.AC:Add(task.delay(0.25, function() -- Line: 122
            -- upvalues: u2 (ref)
            u2.Boost = 25;
        end));
        u6.AC:Add(task.delay(0.75, function() -- Line: 125
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end));
        u6.AC:Add(task.delay(1, function() -- Line: 128
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Rough Play", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("Thief", "StolenDribble", Enum.AnimationPriority.Action3);
        u4:PlayBall("Thief", "StolenDribbleBall", Enum.AnimationPriority.Action3);
        local u7 = "F";
        u6.AC:Connect(RunService.Heartbeat, function() -- Line: 140
            -- upvalues: HumanoidRootPart (copy), Humanoid (copy), u7 (ref), LinearVelocity (copy), NumberValue (copy)
            local v8 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
            u7 = v8.X > 0.01 and "R" or (v8.X < -0.01 and "L" or (v8.Z > 0.01 and "B" or "F"));
            local v9 = u7 == "R" and HumanoidRootPart.CFrame.RightVector or (u7 == "L" and -HumanoidRootPart.CFrame.RightVector or u7 == "B" and -HumanoidRootPart.CFrame.LookVector);

            if not v9 then
                if u7 == "F" then
                    v9 = HumanoidRootPart.CFrame.LookVector;
                else
                    v9 = false;
                end;
            end;

            LinearVelocity.VectorVelocity = v9 * NumberValue.Value;
        end);
        task.wait(0.25);
        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Value = 30
        }):Play();
        task.wait(0.5);
        NumberValue.Value = 60;
        TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Value = 30
        }):Play();
        local u10 = nil;
        task.delay(3, function() -- Line: 156
            -- upvalues: u10 (ref)
            u10 = true;
        end);
        local u11 = 1;
        local u12 = false;
        local u13 = nil;

        local function End() -- Line: 165
            -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u5 (ref), u13 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[2] = tick() + Abilities.Thief[2];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

            if u5.CharValues.HasBall then
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Stolen Dribble";
            else
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Rough Play";
            end;

            u13:Disconnect();

            if u6.ThiefDribble then
                u6.ThiefDribble = nil;
            end;
        end;

        u13 = RunService.Heartbeat:Connect(function(p14) -- Line: 185
            -- upvalues: u6 (copy), u10 (ref), End (copy), u5 (ref), LocalPlayer (ref), u11 (ref), u12 (ref)
            if not u6.ThiefDribble or u10 then
                End();

                return;
            end;

            if not u5.CharValues.HasBall then
                End();

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u11;

            if u11 > 0.5 and not u12 then
                p14 = -p14 or p14;
            end;

            u11 = u11 + p14;

            if u11 <= 0.5 then
                u12 = true;
            end;

            if u11 >= 1 then
                u12 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Stolen Drive";
        end);

        return;
    end;

    u6.ThiefDribble = nil;
    u6.AC:Add(task.delay(0.75, function() -- Line: 61
        -- upvalues: u2 (ref)
        u2.Boost = 25;
    end));
    u6.AC:Add(task.delay(1.25, function() -- Line: 64
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u1.Ability:Fire("Rough Play", {
        State = "Forward",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Thief", "StolenDribbleForward", Enum.AnimationPriority.Action3);
    u4:PlayBall("Thief", "StolenDribbleForwardBall", Enum.AnimationPriority.Action3);
    local NumberValue2 = Instance.new("NumberValue");
    NumberValue2.Value = 0;
    u6.AC:Add(NumberValue2);
    u6.AC:Connect(RunService.Heartbeat, function() -- Line: 79
        -- upvalues: LinearVelocity (copy), HumanoidRootPart (copy), NumberValue (copy), NumberValue2 (copy)
        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value + HumanoidRootPart.CFrame.RightVector * NumberValue2.Value;
    end);
    local u15 = nil;
    u15 = u1.Ability:Connect(function() -- Line: 84
        -- upvalues: u15 (ref), ReplicatedStorage (ref), u2 (ref), u3 (ref), HumanoidRootPart (copy)
        u15:Disconnect();
        local Value = ReplicatedStorage.Basketball.Value;
        task.delay(0.5, function() -- Line: 89
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.Boost = 0;
        end);
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
        Value.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.LookVector - Vector3.new(0, 0.8, 0)) * 60;
    end);
    u6.AC:Add(u15);
    TweenService:Create(NumberValue, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 45
    }):Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 60
    }):Play();
    task.wait(0.1);
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = -60
    }):Play();
    task.wait(0.1);
    TweenService:Create(NumberValue, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Value = 15
    }):Play();
    TweenService:Create(NumberValue2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    task.wait(0.1);
    TweenService:Create(NumberValue, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 15
    }):Play();
    task.wait(0.16666666666666666);
    TweenService:Create(NumberValue, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 30
    }):Play();
    task.wait(0.4166666666666667);
    NumberValue.Value = 60;
    TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 30
    }):Play();
end;