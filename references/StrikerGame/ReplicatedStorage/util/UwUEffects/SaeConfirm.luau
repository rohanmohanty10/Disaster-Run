 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in pairs(p2.HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p2.trailplaceholder["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p2.trailplaceholder2["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.223] = function(p4, p5, p6) -- Line: 33
        local _ = p4.Character;
        local _ = p4.Meshes;
        local _ = p4.Cache;

        for _, descendant in p5.trailplaceholder["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0.417] = function(p7, p8, p9) -- Line: 46
        local _ = p7.Character;
        local _ = p7.Meshes;
        local _ = p7.Cache;

        for _, descendant in p8.trailplaceholder2["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [0.533] = function(p10, p11, p12) -- Line: 59
        local _ = p10.Character;
        local _ = p10.Meshes;
        local _ = p10.Cache;

        for _, descendant in p11.trailplaceholder["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in p11.trailplaceholder2["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end,

    [0.583] = function(p13, p14, p15) -- Line: 80
        local _ = p13.Character;
        local _ = p13.Meshes;
        local _ = p13.Cache;

        for _, descendant in p14.HumanoidRootPart["3"]:GetDescendants() do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in p14.trailplaceholder2["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in p14.trailplaceholder["1"]:GetDescendants() do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end,

    [2] = function() -- Line: 107
    end
};