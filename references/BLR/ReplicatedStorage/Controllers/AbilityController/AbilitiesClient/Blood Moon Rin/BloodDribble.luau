  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p1, p2, u3) -- Line: 22
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), AnimationController (copy), StatesController (copy), TweenService (copy)
    local BloodDribble = AbilityBalancing.BloodDribble;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local _, u4, _, _ = AbilityUtils.getCharacter();
    local ABC = p1.ABC;
    p1:AbilityCooldown(3, BloodDribble.Cooldown);
    p1.AbilityService.Ability:Fire("BloodDribble");
    AnimationController:StopAnims();
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 44
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "BloodDribble");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    AnimationController:GetBallTrack("BloodDribbleBall"):Play();
    local CFrame2 = u4.CFrame;
    ABC:Add((AbilityUtils.execute.dash(30, 0.8, {
        notlookat = true,

        direction = function() -- Line: 72, Name: direction
            -- upvalues: CFrame2 (copy)
            return -CFrame2.RightVector;
        end,

        speed = function(p5) -- Line: 73, Name: speed
            -- upvalues: TweenService (ref), BloodDribble (copy)
            if p5 <= 0.2 then
                return nil;
            end;

            local Value = TweenService:GetValue(math.clamp((p5 - 0.2) / 0.5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local v6 = BloodDribble.MoveSpeedValue * 0.5;

            return math.lerp(v6, v6 * 0.7, Value);
        end,

        stepped = function(p7, p8) -- Line: 63
            -- upvalues: AbilityUtils (ref), u4 (copy)
            return AbilityUtils.wallCheck(u4.CFrame.Position, p8 * 1 / 30) and Vector3.new(0, 0, 0) or p8;
        end
    })));
    ABC:Add(task.delay(0.8, function() -- Line: 92
        -- upvalues: AbilityUtils (ref), u3 (copy), u4 (copy), BloodDribble (copy), ABC (copy)
        local v9, v10 = AbilityUtils.FastDashTo(u3, (u4.CFrame * CFrame.new(0, 0, -BloodDribble.TravelDistance)).Position, 2, 0.7);
        ABC:Add(v9);
        ABC:Add(v10);
    end));
    task.delay(1.4, function() -- Line: 99
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;