 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local u5 = RunService:IsStudio();

return function(u6) -- Line: 22, Name: Pushoff
    -- upvalues: LocalPlayer (copy), u5 (copy), Effects (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), Essentials (copy), TweenService (copy), RunService (copy), ReplicatedStorage (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v7 = u6:CheckInfront(25);

    if v7 == nil and u5 then
        v7 = workspace.DefenseRig;
    end;

    if not v7 then
        u6:ResetCD(3);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    if math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 80 then
        u6:ResetCD(3);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    u2 = u6.MovementController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2.States.Shooting = true;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u6.AC:Add(task.delay(3, function() -- Line: 44
        -- upvalues: u6 (copy), u2 (ref)
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.Shooting = false;
        u2.States.NoWalk = false;
    end));
    u3:StopAll();
    u3:PlayChar("Playmaker", `PushOff{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Playmaker", `PushOff{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("PushOff", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = (1 / 0);
    LinearVelocity.Parent = HumanoidRootPart;
    local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
    local u8 = "Start";
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local u9 = -HumanoidRootPart.CFrame.LookVector;
    local u10 = 30;
    local u11 = TweenService:GetValue(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out) * 23;
    u6.AC:Connect(RunService.Heartbeat, function(p12) -- Line: 66
        -- upvalues: LinearVelocity (copy), LookVector (ref), u10 (ref), u11 (ref), HumanoidRootPart (copy), Position (copy)
        LinearVelocity.VectorVelocity = LookVector * u10;
        u10 = u10 - u11 * (p12 * 3.25);
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));

        if u10 <= 15 then
            u10 = 15;
        end;
    end);
    u6.AC:Add(LinearVelocity);
    task.spawn(function() -- Line: 74
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1), {
            FieldOfView = 60
        }):Play();
        task.delay(0.4, function() -- Line: 78
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2), {
                FieldOfView = 80
            }):Play();
        end);
        task.delay(1.23, function() -- Line: 82
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 30
            }):Play();
        end);
        task.delay(2, function() -- Line: 86
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.1), {
                FieldOfView = 70
            }):Play();
        end);
    end);
    task.delay(0.4, function() -- Line: 91
        -- upvalues: u8 (ref), LookVector (ref), u10 (ref), u11 (ref), TweenService (ref)
        u8 = "Back";
        LookVector = -LookVector;
        u10 = 60;
        u11 = TweenService:GetValue(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 23;
    end);
    task.delay(1.23, function() -- Line: 92
        -- upvalues: u8 (ref), LookVector (ref), u10 (ref), u11 (ref), TweenService (ref)
        u8 = "Jump";
        LookVector = LookVector + Vector3.new(0, 0.65, 0);
        u10 = 30;
        u11 = TweenService:GetValue(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out) * 23;
    end);
    u6.AC:Connect(u1.Ability, function() -- Line: 94
        -- upvalues: LinearVelocity (copy), u6 (copy), u2 (ref), HumanoidRootPart (copy), u9 (copy), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
        local _ = LinearVelocity.VectorVelocity;
        u6.AC:Clean();
        u2.States.Ability = false;
        u2.States.Shooting = false;
        u2.States.NoWalk = false;
        task.delay(0.025, function() -- Line: 97
            -- upvalues: HumanoidRootPart (ref), u9 (ref)
            HumanoidRootPart.AssemblyLinearVelocity = (u9 - Vector3.new(0, 0.05, 0)) * 120;
        end);
        local Value = ReplicatedStorage.Basketball.Value;
        u2.States.Shooting = false;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
        local Position2 = Value.Position;
        local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
        local v13 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
        local math_log_ret = math.log(1 + v13.Magnitude * 0.045);
        Value.AssemblyLinearVelocity = v13 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
    end);
end;