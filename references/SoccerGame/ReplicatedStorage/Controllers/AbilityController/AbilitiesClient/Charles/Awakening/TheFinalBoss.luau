  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), Players (copy), Popup (copy), RunService (copy), AbilityBalancing (copy)
    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Value = ReplicatedStorage.Football.Value;
    local Value2 = Value.OnPlayer.Value;
    local Value3 = Value.Char.Value;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value3);
    local v4;

    if Value3 then
        v4 = Value3:GetAttribute("IsTrainingDummy");
    else
        v4 = Value3;
    end;

    if Value3 and (Value3.Values.Goalie.Value and Value3.Values.IsInPenalty.Value) then
        return;
    end;

    if not ((PlayerFromCharacter and PlayerFromCharacter.Team ~= p2.Team or v4) and (not u3.Values.HasBall.Value and Value2)) then
        Popup.Popup(p2, "Enemy must have ball!");

        if not RunService:IsStudio() then
            return;
        end;
    end;

    if not v4 then
        Value3 = PlayerFromCharacter.Character;
    end;

    if (u3.HumanoidRootPart.Position - Value3.HumanoidRootPart.Position).Magnitude >= AbilityBalancing.TheFinalBoss.ActivationRangePlayer then
        Popup.Popup(p2, "Too far!");

        return;
    end;

    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.ABC:Add(function() -- Line: 50
        -- upvalues: u1 (copy), u3 (copy)
        u1.Camera.Cutscene = false;
        u1.InAbility = false;
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.ABC:Add(task.delay(20, function() -- Line: 59
        -- upvalues: u1 (copy), AbilityBalancing (ref)
        u1:AbilityCooldown("2", AbilityBalancing.TheFinalBoss.Cooldown);
        u1.ABC:Clean();
    end));
    u1:AbilityCooldown("2", AbilityBalancing.TheFinalBoss.Cooldown);
    u1.AbilityService.Ability:Fire("TheFinalBoss");
    task.wait(8);
    u1.ABC:Clean();
end;