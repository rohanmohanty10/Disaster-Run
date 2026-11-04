  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Popup = require(ReplicatedStorage.Shared.Popup);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 15
    -- upvalues: AbilityUtils (copy), ReplicatedStorage (copy), LocalPlayer (copy), Popup (copy), Players (copy), AbilityBalancing (copy), interface (copy), StatesController (copy)
    local Character, v1, _, _ = AbilityUtils.getCharacter();

    if not v1 then
        return;
    end;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    local Home = workspace.Goals.Home;
    local v2 = workspace.Goals:FindFirstChild(LocalPlayer.Team.Name) or Home;
    local Magnitude = (Character.HumanoidRootPart.Position - v2.Position).Magnitude;

    if #game.CollectionService:GetTagged("GoalPart") > 1 then
        local v3 = false;

        for _, v in game.CollectionService:GetTagged("GoalPart") do
            if v2 ~= v and (Character.HumanoidRootPart.Position - v.Position).Magnitude * 0.75 < Magnitude then
                v3 = true;
                break;
            end;
        end;

        if v3 == false then
            Popup.Popup(LocalPlayer, "Must be on your side of the field!");

            return;
        end;
    end;

    if ReplicatedStorage.Football.Value.OnPlayer.Value == false then
        Popup.Popup(LocalPlayer, "Ball must be on a rival team!");

        return;
    end;

    LocalPlayer.Character.Values.Sliding.Value = true;
    task.delay(0.6, function() -- Line: 60
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.Values.Sliding.Value = false;
    end);
    local Value = ReplicatedStorage.Football.Value.Char.Value;
    local v4 = Players:FindFirstChild(Value.Name);

    if v4 then
        if v4.Team == LocalPlayer.Team then
            Popup.Popup(LocalPlayer, "Ball must be on a rival team!");

            return;
        end;

        if Value.Values.Dribbling.Value then
            return;
        end;

        if v4.Character.Values.Goalie.Value and v4.Character.Values.IsInPenalty.Value then
            return;
        end;
    else
        if not Value:GetAttribute("IsTrainingDummy") then
            return;
        end;

        if Value.Values.Goalie.Value and Value.Values.IsInPenalty.Value then
            return;
        end;
    end;

    local Stoppage = AbilityBalancing.Stoppage;

    if (ReplicatedStorage.Football.Value.Position - Character.HumanoidRootPart.Position).Magnitude >= Stoppage.ActivationRangePlayer then
        return;
    end;

    interface:AbilityCooldown(2, Stoppage.Cooldown);
    StatesController.States.Ability = true;
    task.delay(0.5, function() -- Line: 88
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);

    if v4 then
        Value = v4.Character or Value;
    end;

    interface.AbilityService.Ability:Fire("Disruption", Value);
end;