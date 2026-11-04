  

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
    local _ = AbilityBalancing.NELChopFeint;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(3, 1.6);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface.TyrantHeelFlick = true;
        interface.AbilityService.Ability:Fire("TyrantTwistedPath");
        local Track = AnimationController:GetTrack("Abilities", "TyrantTwistedPath");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local v11, v12 = AbilityUtils.FastDashTo(Character, u9.Position + (u9.CFrame.RightVector + u9.CFrame.LookVector).Unit * 65, 2, 0.6);
        ABC:Add(v11);
        ABC:Add(v12);
        ABC:Add(task.delay(0.8, function() -- Line: 74
            -- upvalues: u9 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local v13, v14 = AbilityUtils.FastDashTo(Character, u9.Position + -u9.CFrame.RightVector * 65, 2, 1);
            ABC:Add(v13);
            ABC:Add(v14);
        end));
        ABC:Add(function() -- Line: 82
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(1.8, function() -- Line: 86
            -- upvalues: ABC (copy), interface (ref)
            ABC:Clean();
            task.wait(2);

            if interface.TyrantHeelFlick then
                interface.TyrantHeelFlick = false;
                interface:AbilityCooldown(3, 40);
            end;
        end));

        return true;
    end;
end;