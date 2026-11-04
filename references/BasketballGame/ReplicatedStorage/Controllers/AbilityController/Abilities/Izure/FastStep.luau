 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Parent = require(script.Parent.Parent);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local u7 = 1;
LocalPlayer.CharacterAdded:Connect(function() -- Line: 25
    -- upvalues: u7 (ref), Parent (copy)
    u7 = 1;
    Parent.Izure[1].BallName = "Instinct I";
end);

return function(u8) -- Line: 31
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), u7 (ref), RunService (copy), TweenService (copy), Parent (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.Animations;
    u3 = u8.MovementController;
    u4 = u8.BallController;
    u5 = u8.CameraController;
    u6 = u8.Network;

    if not u6.CharValues.HasBall then
        u1.Ability:Fire("Fast Step", {
            State = "Dash",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2:StopAll();
        local u9 = u2:PlayChar("Izure", "FastStep", Enum.AnimationPriority.Action3, true);
        local u10 = u2:PlayBall("Izure", "FastStepBall", Enum.AnimationPriority.Action3, true);
        u8.AC:Connect(u1.Ability, function(p11) -- Line: 182
            -- upvalues: RunService (ref), u6 (ref), u9 (copy), u10 (copy), u8 (copy), u3 (ref), HumanoidRootPart (copy), TweenService (ref)
            if not (p11 and p11.Direction) then
                return;
            end;

            local u12 = nil;
            u12 = RunService.Heartbeat:Connect(function() -- Line: 186
                -- upvalues: u6 (ref), u12 (ref), u9 (ref), u10 (ref)
                if u6.CharValues.HasBall then
                    u12:Disconnect();
                    u9.TimePosition = 0.2;
                    u10.TimePosition = 0.2;
                end;
            end);
            u8.AC:Add(u12);
            u3.States.Ability = true;
            u3.Boost = 20;
            u8.AC:Add(function() -- Line: 200
                -- upvalues: u3 (ref)
                u3.States.Ability = false;
                u3.Boost = 0;
            end);
            u8.AC:Add(task.delay(0.2, function() -- Line: 205
                -- upvalues: u8 (ref)
                u8.AC:Clean();
            end));
            local v13 = u8.AC:Add(Instance.new("LinearVelocity"));
            v13.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            v13.MaxAxesForce = Vector3.new(500000, 0, 500000);
            v13.Attachment0 = HumanoidRootPart.RootAttachment;
            v13.Parent = HumanoidRootPart;
            v13.VectorVelocity = p11.Direction * 200;
            TweenService:Create(v13, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                VectorVelocity = p11.Direction * 125
            }):Play();
        end);

        return;
    end;

    if u8.MovementController.States.PumpFake then
        u8:ResetCD(1);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if u7 ~= 1 and (u7 ~= 2 and u7 ~= 3) then
        u7 = 1;
    end;

    u3.States.Ability = true;
    u3.Boost = 20;
    u8.AC:Add(function() -- Line: 57
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.Boost = 0;
    end);
    local u14 = nil;
    local u15 = u8.AC:Add(Instance.new("NumberValue"));
    local u16 = u8.AC:Add(Instance.new("LinearVelocity"));
    u16.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u16.MaxAxesForce = Vector3.new(40000, 0, 40000);
    u16.Attachment0 = HumanoidRootPart.RootAttachment;
    u16.Parent = HumanoidRootPart;
    u8.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 72
        -- upvalues: u16 (copy), u14 (ref), HumanoidRootPart (copy), u15 (copy)
        if u16 then
            if u14 then
                u16.VectorVelocity = HumanoidRootPart.CFrame.RightVector * u14 * u15.Value + HumanoidRootPart.CFrame.LookVector * u15.Value / 2;

                return;
            end;

            u16.VectorVelocity = HumanoidRootPart.CFrame.LookVector * u15.Value;
        end;
    end);
    u2:StopAll();
    u2:PlayChar("Izure", `Instinct{u7}`, Enum.AnimationPriority.Action3);
    u2:PlayBall("Izure", `Instinct{u7}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Fast Step", {
        State = "Dribble",
        TimeSent = workspace:GetServerTimeNow(),
        Tier = u7
    });
    task.spawn(function() -- Line: 88
        -- upvalues: u7 (ref), u8 (copy), u3 (ref), u14 (ref), u15 (copy), TweenService (ref)
        if u7 ~= 1 then
            if u7 ~= 2 then
                if u7 == 3 then
                    u8.AC:Add(task.delay(2.4166666666666665, function() -- Line: 130
                        -- upvalues: u8 (ref)
                        u8.AC:Clean();
                    end));
                    u8.AC:Add(task.delay(2, function() -- Line: 134
                        -- upvalues: u3 (ref)
                        u3.States.Ability = false;
                        u3.Boost = 0;
                    end));
                    u14 = -1;
                    u15.Value = 45;
                    TweenService:Create(u15, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Value = 5
                    }):Play();
                    task.wait(0.75);
                    u14 = 2.5;
                    u15.Value = 45;
                    TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Value = 5
                    }):Play();
                    task.wait(0.5);
                    u14 = -1;
                    u15.Value = 45;
                    TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Value = 5
                    }):Play();
                    task.wait(0.5);
                    u14 = 1;
                    u15.Value = 45;
                    TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        Value = 5
                    }):Play();
                end;

                return;
            end;

            u8.AC:Add(task.delay(0.8333333333333334, function() -- Line: 113
                -- upvalues: u8 (ref)
                u8.AC:Clean();
            end));
            u8.AC:Add(task.delay(0.5, function() -- Line: 117
                -- upvalues: u3 (ref)
                u3.States.Ability = false;
                u3.Boost = 0;
            end));
            u15.Value = 45;
            TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = 5
            }):Play();
            task.wait(0.5);
            u15.Value = -120;
            TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Value = -5
            }):Play();

            return;
        end;

        u8.AC:Add(task.delay(0.75, function() -- Line: 90
            -- upvalues: u8 (ref)
            u8.AC:Clean();
        end));
        u8.AC:Add(task.delay(0.5, function() -- Line: 94
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
            u3.Boost = 0;
        end));
        u14 = 1;
        u15.Value = 45;
        TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = 5
        }):Play();
        task.wait(0.25);
        u14 = -5;
        task.wait(0.25);
        u14 = 2.5;
        u15.Value = 60;
        TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Value = 5
        }):Play();
    end);
    u7 = u7 + 1;

    if u7 > 3 then
        u7 = 1;
    end;

    Parent.Izure[1].BallName = `Instinct {u7 == 1 and "I" or (u7 == 2 and "II" or (u7 == 3 and "III" or false))}`;

    if not (u7 == 1 or (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) or LocalPlayer.Style.Value == "Thief" and u8.TotalTheft) then
        u8.CDS[1] = tick() + 25;
    end;
end;