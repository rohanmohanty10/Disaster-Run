  

local CameraShaker = require(game:WaitForChild("ReplicatedStorage").Shared.CameraShaker);

return function(u1, p2, u3) -- Line: 3
    -- upvalues: CameraShaker (copy)
    local v4 = u1.CopiedStyle and "1" or "3";
    local v5 = p2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild(v4);
    local UIScale = v5:FindFirstChild("UIScale");

    if not v5 then
        return;
    end;

    if u1.LostBallConnection then
        u1.LostBallConnection:Disconnect();
        u1.LostBallConnection = nil;
    end;

    if u1.UITween2 then
        u1.UITween2:Cancel();
        u1.UITween2 = nil;
    end;

    if u1.UITween1 then
        u1.UITween1:Cancel();
        u1.UITween1 = nil;
    end;

    UIScale.Scale = 1;
    v5.ImageColor3 = Color3.fromRGB(255, 255, 255);
    u1.OverwriteText[v4] = "Emperor\'s Dribble";
    u1.KaiserDribbleShot = nil;
    u3:SetAttribute("KaiserDribbleShot", nil);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserDribbleShoot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserDribbleShoot:Play();
    u1.Animations.Ball.KaiserDribbleShoot:Play();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    game.Workspace.CurrentCamera.FieldOfView = 25;
    u1:AbilityCooldown(v4, 60);
    u1.StatesController.States.Ability = true;
    u1.AbilityService.Ability:Fire("KaiserDribbleULT", {
        State = script.Parent.Name,
        Action = script.Name
    });
    local u6 = false;
    task.delay(1.5, function() -- Line: 34
        -- upvalues: u6 (ref), u1 (copy)
        if not u6 then
            u1.StatesController.States.Ability = false;
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p7) -- Line: 40
        -- upvalues: u6 (ref), u1 (copy), FieldOfView (copy), u3 (copy), CameraShaker (ref)
        u6 = true;

        if p7.State ~= "Failed" then
            if p7.State == "Shoot" then
                u1.StatesController.States.Ability = false;
                u1.ABC:Clean();
                p7.Ball.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + p7.ShotHeight) * p7.ShotPower;
                u1.BallController:DragBall(p7.Ball);
                game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
                local v9 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p8) -- Line: 53
                    game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(p8.Position * 1) * p8.Rotation;
                end);
                v9:Start();
                v9:Shake(v9.Presets.Explosion);
                task.delay(0.45, v9.Stop, v9);
            end;

            return;
        end;

        u1.StatesController.States.Ability = false;
        u1.ABC:Clean();
        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
    end);
end;