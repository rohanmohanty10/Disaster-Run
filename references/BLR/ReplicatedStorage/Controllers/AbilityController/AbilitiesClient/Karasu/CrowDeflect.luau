  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
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
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), interface (copy), StatesController (copy), Spring (copy), getPlayerTarget (copy), Players (copy), RunService (copy), LocalPlayer (copy), CameraController (copy), Popup (copy), BallController (copy), workspace_CurrentCamera (copy)
    local CrowDeflect = AbilityBalancing.CrowDeflect;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u3, u4, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "CrowDeflect");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local ABC = interface.ABC;
    interface:AbilityCooldown(1, CrowDeflect.Cooldown);
    interface.AbilityService.Ability:Fire("CrowDeflect", {
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
    local math_clamp_ret = math.clamp((u3.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude, 6, 12);
    print(math_clamp_ret);
    local u5 = Spring.new(math_clamp_ret);
    u5.Speed = 16;
    u5.Damper = 1;

    local function changeYVelocity(p6: number) -- Line: 89
        -- upvalues: u3 (copy)
        local AssemblyLinearVelocity = u3.AssemblyLinearVelocity;
        u3.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, p6, AssemblyLinearVelocity.Z);
    end;

    local u9 = getPlayerTarget(false, function(p7, p8) -- Line: 94
        -- upvalues: u3 (copy), CrowDeflect (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p7:GetAttribute("IsTrainingDummy") then
            return (p7.HumanoidRootPart.Position - u3.Position).Magnitude < CrowDeflect.ActivationRangePlayer;
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

        if (p7.HumanoidRootPart.Position - u3.Position).Magnitude < CrowDeflect.ActivationRangePlayer then
            return true;
        end;
    end);

    if u9 and (u9.HumanoidRootPart.Position - u3.Position).Magnitude > CrowDeflect.ActivationRangePlayer then
        u9 = nil;
    end;

    local u10 = false;
    local u11 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 123
        -- upvalues: u5 (copy), CameraController (ref), CrowDeflect (copy), u3 (copy), u10 (ref)
        u5.Target = 55;
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local AssemblyLinearVelocity = u3.AssemblyLinearVelocity;
        u3.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, CrowDeflect.JumpHeight, AssemblyLinearVelocity.Z);
        u10 = true;
        u5.Target = 60;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        u5.Target = 30;
        task.wait(0.2);
        u5.Target = 0;
    end);
    ABC:Add(task.delay(0.8, function() -- Line: 144
        -- upvalues: u11 (ref), u9 (ref), ABC (copy)
        if not (u11 and u9) then
            ABC:Destroy();
        end;
    end));
    ABC:Add(task_spawn_ret);
    ABC:Add(task.delay(5, function() -- Line: 151
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    local os_clock_ret = os.clock();
    local u12 = false;

    local function onLanded() -- Line: 160
        -- upvalues: u12 (ref), BodyVelocity (copy)
        u12 = true;
        BodyVelocity:Destroy();
    end;

    ABC:Add(interface.AbilityService.Ability:Connect(function(p13, u14) -- Line: 165
        -- upvalues: CameraController (ref), u11 (ref), task_spawn_ret (copy), u12 (ref), BodyVelocity (copy), os_clock_ret (copy), u9 (ref), interface (ref), Track (copy), Popup (ref), LocalPlayer (ref), ABC (copy), StatesController (ref), Character (copy), BallController (ref), RunService (ref)
        if p13 == "Start" and u14 then
            CameraController.FOVBonus = 14;
            u11 = true;
            task.cancel(task_spawn_ret);
            u12 = true;
            BodyVelocity:Destroy();
            u12 = true;
            task.wait(1.6 - (os.clock() - os_clock_ret));

            if u9 then
                interface.AbilityService.Ability:Fire("CrowDeflect", {
                    Target = u9
                });
            else
                Track:Stop();
                Popup.Popup(LocalPlayer, "No teammate to pass to!");
                ABC:Destroy();
            end;

            task.wait(0.3);

            if not u12 then
                CameraController.FOVBonus = 7;
            end;
        elseif u14 then
            StatesController.States.Ability = false;
            local HumanoidRootPart = Character.HumanoidRootPart;
            local HumanoidRootPart2 = u9.HumanoidRootPart;
            local u15 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
            local math_clamp_ret2 = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
            u14.AssemblyLinearVelocity = u15 * math_clamp_ret2;
            BallController:DragBall(u14);
            local u16 = tick();
            ABC:Connect(RunService.Heartbeat, function(p17) -- Line: 207
                -- upvalues: u16 (copy), u14 (copy), ABC (ref), HumanoidRootPart2 (copy), u15 (ref), math_clamp_ret2 (ref), HumanoidRootPart (copy)
                if tick() > u16 + 2 or (not u14 or u14.OnPlayer.Value) then
                    return ABC:Clean();
                end;

                local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
                local v18 = tick() > u16 + 0.55;
                u15 = u15:Lerp((HumanoidRootPart2.Position - u14.Position).Unit + Vector3.new(0, v18 and 0.15 or 0.35, 0), 6.5 * p17);
                math_clamp_ret2 = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

                if u14.Position.Y < 5 or (HumanoidRootPart2.Position - u14.Position).Magnitude <= 7 then
                    ABC:Clean();

                    return;
                end;

                u14.AssemblyLinearVelocity = u14.AssemblyLinearVelocity:Lerp(u15 * math_clamp_ret2, 6.5 * p17);
            end);
        end;
    end));
    ABC:Add(u4.StateChanged:Connect(function(p19) -- Line: 238
        -- upvalues: u12 (ref), u11 (ref), BodyVelocity (copy)
        if u12 or not u11 then
            return;
        end;

        if p19 == Enum.HumanoidStateType.Landed then
            u12 = true;
            BodyVelocity:Destroy();
        end;
    end));
    local MoveDirection = u4.MoveDirection;

    if MoveDirection.Magnitude == 0 then
        MoveDirection = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    ABC:Add(RunService.RenderStepped:Connect(function(p20) -- Line: 254
        -- upvalues: u10 (ref), u11 (ref), u12 (ref), u4 (copy), BodyVelocity (copy), MoveDirection (ref), u5 (copy), AbilityUtils (ref), u3 (copy)
        if u10 and (u11 and (not u12 and u4:GetState() == Enum.HumanoidStateType.Running)) then
            u12 = true;
            BodyVelocity:Destroy();
        end;

        if u12 then
            return;
        end;

        local v21 = MoveDirection * u5.Position;
        BodyVelocity.MaxForce = Vector3.new(1000000000, 0, 1000000000);
        BodyVelocity.Velocity = v21;

        if AbilityUtils.wallCheck(u3.CFrame.Position, v21 * 1 / 30) then
            BodyVelocity.Velocity = Vector3.new(0, 0, 0);
        end;

        print(BodyVelocity.Velocity);
        u3.CFrame = CFrame.lookAlong(u3.CFrame.Position, MoveDirection);
    end));
    ABC:Add(function() -- Line: 282
        -- upvalues: Track (copy), CameraController (ref), StatesController (ref), BodyForce (copy), BodyVelocity (copy)
        Track:Stop();
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
        BodyForce:Destroy();
        BodyVelocity:Destroy();
    end);
end;