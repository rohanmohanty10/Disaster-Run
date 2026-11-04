  

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
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), interface (copy), StatesController (copy), Spring (copy), getPlayerTarget (copy), Players (copy), RunService (copy), LocalPlayer (copy), CameraController (copy), BallController (copy), workspace_CurrentCamera (copy)
    local AbsoluteZeroDefense = AbilityBalancing.AbsoluteZeroDefense;

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    local u3 = false;
    local _, u4, u5, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "AbsoluteZeroDefense");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local ABC = interface.ABC;
    interface:AbilityCooldown(2, AbsoluteZeroDefense.Cooldown);
    interface.AbilityService.Ability:Fire("AbsoluteZeroDefense", {
        HitboxStart = workspace:GetServerTimeNow() + 0.35
    });
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
    print(math_clamp_ret);
    local u6 = Spring.new(math_clamp_ret);
    u6.Speed = 16;
    u6.Damper = 1;

    local function changeYVelocity(p7: number) -- Line: 82
        -- upvalues: u4 (copy)
        local _ = u4.AssemblyLinearVelocity;
        u4.AssemblyLinearVelocity = Vector3.new(0, p7, 0);
    end;

    local v10 = getPlayerTarget(false, function(p8, p9) -- Line: 87
        -- upvalues: u4 (copy), AbsoluteZeroDefense (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p8:GetAttribute("IsTrainingDummy") then
            return (p8.HumanoidRootPart.Position - u4.Position).Magnitude < AbsoluteZeroDefense.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p8);

        if RunService:IsStudio() then
            return true;
        end;

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team ~= LocalPlayer.Team then
            return false;
        end;

        if p8.Values.InCutscene.Value then
            return false;
        end;

        if (p8.HumanoidRootPart.Position - u4.Position).Magnitude < AbsoluteZeroDefense.ActivationRangePlayer then
            return true;
        end;
    end);
    local _ = v10 and (v10.HumanoidRootPart.Position - u4.Position).Magnitude > AbsoluteZeroDefense.ActivationRangePlayer;
    local u11 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 116
        -- upvalues: u6 (copy), CameraController (ref), AbsoluteZeroDefense (copy), u4 (copy), u11 (ref)
        u6.Target = 55;
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local _ = u4.AssemblyLinearVelocity;
        u4.AssemblyLinearVelocity = Vector3.new(0, AbsoluteZeroDefense.JumpHeight, 0);
        u11 = true;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        task.wait(0.2);
    end);
    ABC:Add(task.delay(0.8, function() -- Line: 137
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(task_spawn_ret);
    ABC:Add(task.delay(5, function() -- Line: 144
        -- upvalues: u3 (ref), ABC (copy)
        if not u3 then
            ABC:Clean();
        end;
    end));
    os.clock();
    local u12 = false;

    local function onLanded() -- Line: 156
        -- upvalues: u12 (ref), BodyVelocity (copy)
        u12 = true;
        BodyVelocity:Destroy();
    end;

    ABC:Add(interface.AbilityService.Ability:Connect(function(p13, p14) -- Line: 163
        -- upvalues: BallController (ref)
        p13.AssemblyLinearVelocity = p14;
        BallController:DragBall(p13);
    end));
    ABC:Add(u5.StateChanged:Connect(function(p15) -- Line: 168
    end));
    local u16 = Vector3.new(0, 1, 0);

    if u16.Magnitude == 0 then
        u16 = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    ABC:Add(RunService.RenderStepped:Connect(function(p17) -- Line: 184
        -- upvalues: u11 (ref), u12 (ref), u5 (copy), BodyVelocity (copy), u16 (ref), u6 (copy), AbilityUtils (ref), u4 (copy)
        if u12 then
            return;
        end;

        local v18 = u16 * u6.Position;
        BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
        BodyVelocity.Velocity = v18;

        if AbilityUtils.wallCheck(u4.CFrame.Position, v18 * 1 / 30) then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;
    end));
    ABC:Add(function() -- Line: 211
        -- upvalues: u3 (ref), CameraController (ref), StatesController (ref), BodyForce (copy), BodyVelocity (copy)
        u3 = true;
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end);
end;