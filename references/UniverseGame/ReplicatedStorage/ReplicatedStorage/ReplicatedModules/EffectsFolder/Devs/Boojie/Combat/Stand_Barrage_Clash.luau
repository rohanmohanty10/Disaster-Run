  

 

return function(p1, p2) -- Line: 1
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = p2:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    local u3 = game.ReplicatedStorage["Client Assets"].Combat.BarrageClash:Clone();
    u3.CFrame = CFrame.lookAt(HumanoidRootPart.Position:Lerp(HumanoidRootPart2.Position, 0.75), HumanoidRootPart2.Position);
    u3.Parent = workspace.Effects;
    local u4 = 0;

    for _, descendant in pairs(u3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 16
                -- upvalues: descendant (copy), u4 (ref)
                local v5 = descendant:GetAttribute("EmitDelay");
                local v6 = descendant:GetAttribute("EmitCount") or descendant.Rate;
                local v7 = descendant.Lifetime.Max + (v5 or 0);

                if u4 < v7 then
                    u4 = v7;
                end;

                if v5 and v5 > 0 then
                    local _ = v7 + v5;
                    task.wait(v5);
                end;

                descendant:Emit(v6 / 8);
            end);
        end;
    end;

    task.defer(function() -- Line: 32
        -- upvalues: u4 (ref), u3 (copy)
        task.wait(u4 + 0.5);
        u3:Destroy();
    end);
end;