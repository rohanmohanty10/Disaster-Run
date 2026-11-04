  

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
    local NELChopFeint = AbilityBalancing.NELChopFeint;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface.ChopFeintCD = interface.ChopFeintCD and interface.ChopFeintCD + 1 or 1;
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.AbilityService.Ability:Fire("NELChopFeint");
        local Track = AnimationController:GetTrack("Abilities", "NELChopFeint");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("NELChopFeintBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        ABC:Add(task.delay(0.1, function() -- Line: 71
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), NELChopFeint (copy), ABC (copy)
            local v11, v12 = AbilityUtils.FastDashTo(Character, u9.Position + -u9.CFrame.RightVector * NELChopFeint.FeintDistance, 2, 0.3);
            ABC:Add(v11);
            ABC:Add(v12);
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 80
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), NELChopFeint (copy), ABC (copy)
            local v13, v14 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * NELChopFeint.TravelDistance, 2, 0.4);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        ABC:Add(function() -- Line: 88
            -- upvalues: Character (copy), interface (ref), StatesController (ref)
            if Character.Values.HasBall.Value or interface.ChopFeintCD == 2 then
                interface:AbilityCooldown(2, 40);
                interface.ChopFeint = nil;
            else
                interface:AbilityCooldown(2, 2);
            end;

            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(1, function() -- Line: 98
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;