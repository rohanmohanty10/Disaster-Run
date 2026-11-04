  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), Popup (copy), LocalPlayer (copy)
    local _ = AbilityBalancing.IllusionCross;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(3, 3);
    interface.DaisyCutter = not interface.DaisyCutter;
    Popup.Popup(LocalPlayer, "Illusion Cross Mode: " .. (interface.DaisyCutter and "Daisy Cutter" or "Cross"));
    interface.AbilityService.Ability:Fire("SpellChange");
end;