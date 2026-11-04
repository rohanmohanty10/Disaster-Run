  

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
    local MiroChopDribble = AbilityBalancing.MiroChopDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        local X = Character.HumanoidRootPart.CFrame:vectorToObjectSpace(Character.Humanoid.MoveDirection).X;
        local math_round_ret = math.round(X);
        local v11 = math_round_ret == 1 and "Right" or "Left";
        interface:AbilityCooldown(2, 2);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        StatesController.OwnWalkState = true;
        interface.AbilityService.Ability:Fire("MagicalTurn", "Side");
        local Track = AnimationController:GetTrack("Abilities", "MagicalTurn" .. v11);
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("MagicalTurn" .. v11 .. "Ball");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        ABC:Add(task.delay(1.25, function() -- Line: 76
            -- upvalues: u9 (copy), math_round_ret (ref), AbilityUtils (ref), Character (copy), ABC (copy)
            local v12, v13 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * -math_round_ret * 20, 2, 0.35);
            ABC:Add(v12);
            ABC:Add(v13);
        end));
        ABC:Add(task.delay(1.6, function() -- Line: 84
            -- upvalues: u9 (copy), math_round_ret (ref), AbilityUtils (ref), Character (copy), ABC (copy)
            local v14, v15 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * math_round_ret * 70, 2, 0.4);
            ABC:Add(v14);
            ABC:Add(v15);
        end));
        ABC:Add(function() -- Line: 93
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
            StatesController.OwnWalkState = false;
        end);
        interface.HeelFlick = true;
        ABC:Add(task.delay(2, function() -- Line: 100
            -- upvalues: ABC (copy), interface (ref), MiroChopDribble (copy)
            ABC:Clean();
            task.wait(2);

            if interface.HeelFlick then
                interface.HeelFlick = false;
                interface:AbilityCooldown(2, MiroChopDribble.Cooldown);
            end;
        end));

        return true;
    end;
end;