  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.StatesController);
require(ReplicatedStorage2.Controllers.StylePassiveController.Passive_LandingMetavision);
require(ReplicatedStorage2.Controllers.StylePassiveController.Passive_CooldownMetavision);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local CarrotGrab = AbilityBalancing.CarrotGrab;

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.airBall(LocalPlayer, CarrotGrab.BallRange, 14) and AbilityUtils.rules.slotReady(1)))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, CarrotGrab, 15, 1, false);
end;