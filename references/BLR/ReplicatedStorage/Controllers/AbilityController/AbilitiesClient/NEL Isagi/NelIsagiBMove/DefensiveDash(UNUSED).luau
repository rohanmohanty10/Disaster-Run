  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Popup);

return function(u1, p2, u3, p4) -- Line: 4
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Humanoid.FloorMaterial == Enum.Material.Air then
        return;
    end;

    u1:AbilityCooldown("3", 30);
    print("Left Shoot");
    local u5 = false;
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.LeftyShoot.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.LeftyShoot.Looped = false;
    u1.Animations.Abilities.LeftyShoot:Play();
    task.delay(0.25, function() -- Line: 20
        -- upvalues: u5 (ref), u1 (copy)
        if u5 then
            return;
        end;

        u1.Animations.Abilities.LeftyShoot:AdjustSpeed(0);
    end);
    local _ = u3.HumanoidRootPart;
    u1.AbilityService.Ability:Fire("NELDirectShot", { "Lefty", "Start" });
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u3.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    game.Debris:AddItem(BodyVelocity, 0.35);
    local BodyGyro = Instance.new("BodyGyro");
    BodyGyro.Parent = u3.HumanoidRootPart;
    BodyGyro.MaxTorque = Vector3.new(inf, inf, inf);
    game.Debris:AddItem(BodyGyro, 0.45);
    BodyVelocity.Velocity = u3.HumanoidRootPart.CFrame.LookVector * (u3:GetAttribute("RageBar") >= 0.5 and 100 or false) or 80;
    local os_clock_ret = os.clock();
    local v6 = 8;
    local v7 = {};
    local v8 = nil;

    while true do
        task.wait();
        local Players = game.Players:GetPlayers();
        local v9 = {};

        for _, v in pairs(Players) do
            if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
                local v10 = u3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Unit);
                local math_acos_ret = math.acos(v10);
                local _ = math_acos_ret < 1.9039955476301778;

                if math_acos_ret < 1.5707963267948966 then
                    table.insert(v9, v.Character);
                end;
            end;
        end;

        for _, v in pairs(v9) do
            local Magnitude = (v.HumanoidRootPart.Position - u3.HumanoidRootPart.Position).Magnitude;

            if Magnitude < v6 then
                if v.Values.Dribbling.Value then
                    table.insert(v7, v);
                end;

                if not table.find(v7, v) then
                    u5 = true;
                    v8 = v;
                    v6 = Magnitude;
                end;
            end;
        end;

        table.clear(v9);
        table.clear(Players);

        if v8 or os.clock() - os_clock_ret > 0.5 then
            u1.Animations.Abilities.LeftyShoot:AdjustSpeed(1);
            BodyVelocity:Destroy();
            BodyGyro:Destroy();
            u1.AbilityService.Ability:Fire("NELDirectShot", { "Lefty", "End", v8 });
            u1.ABC:Connect(u1.AbilityService.Ability, function(p11, p12) -- Line: 102
                -- upvalues: u1 (copy), u3 (copy)
                print(p12);
                u1.ABC:Clean();
                u1.StatesController.States.Ability = false;
                p11.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.18, 0)) * p12;
                u1.BallController:DragBall(p11);
            end);
            u1.ABC:Add(task.delay(2, function() -- Line: 111
                -- upvalues: u1 (copy)
                u1.StatesController.States.Ability = false;
                u1.ABC:Clean();
            end));

            return;
        end;
    end;
end;