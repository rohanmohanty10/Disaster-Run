  

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
    local KrampusChopDribble = AbilityBalancing.KrampusChopDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(2, KrampusChopDribble.Cooldown);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.AbilityService.Ability:Fire("KrampusChopDribble");
        local Track = AnimationController:GetTrack("Abilities", "KrampusChopDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("KrampusChopDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        ABC:Add(task.delay(0.1, function() -- Line: 71
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), KrampusChopDribble (copy), ABC (copy)
            local v11, v12 = AbilityUtils.FastDashTo(Character, u9.Position + (-u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * (KrampusChopDribble.Distance / 2), 2, 0.5);
            ABC:Add(v11);
            ABC:Add(v12);
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 79
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), KrampusChopDribble (copy), ABC (copy)
            local v13, v14 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * (KrampusChopDribble.Distance / 2), 2, 0.6);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        ABC:Add(task.delay(1.2, function() -- Line: 87
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), KrampusChopDribble (copy), ABC (copy)
            local v15, v16 = AbilityUtils.FastDashTo(Character, u9.Position + (-(u9.CFrame.RightVector * 0.5) + u9.CFrame.LookVector).Unit * KrampusChopDribble.Distance, 2, 0.5);
            ABC:Add(v15);
            ABC:Add(v16);
        end));
        ABC:Add(function() -- Line: 95
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(1.7, function() -- Line: 100
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;