  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local OverlapParams_new_ret = OverlapParams.new();
OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
OverlapParams_new_ret.FilterDescendantsInstances = { workspace.Debris };

return function() -- Line: 19
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), Popup (copy), ReplicatedStorage (copy), OverlapParams_new_ret (copy), interface (copy)
    local UnstoppableDemonShot = AbilityBalancing.UnstoppableDemonShot;
    local Character = LocalPlayer.Character;

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    if not AbilityUtils.rules.slotReady(1) then
        return;
    end;

    local v1 = LocalPlayer.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away;

    if (v1.Position - Character.HumanoidRootPart.Position).Magnitude > UnstoppableDemonShot.PenBoxRange then
        Popup.Popup(LocalPlayer, "Must be near the goal");

        return;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not (Value and (Value:IsDescendantOf(workspace) and not Value.OnPlayer.Value)) then
        Popup.Popup(LocalPlayer, "Ball must be loose!");

        return;
    end;

    local v2 = false;

    for _, v in workspace:GetPartsInPart(v1, OverlapParams_new_ret) do
        if v == Value then
            v2 = true;
            break;
        end;
    end;

    if not v2 then
        Popup.Popup(LocalPlayer, "Ball must be in the penalty box!");

        return;
    end;

    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, UnstoppableDemonShot, 14, 1, true, LookVector);
end;