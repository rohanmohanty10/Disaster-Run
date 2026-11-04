 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u5) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), Effects (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u5.AbilityService;
    u2 = u5.MovementController;
    u3 = u5.BallController;
    u4 = u5.Animations;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;

    if math.abs(HumanoidRootPart.Position.X - Position.X) > 145 then
        u5:ResetCD(2);
        Effects:Popup("Only shootable from your half of the court!");

        return;
    end;

    if u5.Network.CharValues.Inside then
        u5:ResetCD(2);
        Effects:Popup("If it ain\'t a three, it ain’t me!");

        return;
    end;

    Effects:Popup("They fall down for jumping too early!");
    local v6;

    if (HumanoidRootPart.Position - Position).Magnitude > 110 then
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(4.9, function() -- Line: 53
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        task.spawn(function() -- Line: 58
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
                FieldOfView = 50
            }):Play();
            task.wait(0.5);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.48333333333333334), {
                FieldOfView = 100
            }):Play();
            task.wait(0.48333333333333334);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
        end);
        u4:StopAll();
        u4:PlayChar("Goat", "SleepShot", Enum.AnimationPriority.Action3);
        u4:PlayBall("Goat", "SleepShotBall", Enum.AnimationPriority.Action3);
        v6 = "Sleep";
    else
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        task.delay(2.9, function() -- Line: 74
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
        task.spawn(function() -- Line: 79
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5), {
                FieldOfView = 50
            }):Play();
            task.wait(0.5);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.08333333333333333), {
                FieldOfView = 100
            }):Play();
            task.wait(0.08333333333333333);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
                FieldOfView = 70
            }):Play();
        end);
        u4:StopAll();
        local u7 = u4:PlayChar("Goat", "AuraShot", Enum.AnimationPriority.Action3, true);
        local u8 = u4:PlayBall("Goat", "AuraShotBall", Enum.AnimationPriority.Action3, true);
        task.delay(0.5, function() -- Line: 91
            -- upvalues: u7 (copy), u8 (copy), HumanoidRootPart (copy)
            u7.TimePosition = 0.9;
            u8.TimePosition = 0.9;
            local v9 = HumanoidRootPart;
            v9.CFrame = v9.CFrame + Vector3.new(0, 4, 0);
        end);
        v6 = "Aura";
    end;

    u1.Ability:Fire("Sleep Shot", {
        TimeSent = workspace:GetServerTimeNow(),
        State = `{v6}Shot`
    });
    task.wait(0.5);
    local u10 = 30;
    local u11 = 0.75;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BodyVelocityBasketball";
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    local u12 = tick() + (v6 == "Aura" and 0.4 or 0);
    local u14 = RunService.Heartbeat:Connect(function(p13) -- Line: 113
        -- upvalues: u10 (ref), u12 (copy), BodyVelocity (copy), u11 (ref)
        if u10 >= 10 then
            if u12 + 0.125 < tick() then
                BodyVelocity.Velocity = Vector3.new(0, u11, 0) * u10;
                u11 = u11 - p13 * 1.75;
            else
                BodyVelocity.Velocity = Vector3.new(0, 0, 0);
            end;

            u10 = u10 - p13;
        end;
    end);
    task.delay(0.5 - (v6 == "Sleep" and 0 or 0.4), function() -- Line: 125
        -- upvalues: u14 (ref), BodyVelocity (copy)
        if u14 then
            u14:Disconnect();
        end;

        BodyVelocity:Destroy();
    end);
    u5.AC:Connect(u1.Ability, function(p15) -- Line: 133
        -- upvalues: u5 (copy), ReplicatedStorage (ref), Position (copy), HumanoidRootPart (copy)
        if not p15 or p15.State ~= "Shot" then
            return;
        end;

        u5.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        local _ = Value.Position;
        local v16 = Position - Value.Position;
        local v17, v18;

        if (HumanoidRootPart.Position - Position).Magnitude <= 30 then
            v17 = v16.Magnitude * 0.0455;
            v18 = 1.35;
        else
            v17 = v16.Magnitude * 0.04;
            v18 = 0.5;
        end;

        local math_log_ret = math.log(v18 + v17);
        Value.AssemblyLinearVelocity = v16 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;