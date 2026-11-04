  

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
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 29
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 33
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 41
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), LocalPlayer (copy), StatesController (copy), AnimationController (copy)
    local SideStepDribble = AbilityBalancing.SideStepDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(3) and not interface.__trapped)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(3, LocalPlayer.PlayerStats.Flow.Value == "Singularity" and LocalPlayer.PlayerStats.InFlow.Value and SideStepDribble.Cooldown * 0.85 or SideStepDribble.Cooldown);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        local Track = AnimationController:GetTrack("Abilities", "SideStepDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("SideStepDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("SideStepDribble");
        ABC:Add(function() -- Line: 77
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        local v11, v12 = AbilityUtils.FastDashTo(Character, (u9.CFrame * CFrame.new(20, 0, -20)).Position, 2, 0.5);
        ABC:Add(v11);
        ABC:Add(v12);
        ABC:Add(task.delay(0.5, function() -- Line: 87
            -- upvalues: AbilityUtils (ref), Character (copy), u9 (copy), ABC (copy)
            local v13, v14 = AbilityUtils.FastDashTo(Character, (u9.CFrame * CFrame.new(-20, 0, -20)).Position, 2, 0.5);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        ABC:Add(task.delay(1.5, function() -- Line: 93
            -- upvalues: AbilityUtils (ref), Character (copy), u9 (copy), SideStepDribble (copy), ABC (copy)
            local v15, v16 = AbilityUtils.FastDashTo(Character, (u9.CFrame * CFrame.new(0, 0, -SideStepDribble.Distance)).Position, 2, 0.5);
            ABC:Add(v15);
            ABC:Add(v16);
        end));
        ABC:Add(task.delay(2.3, function() -- Line: 99
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;