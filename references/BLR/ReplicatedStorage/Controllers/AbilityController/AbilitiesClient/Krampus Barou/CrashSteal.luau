  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy), RunService (copy)
    local CrashSteal = AbilityBalancing.CrashSteal;
    local Football = workspace:FindFirstChild("Football");

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    if not Football or AbilityUtils.rules.onball(LocalPlayer, false) then
        Popup.Popup(LocalPlayer, "Ball must be loose!");

        return;
    end;

    local Character, u1, v2, _ = AbilityUtils.getCharacter();

    if (u1.Position - Football.Position).Magnitude <= CrashSteal.ActivationRangeBall then
        interface:AbilityCooldown(1, CrashSteal.Cooldown);
        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        AnimationController:StopAnims();
        local Track = AnimationController:GetTrack("Abilities", "CrashSteal");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        interface.AbilityService.Ability:Fire("CrashSteal");
        ABC:Add(task.delay(0.2, function() -- Line: 67
            -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), CrashSteal (copy), ABC (copy), RunService (ref), interface (ref)
            local Football2 = workspace:FindFirstChild("Football");
            local LookVector = u1.CFrame.LookVector;

            if Football2 then
                LookVector = CFrame.new(u1.Position, (Vector3.new(Football2.Position.X, u1.Position.Y, Football2.Position.Z))).LookVector;
            end;

            local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + Vector3.new(LookVector.X, 0, LookVector.Z) * CrashSteal.Distance, 2, 0.4);
            ABC:Add(v3);
            ABC:Add(v4);
            ABC:Add(RunService.Heartbeat:Connect(function() -- Line: 78
                -- upvalues: Football2 (copy), u1 (ref), interface (ref)
                if not Football2.OnPlayer.Value and (u1.Position - Football2.Position).Magnitude <= 5 then
                    interface.AbilityService.Ability:Fire("CrashSteal", "Steal");
                end;
            end));
        end));
        ABC:Add(function() -- Line: 85
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.7, function() -- Line: 89
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;

    Popup.Popup(LocalPlayer, "Ball not in range!");
end;