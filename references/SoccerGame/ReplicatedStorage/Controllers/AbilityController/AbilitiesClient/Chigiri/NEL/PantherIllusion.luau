  

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
require(ReplicatedStorage2.Shared.AbilityUtils);
require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(p1) -- Line: 28, Name: Accelerate
    -- upvalues: AbilityUtils (copy), interface (copy), AbilityBalancing (copy)
    local _, _, _, _ = AbilityUtils.getCharacter();

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        return;
    end;

    interface.PICharges = interface.PICharges and 2 or 1;
    interface.AbilityService.Ability:Fire("Accelerate", interface.PICharges);

    if interface.PICharges ~= 2 then
        interface:AbilityCooldown(2, 1.5);

        return;
    end;

    interface.PICharges = nil;
    interface:AbilityCooldown(2, AbilityBalancing.Accelerate.Cooldown);
end;