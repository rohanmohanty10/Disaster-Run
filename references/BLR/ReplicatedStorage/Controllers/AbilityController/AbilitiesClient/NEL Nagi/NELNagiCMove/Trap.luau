  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, u3) -- Line: 18, Name: Trap
    -- upvalues: ReplicatedStorage (copy), RunService (copy)
    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if ReplicatedStorage.GameValues.AbilityDb.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if p2.Character:GetAttribute("Trapped") then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.InAbility then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.InAbility = true;
    local Value = u3.Values.HasBall.Value;
    u1:AbilityCooldown("1", 1);
    u1.AbilityService.Ability:Fire("Trap");
    u1.Animations:StopAnims();

    for _, descendant in u3.HumanoidRootPart:GetDescendants() do
        if descendant:IsA("BodyMover") then
            descendant:Destroy();
        end;
    end;

    if Value then
        u1.Animations.Abilities.Trap.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Abilities.Trap:Play();
        u1.Animations.Ball.TrapBall.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Ball.TrapBall:Play();
    else
        u1.Animations.Abilities.Trap.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.Trap:Play();
    end;

    task.delay(0.5, function() -- Line: 63
        -- upvalues: u1 (copy), RunService (ref), u3 (copy), Value (ref)
        u1.JustOne = tick() + 0.3;
        u1.ABC:Connect(RunService.Heartbeat, function() -- Line: 65
            -- upvalues: u3 (ref), u1 (ref), Value (ref)
            if u3 == nil then
                if u1.ABC then
                    u1.ABC:Clean();
                end;

                u1.InAbility = false;

                return;
            end;

            if tick() >= u1.JustOne or (u1.InAbility == false or u3.Values.HasBall.Value == false and Value) then
                u1.ABC:Clean();
            end;

            if u3.Values.HasBall.Value then
                Value = true;
            end;
        end);
    end);
    task.delay(1.5, function() -- Line: 85
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    local u4 = p2.PlayerStats.Flow.Value == "Singularity" and p2.PlayerStats.InFlow.Value and 32 or 40;
    u1.ABC:Add(function() -- Line: 93
        -- upvalues: Value (ref), u1 (copy), u4 (copy)
        if not Value then
            u1:AbilityCooldown("1", u4);
        end;

        task.delay(1.4, function() -- Line: 98
            -- upvalues: u1 (ref), u4 (ref)
            u1:AbilityCooldown("1", u4);
        end);
        u1.InAbility = false;
    end);
end;