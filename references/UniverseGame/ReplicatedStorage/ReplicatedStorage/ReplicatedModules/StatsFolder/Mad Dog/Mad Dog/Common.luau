  

 

return {
    EnableTrail = function(p1, p2, p3) -- Line: 3, Name: EnableTrail
        if typeof(p2) == "boolean" then
            for _, child in p1:GetChildren() do
                if child:IsA("BasePart") then
                    for _, descendant in child:GetDescendants() do
                        if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and descendant:GetAttribute("AtkTrail") then
                            descendant.Enabled = p3;
                        end;
                    end;
                end;
            end;

            return;
        end;

        if typeof(p2) == "table" then
            for _, child in p1:GetChildren() do
                if child:IsA("BasePart") and table.find(p2, child.Name) then
                    for _, descendant in child:GetDescendants() do
                        if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and descendant:GetAttribute("AtkTrail") then
                            descendant.Enabled = p3;
                        end;
                    end;
                end;
            end;

            return;
        end;

        if typeof(p2) == "string" then
            if not p1:FindFirstChild(p2) then
                return;
            end;

            for _, descendant in p1[p2]:GetDescendants() do
                if (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter")) and descendant:GetAttribute("AtkTrail") then
                    descendant.Enabled = p3;
                end;
            end;
        end;
    end,

    EnableKnifeTrail = function(p4, p5) -- Line: 40, Name: EnableKnifeTrail
        if not p4:FindFirstChild("Stand") then
            return;
        end;

        for _, descendant in p4.Stand:GetDescendants() do
            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = p5;
            end;
        end;
    end
};