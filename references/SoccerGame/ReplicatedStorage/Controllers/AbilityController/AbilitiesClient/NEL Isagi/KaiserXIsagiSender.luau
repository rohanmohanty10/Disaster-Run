  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, u2, u3, u4) -- Line: 16, Name: Move
    -- upvalues: Players (copy), ReplicatedStorage (copy), RunService (copy)
    if typeof(u4) ~= "table" or (typeof(u4.RequestToken) ~= "string" or u2.Character ~= u3) then
        return false;
    end;

    local target = u4.target;
    print("KaiserXIsagiSender", target);
    local v5;

    if u3 then
        v5 = u3:FindFirstChild("HumanoidRootPart");
    else
        v5 = u3;
    end;

    local u6;

    if target then
        u6 = Players:GetPlayerFromCharacter(target);
    else
        u6 = target;
    end;

    local v7;

    if target then
        v7 = target:FindFirstChild("HumanoidRootPart");
    else
        v7 = target;
    end;

    if not (v5 and (u6 and (u6.Team == u2.Team and (u6.Character == target and v7)))) then
        return false;
    end;

    local v8 = 27;
    local v9 = nil;

    for _, v in Players:GetPlayers() do
        local Character = v.Character;
        local v10;

        if Character then
            v10 = Character:FindFirstChild("HumanoidRootPart");
        else
            v10 = Character;
        end;

        local v11;

        if Character then
            v11 = Character:FindFirstChild("Values");
        else
            v11 = Character;
        end;

        local v12;

        if v11 then
            v12 = v11:FindFirstChild("Goalie");
        else
            v12 = v11;
        end;

        if v11 then
            v11 = v11:FindFirstChild("IsInPenalty");
        end;

        if v.Team ~= game.Teams.Visitor and (v.Team ~= u2.Team and (v10 and not (v12 and (v12.Value and (v11 and v11.Value))))) then
            local v13 = v10.Position - v5.Position;

            if v13.Magnitude > 0.001 then
                local v14 = v5.CFrame.LookVector:Dot(v13.Unit);
                local math_clamp_ret = math.clamp(v14, -1, 1);

                if math.acos(math_clamp_ret) < 1.5707963267948966 and v13.Magnitude < v8 then
                    v8 = v13.Magnitude;
                    v9 = Character;
                end;
            end;
        end;
    end;

    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.StatesController.SpeedBoost = 5;
    u1.ABC:Add(function() -- Line: 71
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.StatesController.SpeedBoost = 0;
    end);
    u1.ABC:Add(task.delay(3, function() -- Line: 77
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.Animations:StopAnims();
    u1.Animations.Abilities.NELIsagixKaiserCRUser.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.NELIsagixKaiserCRUser:Play();
    u1.AbilityService.Ability:Fire(script.Name, {
        Enemy = v9,
        Target = target,
        RequestToken = u4.RequestToken
    });
    u1.ABC:Connect(u1.AbilityService.Ability, function(u15, p16) -- Line: 91
        -- upvalues: u4 (copy), u2 (copy), u3 (copy), u6 (copy), target (copy), ReplicatedStorage (ref), u1 (copy), RunService (ref)
        local v17;

        if u15 then
            v17 = u15:FindFirstChild("Char");
        else
            v17 = u15;
        end;

        local v18;

        if u15 then
            v18 = u15:FindFirstChild("OnPlayer");
        else
            v18 = u15;
        end;

        if p16 ~= u4.RequestToken or (u2.Character ~= u3 or (u6.Character ~= target or (u6.Team ~= u2.Team or not (u15 and (u15:IsA("BasePart") and (ReplicatedStorage.Football.Value == u15 and (u15.Parent == workspace and (v17 and (v17.Value == u3 and (v18 and not v18.Value)))))))))) then
            return;
        end;

        u1.StatesController.States.Ability = false;
        local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");
        local HumanoidRootPart2 = target:FindFirstChild("HumanoidRootPart");

        if not (HumanoidRootPart and HumanoidRootPart2) then
            return u1.ABC:Clean();
        end;

        local v19 = HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position;

        if v19.Magnitude <= 0.001 then
            return u1.ABC:Clean();
        end;

        local u20 = v19.Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u15.AssemblyLinearVelocity = u20 * math_clamp_ret;
        u1.BallController:DragBall(u15);
        local u21 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p22) -- Line: 132
            -- upvalues: u21 (copy), u15 (copy), u1 (ref), HumanoidRootPart2 (copy), u20 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u21 + 4 or (not u15 or u15.OnPlayer.Value) then
                return u1.ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v23 = tick() > u21 + 0.55;
            u20 = u20:Lerp((HumanoidRootPart2.Position - u15.Position).Unit + Vector3.new(0, v23 and 0.15 or 0.35, 0), 6.5 * p22);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u15.Position.Y < 5 or (HumanoidRootPart2.Position - u15.Position).Magnitude <= 7 then
                return u1.ABC:Clean();
            end;

            u15.AssemblyLinearVelocity = u15.AssemblyLinearVelocity:Lerp(u20 * math_clamp_ret, 6.5 * p22);
        end);
    end);

    return true;
end;