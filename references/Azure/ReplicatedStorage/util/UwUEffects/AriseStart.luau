 

 

return {
    [0.1] = function(p1, p2, p3) -- Line: 2
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in p1.Character.HumanoidRootPart.screen:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end,

    [9000000000] = function() -- Line: 14
    end
};