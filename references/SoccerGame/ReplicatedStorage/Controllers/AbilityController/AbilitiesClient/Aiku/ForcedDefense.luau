  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, u2, p3) -- Line: 13, Name: ForcedDefense
    -- upvalues: ReplicatedStorage (copy), Popup (copy), Players (copy)
    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    local Home = workspace.Goals.Home;
    local v4 = workspace.Goals:FindFirstChild(u2.Team.Name) or Home;
    local Magnitude = (p3.HumanoidRootPart.Position - v4.Position).Magnitude;

    if #game.CollectionService:GetTagged("GoalPart") > 1 then
        local v5 = false;

        for _, v in game.CollectionService:GetTagged("GoalPart") do
            if v4 ~= v and (p3.HumanoidRootPart.Position - v.Position).Magnitude * 0.75 < Magnitude then
                v5 = true;
                break;
            end;
        end;

        if v5 == false then
            Popup.Popup(u2, "Must be on your side of the field!");

            return;
        end;
    end;

    if p3.Values.HasBall.Value then
        Popup.Popup(u2, "Ball must be on a rival team!");

        return;
    end;

    if ReplicatedStorage.Football.Value.OnPlayer.Value == false then
        Popup.Popup(u2, "Ball must be on a rival team!");

        return;
    end;

    local Value = ReplicatedStorage.Football.Value.Char.Value;
    local v6 = Players:FindFirstChild(Value.Name);

    if v6 then
        if v6.Team == u2.Team then
            Popup.Popup(u2, "Ball must be on a rival team!");

            return;
        end;

        if v6.Character.Values.Goalie.Value and v6.Character.Values.IsInPenalty.Value then
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

    if (ReplicatedStorage.Football.Value.Position - p3.HumanoidRootPart.Position).Magnitude >= 16 then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if not u1.DefenceCharges or u1.AbilityOne ~= u1.DefenceCooldownEnd then
        u1.DefenceCharges = 0;
    end;

    if u1.DefenceCharges == 1 or u2.PlayerStats.InAwakening.Value == false then
        u1.DefenceCharges = 2;
        u1:AbilityCooldown("1", 60);
    else
        u1.DefenceCharges = 1;
        u1:AbilityCooldown("1", 1);
    end;

    u1.DefenceCooldownEnd = u1.AbilityOne;
    u2.Character.Values.Sliding.Value = true;
    task.delay(0.6, function() -- Line: 85
        -- upvalues: u2 (copy)
        u2.Character.Values.Sliding.Value = false;
    end);
    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.StatesController.States.Ability = true;
    task.delay(0.5, function() -- Line: 93
        -- upvalues: u1 (copy), Shiftlock (copy)
        u1.StatesController.States.Ability = false;
        u1.Camera:SetShiftlock(Shiftlock);
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.ForcePass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ForcePass:Play();

    if v6 then
        Value = v6.Character or Value;
    end;

    u1.AbilityService.Ability:Fire("ForcePass", Value);
end;