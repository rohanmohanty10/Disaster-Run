  

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local KaiserImpact = require(ReplicatedStorage.AbilityBalancing).KaiserImpact;
local Trove = require(ReplicatedStorage.Packages.Trove);

return function(u1, p2, u3) -- Line: 7
    -- upvalues: KaiserImpact (copy), RunService (copy), Trove (copy)
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

    if u1.AbilityOne > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KaiserImpact.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KaiserImpact:Play();
    u1.Animations.Ball.KaiserImpact.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.KaiserImpact:Play();
    u1:AbilityCooldown("1", KaiserImpact.Cooldown);
    u1.AbilityService.Ability:Fire("KaiserImpact");
    u1.ABC:Add(function() -- Line: 29
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    local MoveSpeedValue = KaiserImpact.MoveSpeedValue;
    local u5 = tick();
    local u6 = nil;
    u6 = u1.ABC:Connect(RunService.Heartbeat, function(p7) -- Line: 37
        -- upvalues: u5 (copy), KaiserImpact (ref), u6 (ref), u3 (copy), u1 (copy), workspace_CurrentCamera (copy), u4 (copy), MoveSpeedValue (ref)
        if tick() - u5 >= KaiserImpact.MoveSpeedDuration then
            u6:Disconnect();

            if not u3.Values.HasBall.Value then
                u1.ABC:Clean();
            end;

            return;
        end;

        local LookVector = workspace_CurrentCamera.CFrame.LookVector;
        local _ = Vector3.new(LookVector.X, u4.CFrame.LookVector.Y, LookVector.Z) * MoveSpeedValue;
        MoveSpeedValue = MoveSpeedValue - 25 * p7;
    end);
    u1.ABC:Add(task.delay(5, function() -- Line: 53
        -- upvalues: u6 (ref), u1 (copy)
        u6:Disconnect();
        u1.ABC:Clean();
    end));
    u1.ABC:Connect(u1.AbilityService.Ability, function(u8) -- Line: 58
        -- upvalues: u3 (copy), u1 (copy), workspace_CurrentCamera (copy), KaiserImpact (ref), Trove (ref), RunService (ref)
        if not u3.Values.HasBall.Value then
            u1.ABC:Clean();
        end;

        u1.StatesController.States.Ability = false;
        local u9 = workspace_CurrentCamera.CFrame.LookVector + KaiserImpact.ShotTiltVector;
        u8.AssemblyLinearVelocity = u9 * KaiserImpact.ShotPower;
        u1.BallController:DragBall(u8);
        local u10 = Trove.new();
        local ShotDuration = KaiserImpact.ShotDuration;
        local ShotPower = KaiserImpact.ShotPower;
        local u11 = tick();
        local Position = u8.Position;
        u10:Connect(RunService.Stepped, function(p12, p13) -- Line: 78
            -- upvalues: ShotPower (ref), u8 (copy), u9 (copy), u11 (copy), ShotDuration (copy), Position (copy), u10 (copy)
            ShotPower = math.max(ShotPower - 190 * p13, 40);
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { u8 };
            RaycastParams_new_ret.CollisionGroup = "Trajectory";
            local v14 = workspace:Raycast(u8.Position, u9 * 10, RaycastParams_new_ret);

            if ShotDuration <= tick() - u11 or v14 and v14.Instance or (u8.OnPlayer.Value or (u8.Position - Position).Magnitude >= 200) then
                u10:Destroy();

                return;
            end;

            u8.AssemblyLinearVelocity = u9 * ShotPower;
        end);
        u10:Add(task.delay(ShotDuration + 1, function() -- Line: 96
            -- upvalues: u10 (copy)
            u10:Destroy();
        end));
    end);
end;