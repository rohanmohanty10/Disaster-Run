  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, u3) -- Line: 14, Name: BunnyHop
    -- upvalues: AbilityBalancing (copy), TweenService (copy), RunService (copy)
    if u1.ABC then
        u1.ABC:Clean();
    end;

    local MoveSpeedValue = AbilityBalancing.BunnyHop.MoveSpeedValue;
    local MoveSpeedDuration = AbilityBalancing.BunnyHop.MoveSpeedDuration;
    local HumanoidRootPart = u3.HumanoidRootPart;
    u1:AbilityCooldown("1", AbilityBalancing.BunnyHop.Cooldown);
    u1.AbilityService.Ability:Fire("BunnyHop");
    u1.Animations:StopAnims();
    u1.StatesController.States.Ability = true;
    u1.Animations.Abilities.BunnyHop.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.BunnyHop:Play();
    task.delay(MoveSpeedDuration - 0.7, function() -- Line: 33
        -- upvalues: u1 (copy)
        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(500000, 0, 500000);
    BodyVelocity.Parent = HumanoidRootPart;
    task.wait(0.4);
    tick();
    u1.ABC:Add(function() -- Line: 45
        -- upvalues: TweenService (ref), BodyVelocity (copy), u3 (copy), u1 (copy)
        TweenService:Create(BodyVelocity, TweenInfo.new(0.4), {
            Velocity = Vector3.new(0, 0, 0)
        }):Play();
        task.wait(0.4);

        if not u3.Values.HasBall.Value then
            task.wait(0.3);
        end;

        u1.StatesController.States.Ability = false;
        BodyVelocity:Destroy();
    end);
    u1.ABC:Connect(RunService.Heartbeat, function() -- Line: 61
        -- upvalues: BodyVelocity (copy), HumanoidRootPart (copy), MoveSpeedValue (copy)
        BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * MoveSpeedValue;
    end);
end;