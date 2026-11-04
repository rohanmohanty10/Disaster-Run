  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
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
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), RunService (copy)
    local MiroChopDribble = AbilityBalancing.MiroChopDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(1, 2);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.AbilityService.Ability:Fire("MiroChopDribble");
        local Track = AnimationController:GetTrack("Abilities", "CR7ChopDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        ABC:Add(task.delay(0.1, function() -- Line: 71
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), MiroChopDribble (copy), ABC (copy)
            local v11, v12 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.RightVector * (MiroChopDribble.Distance / 2), 2, 0.4);
            ABC:Add(v11);
            ABC:Add(v12);
        end));
        ABC:Add(task.delay(0.5, function() -- Line: 79
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), MiroChopDribble (copy), ABC (copy)
            local v13, v14 = AbilityUtils.FastDashTo(Character, u9.Position + (-u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * (MiroChopDribble.Distance / 2), 2, 0.3);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        ABC:Add(task.delay(0.8, function() -- Line: 88
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), MiroChopDribble (copy), ABC (copy)
            local v15, v16 = AbilityUtils.FastDashTo(Character, u9.Position + u9.CFrame.LookVector.Unit * MiroChopDribble.Distance, 2, 0.5, Enum.EasingStyle.Linear);
            ABC:Add(v15);
            ABC:Add(v16);
        end));
        ABC:Add(task.delay(1.3, function() -- Line: 96
            -- upvalues: u9 (copy), ABC (copy), RunService (ref), MiroChopDribble (copy)
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
            BodyVelocity.Parent = u9;
            ABC:Add(BodyVelocity);
            ABC:Connect(RunService.Heartbeat, function() -- Line: 103
                -- upvalues: BodyVelocity (copy), u9 (ref), MiroChopDribble (ref)
                BodyVelocity.Velocity = u9.CFrame.LookVector * MiroChopDribble.Distance;
            end);
        end));
        ABC:Add(function() -- Line: 108
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        interface.KnuckleBall = true;
        ABC:Add(task.delay(1.9, function() -- Line: 114
            -- upvalues: ABC (copy), interface (ref), MiroChopDribble (copy)
            ABC:Clean();
            task.wait(4);

            if interface.KnuckleBall then
                interface.KnuckleBall = false;
                interface:AbilityCooldown(1, MiroChopDribble.Cooldown);
            end;
        end));

        return true;
    end;
end;