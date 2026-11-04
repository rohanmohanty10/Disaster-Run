  

local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Popup = require(game:GetService("ReplicatedStorage").Shared.Popup);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Beinschuss = require(ReplicatedStorage.AbilityBalancing).Beinschuss;
local ActivationRangePlayer = Beinschuss.ActivationRangePlayer;

return function(u1, p2, u3) -- Line: 9
    -- upvalues: ActivationRangePlayer (copy), Popup (copy), Beinschuss (copy), RunService (copy)
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

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        return;
    end;

    if u3.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        return;
    end;

    if u3.HumanoidRootPart.Position.Y >= 12 then
        return;
    end;

    local v5 = false;

    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Character:FindFirstChild("Values") and (v.Team ~= p2.Team and v.Team.Name ~= "Visitor")) and not ((not v.Character.Values.Goalie.Value or v.Character.Values.IsInPenalty.Value) and v.Character.Values.Goalie.Value) and ActivationRangePlayer >= (v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude then
            v5 = true;
            break;
        end;
    end;

    if not (v5 or workspace:FindFirstChild("PassRig")) then
        u1.StatesController.States.Ability = false;

        return Popup.Popup(p2, "No enemy nearby!");
    end;

    u1.StatesController.States.Ability = true;
    u3.HumanoidRootPart.Anchored = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.BeinschussPlr1.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.BeinschussPlr1:Play();
    u1.Animations.Ball.KaiserBeinschuss.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Ball.KaiserBeinschuss:Play();
    u1.AbilityService.Ability:Fire("Beinschuss");
    u1:AbilityCooldown("1", Beinschuss.Cooldown);
    u1.ABC:Add(function() -- Line: 53
        -- upvalues: u1 (copy), u3 (copy)
        u1.StatesController.States.Ability = false;
        u3.HumanoidRootPart.Anchored = false;
    end);
    local MoveSpeedValue = Beinschuss.MoveSpeedValue;
    local u6 = tick();
    local u7 = nil;
    u7 = u1.ABC:Connect(RunService.Heartbeat, function(p8) -- Line: 60
        -- upvalues: u6 (copy), Beinschuss (ref), u7 (ref), u3 (copy), u1 (copy), workspace_CurrentCamera (copy), u4 (copy), MoveSpeedValue (ref)
        if tick() - u6 >= Beinschuss.MoveSpeedDuration then
            u7:Disconnect();

            if not u3.Values.HasBall then
                u1.ABC:Clean();
            end;

            return;
        end;

        local LookVector = workspace_CurrentCamera.CFrame.LookVector;
        local _ = Vector3.new(LookVector.X, u4.CFrame.LookVector.Y, LookVector.Z) * MoveSpeedValue;
        MoveSpeedValue = MoveSpeedValue - 25 * p8;
    end);
    u1.ABC:Add(task.delay(15, function() -- Line: 87
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    local u9 = workspace_CurrentCamera.CFrame.LookVector + Beinschuss.ShotTiltVector;
    u1.ABC:Connect(u1.AbilityService.Ability, function(u10) -- Line: 93
        -- upvalues: u1 (copy), u9 (copy), Beinschuss (ref), RunService (ref)
        u1.StatesController.States.Ability = false;
        u10.AssemblyLinearVelocity = u9 * Beinschuss.ShotPower;
        u1.BallController:DragBall(u10);
        local u11 = tick();
        local Position = u10.Position;
        u1.ABC:Connect(RunService.Stepped, function(p12) -- Line: 102
            -- upvalues: u10 (copy), u9 (ref), u11 (copy), Position (copy), u1 (ref), Beinschuss (ref)
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { u10 };

            if workspace.PenaltyArea:FindFirstChild("Away") then
                table.insert(RaycastParams_new_ret.FilterDescendantsInstances, workspace.PenaltyArea.Away);
            end;

            if workspace.PenaltyArea:FindFirstChild("Home") then
                table.insert(RaycastParams_new_ret.FilterDescendantsInstances, workspace.PenaltyArea.Away);
            end;

            RaycastParams_new_ret.CollisionGroup = "Trajectory";
            local v13 = workspace:Raycast(u10.Position, u9 * 10, RaycastParams_new_ret);

            if tick() - u11 >= 3 or v13 and v13.Instance or (u10.OnPlayer.Value or (u10.Position - Position).Magnitude >= 120) then
                u1.ABC:Clean();
            end;

            u10.AssemblyLinearVelocity = u9 * Beinschuss.ShotPower;
        end);
    end);
end;