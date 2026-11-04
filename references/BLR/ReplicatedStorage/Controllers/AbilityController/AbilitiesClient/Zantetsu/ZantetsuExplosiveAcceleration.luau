  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ZantetsuExplosiveAcceleration = require(ReplicatedStorage2.AbilityBalancing).ZantetsuExplosiveAcceleration;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28, Name: ExplosiveAcceleration
    -- upvalues: AbilityUtils (copy), interface (copy), StatesController (copy), ZantetsuExplosiveAcceleration (copy), AnimationController (copy), LocalPlayer (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 41
        -- upvalues: StatesController (ref), interface (ref), ZantetsuExplosiveAcceleration (ref)
        StatesController.States.Ability = false;
        StatesController.States.AllowedAbility = nil;

        if interface.MotorCar then
            task.delay(1, function() -- Line: 46
                -- upvalues: interface (ref), ZantetsuExplosiveAcceleration (ref)
                interface:AbilityCooldown(1, ZantetsuExplosiveAcceleration.Cooldown);
                interface.MotorCar = false;
            end);

            return;
        end;

        interface:AbilityCooldown(1, ZantetsuExplosiveAcceleration.Cooldown);
    end);
    local Track = AnimationController:GetTrack("Abilities", "ExplosiveAcceleration1");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface:AbilityCooldown(1, 0.9);
    interface.AbilityService.Ability:Fire("ZantetsuExplosiveAcceleration");
    local LookVector = u1.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local v2, v3 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * ZantetsuExplosiveAcceleration.TravelDistance, -2, 0.9);
    ABC:Add(v2);
    ABC:Add(v3);
    ABC:Add(task.delay(2.3, function() -- Line: 72
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(Character.Humanoid.Died:Connect(function() -- Line: 76
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(task.delay(0.9, function() -- Line: 80
        -- upvalues: AbilityUtils (ref), LocalPlayer (ref), interface (ref), Track (copy), AnimationController (ref), StatesController (ref), ABC (copy), u1 (copy), ZantetsuExplosiveAcceleration (ref), Character (copy)
        if not AbilityUtils.rules.onball(LocalPlayer, false) then
            ABC:Clean();

            return;
        end;

        interface.MotorCar = true;
        Track:Stop();
        local Track2 = AnimationController:GetTrack("Abilities", "ExplosiveAcceleration2");
        Track2.Looped = false;
        Track2.Priority = Enum.AnimationPriority.Action3;
        Track2:Play();
        StatesController.States.AllowedAbility = { 1, 2 };
        interface.AbilityService.Ability:Fire("ZantetsuExplosiveAcceleration", {
            Type = "Second"
        });
        ABC:Add(task.delay(0.4, function() -- Line: 94
            -- upvalues: u1 (ref), ZantetsuExplosiveAcceleration (ref), AbilityUtils (ref), Character (ref), ABC (ref)
            local LookVector2 = u1.CFrame.LookVector;
            local Unit2 = Vector3.new(LookVector2.X, 0, LookVector2.Z).Unit;
            local v4, v5 = AbilityUtils.FastDashTo(Character, u1.Position + Unit2 * ZantetsuExplosiveAcceleration.TravelDistance, -2, 1);
            ABC:Add(v4);
            ABC:Add(v5);
        end));
    end));
end;