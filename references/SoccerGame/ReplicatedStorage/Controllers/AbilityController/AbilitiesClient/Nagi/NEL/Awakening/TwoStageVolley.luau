  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), ReplicatedStorage2 (copy), Popup (copy), Players (copy), interface (copy)
    local TwoStageVolley = AbilityBalancing.TwoStageVolley;

    if not (AbilityUtils.rules.offball(LocalPlayer) and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    local Value = ReplicatedStorage2.Football.Value;

    if not Value.OnPlayer.Value then
        Popup.Popup(LocalPlayer, "Ball must be on an enemy player");

        return;
    end;

    local Value2 = Value.Char.Value;

    if not Value2 then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

    if Value2 then
        Value2 = Value2:GetAttribute("IsTrainingDummy");
    end;

    if not (Value2 or PlayerFromCharacter and PlayerFromCharacter.Team ~= LocalPlayer.Team) then
        Popup.Popup(LocalPlayer, "Ball must be on an enemy player");

        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, TwoStageVolley, 16, 3, true, workspace.CurrentCamera.CFrame.LookVector);
end;