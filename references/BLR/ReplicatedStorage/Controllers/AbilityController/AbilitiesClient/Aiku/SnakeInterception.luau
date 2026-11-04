  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local SnakeInterception = require(ReplicatedStorage.AbilityBalancing).SnakeInterception;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1, p2, p3) -- Line: 26
    -- upvalues: AbilityUtils (copy), SnakeInterception (copy), AnimationController (copy), StatesController (copy)
    AbilityUtils.rules.offball(nil, false);

    if not (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    local ABC = p1.ABC;

    if ABC then
        ABC:Clean();
    end;

    p1:AbilityCooldown("2", SnakeInterception.Cooldown);
    p1.Animations:StopAnims();
    AnimationController:GetTrack("Abilities", "SnakeInterception"):Play();
    StatesController.States.Ability = true;
    p1.AbilityService.Ability:Fire("SnakeInterception");
    ABC:Add(AbilityUtils.execute.shot(SnakeInterception));
    ABC:Add(function() -- Line: 51
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
    task.delay(1.5, function() -- Line: 56
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;