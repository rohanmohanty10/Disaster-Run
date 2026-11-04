  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 22
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), interface (copy), Popup (copy), AbilityUtils (copy)
    local CenterOfGravity = AbilityBalancing.CenterOfGravity;
    local PlayerStats = LocalPlayer:FindFirstChild("PlayerStats");

    if PlayerStats then
        PlayerStats = PlayerStats:FindFirstChild("InAwakening");
    end;

    if not (PlayerStats and PlayerStats.Value) then
        return;
    end;

    if interface.RinCenterOfGravityPending then
        return;
    end;

    if (interface.RinCenterOfGravityUses or 0) >= CenterOfGravity.MaxUsesPerAwakening then
        Popup.Popup(LocalPlayer, "Center of Gravity has already been used twice this awakening!");

        return;
    end;

    local v1 = AbilityUtils.rules.enemyTarget(CenterOfGravity.EnemyRange, false);

    if not (v1 and (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    interface.RinCenterOfGravityPending = true;
    local u2 = false;
    local u3 = false;
    AbilityUtils.clientCutsceneSkill(interface, CenterOfGravity, CenterOfGravity.CutsceneLength + 2, nil, false, nil, true);
    local ABC = interface.ABC;

    local function applyCooldown() -- Line: 63
        -- upvalues: u3 (ref), interface (ref), CenterOfGravity (copy)
        if u3 then
            return;
        end;

        u3 = true;
        interface:AbilityCooldown(tostring(3), CenterOfGravity.Cooldown);
    end;

    ABC:Add(function() -- Line: 69
        -- upvalues: interface (ref), u2 (ref), u3 (ref), CenterOfGravity (copy)
        interface.RinCenterOfGravityPending = nil;

        if u2 then
            if u3 then
                return;
            end;

            u3 = true;
            interface:AbilityCooldown(tostring(3), CenterOfGravity.Cooldown);
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(p4) -- Line: 76
        -- upvalues: u2 (ref), interface (ref), CenterOfGravity (copy), u3 (ref), ABC (copy)
        if p4 == "accepted" then
            u2 = true;
            interface.RinCenterOfGravityPending = nil;
            interface.RinCenterOfGravityUses = math.min((interface.RinCenterOfGravityUses or 0) + 1, CenterOfGravity.MaxUsesPerAwakening);

            return;
        end;

        if p4 ~= "complete" then
            if p4 == "rejected" then
                u2 = false;
                interface.RinCenterOfGravityPending = nil;
                ABC:Clean();
            end;

            return;
        end;

        if not u3 then
            u3 = true;
            interface:AbilityCooldown(tostring(3), CenterOfGravity.Cooldown);
        end;

        ABC:Clean();
    end);
    interface.AbilityService.Ability:Fire(script.Name, v1);
end;