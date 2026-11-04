  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1, p2) -- Line: 18
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), StatesController (copy), ReplicatedStorage (copy)
    local SnakeVision = AbilityBalancing.SnakeVision;
    AbilityUtils.rules.offball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    u1:AbilityCooldown(3, SnakeVision.Cooldown);
    local ABC = u1.ABC;
    local Character, _, _, _ = AbilityUtils.getCharacter();
    StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionStart");
    u1.AbilityService.Ability:Fire("SnakeVision", {
        State = "Enable"
    });
    require(ReplicatedStorage.Effects.Aiku.SnakeVisionVFX)();
    Character:SetAttribute("SnakeVision", true);
    ABC:Add(function() -- Line: 42, Name: disableSkill
        -- upvalues: u1 (copy), Character (copy), StatesController (ref)
        u1.AbilityService.Ability:Fire("SnakeVision", {
            State = "Disable"
        });
        Character:SetAttribute("SnakeVision", false);
        StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionEnd");
    end);
    ABC:Add(p2.CharacterRemoving:Connect(function() -- Line: 50
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    task.delay(SnakeVision.Duration, function() -- Line: 54
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;