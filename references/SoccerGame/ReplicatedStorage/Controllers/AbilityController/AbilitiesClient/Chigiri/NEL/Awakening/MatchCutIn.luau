  

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
    local MatchCutIn = AbilityBalancing.MatchCutIn;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(3, MatchCutIn.Cooldown);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.AbilityService.Ability:Fire("MatchCutIn");
        local Track = AnimationController:GetTrack("Abilities", "MatchCutIn");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local u11 = false;
        ABC:Add(task.delay(0.05, function() -- Line: 68
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local v12, v13 = AbilityUtils.FastDashTo(Character, u9.Position + -u9.CFrame.RightVector * 20, 2, 0.15);
            ABC:Add(v12);
            ABC:Add(v13);
        end));
        ABC:Add(task.delay(0.3, function() -- Line: 76
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local v14, v15 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * 20, 2, 0.25);
            ABC:Add(v14);
            ABC:Add(v15);
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 84
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), MatchCutIn (copy), ABC (copy)
            local v16, v17 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.LookVector.Unit * MatchCutIn.Distance, 2, 0.6, Enum.EasingStyle.Linear);
            ABC:Add(v16);
            ABC:Add(v17);
        end));
        ABC:Add(function() -- Line: 92
            -- upvalues: u11 (ref), StatesController (ref)
            u11 = true;
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(1.2, function() -- Line: 97
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;