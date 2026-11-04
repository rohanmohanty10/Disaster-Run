  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, u3) -- Line: 18, Name: TrueDirectShot
    -- upvalues: Popup (copy), RunService (copy)
    if p2.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if u3.Humanoid.FloorMaterial == Enum.Material.Air then
        return;
    end;

    if u3.Values.HasBall.Value then
        return Popup.Popup(p2, "You must not have the Ball!");
    end;

    local u4 = nil;
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Team == p2.Team and v.Team ~= game.Teams.Visitor then
            local Character = v.Character;

            if Character and (Character:FindFirstChild("HumanoidRootPart") and (Character:FindFirstChild("Values") and not (Character.Values.Goalie.Value and Character.Values.IsInPenalty.Value))) and (Character.Values.HasBall.Value and (u3.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude <= 30) then
                u4 = Character;
            end;
        end;
    end;

    if workspace:FindFirstChild("PassRig") then
        u4 = workspace.PassRig;
    end;

    if not u4 then
        return Popup.Popup(p2, "A teammate nearby you must have the Ball");
    end;

    local HumanoidRootPart2 = u4:FindFirstChild("HumanoidRootPart");
    u1:AbilityCooldown("3", 70);
    u1.AbilityService.Ability:Fire("TrueDirectShot", { u4, "Take" });
    u1.ABC:Connect(u1.AbilityService.Ability, function(p5, u6, p7) -- Line: 54
        -- upvalues: HumanoidRootPart (copy), HumanoidRootPart2 (copy), u1 (copy), RunService (ref), u3 (copy), u4 (ref)
        if p5 ~= "TakeBall" then
            if p5 ~= "Shot" then
                if p5 == "Failed" then
                    if u1.ABC then
                        u1.ABC:Clean();
                    end;

                    u1.StatesController.States.Ability = false;
                end;

                return;
            end;

            if u1.ABC then
                u1.ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = (u3.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.12, 0)) * p7;
            u1.BallController:DragBall(u6);
            task.wait(0.1);
            u1.StatesController.States.Ability = false;

            return;
        end;

        local u8 = (HumanoidRootPart.Position + HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart2.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude * 1.5, 0, 150);
        u1.BallController:DragBall(u6);
        u6.AssemblyLinearVelocity = u8 * math_clamp_ret;
        local u9 = tick();
        local u10 = nil;
        u10 = u1.ABC:Connect(RunService.Heartbeat, function(p11) -- Line: 68
            -- upvalues: u9 (copy), u6 (copy), HumanoidRootPart (ref), u10 (ref), HumanoidRootPart2 (ref), u8 (ref), math_clamp_ret (ref), u1 (ref)
            if tick() > u9 + 1.5 then
                u6.Position = HumanoidRootPart.Position - Vector3.new(0, 1, 0);

                return u10:Disconnect();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            u8 = u8:Lerp((HumanoidRootPart.Position - u6.Position).Unit + Vector3.new(0, 0.1, 0), 6.5 * p11);
            math_clamp_ret = math.clamp((HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude * 2.75, 0, 150);

            if (HumanoidRootPart.Position - u6.Position).Magnitude <= 7 then
                u1.BallController:DragBall(u6);
                u6.Position = HumanoidRootPart.Position - Vector3.new(0, 1, 0);
                u10:Disconnect();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u8 * math_clamp_ret, 6.5 * p11);
        end);

        repeat
            task.wait();
        until tick() > u9 + 1.5 or u3.Values.HasBall.Value;

        if not u3.Values.HasBall.Value then
            return u1.ABC:Clean();
        end;

        u1.StatesController.States.Ability = true;
        u1.Animations:StopAnims();
        u1.Animations.Abilities.DirectShot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.DirectShot:Play();
        u1.Animations.Ball.DirectShot:Play();
        u1.AbilityService.Ability:Fire("TrueDirectShot", { u4, "Shoot" });
    end);
end;