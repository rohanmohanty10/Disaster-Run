 
 

return {
    { 6, function(p1) -- Line: 3
            for _, descendant in pairs(p1.HumanoidRootPart.RadiantKick.WindUp:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 36, function(p2) -- Line: 12
            for _, descendant in pairs(p2.HumanoidRootPart.RadiantKick.Shoot:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};