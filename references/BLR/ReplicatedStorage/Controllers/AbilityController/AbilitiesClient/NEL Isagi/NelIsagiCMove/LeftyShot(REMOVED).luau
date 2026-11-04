  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3, p4) -- Line: 5
    -- upvalues: AbilityBalancing (copy)
    u1:AbilityCooldown("1", 30);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.LeftyShoot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.LeftyShoot.Looped = false;
    u1.Animations.Abilities.LeftyShoot:Play();
    local _ = p3.HumanoidRootPart;
    u1.AbilityService.Ability:Fire("NELDirectShot", { "Lefty", "Start" });
    u1.Animations.Abilities.LeftyShoot:AdjustSpeed(1);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5, p6) -- Line: 21
        -- upvalues: AbilityBalancing (ref), u1 (copy)
        local ShotPower = AbilityBalancing.LeftyShot.ShotPower;
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
        print(LookVector);

        if LookVector.Y < 0.15 then
            LookVector = Vector3.new(LookVector.X, 0.15, LookVector.Z);
        end;

        u1.ABC:Clean();
        u1.StatesController.States.Ability = false;
        p5.AssemblyLinearVelocity = LookVector * ShotPower;
        u1.BallController:DragBall(p5);
    end);
    u1.ABC:Add(task.delay(2, function() -- Line: 39
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.ABC:Clean();
    end));
end;