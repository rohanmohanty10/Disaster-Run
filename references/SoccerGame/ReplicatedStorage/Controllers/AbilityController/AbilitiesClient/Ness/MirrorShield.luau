  

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
    local MirrorShield = AbilityBalancing.MirrorShield;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u3, v4, _ = AbilityUtils.getCharacter();
    local Track = AnimationController:GetTrack("Abilities", "MirrorShieldStart");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    local ABC = interface.ABC;
    interface:AbilityCooldown(1, MirrorShield.Cooldown);
    interface.AbilityService.Ability:Fire("MirrorShield", {
        HitboxStart = workspace:GetServerTimeNow() + 0.6
    });
    StatesController.States.Ability = true;
    Track:Play();
    math.clamp((Vector3.new(0, 1, 0)).Magnitude, 1, 3);
    local v5 = Spring.new(Vector3.new(0, 1, 0));
    v5.Speed = 8;
    v5.Damper = 1;

    local function changeYVelocity(p6: number) -- Line: 84
        -- upvalues: u3 (copy), ABC (copy)
        local _ = u3.AssemblyLinearVelocity;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
        BodyVelocity.Velocity = u3.CFrame.LookVector * 75 + Vector3.new(0, 50, 0);
        BodyVelocity.Parent = u3;
        game.Debris:AddItem(BodyVelocity, 0.1);
        ABC:Add(BodyVelocity);
    end;

    local u9 = getPlayerTarget(false, function(p7, p8) -- Line: 97
        -- upvalues: u3 (copy), MirrorShield (copy), Players (ref), RunService (ref), LocalPlayer (ref)
        if p7:GetAttribute("IsTrainingDummy") then
            return (p7.HumanoidRootPart.Position - u3.Position).Magnitude < MirrorShield.ActivationRangePlayer;
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

        if (p7.HumanoidRootPart.Position - u3.Position).Magnitude < MirrorShield.ActivationRangePlayer then
            return true;
        end;
    end);

    if u9 and (u9.HumanoidRootPart.Position - u3.Position).Magnitude > MirrorShield.ActivationRangePlayer then
        u9 = nil;
    end;

    print(u9);
    local u10 = false;
    local task_spawn_ret = task.spawn(function() -- Line: 128
        -- upvalues: CameraController (ref), MirrorShield (copy), u3 (copy), ABC (copy), u10 (ref)
        CameraController.FOVBonus = 3;
        task.wait(0.15);
        CameraController.FOVBonus = 10;
        local _ = u3.AssemblyLinearVelocity;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
        BodyVelocity.Velocity = u3.CFrame.LookVector * 75 + Vector3.new(0, 50, 0);
        BodyVelocity.Parent = u3;
        game.Debris:AddItem(BodyVelocity, 0.1);
        ABC:Add(BodyVelocity);
        u10 = true;
        task.wait(0.4);
        CameraController.FOVBonus = 3;
        task.wait(0.2);
    end);
    ABC:Add(task.delay(1.2, function() -- Line: 149
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    ABC:Add(task_spawn_ret);
    ABC:Add(task.delay(5, function() -- Line: 156
        -- upvalues: ABC (copy)
        ABC:Destroy();
    end));
    os.clock();
    local u11 = false;

    local function onLanded() -- Line: 165
        -- upvalues: u11 (ref)
        u11 = true;
    end;

    ABC:Add(interface.AbilityService.Ability:Connect(function(u12, p13) -- Line: 172
        -- upvalues: AnimationController (ref), u9 (ref), Character (copy), BallController (ref), ABC (copy), RunService (ref), interface (ref), workspace_CurrentCamera (ref), AbilityBalancing (ref)
        if not u12 then
            AnimationController:GetTrack("Abilities", "MirrorShieldHit"):Play();

            return;
        end;

        if not u9 then
            u12.AssemblyLinearVelocity = workspace_CurrentCamera.CFrame.LookVector * AbilityBalancing.DragonicVolley.ShotPower;
            BallController:DragBall(u12);

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = u9.HumanoidRootPart;
        local u14 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0) + -HumanoidRootPart.CFrame.RightVector * 0.8;
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 200);
        u12.AssemblyLinearVelocity = u14 * math_clamp_ret;
        BallController:DragBall(u12);
        local u15 = tick();
        ABC:Connect(RunService.Heartbeat, function(p16) -- Line: 193
            -- upvalues: u15 (copy), u12 (copy), ABC (ref), HumanoidRootPart2 (copy), u14 (ref), math_clamp_ret (ref), HumanoidRootPart (copy), interface (ref), u9 (ref)
            if tick() > u15 + 1.25 or (not u12 or u12.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v17 = tick() > u15 + 0.55;
            u14 = u14:Lerp((HumanoidRootPart2.Position - u12.Position).Unit + Vector3.new(0, v17 and 0.15 or 0.35, 0), 6.5 * p16);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);
            local _ = u12.Position.Y < 5;

            if (HumanoidRootPart2.Position - u12.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u12.AssemblyLinearVelocity = u12.AssemblyLinearVelocity:Lerp(u14 * math_clamp_ret, 6.5 * p16);
            interface.AbilityService.Ability:Fire("MirrorShield", {
                Target = u9
            });
        end);
    end));
    ABC:Add(v4.StateChanged:Connect(function(p18) -- Line: 232
    end));

    if v4.MoveDirection.Magnitude == 0 then
        local _ = (workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    end;

    ABC:Add(function() -- Line: 249
        -- upvalues: CameraController (ref), StatesController (ref)
        CameraController.FOVBonus = 0;
        StatesController.States.Ability = false;
    end);
end;