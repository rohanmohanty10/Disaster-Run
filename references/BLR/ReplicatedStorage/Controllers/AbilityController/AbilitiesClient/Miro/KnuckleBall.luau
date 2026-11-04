  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
local BallController = require(ReplicatedStorage.Controllers.BallController);
require(ReplicatedStorage.Shared.Spring);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local KnuckleBall = require(ReplicatedStorage.AbilityBalancing).KnuckleBall;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function() -- Line: 31
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), KnuckleBall (copy), StatesController (copy), BallController (copy), RunService (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    interface.KnuckleBall = nil;
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "KnuckleBall"):Play();
    interface:AbilityCooldown(1, KnuckleBall.Cooldown);
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("KnuckleBall");
    ABC:Connect(interface.AbilityService.Ability, function(u1) -- Line: 54
        -- upvalues: KnuckleBall (ref), BallController (ref), ABC (copy), RunService (ref)
        u1.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + KnuckleBall.ShotTiltVector) * KnuckleBall.ShotPower;
        BallController:DragBall(u1);
        local u2 = tick();
        ABC:Connect(RunService.Heartbeat, function(p3) -- Line: 63
            -- upvalues: u1 (copy), ABC (ref), u2 (copy)
            if not u1 or u1.OnPlayer.Value then
                return ABC:Clean();
            end;

            local v4 = tick() - u2;

            if v4 > 0.4 then
                local math_random_ret = math.random(-2, 2);
                local Vector3_new_ret = Vector3.new(math_random_ret, 0, math.random(-2, 2));
                u1.AssemblyLinearVelocity = u1.AssemblyLinearVelocity + Vector3_new_ret * p3 * 10;
            end;

            if v4 > 2 then
                return ABC:Clean();
            end;
        end);
    end);
    ABC:Add(function() -- Line: 91
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(2, function() -- Line: 96
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;