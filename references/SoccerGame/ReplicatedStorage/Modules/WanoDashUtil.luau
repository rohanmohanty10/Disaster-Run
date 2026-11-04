  

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

return {
    DashAlignPosition = function(p1) -- Line: 7, Name: DashAlignPosition
        -- upvalues: TweenService (copy)
        local HumanoidRootPart = p1.Character:WaitForChild("HumanoidRootPart");
        local v2 = p1.Duration or 0.3;
        local v3 = p1.DelayBetween or 0.05;
        local v4 = p1.Distance or 30;
        local v5 = p1.Responsiveness or 200;
        local v6 = p1.MaxForce or 40000;
        local v7 = p1.EasingStyle or Enum.EasingStyle.Quad;
        local v8 = p1.EasingDirection or Enum.EasingDirection.Out;

        for _, v in ipairs(p1.Directions) do
            local AlignPosition = Instance.new("AlignPosition");
            AlignPosition.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
            AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
            AlignPosition.Responsiveness = v5;
            AlignPosition.MaxForce = v6;
            AlignPosition.Position = HumanoidRootPart.Position;
            AlignPosition.Parent = HumanoidRootPart;
            local v9 = HumanoidRootPart.Position + v.Unit * v4;
            TweenService:Create(AlignPosition, TweenInfo.new(v2, v7, v8), {
                Position = v9
            }):Play();
            task.wait(v2 + v3);
            AlignPosition:Destroy();
        end;
    end,

    DashSimpleLinear = function(p10) -- Line: 40, Name: DashSimpleLinear
        local HumanoidRootPart = p10.Character:WaitForChild("HumanoidRootPart");
        local v11 = p10.Duration or 0.3;
        local v12 = p10.Power or 100;
        local v13 = p10.DelayBetween or 0.05;
        local v14 = p10.MaxAxesForce or Vector3.new(100000, 0, 100000);

        for _, v in ipairs(p10.Directions) do
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Name = "SimpleDashLV";
            LinearVelocity.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
            LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
            LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
            LinearVelocity.ForceLimitsEnabled = true;
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = v14;
            LinearVelocity.VectorVelocity = v.Unit * v12;
            LinearVelocity.Parent = HumanoidRootPart;
            task.wait(v11);
            LinearVelocity:Destroy();
            task.wait(v13);
        end;
    end,

    DashAdvancedLinear = function(p15) -- Line: 67, Name: DashAdvancedLinear
        -- upvalues: RunService (copy)
        local Character = p15.Character;
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u16 = p15.Duration or 0.3;
        local u17 = p15.Power or 100;
        local v18 = p15.ResidualFrac or 0.3;
        local u19 = p15.BlendStart or 0.75;
        local v20 = p15.DelayBetween or 0.05;
        local v21 = p15.MaxAxesForce or Vector3.new(100000, 0, 100000);
        local v22 = p15.LvName or "DashLV";

        for _, v in ipairs(p15.Directions) do
            if HumanoidRootPart:FindFirstChild(v22) then
                HumanoidRootPart[v22]:Destroy();
            end;

            local u23 = tick();
            local u24 = u17 * v18;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Name = v22;
            LinearVelocity.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment");
            LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World;
            LinearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector;
            LinearVelocity.ForceLimitsEnabled = true;
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = v21;
            LinearVelocity.Parent = HumanoidRootPart;
            LinearVelocity.VectorVelocity = v.Unit * u17;
            local u25 = nil;
            u25 = RunService.Heartbeat:Connect(function() -- Line: 99
                -- upvalues: u23 (copy), u16 (copy), u25 (ref), LinearVelocity (copy), u17 (copy), u24 (copy), v (copy), u19 (copy), Character (copy)
                local v26 = tick() - u23;

                if u16 <= v26 then
                    u25:Disconnect();
                    LinearVelocity:Destroy();

                    return;
                end;

                local math_clamp_ret = math.clamp(v26 / u16, 0, 1);
                local v27 = 1 - (1 - math_clamp_ret) ^ 2;
                local Unit = v.Unit;

                if u19 < math_clamp_ret then
                    local Humanoid = Character:FindFirstChild("Humanoid");

                    if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
                        Unit = v.Unit:Lerp(Humanoid.MoveDirection.Unit, (math_clamp_ret - u19) / (1 - u19));
                    end;
                end;

                LinearVelocity.VectorVelocity = Unit * (u17 * (1 - v27) + u24 * v27);
            end);
            task.wait(u16 + v20);
        end;
    end
};