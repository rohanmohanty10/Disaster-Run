 
 

return {
    { 6, function(p1) -- Line: 3
            for _, descendant in pairs(p1["Right Arm"].StrongWindUp:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end },
    { 33, function(p2) -- Line: 12
            for _, descendant in pairs(p2.HumanoidRootPart.StrongLeft:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(p2["Right Arm"].StrongWindUp:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end }
};