  

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
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), StatesController (copy), interface (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local TerritoryShot = AbilityBalancing.TerritoryShot;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, TerritoryShot.Cooldown);
    local ABC = interface.ABC;
    local _, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "TerritoryShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("TerritoryShot");
    ABC:Add(AbilityUtils.execute.shot(TerritoryShot, nil, ABC));
    ABC:Add(function() -- Line: 62
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 66
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;