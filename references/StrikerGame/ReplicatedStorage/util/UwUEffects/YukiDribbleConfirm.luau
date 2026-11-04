 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p2.HumanoidRootPart;

        for _, descendant in HumanoidRootPart["2"]:GetDescendants() do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in HumanoidRootPart["2.5"]:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in p3.All do
            if v.Name == "Aura" and v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end,

    [0.6] = function(p4, p5, p6) -- Line: 31
        local _ = p4.Character;
        local _ = p4.Meshes;
        local _ = p4.Cache;

        for _, descendant in p5.HumanoidRootPart["2.5"]:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in p6.All do
            if v.Name == "Aura" and v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end,

    [1.5] = function() -- Line: 50
    end
};