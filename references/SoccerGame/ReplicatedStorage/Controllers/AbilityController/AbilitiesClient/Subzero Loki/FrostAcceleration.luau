  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local _ = workspace.CurrentCamera;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local FrostAcceleration = require(ReplicatedStorage.AbilityBalancing).FrostAcceleration;

return function() -- Line: 24
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), StatesController (copy), TweenService (copy), FrostAcceleration (copy)
    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(1, 1.5);
    AbilityUtils.clearMovers(Character);
    local Track = AnimationController:GetTrack("Abilities", "FrostAcceleration");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("FrostAccelerationBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action3;
    BallTrack:Play();
    interface.StatesController.States.Ability = true;
    local ABC = interface.ABC;
    interface.AbilityService.Ability:Fire("FrostAcceleration", {
        dontKick = false,
        ballSpawnTime = workspace:GetServerTimeNow() + 0.8 - 0.3
    });
    ABC:Add(interface.AbilityService.Ability:Connect(function(p2, p3) -- Line: 58
        if typeof(p2) == "Instance" then
            p2.AssemblyLinearVelocity = p3;
        end;
    end));
    local u4 = false;
    local v9 = AbilityUtils.execute.dash(12, 1.3, {
        directionRecalculates = true,

        stepped = function(p5, p6) -- Line: 67, Name: stepped
            -- upvalues: u4 (ref), StatesController (ref), AbilityUtils (ref), u1 (copy)
            if p5 > 0.8 and not u4 then
                u4 = true;
                StatesController.CharacterEvents.CustomEvent:Fire("ExplosiveAcceleration");
            end;

            if AbilityUtils.wallCheck(u1.CFrame.Position, p6 * 1) then
                return Vector3.new(0, 0, 0);
            end;
        end,

        speed = function(p7) -- Line: 79, Name: speed
            -- upvalues: TweenService (ref), FrostAcceleration (ref)
            if p7 <= 0.8 then
                return p7 > 0.4 and -6 or 6;
            end;

            local Value = TweenService:GetValue(math.clamp((p7 - 0.8) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

            return math.lerp(FrostAcceleration.MoveSpeedValue, FrostAcceleration.MoveSpeedValue * 0.7, Value);
        end,

        fov = function(p8) -- Line: 92, Name: fov
            return p8 > 0.8 and 25 or 8;
        end
    });
    interface.FrostShot = true;
    task.delay(3, function() -- Line: 101
        -- upvalues: interface (ref), FrostAcceleration (ref)
        if interface.FrostShot then
            interface:AbilityCooldown(1, FrostAcceleration.Cooldown);
            interface.FrostShot = nil;
        end;
    end);
    v9:Add(function() -- Line: 108
        -- upvalues: interface (ref), Track (copy), BallTrack (copy), ABC (copy)
        interface.StatesController.States.Ability = false;
        Track:Stop();
        BallTrack:Stop();
        ABC:Clean();
    end);
    ABC:Add(v9);
end;