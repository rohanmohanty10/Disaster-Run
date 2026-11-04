  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), interface (copy)
    local SendouStarClear = AbilityBalancing.SendouStarClear;

    if not (AbilityUtils.rules.canAct(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(2))))) then
        return false;
    end;

    if not (AbilityUtils.rules.looseBall(LocalPlayer, (1 / 0), false, {
        allowGoalkeeperThrows = true
    }) and (AbilityUtils.rules.ballInOwnGoalkeeperBox(LocalPlayer, false) and AbilityUtils.rules.nearOwnGoalkeeperBox(LocalPlayer, SendouStarClear.PlayerBoxRange, false))) then
        Popup.Popup(LocalPlayer, "Be within 20 studs of your goalkeeper box, with a loose ball inside!");

        return false;
    end;

    AbilityUtils.clientCutsceneSkill(interface, SendouStarClear, SendouStarClear.Duration + 3, 2, true, workspace.CurrentCamera.CFrame.LookVector);
    interface.AbilityService.Ability:Fire(script.Name);

    return true;
end;