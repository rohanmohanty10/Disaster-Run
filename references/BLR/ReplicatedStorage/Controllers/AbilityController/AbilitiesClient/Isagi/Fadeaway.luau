  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("GuiService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local Fadeaway = require(ReplicatedStorage.AbilityBalancing).Fadeaway;

return function(u1, p2, p3) -- Line: 17, Name: Fadeaway
    -- upvalues: ReplicatedStorage (copy), AbilityUtils (copy), Fadeaway (copy), Popup (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    local v4 = AbilityUtils.rules.enemyTarget(Fadeaway.ActivationRangePlayer);

    if not v4 then
        return;
    end;

    if not v4 or (not v4 and 30 or (p3.HumanoidRootPart.Position - v4.HumanoidRootPart.Position).Magnitude) > Fadeaway.ActivationRangePlayer then
        Popup.Popup(p2, "Must be close and looking at an enemy!");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1:AbilityCooldown("2", Fadeaway.Cooldown);
    u1.StatesController.States.Ability = true;
    task.delay(0.35, function() -- Line: 38
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.Fadeaway.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.Fadeaway:Play();
    u1.AbilityService.Ability:Fire("Fadeaway", v4);
end;