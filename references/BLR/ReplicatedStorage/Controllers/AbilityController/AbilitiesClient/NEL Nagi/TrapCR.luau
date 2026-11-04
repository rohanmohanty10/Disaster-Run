  

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

return function(u1, p2, u3, p4) -- Line: 18, Name: Trap
    -- upvalues: ReplicatedStorage (copy), RunService (copy)
    if u1.UsingTrapCR then
        return;
    end;

    print("using trap CR");
    u1.UsingTrapCR = true;
    local os_clock_ret = os.clock();

    if (ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Magnitude >= 50 then
        repeat
            task.wait();
        until (ReplicatedStorage.Football.Value.Position - u3.HumanoidRootPart.Position).Magnitude < 40 or os.clock() - os_clock_ret > 3;
    end;

    if os.clock() - os_clock_ret > 3 then
        return;
    end;

    if u1.InAbility then
        return;
    end;

    if p2.Character:GetAttribute("Trapped") then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    u1.InAbility = true;
    local Value = u3.Values.HasBall.Value;
    u1:AbilityCooldown("1", 1);
    u1.AbilityService.Ability:Fire("Trap", true);
    u1.Animations:StopAnims();

    if Value then
        u1.Animations.Abilities.Trap.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Abilities.Trap:Play();
        u1.Animations.Ball.TrapBall.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Ball.TrapBall:Play();
    else
        u1.Animations.Abilities.NELNagiCR.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.NELNagiCR:Play();
    end;

    task.delay(0.5, function() -- Line: 67
        -- upvalues: u1 (copy), RunService (ref), u3 (copy), Value (ref)
        u1.JustOne = tick() + 0.5;
        u1.ABC:Connect(RunService.Heartbeat, function() -- Line: 69
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
    u1.ABC:Add(function() -- Line: 91
        -- upvalues: u1 (copy), Value (ref)
        u1.UsingTrapCR = false;

        if not Value then
            u1:AbilityCooldown("1", 40);
        end;

        task.delay(1.4, function() -- Line: 98
            -- upvalues: u1 (ref)
            if u1.AbilityTwo <= tick() then
                u1:AbilityCooldown("1", 40);
            end;
        end);
        u1.InAbility = false;
    end);
end;