 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), TweenService (copy), workspace_CurrentCamera (copy), CameraShaker (copy), RunService (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.Animations;
    u3 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u7.MovementController.States.PumpFake then
        u7:ResetCD(4);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local Magnitude = (HumanoidRootPart.Position - Vector3_new_ret).Magnitude;

    if Magnitude < 35 then
        u7:ResetCD(4);
        Effects:Popup("Too close to hoop!");

        return;
    end;

    if Magnitude >= 135 then
        u7:ResetCD(4);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    u3.States.Ability = true;
    u7.AC:Add(function() -- Line: 56
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
    u7.AC:Add(task.delay(1.75, function() -- Line: 60
        -- upvalues: u7 (copy)
        u7.AC:Clean();
    end));
    task.spawn(function() -- Line: 64
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref), u5 (ref), CameraShaker (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.3333333333333333), {
            FieldOfView = 40
        }):Play();
        task.wait(1.3333333333333333);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.25), {
            FieldOfView = 100
        }):Play();
        task.wait(0.25);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1), {
            FieldOfView = 70
        }):Play();
        u5.CamShake:Shake(CameraShaker.Presets.Ankle);
    end);
    u1.Ability:Fire("Fakeout", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u2:StopAll();
    u2:PlayChar("Izure", "Fakeout", Enum.AnimationPriority.Action3, true);
    u2:PlayBall("Izure", "FakeoutBall", Enum.AnimationPriority.Action3, true);
    local u8 = u7.AC:Add(Instance.new("LinearVelocity"));
    u8.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u8.MaxAxesForce = Vector3.new(inf, inf, inf);
    u8.Attachment0 = HumanoidRootPart.RootAttachment;
    u8.Parent = HumanoidRootPart;
    local Hoop2 = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Unit = (Vector3.new(Hoop2.Position.X, HumanoidRootPart.Position.Y, Hoop2.Position.Z) - HumanoidRootPart.Position).Unit;
    u8.VectorVelocity = Vector3.new(Unit.X, 0, Unit.Z) * 180;
    TweenService:Create(u8, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        VectorVelocity = Vector3.new()
    }):Play();
    task.delay(1.3333333333333333, function() -- Line: 94
        -- upvalues: u8 (copy), HumanoidRootPart (copy), TweenService (ref)
        u8.VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 90 + Vector3.new(0, 45, 0);
        TweenService:Create(u8, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            VectorVelocity = -HumanoidRootPart.CFrame.LookVector * 30 + Vector3.new(0, -30, 0)
        }):Play();
    end);
    task.wait(1);
    local u9 = nil;
    u9 = RunService.Heartbeat:Connect(function() -- Line: 102
        -- upvalues: u8 (copy), u9 (ref), Hoop2 (copy), HumanoidRootPart (copy)
        if u8 and u8.Parent then
            if (Vector3.new(Hoop2.Position.X, HumanoidRootPart.Position.Y, Hoop2.Position.Z) - HumanoidRootPart.Position).Magnitude < 10 then
                u8.MaxAxesForce = Vector3.new(0, inf, 0);
                u9:Disconnect();
            end;

            return;
        end;

        u9:Disconnect();
    end);
    u7.AC:Connect(u1.Ability, function() -- Line: 116
        -- upvalues: ReplicatedStorage (ref), u4 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
        local Value = ReplicatedStorage.Basketball.Value;
        local LastCharacterToPossessBall = u4:GetLastCharacterToPossessBall();
        Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
        local _ = Value.Position;
        local v10 = Hoop.Position - Value.Position;
        local v11, v12;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v11 = v10.Magnitude * 0.0455;
            v12 = 1.35;
        else
            v11 = v10.Magnitude * 0.04;
            v12 = 0.5;
        end;

        local math_log_ret = math.log(v12 + v11);
        Value.AssemblyLinearVelocity = v10 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;