 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 23
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), CameraShaker (copy), TweenService (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.BallController;
    u2 = u7.CameraController;
    u3 = u7.MovementController;
    u4 = u7.AbilityService;
    u5 = u7.Animations;
    u6 = u7.Network;
    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
    local Vector3_new_ret = Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z);
    local v8 = Vector3_new_ret - HumanoidRootPart.Position;

    if v8:Dot(v8) < 8100 then
        u7:ResetCD(1);
        Effects:Popup("Too close to hoop!", 1);

        return;
    end;

    if v8:Dot(v8) > 22500 then
        u7:ResetCD(1);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    u3.States.Shooting = true;
    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(2.35, function() -- Line: 63
        -- upvalues: u3 (ref)
        u3.States.Shooting = false;
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u5:StopAll();
    u5:PlayChar("Air", "Fadeaway", Enum.AnimationPriority.Action3);
    u5:PlayBall("Air", "FadeawayBall", Enum.AnimationPriority.Action3);
    task.delay(1.8666666666666667, function() -- Line: 76
        -- upvalues: u2 (ref), CameraShaker (ref)
        u2.CamShake:Shake(CameraShaker.Presets.Ankle);
    end);
    task.delay(1, function() -- Line: 80
        -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FieldOfView = 45
        }):Play();
        task.delay(0.5, function() -- Line: 82
            -- upvalues: TweenService (ref), workspace_CurrentCamera (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.36666666666666664, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = 90
            }):Play();
        end);
    end);
    task.delay(1.5, function() -- Line: 87
        -- upvalues: Humanoid (copy)
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    end);
    u4.Ability:Fire("Fadeaway", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(1.7666666666666666);
    u7.AC:Connect(u4.Ability, function() -- Line: 95
        -- upvalues: u7 (copy), ReplicatedStorage (ref), u3 (ref), u1 (ref), Vector3_new_ret (copy), Hoop (copy), HumanoidRootPart (copy)
        u7.AC:Clean();
        local Value = ReplicatedStorage.Basketball.Value;
        u3.States.Shooting = false;
        u3.States.Ability = false;
        u3.States.NoWalk = false;
        local LastCharacterToPossessBall = u1:GetLastCharacterToPossessBall();
        Value.CFrame = CFrame.new(LastCharacterToPossessBall.PlrBall.Anims.BALL.Position, Vector3_new_ret);
        local _ = Value.Position;
        local v9 = Hoop.Position - Value.Position;
        local v10, v11;

        if (HumanoidRootPart.Position - Hoop.Position).Magnitude <= 30 then
            v10 = v9.Magnitude * 0.0455;
            v11 = 1.35;
        else
            v10 = v9.Magnitude * 0.04;
            v11 = 0.5;
        end;

        local math_log_ret = math.log(v11 + v10);
        Value.AssemblyLinearVelocity = v9 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;