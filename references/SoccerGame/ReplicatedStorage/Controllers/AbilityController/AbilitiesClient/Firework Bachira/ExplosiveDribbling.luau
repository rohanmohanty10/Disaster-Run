  

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
    -- upvalues: AbilityBalancing (copy), interface (copy), AbilityUtils (copy), StatesController (copy), AnimationController (copy)
    local ExplosiveDribbling = AbilityBalancing.ExplosiveDribbling;

    if interface.FlashyShot then
        return;
    end;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface:AbilityCooldown(1, 2.5);
    local Character, u9, v10, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local _ = v10.MoveDirection.Unit;
    local u11 = false;
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("ExplosiveDribbling");
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "ExplosiveDribbling");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("ExplosiveDribblingBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    local _ = v10.MoveDirection.Unit;
    local TravelDistance = ExplosiveDribbling.TravelDistance;
    ABC:Add(function() -- Line: 81
        -- upvalues: StatesController (ref), u11 (ref), interface (ref), ExplosiveDribbling (copy)
        StatesController.States.Ability = false;

        if u11 then
            interface.FlashyShot = true;
            task.delay(2.5, function() -- Line: 87
                -- upvalues: interface (ref), ExplosiveDribbling (ref)
                if interface.FlashyShot then
                    interface.FlashyShot = false;
                    interface:AbilityCooldown(1, ExplosiveDribbling.Cooldown);
                end;
            end);
        end;
    end);
    ABC:Add(task.delay(0.3, function() -- Line: 106
        -- upvalues: u9 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local LookVector = (u9.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)).LookVector;
        local v12, v13 = AbilityUtils.FastDashTo(Character, u9.Position + LookVector * TravelDistance, 2, 0.4);
        ABC:Add(v12);
        ABC:Add(v13);
    end));
    ABC:Add(task.delay(1, function() -- Line: 117
        -- upvalues: u9 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local LookVector = (u9.CFrame * CFrame.Angles(0, -0.7853981633974483, 0)).LookVector;
        local v14, v15 = AbilityUtils.FastDashTo(Character, u9.Position + LookVector * TravelDistance, 2, 0.3);
        ABC:Add(v14);
        ABC:Add(v15);
    end));
    ABC:Add(task.delay(1.4, function() -- Line: 128
        -- upvalues: u11 (ref), ABC (copy)
        u11 = true;
        ABC:Clean();
    end));
end;