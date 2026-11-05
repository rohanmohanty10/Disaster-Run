  

 

return {
    SetTrail = function(p1, p2) -- Line: 3, Name: SetTrail
        local Stand = p1:FindFirstChild("Stand");

        if not Stand then
            return;
        end;

        for _, descendant in pairs(Stand:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = p2;
            end;
        end;
    end,

    SetParticle = function(p3, p4) -- Line: 17, Name: SetParticle
        for _, descendant in pairs(p3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(p4, function() -- Line: 22
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end,

    WeldTo = function(p5, p6, p7) -- Line: 29, Name: WeldTo
        p7.CFrame = p5;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p6;
        WeldConstraint.Part1 = p7;
        WeldConstraint.Parent = p7;

        return WeldConstraint;
    end
};