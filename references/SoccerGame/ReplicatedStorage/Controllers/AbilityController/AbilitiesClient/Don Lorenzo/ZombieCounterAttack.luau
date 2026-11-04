  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ZombieCounterAttack = require(ReplicatedStorage.AbilityBalancing).ZombieCounterAttack;

return function(u1, p2, u3) -- Line: 16, Name: CounterAttack
    -- upvalues: ReplicatedStorage (copy), ZombieCounterAttack (copy), Popup (copy), RunService (copy)
    local LookVector = u3.HumanoidRootPart.CFrame.LookVector;
    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    if Value.OnPlayer.Value then
        return;
    end;

    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if (ReplicatedStorage.Football.Value.Position - p2.Character.HumanoidRootPart.Position).Magnitude > ZombieCounterAttack.ActivationRangeBall then
        Popup.Popup(p2, "Ball must be closer!");

        return;
    end;

    if p2.Character.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be free");

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local Shiftlock = u1.Camera.Shiftlock;
    u1.Camera:SetShiftlock(false);
    u1.Camera.Cutscene = true;
    u1.InAbility = true;
    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1:AbilityCooldown("2", ZombieCounterAttack.Cooldown);
    task.wait(0.1);

    if p2.Character.Values.HasBall.Value then
        Popup.Popup(p2, "Ball must be free");
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;

        return;
    end;

    task.delay(7, function() -- Line: 52
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    u1.AbilityService.Ability:Fire("ZombieCounterAttack");
    u1.Animations:StopAnims();
    u1.Animations.Ball.CounterAttackBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.CounterAttackBall:Play();
    u1.Animations.Abilities.CounterAttack.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.CounterAttack:Play();
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4: any, p5: userdata) -- Line: 69
        -- upvalues: u1 (copy), u3 (copy), Shiftlock (copy), RunService (ref), ReplicatedStorage (ref), LookVector (copy), ZombieCounterAttack (ref)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.InAbility = false;
        u1.Camera.Cutscene = false;
        u3.HumanoidRootPart.Anchored = false;
        u1.Camera:SetShiftlock(Shiftlock);

        if not p5 then
            ReplicatedStorage.Football.Value.AssemblyLinearVelocity = (LookVector + ZombieCounterAttack.ShotTiltVector) * ZombieCounterAttack.ShotPower;
            u1.BallController:DragBall(ReplicatedStorage.Football.Value);

            return;
        end;

        local Character = p5.Character;
        local Vector3_new_ret = Vector3.new(Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Character.HumanoidRootPart.AssemblyLinearVelocity.Z);
        local u6 = (Character.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u4.AssemblyLinearVelocity = u6 * math_clamp_ret;
        u1.BallController:DragBall(u4);
        local u7 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 94
            -- upvalues: u7 (copy), u1 (ref), u4 (copy), Vector3_new_ret (ref), Character (copy), u6 (ref), math_clamp_ret (ref), u3 (ref)
            if tick() > u7 + 1.5 then
                u1.ABC:Clean();

                return;
            end;

            if u4.OnPlayer.Value then
                u1.ABC:Clean();

                return;
            end;

            if u4 == nil then
                u1.ABC:Clean();

                return;
            end;

            Vector3_new_ret = Vector3.new(Character.HumanoidRootPart.AssemblyLinearVelocity.X, 0, Character.HumanoidRootPart.AssemblyLinearVelocity.Z);

            if tick() > u7 + 0.55 then
                u6 = u6:Lerp((Character.HumanoidRootPart.Position - u4.Position).Unit + Vector3.new(0, 0.15, 0), 6.5 * p8);
            else
                u6 = u6:Lerp((Character.HumanoidRootPart.Position - u4.Position).Unit + Vector3.new(0, 0.35, 0), 6.5 * p8);
            end;

            math_clamp_ret = (Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 2.75;
            math_clamp_ret = math.clamp(math_clamp_ret, 0, 150);

            if math_clamp_ret <= 7 then
                u1.ABC:Clean();

                return;
            end;

            u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u6 * math_clamp_ret, 6.5 * p8);
        end);
    end);
end;