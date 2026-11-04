  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, u3) -- Line: 15, Name: Periscope
    -- upvalues: Popup (copy), AbilityBalancing (copy), RunService (copy)
    if u1.AbilityOne > tick() then
        return;
    end;

    if u3.Values.HasBall.Value then
        Popup.Popup(u2, "Only usable without ball");

        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if not u1.Uses then
        u1.Uses = 0;
    end;

    local workspace_Football = workspace.Football;
    local v4 = AbilityBalancing.Periscope.ActivationRangeBall >= (Vector3.new(u3.HumanoidRootPart.Position.X, 0, u3.HumanoidRootPart.Position.Z) - Vector3.new(workspace_Football.Position.X, 0, workspace_Football.Position.Z)).Magnitude;
    local _ = workspace_Football.Position.Y - 9 > 5;
    local u5 = false;
    u1.AbilityService.Ability:Fire("Periscope", v4);
    u1:AbilityCooldown("1", 0.3);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p6) -- Line: 39
        -- upvalues: u5 (ref), Popup (ref), u2 (copy), u1 (copy), RunService (ref), u3 (copy), workspace_Football (copy), AbilityBalancing (ref)
        u5 = true;

        if p6 == "DNS" then
            Popup.Popup(u2, "Could not start");
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.ABC:Clean();

            return;
        end;

        if p6 == "Redirect" then
            local u7 = u1.BallController.Closest or RunService:IsStudio() and workspace.PassRig;
            print(u7);

            if not u7 then
                workspace_Football.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + AbilityBalancing.Periscope.ShotTiltVector) * AbilityBalancing.Periscope.ShotPower;
                u1.BallController:DragBall(workspace_Football);

                return;
            end;

            local Vector3_new_ret = Vector3.new(u7.HumanoidRootPart.AssemblyLinearVelocity.X, 0, u7.HumanoidRootPart.AssemblyLinearVelocity.Z);
            local u8 = (u7.HumanoidRootPart.Position + Vector3_new_ret - u3.HumanoidRootPart.Position).Unit + Vector3.new(0, 0.05, 0);
            workspace_Football.AssemblyLinearVelocity = u8 * math.clamp((u7.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
            u1.BallController:DragBall(workspace_Football);
            local u9 = tick();
            local v10 = workspace:GetRealPhysicsFPS() / 60;
            local math_clamp_ret = math.clamp(v10, 1, 4);
            u1.ABC:Connect(RunService.Heartbeat, function(p11) -- Line: 66
                -- upvalues: u9 (copy), math_clamp_ret (ref), u1 (ref), workspace_Football (ref), u8 (ref), u7 (copy), u3 (ref)
                if tick() > u9 + 0.4 * math_clamp_ret then
                    u1.ABC:Clean();

                    return;
                end;

                if workspace_Football.OnPlayer.Value or not workspace_Football then
                    u1.ABC:Clean();

                    return;
                end;

                local v12 = 1 - math.exp(-6.5 * p11);
                local v13 = tick() > u9 + 0.15 * math_clamp_ret and Vector3.new(0, 0.1, 0) or Vector3.new(0, 0.25, 0);
                u8 = u8:Lerp((u7.HumanoidRootPart.Position - workspace_Football.Position).Unit + v13, v12);
                local math_clamp_ret2 = math.clamp((u7.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude * 3.5, 0, 220);

                if math_clamp_ret2 <= 7 then
                    u1.ABC:Clean();

                    return;
                end;

                workspace_Football.AssemblyLinearVelocity = workspace_Football.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret2, v12);
            end);

            return;
        end;

        local v14 = u1;
        v14.Uses = v14.Uses + 1;

        if u1.Uses >= 2 then
            u1.Uses = nil;
            u1:AbilityCooldown("1", AbilityBalancing.Periscope.Cooldown);
        end;

        u1.Animations:StopAnims();
        u1.StatesController.States.Ability = true;
        u1.StatesController.OwnWalkState = true;
        local _ = p6 == "Success";
        local v15 = "Periscope";
        u1.Animations.Abilities[v15].Priority = Enum.AnimationPriority.Action3;
        u1.Animations.Abilities[v15]:Play();
        task.wait(2.5);
        u1.ABC:Clean();
        u1.Animations.Abilities[v15]:Stop();
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
    end);
    task.delay(2.5, function() -- Line: 130
        -- upvalues: u5 (ref), u1 (copy)
        if u5 == false then
            u1.Animations.Abilities.Periscope:Stop();
            u1.StatesController.States.Ability = false;
            u1.StatesController.OwnWalkState = false;
            u1.ABC:Clean();
        end;
    end);
end;