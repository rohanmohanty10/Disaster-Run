  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
local CameraController = require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local Spring = require(ReplicatedStorage2.Shared.Spring);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

local function ClampMagnitude(p1, p2) -- Line: 30
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit * math.min(p1.Magnitude, p2);
end;

return function() -- Line: 35
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), interface (copy), StatesController (copy), Spring (copy), getPlayerTarget (copy), Players (copy), RunService (copy), LocalPlayer (copy), CameraController (copy), workspace_CurrentCamera (copy), BallController (copy)
    local DragonicVolley = AbilityBalancing.DragonicVolley;
    print("Here");

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    print("Passdd");
    local _, u3, v4, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "DragonDriveKick");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local ABC = interface.ABC;
    interface:AbilityCooldown(1, DragonicVolley.Cooldown);
    interface.AbilityService.Ability:Fire("DragonDriveNew", {
        HitboxStart = workspace:GetServerTimeNow() + 0.35
    });
    StatesController.States.Ability = true;
    Track:Play();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
    BodyVelocity.Velocity = Vector3.new(0, 0, 0);
    BodyVelocity.Parent = u3;
    local BodyForce = Instance.new("BodyForce");
    BodyForce.Force = Vector3.new(0, -workspace.Gravity * u3.AssemblyMass * 0.75, 0);
    BodyForce.Parent = u3;
    math.clamp((Vector3.new(0, 1, 0)).Magnitude, 1, 3);
    local u5 = Spring.new(Vector3.new(0, 1, 0));
    u5.Speed = 8;
    u5.Damper = 1;

    local function changeYVelocity(p6: number) -- Line: 88
        -- upvalues: u3 (copy)
        local AssemblyLinearVelocity = u3.AssemblyLinearVelocity;
        u3.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, p6, AssemblyLinearVelocity.Z);
    end;

    local v9 = getPlayerTarget(false, function(p7, p8) -- Line: 93
        -- upvalues: u3 (copy), DragonicVolley (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p7:GetAttribute("IsTrainingDummy") then
            return (p7.HumanoidRootPart.Position - u3.Position).Magnitude < DragonicVolley.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p7);

        if RunService:IsStudio() then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p7.Values.InCutscene.Value then
            return false;
        end;

        if (p7.HumanoidRootPart.Position - u3.Position).Magnitude < DragonicVolley.ActivationRangePlayer then
            return true;
        end;
    end);
    local _ = v9 and (v9.HumanoidRootPart.Position - u3.Position).Magnitude > DragonicVolley.ActivationRangePlayer;
    local u10 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 122
        -- upvalues: u5 (copy), CameraController (ref), DragonicVolley (copy), u3 (copy), u10 (ref)
        u5.Target = 35;
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local AssemblyLinearVelocity = u3.AssemblyLinearVelocity;
        u3.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, DragonicVolley.JumpHeight, AssemblyLinearVelocity.Z);
        u10 = true;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        task.wait(0.2);
    end);
    ABC:Add(task.delay(1.2, function() -- Line: 143
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    ABC:Add(task_spawn_ret);
    ABC:Add(task.delay(5, function() -- Line: 150
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    os.clock();
    local u11 = false;

    local function onLanded() -- Line: 159
        -- upvalues: u11 (ref), BodyVelocity (copy)
        u11 = true;
        BodyVelocity:Destroy();
    end;

    ABC:Add(interface.AbilityService.Ability:Connect(function(p12, p13) -- Line: 166
        -- upvalues: AnimationController (ref), workspace_CurrentCamera (ref), AbilityBalancing (ref), BallController (ref)
        if not p12 then
            AnimationController:GetTrack("Abilities", "DragonicVolleyShot"):Play();

            return;
        end;

        p12.AssemblyLinearVelocity = workspace_CurrentCamera.CFrame.LookVector * AbilityBalancing.DragonicVolley.ShotPower;
        BallController:DragBall(p12);
    end));
    ABC:Add(v4.StateChanged:Connect(function(p14) -- Line: 177
    end));

    if v4.MoveDirection.Magnitude == 0 then
        local _ = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    ABC:Add(function() -- Line: 194
        -- upvalues: CameraController (ref), StatesController (ref), BodyForce (copy), BodyVelocity (copy)
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end);
end;