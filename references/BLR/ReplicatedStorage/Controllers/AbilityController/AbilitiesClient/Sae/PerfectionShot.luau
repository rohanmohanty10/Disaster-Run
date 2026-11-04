  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 19, Name: Trivela
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), RunService (copy), ReplicatedStorage (copy)
    local _ = AbilityBalancing.Trivela;

    if not (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(3)) then
        return;
    end;

    local u4 = AbilityUtils.rules.grounded(p2, false);
    interface:AbilityCooldown(3, AbilityBalancing.ElasticNutmeg.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.PerfectionShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PerfectionShot:Play();
    u1.Animations.Ball.PerfectionShotBall.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.PerfectionShotBall:Play();
    print("trivela");
    u1.AbilityService.Ability:Fire("PerfectionShot");
    u1.ABC:Connect(u1.AbilityService.Ability, function(u5, u6) -- Line: 46
        -- upvalues: u1 (copy), u4 (copy), AbilityBalancing (ref), RunService (ref), ReplicatedStorage (ref)
        print("Here");
        u1.StatesController.States.Ability = false;
        u5.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + (u4 and (Vector3.new(0, 0.3, 0) + u6 / 1.5 or Vector3.new(0, 0.65, 0)) or Vector3.new(0, 0.65, 0))) * ((AbilityBalancing.Trivela.ShotPower + 16) * (u4 and 1 or 0.75));

        if u4 then
            task.delay(0.1, function() -- Line: 58
                -- upvalues: u1 (ref), RunService (ref), u5 (copy), u6 (copy)
                local u7 = -43;
                u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 61
                    -- upvalues: u7 (ref), u1 (ref), u5 (ref), u6 (ref)
                    u7 = u7 + 50 * p8;

                    if u7 >= -20 then
                        u1.ABC:Clean();
                    end;

                    u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u5.AssemblyLinearVelocity + u6 * u7, 8 * p8);
                end);
            end);
        end;

        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(2.5, function() -- Line: 74
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;