  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 28
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 32
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 40
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local WrappedDribble = AbilityBalancing.WrappedDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.AbilityService.Ability:Fire("WrappedDribble");
        AnimationController:StopAnims();
        local Track = AnimationController:GetTrack("Abilities", "WrappedDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("WrappedDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        local _ = v10.MoveDirection.Unit;
        local TravelDistance = WrappedDribble.TravelDistance;
        interface:AbilityCooldown(1, 1.15);
        ABC:Add(function() -- Line: 79
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.25, function() -- Line: 83
            -- upvalues: u9 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local LookVector = (u9.CFrame * CFrame.Angles(0, 0.6108652381980153, 0)).LookVector;
            local v11, v12 = AbilityUtils.FastDashTo(Character, u9.Position + LookVector * TravelDistance, 2, 0.35);
            ABC:Add(v11);
            ABC:Add(v12);
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 94
            -- upvalues: u9 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local LookVector = (u9.CFrame * CFrame.Angles(0, -0.6108652381980153, 0)).LookVector;
            local v13, v14 = AbilityUtils.FastDashTo(Character, u9.Position + LookVector * TravelDistance, 2, 0.55);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        task.delay(1.15, function() -- Line: 105
            -- upvalues: ABC (copy), interface (ref), WrappedDribble (copy)
            ABC:Clean();
            interface.PresentStrike = true;
            task.wait(2.5);

            if interface.PresentStrike then
                interface.PresentStrike = false;
                interface:AbilityCooldown(1, WrappedDribble.Cooldown);
            end;
        end);

        return true;
    end;
end;