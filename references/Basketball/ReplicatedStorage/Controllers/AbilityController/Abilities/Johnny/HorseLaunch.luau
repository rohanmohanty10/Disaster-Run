 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
require(ReplicatedStorage.Shared.Tables.Zones);
require(ReplicatedStorage.Shared.Utility.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u8) -- Line: 25
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), Effects (copy), CameraShaker (copy), TweenService (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u8.AbilityService;
    u2 = u8.MovementController;
    u3 = u8.CameraController;
    u4 = u8.BallController;
    u5 = u8.Animations;
    u6 = u8.Network;
    u7 = u8.Network;

    if u6.CharValues.HasBall then
        if (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - HumanoidRootPart.Position).Magnitude > 120 then
            Effects:Popup("Too far away from hoop!", 1);
            u8:ResetCD(2);

            return;
        end;

        u2.States.Ability = true;
        task.delay(0.85, function() -- Line: 46
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u5:StopAll();
        u5:PlayChar("Johnny", "WormholeShot", Enum.AnimationPriority.Action3);
        u5:PlayBall("Johnny", "WormholeShotBall", Enum.AnimationPriority.Action3);
        task.delay(0.75, function() -- Line: 54
            -- upvalues: u3 (ref), CameraShaker (ref)
            u3.CamShake:Shake(CameraShaker.Presets.Ankle);
        end);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 45
        }):Play();
        task.delay(0.75, function() -- Line: 59
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = 90
            }):Play();
        end);
        u1.Ability:Fire("Horse Launch", {
            State = "Shot",
            TimeSent = workspace:GetServerTimeNow()
        });
        task.wait(0.75);

        if not u8.Network.CharValues.HasBall then
            return;
        end;

        u8.AC:Connect(u1.Ability, function(p9) -- Line: 71
            -- upvalues: u8 (copy), ReplicatedStorage (ref), u2 (ref), u4 (ref), HumanoidRootPart (copy)
            if not p9 or p9.State ~= "Shot" then
                return;
            end;

            u8.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            u2.States.Shooting = false;
            u2.States.Ability = false;
            local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();
            local v10 = HumanoidRootPart.CFrame * CFrame.new(0, -3, -5.25);
            Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, v10.Position);
            Value.AssemblyLinearVelocity = CFrame.new(Value.Position, v10.Position).LookVector * 4.242640687119285 / 0.1;
        end);

        return;
    end;

    if Humanoid:GetState() == Enum.HumanoidStateType.Jumping or Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        u8:ResetCD(2);
        Effects:Popup("Not usable in air");

        return;
    end;

    u5:StopAll();
    u5:PlayChar("Johnny", "HorseLaunch", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Horse Launch", {
        State = "Launch",
        TimeSent = workspace:GetServerTimeNow()
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(inf, 0, inf);
    LinearVelocity.Parent = HumanoidRootPart;
    u2.States.Ability = true;
    task.wait(0.85);
    u2.States.NoWalk = true;
    task.delay(1, function() -- Line: 110
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    local u11 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);
    LinearVelocity.VectorVelocity = u11 * 200;
    TweenService:Create(LinearVelocity, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        VectorVelocity = u11 * 20
    }):Play();
    HumanoidRootPart.AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity + Vector3.new(0, workspace.Gravity * 1 / 2, 0);
    u8.AC:Add(LinearVelocity);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    tick();
    u8.AC:Connect(RunService.Heartbeat, function() -- Line: 128
        -- upvalues: HumanoidRootPart (copy), u11 (copy), RaycastParams_new_ret (copy), LinearVelocity (copy), RunService (ref)
        local v12 = workspace:Raycast(HumanoidRootPart.Position, u11.Unit * 5, RaycastParams_new_ret);

        if v12 and (not v12.Instance.Parent:FindFirstChild("Humanoid") and LinearVelocity) then
            LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
            RunService.Heartbeat:Wait();
            LinearVelocity:Destroy();
        end;
    end);
    u8.AC:Add(task.delay(1, function() -- Line: 139
        -- upvalues: u8 (copy)
        u8.AC:Clean();
    end));
end;