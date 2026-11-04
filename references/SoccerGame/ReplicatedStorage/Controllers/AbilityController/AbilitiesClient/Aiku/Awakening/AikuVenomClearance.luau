  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 11
    -- upvalues: ClientGlobals (copy), countStyleMastery (copy), AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local Data = ClientGlobals.PlayerData.Data;
    local v1 = Data and Data.DisabledMasteryLevels and Data.DisabledMasteryLevels.Aiku;

    if not (Data and (countStyleMastery(Data, "Aiku") >= 4 and not (v1 and v1[4]))) then
        return false;
    end;

    local AikuVenomClearance = AbilityBalancing.AikuVenomClearance;

    if not (AbilityUtils.rules.canAct(LocalPlayer) and (AbilityUtils.rules.isAwakened(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and AbilityUtils.rules.slotReady(2))))) then
        return false;
    end;

    local v2 = AbilityUtils.rules.aikuAwakeningTarget(LocalPlayer, AikuVenomClearance.EnemyRange);

    if not v2 then
        return false;
    end;

    AbilityUtils.clientCutsceneSkill(interface, AikuVenomClearance, AikuVenomClearance.Duration + 3, 2, true, (workspace.CurrentCamera.CFrame.LookVector + AikuVenomClearance.ShotTiltVector).Unit);
    interface.AbilityService.Ability:Fire(script.Name, v2);

    return true;
end;