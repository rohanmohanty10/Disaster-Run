  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);

return function(u1, u2, u3) -- Line: 8
    -- upvalues: interface (copy), CameraController (copy), RunService (copy)
    if u3.Values.HasBall.Value == false then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local _ = workspace.CurrentCamera;
    local v4 = u2.PlayerStats.Style.Value == "Reo";
    u1:AbilityCooldown("2", v4 and 50 or 1);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.Camera.Cutscene = true;
    u2:SetAttribute("ForceCursor", true);
    interface.KingsDribbleShot = true;
    u3:SetAttribute("KingsDribbleShot", true);
    u1.ABC:Add(function() -- Line: 26
        -- upvalues: u1 (copy), u2 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;
        u1.Camera.Cutscene = false;
        u2:SetAttribute("ForceCursor", nil);
    end);
    u1.AbilityService.Ability:Fire("KingsDribble", {
        Action = "Dribble"
    });
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local function dash(p5: vector, u6: number, u7: number) -- Line: 42
        -- upvalues: HumanoidRootPart (copy), CameraController (ref), RunService (ref), u3 (copy)
        if HumanoidRootPart:FindFirstChild("ChopLV") then
            HumanoidRootPart.ChopLV:Destroy();
        end;

        CameraController:Shake("Hit");
        local u8 = u7 * 0.3;
        local u9 = tick();
        local _ = u9 + u6;
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Name = "ChopLV";
        LinearVelocity.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
        LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
        LinearVelocity.ForceLimitsEnabled = true;
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(100000, 0, 100000);
        LinearVelocity.Parent = HumanoidRootPart;
        local Unit = p5.Unit;
        LinearVelocity.VectorVelocity = Unit * u7;
        local u10 = nil;
        u10 = RunService.Heartbeat:Connect(function() -- Line: 70
            -- upvalues: u9 (copy), u6 (copy), u10 (ref), LinearVelocity (copy), u7 (copy), u8 (copy), Unit (copy), u3 (ref)
            local v11 = tick() - u9;

            if u6 <= v11 then
                u10:Disconnect();
                LinearVelocity:Destroy();

                return;
            end;

            local math_clamp_ret = math.clamp(v11 / u6, 0, 1);
            local v12 = 1 - (1 - math_clamp_ret) ^ 2;
            local v13 = Unit;

            if math_clamp_ret > 0.75 then
                local v14 = u3:FindFirstChild("Humanoid") and u3.Humanoid.MoveDirection;

                if v14 and v14.Magnitude > 0 then
                    v13 = v13:Lerp(v14.Unit, (math_clamp_ret - 0.75) / 0.25);
                end;
            end;

            LinearVelocity.VectorVelocity = v13 * (u7 * (1 - v12) + u8 * v12);
        end);
        task.wait(u6 + 0.05);
    end;

    local Unit = (HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    local Unit2 = (HumanoidRootPart.CFrame.RightVector * Vector3.new(1, 0, 1)).Unit;
    local v15 = u2.PlayerStats.InAwakening.Value and 300 or 200;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KingChop3.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KingChop3:Play();
    dash((Unit * 10 + Unit2 * 15).Unit, 0.3, v15);
    task.wait(0.05);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KingChop2.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KingChop2:Play();
    dash((Unit * 10 - Unit2 * 15).Unit, 0.3, v15);
    task.wait(0.05);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KingChop3.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KingChop3:Play();
    dash((Unit * 10 + Unit2 * 15).Unit, 0.3, v15);
    u1.ABC:Clean();

    if v4 then
        return;
    end;

    task.delay(1, function() -- Line: 128
        -- upvalues: interface (ref), u1 (copy), u3 (copy)
        if interface.KingsDribbleShot == nil then
            return;
        end;

        u1:AbilityCooldown("2", 50);
        u3:SetAttribute("KingsDribbleShot", false);
        interface.KingsDribbleShot = nil;
    end);
    local v16 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

    if v16 then
        local UIScale = v16:FindFirstChild("UIScale");
        UIScale.Scale = 1.25;
        v16.ImageColor3 = Color3.fromRGB(255, 0, 0);
        u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Scale = 1
        });
        u1.UITween1:Play();
        u1.UITween2 = game:GetService("TweenService"):Create(v16, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        });
        u1.UITween2:Play();
    end;
end;