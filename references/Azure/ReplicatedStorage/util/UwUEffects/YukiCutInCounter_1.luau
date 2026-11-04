 
 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Direction;
        local _ = p1.Meshes;
        local _ = p1.Cache;
        local HumanoidRootPart = p2.HumanoidRootPart;
        local _ = p1.Character.HumanoidRootPart;

        for _, descendant in pairs(HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(HumanoidRootPart["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.6] = function(p4, p5, p6) -- Line: 19
        local _ = p4.Meshes;
        local _ = p4.Cache;
        local _ = p4.Character.HumanoidRootPart;

        for _, descendant in pairs(p5.HumanoidRootPart["2.5"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end,

    [5] = function() -- Line: 30
    end
};