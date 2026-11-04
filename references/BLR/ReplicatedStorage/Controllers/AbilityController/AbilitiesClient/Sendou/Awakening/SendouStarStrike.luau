  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), interface (copy)
    local SendouStarStrike = AbilityBalancing.SendouStarStrike;

    if not (AbilityUtils.rules.canAct(LocalPlayer) and (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3)))) then
        return false;
    end;

    if not (AbilityUtils.rules.onball(LocalPlayer, false) or AbilityUtils.rules.looseBall(LocalPlayer, SendouStarStrike.BallRange, false, {
        allowGoalkeeperThrows = true,
        respectThrowLockout = true
    })) then
        Popup.Popup(LocalPlayer, "Have the ball or be near a loose ball!");

        return false;
    end;

    AbilityUtils.clientCutsceneSkill(interface, SendouStarStrike, SendouStarStrike.Duration + 3, 3, true, workspace.CurrentCamera.CFrame.LookVector);
    interface.AbilityService.Ability:Fire(script.Name);

    return true;
end;