  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1) -- Line: 17
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy)
    local SkullRoulette = AbilityBalancing.SkullRoulette;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local Character, u2, _, _ = AbilityUtils.getCharacter();
    u1.StatesController.States.Ability = true;
    u1:AbilityCooldown(3, SkullRoulette.Cooldown);
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "SkullRoulette");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local ABC = u1.ABC;
    u1.AbilityService.Ability:Fire("SkullRoulette");
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.CollisionGroup = "Player";
    RaycastParams_new_ret.FilterDescendantsInstances = { Character };
    local SkullRoulette2 = AbilityBalancing.SkullRoulette;
    ABC:Add(function() -- Line: 54
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    ABC:Add(AbilityUtils.execute.shot(SkullRoulette2));
    ABC:Add(task.delay(0.6, function() -- Line: 60
        -- upvalues: AbilityUtils (ref), Character (copy), u2 (copy), SkullRoulette2 (copy), ABC (copy)
        local v3, v4 = AbilityUtils.FastDashTo(Character, (u2.CFrame * CFrame.new(0, SkullRoulette2.TravelDistance, 0)).Position, 2, 0.3);
        ABC:Add(v3);
        ABC:Add(v4);
    end));
    task.delay(1.45, function() -- Line: 68
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;