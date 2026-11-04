 
 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in pairs(p1.Folder.specs:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Clear();
                end;
            end;
        end },
    { 1, function(p2) -- Line: 8
            shared.vfx.emit(p2.Folder.smoke);
        end },
    { 64, function(p3) -- Line: 13
            shared.vfx.emit(p3.Folder.specs);
        end },
    { 255, function(p4, p5) -- Line: 18
            shared.vfx.emit(p4.Folder.tsbeam, p5.CamPart);
        end }
};