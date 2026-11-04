  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerScriptService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local Spring = require(ReplicatedStorage.Shared.Spring);
local ExplosiveAcceleration = require(script.Parent.ExplosiveAcceleration);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local workspace_CurrentCamera = workspace.CurrentCamera;

local function ClampMagnitude(p1, p2) -- Line: 24
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit * math.min(p1.Magnitude, p2);
end;

return function(u3) -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy), Spring (copy), CameraController (copy), ExplosiveAcceleration (copy), workspace_CurrentCamera (copy), RunService (copy)
    local SwiftIntercept = AbilityBalancing.SwiftIntercept;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local _, u4, u5, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "SwiftInterceptJump");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local Track2 = AnimationController:GetTrack("Abilities", "SwiftInterceptSuccess");
    Track2.Looped = true;
    Track2.Priority = Enum.AnimationPriority.Action4;
    local BallTrack = AnimationController:GetBallTrack("LokiSwiftInterceptCatch");
    BallTrack.Looped = true;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    local AbilityTrove = u3.AbilityTrove;
    u3:AbilityCooldown(3, SwiftIntercept.Cooldown);
    u3.AbilityService.Ability:Fire("SwiftIntercept", workspace:GetServerTimeNow() + 0.35);
    StatesController.States.Ability = true;
    Track:Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = u4;
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Force = Vector3.new(0, -workspace.Gravity * u4.AssemblyMass * 0.75, 0);
    BodyForce.Parent = u4;
    local math_clamp_ret = math.clamp((u4.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude, 6, 12);
    local u6 = Spring.new(math_clamp_ret);
    u6.Speed = 16;
    u6.Damper = 1;

    local function changeYVelocity(p7: number) -- Line: 87
        -- upvalues: u4 (copy)
        local AssemblyLinearVelocity = u4.AssemblyLinearVelocity;
        u4.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, p7, AssemblyLinearVelocity.Z);
    end;

    local u8 = false;
    local u9 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 97
        -- upvalues: u6 (copy), CameraController (ref), SwiftIntercept (copy), u4 (copy), u8 (ref), AbilityTrove (copy)
        u6.Target = 55;
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local AssemblyLinearVelocity = u4.AssemblyLinearVelocity;
        u4.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, SwiftIntercept.JumpHeight, AssemblyLinearVelocity.Z);
        u8 = true;
        u6.Target = 60;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        u6.Target = 30;
        task.wait(0.4);
        u6.Target = 0;
        task.wait(0.5);
        AbilityTrove:Destroy();
    end);
    AbilityTrove:Add(task_spawn_ret);
    AbilityTrove:Add(task.delay(5, function() -- Line: 119
        -- upvalues: AbilityTrove (copy)
        AbilityTrove:Destroy();
    end));
    local u10 = false;
    AbilityTrove:Add(u3.AbilityService.Ability:Connect(function(p11) -- Line: 126
        -- upvalues: CameraController (ref), u9 (ref), task_spawn_ret (copy), Track (copy), Track2 (copy), u10 (ref)
        if p11 then
            CameraController.FOVBonus = 14;
            u9 = true;
            task.cancel(task_spawn_ret);
            Track:Stop(0);
            Track2:Play(0);
            task.wait(0.3);

            if not u10 then
                CameraController.FOVBonus = 7;
            end;
        end;
    end));

    local function onLanded() -- Line: 143
        -- upvalues: u10 (ref), Track2 (copy), AbilityTrove (copy), ExplosiveAcceleration (ref), u3 (copy)
        u10 = true;
        Track2:Stop(0.25);
        AbilityTrove:Destroy();
        ExplosiveAcceleration(u3, "SwiftIntercept");
    end;

    AbilityTrove:Add(u5.StateChanged:Connect(function(p12) -- Line: 150
        -- upvalues: u10 (ref), u9 (ref), Track2 (copy), AbilityTrove (copy), ExplosiveAcceleration (ref), u3 (copy)
        if u10 or not u9 then
            return;
        end;

        if p12 == Enum.HumanoidStateType.Landed then
            u10 = true;
            Track2:Stop(0.25);
            AbilityTrove:Destroy();
            ExplosiveAcceleration(u3, "SwiftIntercept");
        end;
    end));
    local MoveDirection = u5.MoveDirection;

    if MoveDirection.Magnitude == 0 then
        MoveDirection = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    AbilityTrove:Add(RunService.RenderStepped:Connect(function(p13) -- Line: 165
        -- upvalues: u8 (ref), u9 (ref), u10 (ref), u5 (copy), Track2 (copy), AbilityTrove (copy), ExplosiveAcceleration (ref), u3 (copy), MoveDirection (ref), u6 (copy), BodyVelocity (copy), AbilityUtils (ref), u4 (copy)
        if u8 and (u9 and (not u10 and u5:GetState() == Enum.HumanoidStateType.Running)) then
            u10 = true;
            Track2:Stop(0.25);
            AbilityTrove:Destroy();
            ExplosiveAcceleration(u3, "SwiftIntercept");
        end;

        local v14 = MoveDirection * u6.Position;
        BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
        BodyVelocity.Velocity = v14;

        if AbilityUtils.wallCheck(u4.CFrame.Position, v14 * 1 / 30) then
            print("did hit a wall");
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;

        u4.CFrame = CFrame.lookAlong(u4.CFrame.Position, MoveDirection);
    end));
    AbilityTrove:Add(function() -- Line: 188
        -- upvalues: Track (copy), Track2 (copy), BallTrack (copy), CameraController (ref), StatesController (ref), BodyForce (copy), BodyVelocity (copy)
        Track:Stop();
        Track2:Stop();
        BallTrack:Stop(0);
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end);
end;