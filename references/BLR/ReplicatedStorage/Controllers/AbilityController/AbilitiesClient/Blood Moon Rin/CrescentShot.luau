  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1) -- Line: 17
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), RunService (copy), ReplicatedStorage (copy)
    local CrescentShot = AbilityBalancing.CrescentShot;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local _, _, _, _ = AbilityUtils.getCharacter();
    u1.StatesController.NoJump = true;
    u1.StatesController.States.Ability = true;
    u1:AbilityCooldown(1, CrescentShot.Cooldown);
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "CrescentShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local ABC = u1.ABC;
    u1.AbilityService.Ability:Fire("CrescentShot");
    ABC:Connect(u1.AbilityService.Ability, function(u2, u3) -- Line: 46
        -- upvalues: u1 (copy), CrescentShot (copy), RunService (ref), ReplicatedStorage (ref)
        u1.StatesController.NoJump = false;
        u1.StatesController.States.Ability = false;
        local v4 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u3 / 2;
        u2.AssemblyLinearVelocity = v4 * CrescentShot.ShotPower;

        if v4.Y < 0.15 then
            Vector3.new(v4.X, 0.15, v4.Z);
        end;

        task.delay(0.1, function() -- Line: 59
            -- upvalues: u1 (ref), RunService (ref), u2 (copy), u3 (copy)
            local u5 = -43;
            u1.ABC:Connect(RunService.Heartbeat, function(p6) -- Line: 62
                -- upvalues: u5 (ref), u1 (ref), u2 (ref), u3 (ref)
                u5 = u5 + 40 * p6;

                if u5 >= -25 then
                    u1.ABC:Clean();
                end;

                u2.AssemblyLinearVelocity = u2.AssemblyLinearVelocity:Lerp(u2.AssemblyLinearVelocity + u3 * u5, 8 * p6);
            end);
        end);
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    ABC:Add(function() -- Line: 74
        -- upvalues: u1 (copy), Track (copy)
        u1.StatesController.NoJump = false;
        u1.StatesController.States.Ability = false;
        Track:Stop();
    end);
    ABC:Add(task.delay(2, function() -- Line: 80
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;