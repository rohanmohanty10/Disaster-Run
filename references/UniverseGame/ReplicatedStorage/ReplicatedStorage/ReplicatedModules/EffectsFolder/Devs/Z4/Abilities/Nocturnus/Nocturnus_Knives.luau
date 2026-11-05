  

 

game:GetService("Players");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);

return function(p1, p2, p3, p4) -- Line: 7
    -- upvalues: EffectsHandler (copy)
    local v5 = p4 or script.Knife;

    if p1 and p1:FindFirstChild("HumanoidRootPart") then
        local HumanoidRootPart = p1.HumanoidRootPart;
        local u6 = v5:Clone();
        u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(u6.CFrame.LookVector * -p3 + p2);
        u6.CFrame = CFrame.lookAt(u6.Position, HumanoidRootPart.Position);
        u6.Parent = workspace.Effects;
        task.delay(2, u6.Destroy, u6);
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Universal/Combat/Particles/Teleport",
            Scale = 0.5,
            AutoSerialize = true,
            RawPath = true,
            Origin = u6.CFrame
        });
        game.TweenService:Create(u6, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            CFrame = u6.CFrame * CFrame.new(0, 0, p3 + 1)
        }):Play();
        task.delay(0.4, function() -- Line: 30
            -- upvalues: u6 (copy)
            u6.Transparency = 1;

            for _, descendant in ipairs(u6:GetDescendants()) do
                task.spawn(function() -- Line: 34
                    -- upvalues: descendant (copy)
                    if descendant:IsA("BasePart") then
                        descendant.Transparency = 1;

                        return;
                    end;

                    if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end);
            end;
        end);
    end;
end;