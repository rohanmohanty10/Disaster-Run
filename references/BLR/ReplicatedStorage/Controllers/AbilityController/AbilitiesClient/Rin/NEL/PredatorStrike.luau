  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, p3) -- Line: 19, Name: PredatorStrike
    -- upvalues: AbilityUtils (copy), interface (copy), RunService (copy), ReplicatedStorage (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if not AbilityUtils.rules.grounded() then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    interface.PredatorStrike = false;
    u1:AbilityCooldown("2", 45);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.PredatorStrike.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.PredatorStrike:Play();
    u1.AbilityService.Ability:Fire("PredatorStrike");
    u1.ABC:Connect(u1.AbilityService.Ability, function(u4, u5, p6) -- Line: 47
        -- upvalues: u1 (copy), RunService (ref), ReplicatedStorage (ref)
        u1.StatesController.States.Ability = false;
        local v7 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.45, 0) + u5 / 2;
        u4.AssemblyLinearVelocity = v7 * (p6 and 155 or 140);

        if v7.Y < 0.15 then
            Vector3.new(v7.X, 0.15, v7.Z);
        end;

        task.delay(0.1, function() -- Line: 59
            -- upvalues: u1 (ref), RunService (ref), u4 (copy), u5 (copy)
            local u8 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 62
                -- upvalues: u8 (ref), u1 (ref), u4 (ref), u5 (ref)
                u8 = u8 + 40 * p9;

                if u8 >= -25 then
                    u1.ABC:Clean();
                end;

                u4.AssemblyLinearVelocity = u4.AssemblyLinearVelocity:Lerp(u4.AssemblyLinearVelocity + u5 * u8, 8 * p9);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(1.5, function() -- Line: 73
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;