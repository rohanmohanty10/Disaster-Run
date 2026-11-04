  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(ReplicatedStorage.Shared.Popup);

return function(u1, p2, u3) -- Line: 5
    if u3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3 then
        u3 = u3:FindFirstChild("HumanoidRootPart");
    end;

    if not u3 then
        return;
    end;

    u1.StatesController.States.Ability = true;
    u1:AbilityCooldown("3", 60);
    u1.Animations:StopAnims();

    if u3.CFrame:VectorToObjectSpace(u3.AssemblyLinearVelocity).X > 0 then
        u1.Animations.Abilities.BeautifulShotR.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.BeautifulShotR:Play();
        u1.Animations.Ball.BeautifulShotR.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.BeautifulShotR:Play();
    else
        u1.Animations.Abilities.BeautifulShotL.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.BeautifulShotL:Play();
        u1.Animations.Ball.BeautifulShotL.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Ball.BeautifulShotL:Play();
    end;

    u1.AbilityService.Ability:Fire("Surpass", { "BeautifulShot" });
    u1.ABC:Connect(u1.AbilityService.Ability, function(p4, p5) -- Line: 39
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        p4.AssemblyLinearVelocity = (u3.CFrame.LookVector + Vector3.new(0, 0.18, 0)) * 220;
        u1.BallController:DragBall(p4);
    end);
    task.delay(2.5, function() -- Line: 45
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;

        if u1.ABC then
            u1.ABC:Clean();
        end;
    end);
end;