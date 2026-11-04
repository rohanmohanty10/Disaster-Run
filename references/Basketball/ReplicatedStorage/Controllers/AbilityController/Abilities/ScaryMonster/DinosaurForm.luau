 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 19
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), ReplicatedStorage (copy), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u5.AbilityService;
    u2 = u5.Animations;
    u3 = u5.MovementController;
    u4 = u5.Network;

    if not u4.CharValues.HasBall then
        u1.Ability:Fire("Dinosaur Form", {
            HasBall = false,
            TimeSent = workspace:GetServerTimeNow()
        });
        local u6 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.DinosaurFormWalk);
        u6:AdjustSpeed(0.5);
        local u7 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.DinosaurFormRun);
        u3.Boost = 10;
        u3.States.Ability = true;
        u5.AC:Add(function() -- Line: 116
            -- upvalues: u6 (copy), u7 (copy), u3 (ref)
            if u6 then
                u6:Stop();
            end;

            if u7 then
                u7:Stop();
            end;

            u3.Boost = 0;
            u3.States.Ability = false;
        end);
        local u8 = u5.AC:Add(Instance.new("LinearVelocity"));
        u8.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        u8.MaxAxesForce = Vector3.new(40000, 0, 40000);
        u8.Attachment0 = HumanoidRootPart.RootAttachment;
        u8.Parent = HumanoidRootPart;
        u5.AC:Connect(RunService.Heartbeat, function() -- Line: 135
            -- upvalues: Humanoid (copy), u8 (copy), u7 (copy), u6 (copy)
            if Humanoid.MoveDirection.X == 0 or Humanoid.MoveDirection.Z == 0 then
                u8.VectorVelocity = Vector3.new();

                if not u6.IsPlaying then
                    u6:Play();
                end;

                if u7.IsPlaying then
                    u7:Stop(0.5);
                end;
            else
                u8.VectorVelocity = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).Unit * 60;

                if not u7.IsPlaying then
                    u7:Play();
                end;

                if u6.IsPlaying then
                    u6:Stop(0.5);
                end;
            end;
        end);
        u5.AC:Connect(u1.Ability, function() -- Line: 157
            -- upvalues: u5 (copy)
            u5.AC:Clean();
        end);
        u5.AC:Add(task.delay(3, function() -- Line: 161
            -- upvalues: u5 (copy)
            u5.AC:Clean();
        end));

        return;
    end;

    u3.States.Ability = true;
    u5.AC:Add(function() -- Line: 31
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
    u5.AC:Add(task.delay(1, function() -- Line: 35
        -- upvalues: u5 (copy)
        u5.AC:Clean();
    end));
    u2:StopAll();
    u2:PlayChar("ScaryMonster", "TailForm", Enum.AnimationPriority.Action3);
    u2:PlayBall("ScaryMonster", "TailFormBall", Enum.AnimationPriority.Action3);
    local u9 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.TailFormTail);
    u9:Play();
    u9.Priority = Enum.AnimationPriority.Action3;
    u1.Ability:Fire("Dinosaur Form", {
        HasBall = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    u5.TailMode = true;
    Effects:Popup("INCREASED SPEED.", 2, Color3.new(0.482353, 0.32549, 1));
    task.delay(0.5, function() -- Line: 52
        -- upvalues: Effects (ref)
        Effects:Popup("INCREASED DRIBBLING SPEED.", 2, Color3.new(0.482353, 0.32549, 1));
    end);
    task.delay(1, function() -- Line: 55
        -- upvalues: Effects (ref)
        Effects:Popup("BOOSTS END IN 40 SECONDS OR WHEN AWAKENING ENDS.", 2, Color3.new(1, 0.2, 0.2));
    end);
    local u10 = nil;
    u10 = RunService.Heartbeat:Connect(function() -- Line: 60
        -- upvalues: u3 (ref), Humanoid (copy), u9 (copy), u5 (copy), u10 (ref)
        u3.Boost = 10;

        if Humanoid.MoveDirection.X == 0 or Humanoid.MoveDirection.Z == 0 then
            if u9.IsPlaying then
                u9:Stop();
            end;
        elseif not u9.IsPlaying then
            u9:Play();
        end;

        if not u5.Network.CharValues.InAwakening then
            u10:Disconnect();
            u10 = nil;
            u9:Stop();
            u5.TailMode = nil;
            u3.Boost = 0;
        end;
    end);
    task.delay(35, function() -- Line: 85
        -- upvalues: u5 (copy), Effects (ref)
        for i = 1, 5 do
            if not u5.Network.CharValues.InAwakening then
                return;
            end;

            Effects:Popup((`TAIL FORM ENDING IN {5 - i}`));
            task.wait(1);
            local _ = i;
        end;
    end);
    task.delay(40, function() -- Line: 93
        -- upvalues: u10 (ref), u9 (copy), u5 (copy), u3 (ref)
        if u10 then
            u10:Disconnect();
            u10 = nil;
            u9:Stop();
            u5.TailMode = nil;
            u3.Boost = 0;
        end;
    end);
end;