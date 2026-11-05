  

 

return function(p1, p2) -- Line: 1
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            if p2 then
                game.TweenService:Create(descendant, TweenInfo.new(p2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            else
                descendant.Transparency = 1;
            end;
        end;

        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Highlight"))) then
            if descendant:IsA("ParticleEmitter") then
                descendant:Clear();
            end;

            descendant.Enabled = false;
        end;
    end;
end;