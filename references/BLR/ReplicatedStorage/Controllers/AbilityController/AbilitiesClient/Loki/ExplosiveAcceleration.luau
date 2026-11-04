  

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
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local _ = workspace.CurrentCamera;

return function(u1, u2) -- Line: 22
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy), TweenService (copy)
    local u3 = u2 ~= "SwiftIntercept";
    local ExplosiveAcceleration = AbilityBalancing.ExplosiveAcceleration;
    local u4 = AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(1) or not u3)) then
        return;
    end;

    local Character, u5, _, _ = AbilityUtils.getCharacter();

    if u3 then
        u1:AbilityCooldown(1, ExplosiveAcceleration.Cooldown);
    end;

    AbilityUtils.clearMovers(Character);
    local Track = AnimationController:GetTrack("Abilities", u4 and "ExplosiveAccelerationOnBall" or "ExplosiveAcceleration");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("LokiExplosiveAcceleration");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action3;
    BallTrack:Play();
    u1.StatesController.States.Ability = true;
    local ABC = u1.ABC;
    local u6 = u4 and u3 and 0.6 or 0.25;
    u1.AbilityService.Ability:Fire("ExplosiveAcceleration", {
        ballSpawnTime = workspace:GetServerTimeNow() + u6 - 0.3,
        dontKick = not u3
    });
    ABC:Add(u1.AbilityService.Ability:Connect(function(p7, p8) -- Line: 64
        if typeof(p7) == "Instance" then
            p7.AssemblyLinearVelocity = p8;
        end;
    end));
    local u9 = false;
    local v14 = AbilityUtils.execute.dash(12, u6 + 0.5, {
        directionRecalculates = true,

        stepped = function(p10, p11) -- Line: 73, Name: stepped
            -- upvalues: u6 (copy), u9 (ref), u3 (copy), StatesController (ref), u2 (copy), AbilityUtils (ref), u5 (copy)
            if u6 < p10 and not u9 then
                u9 = true;

                if u3 then
                    StatesController.CharacterEvents.CustomEvent:Fire("ExplosiveAcceleration");
                elseif u2 == "SwiftIntercept" then
                    StatesController.CharacterEvents.CustomEvent:Fire("SwiftInterceptDash");
                end;
            end;

            if AbilityUtils.wallCheck(u5.CFrame.Position, p11 * 0.5) then
                return Vector3.new(0, 0, 0);
            end;
        end,

        speed = function(p12) -- Line: 88, Name: speed
            -- upvalues: u6 (copy), TweenService (ref), ExplosiveAcceleration (copy), u4 (copy)
            if u6 >= p12 then
                return p12 > 0.4 and u4 and -6 or 6;
            end;

            local Value = TweenService:GetValue(math.clamp((p12 - u6) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

            return math.lerp(ExplosiveAcceleration.MoveSpeedValue, ExplosiveAcceleration.MoveSpeedValue * 0.7, Value);
        end,

        fov = function(p13) -- Line: 101, Name: fov
            -- upvalues: u6 (copy)
            return u6 < p13 and 25 or 8;
        end
    });
    v14:Add(function() -- Line: 109
        -- upvalues: u1 (copy), Track (copy), BallTrack (copy), ABC (copy)
        u1.StatesController.States.Ability = false;
        Track:Stop();
        BallTrack:Stop();
        ABC:Clean();
    end);
    ABC:Add(v14);
end;