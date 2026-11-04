  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local SkeletonTrap = require(ReplicatedStorage.AbilityBalancing).SkeletonTrap;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, u3) -- Line: 27, Name: Trap
    -- upvalues: ReplicatedStorage (copy), AbilityUtils (copy), StatesController (copy), AnimationController (copy), RunService (copy), SkeletonTrap (copy)
    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if ReplicatedStorage.GameValues.AbilityDb.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if p2.Character:GetAttribute("SkeletonTrap") then
        return;
    end;

    if not AbilityUtils.rules.slotReady(1) then
        return;
    end;

    if u1.InAbility then
        return;
    end;

    local ABC = u1.ABC;

    if ABC then
        ABC:Clean();
    end;

    local Value = u3.Values.HasBall.Value;
    u1:AbilityCooldown("1", 1);
    u1.AbilityService.Ability:Fire("SkeletonTrap");
    StatesController.States.Ability = true;
    u1.InAbility = true;

    for _, descendant in u3.HumanoidRootPart:GetDescendants() do
        if descendant:IsA("BodyMover") then
            descendant:Destroy();
        end;
    end;

    u1.Animations:StopAnims();
    AnimationController:GetTrack("Abilities", "SkeletonTrap"):Play();

    if Value then
        AnimationController:GetBallTrack("SkeletonTrapBall"):Play();
    end;

    task.delay(0.5, function() -- Line: 69
        -- upvalues: u1 (copy), RunService (ref), u3 (copy), Value (ref)
        u1.JustOne = tick() + 0.3;
        u1.ABC:Connect(RunService.Heartbeat, function() -- Line: 71
            -- upvalues: u3 (ref), u1 (ref), Value (ref)
            if u3 == nil then
                if u1.ABC then
                    u1.ABC:Clean();
                end;

                u1.InAbility = false;

                return;
            end;

            if tick() >= u1.JustOne or (u1.InAbility == false or u3.Values.HasBall.Value == false and Value) then
                u1.ABC:Clean();
            end;

            if u3.Values.HasBall.Value then
                Value = true;
            end;
        end);
    end);
    ABC:Add(function() -- Line: 92
        -- upvalues: Value (ref), u1 (copy), SkeletonTrap (ref), StatesController (ref)
        if not Value then
            u1:AbilityCooldown("1", SkeletonTrap.Cooldown);
        end;

        task.delay(1.4, function() -- Line: 97
            -- upvalues: u1 (ref), SkeletonTrap (ref)
            u1:AbilityCooldown("1", SkeletonTrap.Cooldown);
        end);
        StatesController.States.Ability = false;
        u1.InAbility = false;
    end);
end;