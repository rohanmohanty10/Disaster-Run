  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local Trove = require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 20
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), ReplicatedStorage (copy), Trove (copy), LocalPlayer (copy)
    local PredatorKrampus = AbilityBalancing.PredatorKrampus;
    AbilityUtils.rules.offball(nil, false);

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    interface:AbilityCooldown(3, PredatorKrampus.Cooldown);
    local _ = interface.ABC;
    local Character, _, _, _ = AbilityUtils.getCharacter();
    StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionStart");
    interface.AbilityService.Ability:Fire("PredatorKrampus", {
        State = "Enable"
    });
    require(ReplicatedStorage.Effects.KrampusBarou.PredatorKrampusVFX)();
    Character:SetAttribute("PredatorKrampus", true);
    StatesController.SpeedBoost = 7;

    local function disableSkill() -- Line: 44
        -- upvalues: StatesController (ref), interface (ref), Character (copy)
        StatesController.SpeedBoost = 0;
        interface.AbilityService.Ability:Fire("PredatorKrampus", {
            State = "Disable"
        });
        Character:SetAttribute("PredatorKrampus", false);
        StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionEnd");
    end;

    local u1 = Trove.new();
    u1:Add(disableSkill);
    u1:Add(LocalPlayer.CharacterRemoving:Connect(function() -- Line: 55
        -- upvalues: u1 (copy)
        u1:Clean();
    end));
    task.delay(PredatorKrampus.Duration, function() -- Line: 59
        -- upvalues: u1 (copy)
        u1:Clean();
    end);
end;