  

local CameraShaker = require(game:WaitForChild("ReplicatedStorage").Shared.CameraShaker);
local KaiserDribble = require(game:GetService("ReplicatedStorage").AbilityBalancing).KaiserDribble;

return function(u1, p2, u3) -- Line: 4
    -- upvalues: KaiserDribble (copy), CameraShaker (copy)
    local v4 = p2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");
    local UIScale = v4:FindFirstChild("UIScale");

    if not v4 then
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
    v4.ImageColor3 = Color3.fromRGB(255, 255, 255);
    u1.OverwriteText["2"] = "Emperor\'s Dribble";
    u1.KaiserDribbleShot = nil;
    u3:SetAttribute("KaiserDribbleShot", nil);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserDribbleShoot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserDribbleShoot:Play();
    u1.Animations.Ball.KaiserDribbleShoot:Play();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    game.Workspace.CurrentCamera.FieldOfView = 25;
    u1:AbilityCooldown("2", KaiserDribble.Cooldown);
    u1.StatesController.States.Ability = true;
    u1.AbilityService.Ability:Fire("KaiserDribble", {
        State = script.Parent.Name,
        Action = script.Name
    });
    local u5 = false;
    task.delay(1.5, function() -- Line: 34
        -- upvalues: u5 (ref), u1 (copy)
        if not u5 then
            u1.StatesController.States.Ability = false;
            u1.ABC:Clean();
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 40
        -- upvalues: u5 (ref), u1 (copy), FieldOfView (copy), u3 (copy), CameraShaker (ref)
        u5 = true;

        if p6.State ~= "Failed" then
            if p6.State == "Shoot" then
                u1.StatesController.States.Ability = false;
                u1.ABC:Clean();
                p6.Ball.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + p6.ShotHeight) * p6.ShotPower;
                u1.BallController:DragBall(p6.Ball);
                game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
                local v8 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p7) -- Line: 53
                    game.Workspace.CurrentCamera.CFrame = game.Workspace.CurrentCamera.CFrame * CFrame.new(p7.Position * 1) * p7.Rotation;
                end);
                v8:Start();
                v8:Shake(v8.Presets.Explosion);
                task.delay(0.45, v8.Stop, v8);
            end;

            return;
        end;

        u1.StatesController.States.Ability = false;
        u1.ABC:Clean();
        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
    end);
end;