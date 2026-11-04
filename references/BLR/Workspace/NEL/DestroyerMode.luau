  

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
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local DestroyerMode = require(ReplicatedStorage2.AbilityBalancing).DestroyerMode;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), interface (copy), DestroyerMode (copy), StatesController (copy)
    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    AbilityUtils.clearMovers(Character);
    interface:AbilityCooldown(3, DestroyerMode.Cooldown);
    interface.AbilityService.Ability:Fire("DestroyerMode");
    StatesController.SpeedBoost = 6;
    ABC:Add(function() -- Line: 53
        -- upvalues: StatesController (ref)
        StatesController.SpeedBoost = 0;
    end);
    task.delay(DestroyerMode.Duration, function() -- Line: 57
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;