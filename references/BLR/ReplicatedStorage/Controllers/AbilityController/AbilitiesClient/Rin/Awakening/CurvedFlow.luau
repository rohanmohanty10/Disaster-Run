  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), interface (copy), AbilityUtils (copy), LocalPlayer (copy), RunService (copy), ReplicatedStorage (copy)
    local CurvedFlow = AbilityBalancing.CurvedFlow;

    if interface.UsingEgoStoppage then
        return;
    end;

    local v1 = AbilityUtils.rules.enemyTarget(CurvedFlow.EnemyRange);

    if not (v1 and (AbilityUtils.rules.onball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(2)))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v1);
    AbilityUtils.clientCutsceneSkill(interface, CurvedFlow, 20, 2, true, workspace.CurrentCamera.CFrame.LookVector, true);
    local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
    interface.ABC:Connect(interface.AbilityService.Ability, function(u2, u3) -- Line: 60
        -- upvalues: LookVector (copy), CurvedFlow (copy), interface (ref), RunService (ref), ReplicatedStorage (ref)
        local v4 = LookVector + Vector3.new(0, 0.2, 0) + u3 / 2;
        u2.AssemblyLinearVelocity = v4 * CurvedFlow.ShotPower;

        if v4.Y < 0.15 then
            Vector3.new(v4.X, 0.15, v4.Z);
        end;

        task.delay(0.1, function() -- Line: 71
            -- upvalues: interface (ref), RunService (ref), u2 (copy), u3 (copy)
            local u5 = -43;
            interface.ABC:Connect(RunService.Heartbeat, function(p6) -- Line: 74
                -- upvalues: u5 (ref), interface (ref), u2 (ref), u3 (ref)
                u5 = u5 + 40 * p6;

                if u5 >= -25 then
                    interface.ABC:Clean();
                end;

                u2.AssemblyLinearVelocity = u2.AssemblyLinearVelocity:Lerp(u2.AssemblyLinearVelocity + u3 * u5, 8 * p6);
            end);
        end);
        interface.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
end;