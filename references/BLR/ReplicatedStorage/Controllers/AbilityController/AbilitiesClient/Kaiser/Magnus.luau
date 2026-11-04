  

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Magnus = require(game:GetService("ReplicatedStorage").AbilityBalancing).Magnus;

return function(u1, p2, u3) -- Line: 5
    -- upvalues: Magnus (copy), RunService (copy)
    local u4;

    if u3 then
        u4 = u3:FindFirstChild("HumanoidRootPart");
    else
        u4 = u3;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not (u4 and workspace_CurrentCamera) then
        return;
    end;

    if not u3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserMagnus.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserMagnus:Play();
    u1.Animations.Ball.KaiserMagnus.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.KaiserMagnus:Play();
    u1.ABC:Add(function() -- Line: 23
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1.ABC:Add(task.delay(8, function() -- Line: 28
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    local u5 = 35;
    local u6 = tick();
    local u7 = workspace_CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1) + Magnus.ShotTiltVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8) -- Line: 36
        -- upvalues: u1 (copy), u7 (copy), Magnus (ref)
        u1.StatesController.States.Ability = false;
        p8.AssemblyLinearVelocity = u7 * Magnus.ShotPower;
        u1.BallController:DragBall(p8);
    end);
    u1.AbilityService.Ability:Fire("Magnus");
    u1:AbilityCooldown("2", Magnus.Cooldown);
    local u9 = nil;
    u9 = u1.ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 50
        -- upvalues: u6 (copy), u9 (ref), u3 (copy), u1 (copy), workspace_CurrentCamera (copy), u4 (copy), u5 (ref)
        if tick() - u6 >= 0.25 then
            u9:Disconnect();

            if not u3.Values.HasBall then
                u1.ABC:Clean();
            end;

            return;
        end;

        local LookVector = workspace_CurrentCamera.CFrame.LookVector;
        local _ = Vector3.new(LookVector.X, u4.CFrame.LookVector.Y, LookVector.Z) * u5;
        u5 = u5 - 25 * p10;
    end);
end;