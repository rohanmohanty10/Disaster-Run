  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
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

return function(u1, u2, u3, u4) -- Line: 16, Name: ScythePass
    -- upvalues: RunService (copy)
    u1.StatesController.States.Ability = true;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.Animations.Abilities.ScythePass.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ScythePass:Play();
    u1.AbilityService.Ability:Fire("ScythePass", { u4 });
    task.delay(1, function() -- Line: 27
        -- upvalues: u1 (copy)
        u1.StatesController.States.Ability = false;
    end);
    u1:AbilityCooldown("1", 1);
    u1.ABC:Add(function() -- Line: 33
        -- upvalues: u2 (copy), u1 (copy), u3 (copy)
        print("Cleaning");
        local v5 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("1");

        if v5 then
            local UIScale = v5:FindFirstChild("UIScale");
            UIScale.Scale = 1.25;
            v5.ImageColor3 = Color3.fromRGB(255, 0, 0);
            u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Scale = 1
            });
            u1.UITween1:Play();
            u1.UITween2 = game:GetService("TweenService"):Create(v5, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            });
            u1.UITween2:Play();
            u3:SetAttribute("DeathsCall", true);
            task.delay(2, function() -- Line: 50
                -- upvalues: u1 (ref), u3 (ref)
                u1:AbilityCooldown("1", 35);
                u3:SetAttribute("DeathsCall", false);
            end);
        end;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(u6) -- Line: 58
        -- upvalues: u1 (copy), u3 (copy), u4 (copy), RunService (ref)
        u1.StatesController.States.Ability = false;
        local HumanoidRootPart = u3.HumanoidRootPart;
        local HumanoidRootPart2 = u4.HumanoidRootPart;
        local u7 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + HumanoidRootPart.CFrame.RightVector * 1 + Vector3.new(0, 0.25, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u7 * math_clamp_ret;
        u1.BallController:DragBall(u6);
        local u8 = tick();
        u1.ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 75
            -- upvalues: u8 (copy), u6 (copy), u1 (ref), HumanoidRootPart2 (copy), u7 (ref), math_clamp_ret (ref), HumanoidRootPart (copy)
            if tick() > u8 + 2 or (not u6 or u6.OnPlayer.Value) then
                u1.ABC:Clean();

                return;
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v10 = tick() > u8 + 0.55;
            u7 = u7:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v10 and 0.15 or 0.35, 0), 6.5 * p9);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                u1.ABC:Clean();

                return;
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u7 * math_clamp_ret, 6.5 * p9);
        end);
    end);
end;