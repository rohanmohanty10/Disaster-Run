  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);

return function(u1, u2, u3) -- Line: 19, Name: AirDribble
    -- upvalues: AbilityBalancing (copy), interface (copy), ReplicatedStorage (copy), RunService (copy)
    local AirDribble = AbilityBalancing.AirDribble;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if interface.__trapped and u1.AbilityOne < tick() then
        if ReplicatedStorage.Football.Value.Anchored then
            return;
        end;

        if u2.PlayerStats.Stamina.Value <= 10 then
            return;
        end;

        if not u3.Values.HasBall.Value then
            return;
        end;

        u1.OverwriteText["1"] = "Trap";
        u1:AbilityCooldown("1", u2.PlayerStats.Flow.Value == "Singularity" and u2.PlayerStats.InFlow.Value and 38 or 45);
        u1.Animations:StopAnims();
        u1.Animations.Abilities.AirDribbleShoot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.AirDribbleShoot:Play();
        u1.Animations.Ball.AirDribbleShoot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.AirDribbleShoot:Play();
        u1.StatesController.States.Ability = true;
        u1.ABC:Add(function() -- Line: 47
            -- upvalues: interface (ref)
            interface.__trapped = nil;
        end);

        for _, descendant in u2.Character.HumanoidRootPart:GetDescendants() do
            if descendant:IsA("BodyMover") then
                descendant:Destroy();
            end;
        end;

        task.delay(0.35, function() -- Line: 57
            -- upvalues: u1 (copy)
            u1.AbilityService.Ability:Fire("AirDribble", "shotStart");
        end);
        u1.ABC:Add(u1.AbilityService.Ability:Connect(function(p4) -- Line: 61
            -- upvalues: AirDribble (copy), u1 (copy)
            p4.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + AirDribble.ShotTiltVector) * AirDribble.ShotPower;
            u1.BallController:DragBall(p4);
        end));
        task.delay(0.6, function() -- Line: 66
            -- upvalues: u1 (copy)
            if u1.ABC then
                u1.ABC:Clean();
            end;

            u1.StatesController.States.Ability = false;
        end);

        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if ReplicatedStorage.GameValues.AbilityDb.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.OverwriteText["1"] = "Shoot";
    task.delay(0.45, function() -- Line: 82
        -- upvalues: u1 (copy)
        u1.InAbility = true;
    end);
    local Value = u3.Values.HasBall.Value;
    u1.JustOne = tick() + 1;
    u1.AbilityService.Ability:Fire("AirDribble");
    u1.Animations:StopAnims();

    if Value then
        u1.Animations.Abilities.AirDribbleUp.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Abilities.AirDribbleUp:Play();
        u1.Animations.Ball.AirDribbleUp.Priority = Enum.AnimationPriority.Action2;
        u1.Animations.Ball.AirDribbleUp:Play();
        u1.Animations.Abilities.AirDribbleUp:AdjustSpeed(1.35);
        u1.Animations.Ball.AirDribbleUp:AdjustSpeed(1.35);
        u1:AbilityCooldown("1", 2);
        task.wait(0.9);
    else
        u1:AbilityCooldown("1", 1);
    end;

    u1.Animations.Ball.AirDribbleStart.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Ball.AirDribbleStart:Play();
    u1.Animations.Ball.AirDribbleStart:AdjustSpeed(1.35);
    u1.Animations.Abilities.AirDribbleStart.Priority = Enum.AnimationPriority.Action3;
    u1.Animations.Abilities.AirDribbleStart:Play();
    interface.__trapped = true;
    u1.ABC:Add(function() -- Line: 119
        -- upvalues: interface (ref)
        interface.__trapped = nil;
    end);
    local u5 = os.time() + 4;
    task.delay(0.65, function() -- Line: 124
        -- upvalues: u1 (copy), RunService (ref), u3 (copy), Value (ref), u5 (copy)
        u1.ABC:Connect(RunService.Heartbeat, function() -- Line: 125
            -- upvalues: u3 (ref), u1 (ref), Value (ref), u5 (ref)
            if u3 == nil then
                if u1.ABC then
                    u1.ABC:Clean();
                end;

                u1.InAbility = false;

                return;
            end;

            if u3.Values.HasBall.Value then
                Value = true;
            end;

            if (u5 < os.time() or (u1.InAbility == false or u3.Values.HasBall.Value == false and Value)) and u1.ABC then
                u1.ABC:Clean();
            end;
        end);
    end);
    u1.ABC:Add(function() -- Line: 143
        -- upvalues: u2 (copy), u1 (copy)
        u1:AbilityCooldown("1", u2.PlayerStats.Flow.Value == "Singularity" and 38 or 45);
        u1.OverwriteText["1"] = "Trap";
        print("trap shot");
        task.delay(0.15, function() -- Line: 150
        end);
        print("Cleared");
        u1.InAbility = false;
        u1.Animations.Abilities.AirDribbleStart:Stop();
        u1.Animations.Ball.AirDribbleStart:Stop();
    end);
end;