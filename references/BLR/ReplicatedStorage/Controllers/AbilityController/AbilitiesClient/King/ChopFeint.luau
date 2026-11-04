  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local ChopFeint = require(ReplicatedStorage2.AbilityBalancing).ChopFeint;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 17, Name: ChopFeint
    -- upvalues: AbilityUtils (copy), ChopFeint (copy)
    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        local Character = p2.Character;
        local HumanoidRootPart = p2.Character.HumanoidRootPart;
        local Unit = Character.Humanoid.MoveDirection.Unit;

        if Unit.Magnitude <= 0 or HumanoidRootPart.Velocity.Magnitude <= 0.1 then
            Unit = HumanoidRootPart.CFrame.RightVector;
        end;

        u1:AbilityCooldown("1", ChopFeint.Cooldown);
        u1.StatesController.States.Ability = true;
        u1.StatesController.OwnWalkState = true;
        u1.ABC:Add(function() -- Line: 37
            -- upvalues: u1 (copy)
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
        end);
        local v4 = HumanoidRootPart.CFrame:VectorToObjectSpace(Unit);
        local v5 = "Front";
        local u6;

        if math.abs(v4.X) > math.abs(v4.Z) then
            u6 = v4.X > 0 and "Right" or "Left";
        else
            u6 = v4.Z > 0 and "Back" or v5;
        end;

        u1.Animations.Abilities["ChopFeint" .. u6].Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities["ChopFeint" .. u6]:Play();
        u1.Animations.Ball["BallChopFeint" .. u6].Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball["BallChopFeint" .. u6]:Play();
        local v7 = -Vector3.new(Unit.X, 0, Unit.Z);
        local TravelDistance = ChopFeint.TravelDistance;
        local v8 = HumanoidRootPart.Position + v7 * ChopFeint.FeintDistance;
        u1.AbilityService.Ability:Fire("ChopFeint", HumanoidRootPart.Position + v7 * -TravelDistance);
        local v9, v10 = AbilityUtils.FastDashTo(Character, v8, 2, 0.3);
        u1.ABC:Add(v9);
        u1.ABC:Add(v10);
        task.wait(0.5);
        local v11, v12 = AbilityUtils.FastDashTo(Character, HumanoidRootPart.Position + v7 * -TravelDistance, 2, 0.3);
        u1.ABC:Add(v11);
        u1.ABC:Add(v12);
        task.delay(0.5, function() -- Line: 85
            -- upvalues: u1 (copy), u6 (ref)
            u1.ABC:Clean();
            u1.Animations.Abilities["ChopFeint" .. u6]:Stop();
            u1.Animations.Ball["BallChopFeint" .. u6]:Stop();
        end);

        return true;
    end;
end;