  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local Speedster = require(ReplicatedStorage.AbilityBalancing).Speedster;

return function(u1, u2, u3) -- Line: 14, Name: Speedster
    -- upvalues: Speedster (copy), ReplicatedStorage (copy), Trove (copy), RunService (copy)
    if u2.Team == game.Teams.Visitor then
        return;
    end;

    if u2.PlayerStats.Stamina.Value <= Speedster.Stamina then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    u1:AbilityCooldown("1", Speedster.Cooldown);
    u1.StaminaService.DecreaseStamina:Fire(Speedster.Stamina);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KingsRun.Priority = Enum.AnimationPriority.Action2;
    u1.Animations.Abilities.KingsRun:Play();
    u1.StatesController.SpeedBoost = Speedster.MoveSpeedValue;
    u1.EffectsService.Vfx:Fire(ReplicatedStorage.Effects.ChigiriRun);

    if u1.SS then
        u1.SS:Destroy();
    end;

    u1.SS = Trove.new();
    u1.SS:Connect(RunService.Heartbeat, function() -- Line: 36
        -- upvalues: u2 (copy), u3 (copy), u1 (copy)
        if u2 == nil then
            return;
        end;

        if u2.Team == game.Teams.Visitor then
            return;
        end;

        if u3.HumanoidRootPart.AssemblyLinearVelocity.Magnitude >= 5 then
            if u1.Animations.Abilities.KingsRun.IsPlaying == false then
                u1.Animations.Abilities.KingsRun:Play();
            end;
        else
            u1.Animations.Abilities.KingsRun:Stop();
        end;
    end);
    local u4 = false;

    local function cleanup() -- Line: 49
        -- upvalues: u4 (ref), u1 (copy)
        if u4 then
            return;
        end;

        u4 = true;
        xpcall(function() -- Line: 54
            -- upvalues: u1 (ref)
            u1.StatesController.SpeedBoost = 0;
            u1.Animations.Abilities.KingsRun:Stop();
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.StatesController.SpeedBoost = 0;
            u1.SS:Destroy();
        end, warn);
    end;

    u1.SS:Add(task.spawn(function() -- Line: 64
        -- upvalues: Speedster (ref), u4 (ref), u1 (copy)
        task.wait(Speedster.MoveSpeedDuration);

        if u4 then
            return;
        end;

        u4 = true;
        xpcall(function() -- Line: 54
            -- upvalues: u1 (ref)
            u1.StatesController.SpeedBoost = 0;
            u1.Animations.Abilities.KingsRun:Stop();
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.StatesController.SpeedBoost = 0;
            u1.SS:Destroy();
        end, warn);
    end));
    u1.SS:Add(cleanup);
    u1.AbilityService.Ability:Fire("Speedster");
end;