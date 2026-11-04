  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function activate() -- Line: 12
    -- upvalues: LocalPlayer (copy), AbilityUtils (copy), AbilityBalancing (copy), ReplicatedStorage (copy), Popup (copy), Players (copy), interface (copy)
    local Character = LocalPlayer.Character;
    local v1;

    if Character then
        v1 = Character:FindFirstChild("HumanoidRootPart");
    else
        v1 = Character;
    end;

    if Character then
        Character = Character:FindFirstChild("Values");
    end;

    if not (v1 and (Character and LocalPlayer.PlayerStats.InAwakening.Value)) then
        return;
    end;

    if Character.HasBall.Value or not AbilityUtils.rules.slotReady(2) then
        return;
    end;

    if not AbilityUtils.rules.grounded(LocalPlayer) then
        return;
    end;

    local YoMichael = AbilityBalancing.YoMichael;
    local Value = ReplicatedStorage.Football.Value;

    if not Value or (Value.Position - v1.Position).Magnitude > math.min(YoMichael.ActivationRangeBall, YoMichael.ServerActivationRangeBall) then
        Popup.Popup(LocalPlayer, "Ball must be closer!");

        return;
    end;

    local Value2 = Value.Char.Value;

    if not (Value.OnPlayer.Value and Value2) then
        Popup.Popup(LocalPlayer, "Ball must be on an opponent!");

        return;
    end;

    local Values = Value2:FindFirstChild("Values");

    if not Values then
        return;
    end;

    if Values.Goalie.Value and Values.IsInPenalty.Value then
        Popup.Popup(LocalPlayer, "Cannot use on Goalkeeper!");

        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value2);

    if PlayerFromCharacter then
        if PlayerFromCharacter.Team == LocalPlayer.Team then
            Popup.Popup(LocalPlayer, "Ball must be on an opponent!");

            return;
        end;
    elseif not Value2:GetAttribute("IsTrainingDummy") then
        return;
    end;

    AbilityUtils.clientCutsceneSkill(interface, YoMichael, YoMichael.KaiserCutsceneLength + 1, 2, false);
    interface.AbilityService.Ability:Fire("YoMichael", {
        Target = Value2
    });
end;

return function(p2, p3, p4) -- Line: 52
    -- upvalues: activate (copy)
    activate();
end;