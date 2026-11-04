  

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

return function(u1, p2, u3) -- Line: 19, Name: Trivela
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), RunService (copy), ReplicatedStorage (copy)
    local _ = AbilityBalancing.LionShot;

    if not (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    local u4 = AbilityUtils.rules.grounded(p2, false);
    interface:AbilityCooldown(1, AbilityBalancing.LionShot.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.StealthKillShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.StealthKillShot:Play();
    u1.AbilityService.Ability:Fire("StealthKillShot");
    local u5 = u3:GetAttribute("PredatorEye") and 200 or 180;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 43
        -- upvalues: u3 (copy), u1 (copy), u4 (copy), u5 (copy), RunService (ref), ReplicatedStorage (ref)
        print("Here");
        local RightVector = u3.HumanoidRootPart.CFrame.RightVector;
        u1.StatesController.States.Ability = false;
        u6.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + (u4 and (Vector3.new(0, 0.3, 0) + RightVector / 1.5 or Vector3.new(0, 0.65, 0)) or Vector3.new(0, 0.65, 0))) * (u5 * (u4 and 1 or 0.75));

        if u4 then
            task.delay(0.1, function() -- Line: 56
                -- upvalues: u1 (ref), RunService (ref), u6 (copy), RightVector (copy)
                local u7 = -43;
                u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 59
                    -- upvalues: u7 (ref), u1 (ref), u6 (ref), RightVector (ref)
                    u7 = u7 + 50 * p8;

                    if u7 >= -20 then
                        u1.ABC:Clean();
                    end;

                    u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u6.AssemblyLinearVelocity + RightVector * u7, 8 * p8);
                end);
            end);
        end;

        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(2.5, function() -- Line: 72
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;