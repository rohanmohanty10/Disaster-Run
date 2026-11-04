  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local _ = Players.LocalPlayer;

return function() -- Line: 15
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local _, v1, _, _ = AbilityUtils.getCharacter();

    if not v1 then
        return;
    end;

    local Stoppage = AbilityBalancing.Stoppage;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface:AbilityCooldown(1, Stoppage.Cooldown);
    interface.AbilityService.Ability:Fire("Stoppage");
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    StatesController.SpeedBoost = Stoppage.MoveSpeedValue;
    local Track = AnimationController:GetTrack("Abilities", "Stoppage");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local ABC = interface.ABC;
    local u2 = false;
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 44
        -- upvalues: ABC (copy), u2 (ref)
        ABC:Clean();
        u2 = true;
    end);
    ABC:Add(function() -- Line: 49
        -- upvalues: AnimationController (ref), StatesController (ref)
        AnimationController:GetTrack("Abilities", "Stoppage"):Stop();
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        StatesController.SpeedBoost = 0;
    end);
    task.delay(3, function() -- Line: 57
        -- upvalues: u2 (ref), ABC (copy)
        if u2 == false then
            ABC:Clean();
        end;
    end);
end;