 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
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
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u7) -- Line: 21
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), Effects (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), RunService (copy), Essentials (copy), CameraShaker (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u7.AbilityService;
    u2 = u7.Animations;
    u3 = u7.MovementController;
    u4 = u7.BallController;
    u5 = u7.CameraController;
    u6 = u7.Network;

    if u6.CharValues.HasBall then
        if u7.MovementController.States.PumpFake then
            u7:ResetCD(2);
            Effects:Popup("Can\'t use after a fake!");

            return;
        end;

        local v8 = u7:CheckInfront(25);

        if not v8 then
            u7:ResetCD(2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u3.States.Ability = true;
        u7.AC:Add(function() -- Line: 48
            -- upvalues: u3 (ref)
            u3.States.Ability = false;
        end);
        u7.AC:Add(task.delay(0.811111111111111, function() -- Line: 52
            -- upvalues: u7 (copy)
            u7.AC:Clean();
        end));
        u2:StopAll();
        local v9 = u2:PlayChar("ScaryMonster", "LegShot", Enum.AnimationPriority.Action3, true);
        local v10 = u2:PlayBall("ScaryMonster", "LegShotBall", Enum.AnimationPriority.Action3, true);
        v9:AdjustSpeed(1.5);
        v10:AdjustSpeed(1.5);
        local v11 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.LegShotRevolver);
        v11:Play();
        v11:AdjustSpeed(1.5);
        v11.Priority = Enum.AnimationPriority.Action3;
        u1.Ability:Fire("Bullet Pressure", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow(),
            Other = v8
        });
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        local u13 = RunService.Heartbeat:Connect(function(p12) -- Line: 70
            -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
            FieldOfView = Essentials:Lerp(FieldOfView, 40, p12 * 5);
            workspace_CurrentCamera.FieldOfView = FieldOfView;
        end);
        task.delay(0.811111111111111, function() -- Line: 76
            -- upvalues: Character (copy), HumanoidRootPart (copy), u13 (copy), u5 (ref), CameraShaker (ref)
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { Character };
            RaycastParams_new_ret.CollisionGroup = "Player";
            local v14 = -HumanoidRootPart.CFrame.LookVector * 25;
            local v15 = workspace:Raycast(HumanoidRootPart.Position, v14, RaycastParams_new_ret);

            if v15 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v15.Position - HumanoidRootPart.Position).Unit * (v15.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            else
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v14) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            end;

            u13:Disconnect();
            u5.CamShake:Shake(CameraShaker.Presets.Dunk);
        end);
        u7.AC:Add(task.delay(0.12222222222222222, function() -- Line: 97
            -- upvalues: HumanoidRootPart (copy), TweenService (ref), u7 (copy), RunService (ref)
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = -100;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
            TweenService:Create(NumberValue, TweenInfo.new(0.688888888888889, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Value = -25
            }):Play();
            u7.AC:Add(NumberValue);
            u7.AC:Connect(RunService.Heartbeat, function() -- Line: 112
                -- upvalues: LinearVelocity (copy), HumanoidRootPart (ref), NumberValue (copy)
                if LinearVelocity then
                    LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * NumberValue.Value;
                end;
            end);
            task.delay(0.8555555555555556, function() -- Line: 118
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
        end));

        return;
    end;

    local ServerBallPosition = u4:GetServerBallPosition();
    local v16 = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z) - HumanoidRootPart.Position;
    local v17 = v16:Dot(v16);

    if ReplicatedStorage.GameValues.Scoring.Value then
        u7:ResetCD(2);
        Effects:Popup("Can\'t use after a goal!");

        return;
    end;

    if v17 >= 22500 then
        u7:ResetCD(2);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    if ServerBallPosition.Y > 30 then
        u7:ResetCD(2);
        Effects:Popup("Ball is too far up!");

        return;
    end;

    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall and PlayerPossessingBall.Team == LocalPlayer.Team then
        u7:ResetCD(2);
        Effects:Popup("Enemy player must have the ball!");

        return;
    end;

    u2:StopAll();
    u2:PlayChar("ScaryMonster", "BulletPressure", Enum.AnimationPriority.Action3, true):AdjustSpeed(1.5);
    local v18 = Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.ScaryMonster.BulletPressureRevolver);
    v18:Play();
    v18:AdjustSpeed(1.5);
    v18.Priority = Enum.AnimationPriority.Action3;
    u1.Ability:Fire("Bullet Pressure", {
        State = "Pressure",
        TimeSent = workspace:GetServerTimeNow()
    });
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u20 = RunService.Heartbeat:Connect(function(p19) -- Line: 164
        -- upvalues: FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref)
        FieldOfView = Essentials:Lerp(FieldOfView, 40, p19 * 5);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    u3.States.Ability = true;
    u7.AC:Add(function() -- Line: 171
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.VectorVelocity = (v17 > 0 and v16.Unit or HumanoidRootPart.CFrame.LookVector) * 50;
    LinearVelocity.Parent = HumanoidRootPart;
    local u21 = false;
    u7.AC:Add(function() -- Line: 183
        -- upvalues: u20 (copy), u21 (ref), LinearVelocity (copy)
        u20:Disconnect();

        if not u21 then
            LinearVelocity:Destroy();
        end;
    end);
    u7.AC:Add(task.delay(0.3444444444444445, function() -- Line: 190
        -- upvalues: u21 (ref), u7 (copy), Character (copy), ServerBallPosition (copy), HumanoidRootPart (copy), LinearVelocity (copy), TweenService (ref), u20 (copy), u5 (ref), CameraShaker (ref)
        u21 = true;
        u7.AC:Clean();
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
        RaycastParams_new_ret.FilterDescendantsInstances = { Character };
        RaycastParams_new_ret.CollisionGroup = "Player";
        local v22 = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z) - HumanoidRootPart.Position;
        local v23 = v22:Dot(v22);
        local v24 = v23 > 0 and v22.Unit or HumanoidRootPart.CFrame.LookVector;
        local math_sqrt_ret = math.sqrt(v23);
        local v25 = v24 * math.min(25, math_sqrt_ret);
        local v26 = workspace:Raycast(HumanoidRootPart.Position, v25, RaycastParams_new_ret);

        if v26 then
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + (v26.Position - HumanoidRootPart.Position).Unit * (v26.Distance - 1)) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        else
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position + v25) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        end;

        LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * -100;
        TweenService:Create(LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            VectorVelocity = LinearVelocity.VectorVelocity.Unit * 25
        }):Play();
        task.delay(0.2, function() -- Line: 214
            -- upvalues: LinearVelocity (ref)
            LinearVelocity:Destroy();
        end);
        u20:Disconnect();
        u5.CamShake:Shake(CameraShaker.Presets.Dunk);
    end));
end;