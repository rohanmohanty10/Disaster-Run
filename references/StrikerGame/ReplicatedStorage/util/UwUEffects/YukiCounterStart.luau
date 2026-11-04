 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return { function(p1, p2, p3) -- Line: 6
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, descendant in p2.HumanoidRootPart["1"]:GetDescendants() do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end, function() -- Line: 17
    end };