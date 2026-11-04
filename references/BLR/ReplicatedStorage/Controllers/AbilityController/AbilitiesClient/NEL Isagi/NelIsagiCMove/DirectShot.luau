  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, p2, p3, p4) -- Line: 5
    -- upvalues: AbilityBalancing (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    local u5 = false;
    u1:AbilityCooldown("1", 30);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.DirectShot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.DirectShot.Looped = false;
    u1.Animations.Abilities.DirectShot:Play();
    local _ = p3.HumanoidRootPart;
    u1.AbilityService.Ability:Fire("NELDirectShot", { "Direct" });
    print("Started");
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6, p7) -- Line: 23
        -- upvalues: AbilityBalancing (ref), u1 (copy)
        print("Here");
        local ShotPower = AbilityBalancing.NELDirectShot.ShotPower;
        local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
        local Y = AbilityBalancing.NELDirectShot.ShotTiltVector.Y;

        if LookVector.Y < Y then
            LookVector = Vector3.new(LookVector.X, Y, LookVector.Z);
        end;

        p6.AssemblyLinearVelocity = LookVector * ShotPower;
        u1.BallController:DragBall(p6);
        u1.ABC:Clean();
    end);
    u1.ABC:Add(function() -- Line: 39
        -- upvalues: u5 (ref), u1 (copy)
        print("Ended");
        u5 = true;
        u1.StatesController.States.Ability = false;
    end);
    task.delay(2, function() -- Line: 45
        -- upvalues: u5 (ref), u1 (copy)
        if not u5 then
            u1.ABC:Clean();
        end;
    end);
end;