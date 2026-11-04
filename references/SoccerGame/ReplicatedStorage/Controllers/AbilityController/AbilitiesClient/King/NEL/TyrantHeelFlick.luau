  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, p2, u3) -- Line: 17, Name: HeelFlick
    -- upvalues: interface (copy), Debris (copy)
    if u3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    interface.TyrantHeelFlick = nil;
    local _ = u1.BallController.Closest;
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1:AbilityCooldown("3", 40);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.TyrantHeelFlick.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.TyrantHeelFlick:Play();
    u1.AbilityService.Ability:Fire("TyrantHeelFlick");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4) -- Line: 41
        -- upvalues: u1 (copy), u3 (copy), Debris (ref)
        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        warn("SET OWN WALK STATE TO FALSE");
        p4.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * 64;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Parent = u3.HumanoidRootPart;
        BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
        Debris:AddItem(BodyVelocity, 0.45);
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.Parent = u3.HumanoidRootPart;
        BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
        Debris:AddItem(BodyGyro, 0.45);
        BodyVelocity.Velocity = u3.HumanoidRootPart.CFrame.LookVector * 85;
        u1.Animations:StopAnims();
        u1.Animations.Abilities.Steal.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.Steal:Play();
        u1.BallController:DragBall(p4);
    end);
    task.delay(2, function() -- Line: 69
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        warn("SET OWN WALK STATE TO FALSE");
    end);
end;